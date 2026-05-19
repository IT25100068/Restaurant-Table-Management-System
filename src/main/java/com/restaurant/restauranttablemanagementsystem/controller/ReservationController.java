package com.restaurant.restauranttablemanagementsystem.controller;



import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.Reservation;
import com.restaurant.restauranttablemanagementsystem.model.Table;
import com.restaurant.restauranttablemanagementsystem.service.ReservationService;
import com.restaurant.restauranttablemanagementsystem.service.ReviewService;
import com.restaurant.restauranttablemanagementsystem.service.TableService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private TableService tableService;

    @GetMapping("/new")
    public String showReservationForm(Model model) throws SQLException {
        model.addAttribute("minDate", LocalDate.now());
        model.addAttribute("minTime", LocalTime.of(10, 0));
        model.addAttribute("maxTime", LocalTime.of(22, 0));

        List<Table> tables = tableService.getAllTables();
        model.addAttribute("tables", tables);

        return "makeReservation";
    }

    @GetMapping("/available-tables")
    @ResponseBody
    public List<Table> getAvailableTables(@RequestParam int capacity,
                                          @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
                                          @RequestParam @DateTimeFormat(pattern = "HH:mm") LocalTime time) throws SQLException {
        return tableService.getAvailableTables(capacity, date, time);
    }

    @PostMapping("/create")
    public String createReservation(@RequestParam int tableId,
                                    @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
                                    @RequestParam @DateTimeFormat(pattern = "HH:mm") LocalTime time,
                                    @RequestParam int partySize,
                                    @RequestParam(required = false) String specialRequests,
                                    HttpSession session,
                                    Model model) throws SQLException {

        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        boolean success = reservationService.makeReservation(
                customer.getId(), tableId, date, time, partySize, specialRequests
        );

        if (success) {
            return "redirect:/reservation/my";
        } else {
            model.addAttribute("error", "Table is not available at that time. Please choose another time.");
            model.addAttribute("minDate", LocalDate.now());
            model.addAttribute("minTime", LocalTime.of(10, 0));
            model.addAttribute("maxTime", LocalTime.of(22, 0));

            List<Table> tables = tableService.getAllTables();
            model.addAttribute("tables", tables);

            return "makeReservation";
        }
    }

    @GetMapping("/my")
    public String myReservations(HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        List<Reservation> reservations = reservationService.getMyReservations(customer.getId());

        List<Integer> reviewedReservationIds = reviewService.getReviewedReservationIds(customer.getId());

        model.addAttribute("reservations", reservations);
        model.addAttribute("reviewedReservationIds", reviewedReservationIds);
        return "myReservations";
    }

    @PostMapping("/cancel/{id}")
    public String cancelReservation(@PathVariable int id, HttpSession session) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        reservationService.cancelReservation(id);
        return "redirect:/reservation/my";
    }

    @GetMapping("/admin/list")
    public String adminViewAllReservations(@RequestParam(required = false) String date,
                                           @RequestParam(required = false) String customerName,
                                           @RequestParam(required = false) Integer tableId,
                                           HttpSession session, Model model) throws SQLException {

        if (session.getAttribute("isAdmin") == null) {
            return "redirect:/admin/login";
        }

        List<Reservation> reservations;

        if (date != null || customerName != null || tableId != null) {
            reservations = reservationService.searchReservations(date, customerName, tableId);
            model.addAttribute("searchPerformed", true);
        } else {
            reservations = reservationService.getAllReservationsWithDetails();
        }

        model.addAttribute("reservations", reservations);
        return "admin/reservations/list";
    }

    @GetMapping("/admin/edit/{id}")
    public String adminEditReservationForm(@PathVariable int id, Model model) throws SQLException {
        Reservation reservation = reservationService.getReservationById(id);
        model.addAttribute("reservation", reservation);
        return "admin/reservations/edit";
    }

    @PostMapping("/admin/update/{id}")
    public String adminUpdateReservation(@PathVariable int id,
                                         @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
                                         @RequestParam @DateTimeFormat(pattern = "HH:mm") LocalTime time,
                                         @RequestParam int partySize,
                                         @RequestParam String specialRequests,
                                         @RequestParam String status) throws SQLException {

        reservationService.updateReservation(id, date, time, partySize, specialRequests);
        reservationService.updateReservationStatus(id, status);
        return "redirect:/reservation/admin/list";
    }

    @GetMapping("/admin/delete/{id}")
    public String adminDeleteReservation(@PathVariable int id) throws SQLException {
        reservationService.cancelReservation(id);
        return "redirect:/reservation/admin/list";
    }

    @GetMapping("/admin/complete/{id}")
    public String completeReservation(@PathVariable int id, HttpSession session) throws SQLException {
        if (session.getAttribute("isAdmin") == null) {
            return "redirect:/admin/login";
        }

        boolean success = reservationService.completeReservation(id);

        if (success) {
            session.setAttribute("success", "Reservation completed and " +
                    reservationService.getReservationById(id).calculatePoints() +
                    " loyalty points added to customer!");
        } else {
            session.setAttribute("error", "Failed to complete reservation");
        }

        return "redirect:/reservation/admin/list";
    }
}