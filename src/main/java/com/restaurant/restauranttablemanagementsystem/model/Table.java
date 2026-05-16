package com.restaurant.restauranttablemanagementsystem.model;

public class Table {
    private int id;
    private int tableNumber;
    private int seatingCapacity;
    private String location;
    private boolean isAvailable;
    private double pricePerHour;
    private boolean weatherProtected;

    public Table() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTableNumber() { return tableNumber; }
    public void setTableNumber(int tableNumber) { this.tableNumber = tableNumber; }

    public int getSeatingCapacity() { return seatingCapacity; }
    public void setSeatingCapacity(int seatingCapacity) { this.seatingCapacity = seatingCapacity; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }

    public double getPricePerHour() { return pricePerHour; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }

    public boolean isWeatherProtected() { return weatherProtected; }
    public void setWeatherProtected(boolean weatherProtected) { this.weatherProtected = weatherProtected; }
}