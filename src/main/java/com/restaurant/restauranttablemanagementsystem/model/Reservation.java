package com.restaurant.restauranttablemanagementsystem.model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Reservation {
    private int id;
    private int customerId;
    private int tableId;
    private LocalDate reservationDate;
    private LocalTime reservationTime;
    private int partySize;
    private String specialRequests;
    private String status;
    private LocalDate createdAt;

    private String customerName;
    private int tableNumber;

    public Reservation() {}

    public Reservation(int customerId, int tableId, LocalDate reservationDate,
                       LocalTime reservationTime, int partySize) {
        this.customerId = customerId;
        this.tableId = tableId;
        this.reservationDate = reservationDate;
        this.reservationTime = reservationTime;
        this.partySize = partySize;
        this.status = "PENDING";
        this.createdAt = LocalDate.now();
    }

    public int calculatePoints() {
        int basePoints = partySize * 10;
        if (basePoints < 20) {
            basePoints = 20;
        }

        int bonusPoints = 0;
        if (specialRequests != null && !specialRequests.isEmpty()) {
            String lowerReq = specialRequests.toLowerCase();
            if (lowerReq.contains("birthday")) {
                bonusPoints = 50;
            } else if (lowerReq.contains("anniversary")) {
                bonusPoints = 50;
            } else if (lowerReq.contains("celebration")) {
                bonusPoints = 30;
            }
        }

        return basePoints + bonusPoints;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getTableId() { return tableId; }
    public void setTableId(int tableId) { this.tableId = tableId; }

    public LocalDate getReservationDate() { return reservationDate; }
    public void setReservationDate(LocalDate reservationDate) { this.reservationDate = reservationDate; }

    public LocalTime getReservationTime() { return reservationTime; }
    public void setReservationTime(LocalTime reservationTime) { this.reservationTime = reservationTime; }

    public int getPartySize() { return partySize; }
    public void setPartySize(int partySize) { this.partySize = partySize; }

    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDate getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public int getTableNumber() { return tableNumber; }
    public void setTableNumber(int tableNumber) { this.tableNumber = tableNumber; }
}