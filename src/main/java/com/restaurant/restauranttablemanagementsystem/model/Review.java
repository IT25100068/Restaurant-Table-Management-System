package com.restaurant.restauranttablemanagementsystem.model;

import java.time.LocalDate;

public class Review {
    private int id;
    private int customerId;
    private int reservationId;
    private int rating;
    private String comment;
    private boolean isApproved;
    private LocalDate createdAt;

    private String createdAtStr;


    private String customerName;
    private String customerEmail;

    public Review() {}

    public Review(int customerId, int reservationId, int rating, String comment) {
        this.customerId = customerId;
        this.reservationId = reservationId;
        this.rating = rating;
        this.comment = comment;
        this.isApproved = false;
        this.createdAt = LocalDate.now();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public boolean isApproved() { return isApproved; }
    public void setApproved(boolean approved) { isApproved = approved; }

    public LocalDate getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCreatedAtStr() {
        return createdAtStr;
    }

    public void setCreatedAtStr(String createdAtStr) {
        this.createdAtStr = createdAtStr;
    }
}