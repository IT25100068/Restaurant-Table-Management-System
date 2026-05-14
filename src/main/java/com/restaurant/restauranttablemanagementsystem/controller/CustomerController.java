package com.restaurant.restauranttablemanagementsystem.controller;



import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.RegularCustomer;
import com.restaurant.restauranttablemanagementsystem.service.CustomerService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

//    @Autowired
//    private ReservationService reservationService;

//    @Autowired
//    private ReviewService reviewService;

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerCustomer(@RequestParam String name,
                                   @RequestParam String email,
                                   @RequestParam String password,
                                   @RequestParam String phone,
                                   @RequestParam String address,
                                   @RequestParam(required = false) Boolean isPremium,
                                   Model model) throws SQLException {

        boolean registered = customerService.registerCustomer(
                name, email, password, phone, address,
                isPremium != null && isPremium
        );

        if (registered) {
            model.addAttribute("success", "Registration successful! Please login.");
            return "login";
        } else {
            model.addAttribute("error", "Email already exists!");
            return "register";
        }
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginCustomer(@RequestParam String email,
                                @RequestParam String password,
                                HttpSession session,
                                HttpServletRequest request,
                                Model model) throws SQLException {

        Customer customer = customerService.loginCustomer(email, password);

        if (customer != null) {
            session.setAttribute("loggedInCustomer", customer);
            model.addAttribute("customer", customer);
            return "redirect:/customer/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password!");
            return "login";
        }
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }
        model.addAttribute("customer", customer);
        return "profile";
    }

    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam String name,
                                @RequestParam String phone,
                                @RequestParam String address,
                                @RequestParam(required = false) String password,
                                HttpSession session,
                                Model model) throws SQLException {

        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        customer.setName(name);
        customer.setPhone(phone);
        customer.setAddress(address);
        if (password != null && !password.isEmpty()) {
            customer.setPassword(password);
        }

        boolean updated = customerService.updateProfile(customer);

        if (updated) {
            session.setAttribute("loggedInCustomer", customer);
            model.addAttribute("success", "Profile updated successfully!");
        } else {
            model.addAttribute("error", "Update failed!");
        }

        model.addAttribute("customer", customer);
        return "profile";
    }

    @PostMapping("/deleteAccount")
    public String deleteAccount(HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        boolean deleted = customerService.deleteAccount(customer.getId());

        if (deleted) {
            session.invalidate();
            model.addAttribute("success", "Account deleted successfully!");
            return "login";
        } else {
            model.addAttribute("error", "Delete failed!");
            return "profile";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/customer/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

//        List<Reservation> reservations = reservationService.getMyReservations(customer.getId());

//        long activeReservations = reservations.stream()
//                .filter(r -> "PENDING".equals(r.getStatus()) || "CONFIRMED".equals(r.getStatus()))
//                .count();

//        long completedReservations = reservations.stream()
//                .filter(r -> "COMPLETED".equals(r.getStatus()))
//                .count();

//        int reviewsCount = reviewService.getMyReviews(customer.getId()).size();

        int loyaltyPoints = customer.getLoyaltyPoints();
        int pointsInCurrentLevel = loyaltyPoints % 100;
        int pointsToNextLevel = 100 - pointsInCurrentLevel;

        if (pointsToNextLevel == 100) {
            pointsToNextLevel = 100;
        }

        double loyaltyProgress = pointsInCurrentLevel;

        if (loyaltyPoints == 0) {
            loyaltyProgress = 0;
            pointsToNextLevel = 100;
        }

        model.addAttribute("customer", customer);
//        model.addAttribute("activeReservations", activeReservations);
//        model.addAttribute("completedReservations", completedReservations);
//        model.addAttribute("reviewsCount", reviewsCount);
        model.addAttribute("pointsToNextLevel", pointsToNextLevel);
        model.addAttribute("loyaltyProgress", loyaltyProgress);

        return "customerDashboard";
    }

    @GetMapping("/admin/list")
    public String listAllCustomers(@RequestParam(required = false) String search,
                                   Model model) throws SQLException {
        List<Customer> customers;
        if (search != null && !search.isEmpty()) {
            customers = customerService.searchCustomers(search);
            model.addAttribute("searchKeyword", search);
        } else {
            customers = customerService.getAllCustomers();
        }

        Map<String, Object> stats = calculateCustomerStats(customers);

        model.addAttribute("customers", customers);
        model.addAttribute("totalCustomers", customers.size());
        model.addAttribute("premiumCount", stats.get("premiumCount"));
        model.addAttribute("regularCount", stats.get("regularCount"));
        model.addAttribute("totalPoints", stats.get("totalPoints"));

        return "admin/customer/list";
    }

    @GetMapping("/admin/view/{id}")
    public String viewCustomerDetails(@PathVariable int id, Model model) throws SQLException {
        Customer customer = customerService.getCustomerById(id);
        model.addAttribute("customer", customer);
        return "admin/customer/view";
    }

    @PostMapping("/admin/update/{id}")
    public String adminUpdateCustomer(@PathVariable int id,
                                      @RequestParam String name,
                                      @RequestParam String phone,
                                      @RequestParam String address,
                                      @RequestParam String customerType,
                                      Model model) throws SQLException {

        Customer customer = customerService.getCustomerById(id);
        if (customer != null) {
            customer.setName(name);
            customer.setPhone(phone);
            customer.setAddress(address);
            customer.setCustomerType(customerType);

            if ("PREMIUM".equals(customerType) && customer instanceof RegularCustomer) {
                customerService.upgradeToPremium(customer.getId());
            } else {
                customerService.updateCustomer(customer);
            }
        }
        return "redirect:/customer/admin/view/" + id;
    }

    @GetMapping("/admin/get/{id}")
    @ResponseBody
    public Customer getCustomerJson(@PathVariable int id) throws SQLException {
        return customerService.getCustomerById(id);
    }

    @DeleteMapping("/admin/delete/{id}")
    @ResponseBody
    public String deleteCustomer(@PathVariable int id) throws SQLException {
        boolean deleted = customerService.deleteAccount(id);
        return deleted ? "success" : "failed";
    }

    @GetMapping("/admin/delete/{id}")
    public String adminDeleteCustomerGet(@PathVariable int id) throws SQLException {
        customerService.deleteAccount(id);
        return "redirect:/customer/admin/list";
    }

    private Map<String, Object> calculateCustomerStats(List<Customer> customers) {
        Map<String, Object> stats = new HashMap<>();
        long premiumCount = 0;
        long regularCount = 0;
        int totalPoints = 0;

        for (Customer c : customers) {
            if ("PREMIUM".equals(c.getCustomerType())) {
                premiumCount++;
            } else {
                regularCount++;
            }
            totalPoints += c.getLoyaltyPoints();
        }

        stats.put("premiumCount", premiumCount);
        stats.put("regularCount", regularCount);
        stats.put("totalPoints", totalPoints);

        return stats;
    }

    @PostMapping("/clear-message")
    @ResponseBody
    public String clearMessage(HttpSession session) {
        session.removeAttribute("success");
        session.removeAttribute("error");
        return "cleared";
    }

    @GetMapping("/test/points")
    @ResponseBody
    public String testPoints(HttpSession session) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer != null) {

            int currentPoints = customer.getLoyaltyPoints();
            boolean success = customerService.addLoyaltyPointsToCustomer(customer.getId(), 100);
            if (success) {
                Customer updated = customerService.getCustomerById(customer.getId());
                session.setAttribute("loggedInCustomer", updated);
                return "Points added! Previous: " + currentPoints + ", Now: " + updated.getLoyaltyPoints();
            } else {
                return "Failed to add points";
            }
        }
        return "Not logged in";
    }
}