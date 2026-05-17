package com.restaurant.restauranttablemanagementsystem.controller;

import com.restaurant.restauranttablemanagementsystem.model.Admin;
import com.restaurant.restauranttablemanagementsystem.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/login")
    public String showLogin() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) throws SQLException {

        Admin admin = adminService.authenticate(email, password);

        if (admin != null) {
            session.setAttribute("loggedAdmin", admin);
            session.setAttribute("isAdmin", true);
            session.setAttribute("adminRole", admin.getRole());
            return "redirect:/admin/dashboard";
        }

        model.addAttribute("error", "Invalid email or password!");
        return "admin/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("loggedAdmin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        return "admin/dashboard";
    }

    @GetMapping("/list")
    public String listAdmins(HttpSession session, Model model) throws SQLException {
        Admin currentAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (currentAdmin == null || !"SUPER_ADMIN".equals(currentAdmin.getRole())) {
            return "redirect:/admin/login";
        }

        List<Admin> admins = adminService.getAllAdmins();

        model.addAttribute("admins", admins);
        return "admin/adminList";
    }

    @GetMapping("/add")
    public String showAddAdminForm(HttpSession session) {
        Admin currentAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (currentAdmin == null || !"SUPER_ADMIN".equals(currentAdmin.getRole())) {
            return "redirect:/admin/login";
        }
        return "admin/addAdmin";
    }

    @PostMapping("/add")
    public String addAdmin(@RequestParam String username,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String fullName,
                           @RequestParam String role,
                           HttpSession session,
                           Model model) throws SQLException {

        Admin currentAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (currentAdmin == null || !"SUPER_ADMIN".equals(currentAdmin.getRole())) {
            return "redirect:/admin/login";
        }

        boolean success = adminService.registerAdmin(username, email, password, fullName, role);

        if (success) {
            return "redirect:/admin/list";
        } else {
            model.addAttribute("error", "Email already exists!");
            return "admin/addAdmin";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable int id, HttpSession session) throws SQLException {
        Admin currentAdmin = (Admin) session.getAttribute("loggedAdmin");
        if (currentAdmin == null || !"SUPER_ADMIN".equals(currentAdmin.getRole())) {
            return "redirect:/admin/login";
        }

        if (currentAdmin.getId() == id) {
            return "redirect:/admin/list?error=Cannot delete yourself";
        }

        adminService.deleteAdmin(id);
        return "redirect:/admin/list";
    }
}