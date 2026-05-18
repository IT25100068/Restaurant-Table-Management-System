package com.restaurant.restauranttablemanagementsystem.controller;


import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.Reservation;
import com.restaurant.restauranttablemanagementsystem.model.Review;
import com.restaurant.restauranttablemanagementsystem.service.ReservationService;
import com.restaurant.restauranttablemanagementsystem.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/new")
    public String showReviewForm(HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        List<Reservation> allReservations = reservationService.getMyReservations(customer.getId());

        List<Reservation> completedReservations = allReservations.stream()
                .filter(r -> "COMPLETED".equals(r.getStatus()))
                .filter(r -> {
                    try {
                        return !reviewService.hasReviewed(customer.getId(), r.getId());
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                })
                .collect(Collectors.toList());

        model.addAttribute("reservations", completedReservations);
        return "writeReview";
    }

    @PostMapping("/submit")
    public String submitReview(@RequestParam int reservationId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               HttpSession session,
                               Model model) throws SQLException {

        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        if (reviewService.hasReviewed(customer.getId(), reservationId)) {
            model.addAttribute("error", "You have already reviewed this reservation.");
            return "redirect:/review/my";
        }

        boolean success = reviewService.submitReview(customer.getId(), reservationId, rating, comment);

        if (success) {
            model.addAttribute("success", "Thank you for your review! It will be displayed after moderation.");
        } else {
            model.addAttribute("error", "Failed to submit review. Please try again.");
        }

        return "redirect:/review/my";
    }

    @GetMapping("/my")
    public String myReviews(HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        List<Review> reviews = reviewService.getMyReviews(customer.getId());
        model.addAttribute("reviews", reviews);
        return "myReviews";
    }

    @GetMapping("/all")
    public String allReviews(Model model) throws SQLException {
        List<Review> reviews = reviewService.getAllApprovedReviews();
        model.addAttribute("reviews", reviews);
        return "allReviews";
    }

    @GetMapping("/edit/{id}")
    public String showEditReviewForm(@PathVariable int id, HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        Review review = reviewService.getReviewById(id);

        if (review == null || review.getCustomerId() != customer.getId()) {
            return "redirect:/review/my";
        }

        if (review.isApproved()) {
            model.addAttribute("error", "This review has already been approved and cannot be edited.");
            return "redirect:/review/my";
        }

        model.addAttribute("review", review);
        return "editReview";
    }

    @PostMapping("/update/{id}")
    public String updateReview(@PathVariable int id,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               HttpSession session,
                               Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        Review review = reviewService.getReviewById(id);

        if (review == null || review.getCustomerId() != customer.getId()) {
            return "redirect:/review/my";
        }

        if (review.isApproved()) {
            model.addAttribute("error", "This review has already been approved and cannot be updated.");
            return "redirect:/review/my";
        }

        reviewService.updateReview(id, rating, comment);
        model.addAttribute("success", "Review updated successfully!");
        return "redirect:/review/my";
    }

    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable int id, HttpSession session, Model model) throws SQLException {
        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        if (customer == null) {
            return "redirect:/customer/login";
        }

        Review review = reviewService.getReviewById(id);

        if (review == null || review.getCustomerId() != customer.getId()) {
            return "redirect:/review/my";
        }

        if (review.isApproved()) {
            model.addAttribute("error", "This review has already been approved and cannot be deleted.");
            return "redirect:/review/my";
        }

        reviewService.deleteReview(id, customer.getId());
        model.addAttribute("success", "Review deleted successfully!");
        return "redirect:/review/my";
    }

    @GetMapping("/admin/moderation")
    public String moderationPanel(HttpSession session, Model model) throws SQLException {
        if (session.getAttribute("isAdmin") == null) {
            return "redirect:/admin/login";
        }

        List<Review> pendingReviews = reviewService.getPendingReviews();
        List<Review> allReviews = reviewService.getAllReviewsForAdmin();
        Map<String, Object> stats = reviewService.getRatingStatistics();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        for (Review review : pendingReviews) {
            if (review.getCreatedAt() != null) {
                review.setCreatedAtStr(review.getCreatedAt().format(formatter));
            }
        }

        for (Review review : allReviews) {
            if (review.getCreatedAt() != null) {
                review.setCreatedAtStr(review.getCreatedAt().format(formatter));
            }
        }

        model.addAttribute("pendingReviews", pendingReviews);
        model.addAttribute("allReviews", allReviews);
        model.addAttribute("stats", stats);
        return "admin/reviews/moderation";
    }

    @GetMapping("/admin/approve/{id}")
    public String approveReview(@PathVariable int id, HttpSession session) throws SQLException {
        if (session.getAttribute("isAdmin") == null) {
            return "redirect:/admin/login";
        }

        reviewService.approveReview(id);
        return "redirect:/review/admin/moderation";
    }

    @GetMapping("/admin/reject/{id}")
    public String rejectReview(@PathVariable int id, HttpSession session) throws SQLException {
        if (session.getAttribute("isAdmin") == null) {
            return "redirect:/admin/login";
        }

        reviewService.rejectReview(id);
        return "redirect:/review/admin/moderation";
    }

    @GetMapping("/ratings")
    public String ratingSummary(Model model) throws SQLException {
        Map<String, Object> stats = reviewService.getRatingStatistics();
        List<Review> topReviews = reviewService.getAllApprovedReviews();

        model.addAttribute("stats", stats);
        model.addAttribute("topReviews", topReviews.stream().limit(5).collect(Collectors.toList()));
        return "ratingSummary";
    }
}