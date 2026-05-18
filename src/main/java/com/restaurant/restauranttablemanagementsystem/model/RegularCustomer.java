package com.restaurant.restauranttablemanagementsystem.model;

public class RegularCustomer extends Customer {

    public RegularCustomer() {
        this.customerType = "REGULAR";
    }

    public RegularCustomer(String name, String email, String password, String phone) {
        super(name, email, password, phone);
        this.customerType = "REGULAR";
    }

    @Override
    public double calculateDiscount(double amount) {
        return 0;
    }

    @Override
    public int addLoyaltyPoints(double amount) {
        int points = (int)(amount / 20);
        this.loyaltyPoints += points;
        return points;
    }
}