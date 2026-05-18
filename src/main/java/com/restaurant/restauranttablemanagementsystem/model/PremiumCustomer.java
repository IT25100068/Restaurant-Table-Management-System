package com.restaurant.restauranttablemanagementsystem.model;

public class PremiumCustomer extends Customer {
    private double discountRate;

    public PremiumCustomer() {
        this.customerType = "PREMIUM";
        this.discountRate = 15.0;
    }

    public PremiumCustomer(String name, String email, String password, String phone) {
        super(name, email, password, phone);
        this.customerType = "PREMIUM";
        this.discountRate = 15.0;
    }

    public double getDiscountRate() { return discountRate; }
    public void setDiscountRate(double discountRate) { this.discountRate = discountRate; }

    @Override
    public double calculateDiscount(double amount) {
        return amount * (discountRate / 100);
    }

    @Override
    public int addLoyaltyPoints(double amount) {
        int points = (int)(amount / 10);
        this.loyaltyPoints += points;
        return points;
    }
}