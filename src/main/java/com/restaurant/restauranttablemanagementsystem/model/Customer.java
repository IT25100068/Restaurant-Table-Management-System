package com.restaurant.restauranttablemanagementsystem.model;

public abstract class Customer {
    protected int id;
    protected String name;
    protected String email;
    protected String password;
    protected String phone;
    protected String address;
    protected String customerType;
    protected int loyaltyPoints;
    protected String registrationDate;

    public Customer() {}

    public Customer(String name, String email, String password, String phone) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.loyaltyPoints = 0;
    }

    public int getId() {
        return id; 
    }
    public void setId(int id) {
        this.id = id; 
    }

    public String getName() {
        return name; 
    }
    public void setName(String name) {
        this.name = name; 
    }

    public String getEmail() { 
        return email;
    }
    public void setEmail(String email) {
        this.email = email; 
    }

    public String getPassword() {
        return password; 
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone; 
    }
    public void setPhone(String phone) {
        this.phone = phone; 
    }

    public String getAddress() {
        return address; 
    }
    public void setAddress(String address) {
        this.address = address; 
    }

    public String getCustomerType() {
        return customerType; 
    }
    public void setCustomerType(String customerType) {
        this.customerType = customerType; 
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }
    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints; 
    }

    public abstract double calculateDiscount(double amount);
    public abstract int addLoyaltyPoints(double amount);


    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }
}
