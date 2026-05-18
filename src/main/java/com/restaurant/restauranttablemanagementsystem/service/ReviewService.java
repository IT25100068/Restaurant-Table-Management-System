package com.restaurant.restauranttablemanagementsystem.service;

import com.restaurant.restauranttablemanagementsystem.dao.ReviewDAO;
import com.restaurant.restauranttablemanagementsystem.model.Review;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
public class ReviewService {

    @Autowired
    private ReviewDAO reviewDAO;

    public boolean submitReview(int customerId, int reservationId, int rating, String comment) throws SQLException {
        if (reviewDAO.hasReviewed(customerId, reservationId)) {
            return false;
        }

        Review review = new Review(customerId, reservationId, rating, comment);
        return reviewDAO.createReview(review);
    }

    public List<Review> getMyReviews(int customerId) throws SQLException {
        return reviewDAO.getReviewsByCustomerId(customerId);
    }

    public List<Review> getAllApprovedReviews() throws SQLException {
        return reviewDAO.getAllApprovedReviews();
    }

    public List<Review> getAllReviewsForAdmin() throws SQLException {
        return reviewDAO.getAllReviewsForAdmin();
    }

    public List<Review> getPendingReviews() throws SQLException {
        return reviewDAO.getPendingReviews();
    }

    public boolean approveReview(int id) throws SQLException {
        return reviewDAO.approveReview(id);
    }

    public boolean rejectReview(int id) throws SQLException {
        return reviewDAO.rejectReview(id);
    }

    public boolean updateReview(int id, int rating, String comment) throws SQLException {
        return reviewDAO.updateReview(id, rating, comment);
    }

    public boolean deleteReview(int id, int customerId) throws SQLException {
        return reviewDAO.deleteReview(id, customerId);
    }

    public Review getReviewById(int id) throws SQLException {
        return reviewDAO.getReviewById(id);
    }

    public Map<String, Object> getRatingStatistics() throws SQLException {
        return reviewDAO.getRatingStatistics();
    }

    public boolean hasReviewed(int customerId, int reservationId) throws SQLException {
        return reviewDAO.hasReviewed(customerId, reservationId);
    }

    public List<Integer> getReviewedReservationIds(int customerId) throws SQLException {
        return reviewDAO.getReviewedReservationIds(customerId);
    }
}