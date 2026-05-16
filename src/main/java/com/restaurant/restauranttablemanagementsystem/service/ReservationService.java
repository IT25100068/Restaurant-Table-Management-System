package com.restaurant.restauranttablemanagementsystem.service;


import com.restaurant.restauranttablemanagementsystem.dao.CustomerDAO;
import com.restaurant.restauranttablemanagementsystem.dao.ReservationDAO;
import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class ReservationService {

    @Autowired
    private ReservationDAO reservationDAO;

    @Autowired
    private CustomerDAO customerDAO;

    public boolean makeReservation(int customerId, int tableId, LocalDate date,
                                   LocalTime time, int partySize, String specialRequests) throws SQLException {
        if (!reservationDAO.isTableAvailable(tableId, date, time)) {
            return false;
        }

        Reservation reservation = new Reservation(customerId, tableId, date, time, partySize);
        reservation.setSpecialRequests(specialRequests);

        return reservationDAO.createReservation(reservation);
    }

    public List<Reservation> getMyReservations(int customerId) throws SQLException {
        return reservationDAO.getReservationsByCustomerId(customerId);
    }

    public Reservation getReservationById(int id) throws SQLException {
        return reservationDAO.getReservationById(id);
    }

    public boolean cancelReservation(int reservationId) throws SQLException {
        return reservationDAO.cancelReservation(reservationId);
    }

    public boolean updateReservationStatus(int reservationId, String status) throws SQLException {
        return reservationDAO.updateReservationStatus(reservationId, status);
    }

    public List<Reservation> getAllReservationsWithDetails() throws SQLException {
        return reservationDAO.getAllReservationsWithDetails();
    }

    public List<Reservation> searchReservations(String date, String customerName, Integer tableId) throws SQLException {
        return reservationDAO.searchReservations(date, customerName, tableId);
    }

    public boolean updateReservation(int id, LocalDate date, LocalTime time, int partySize, String specialRequests) throws SQLException {
        return reservationDAO.updateReservation(id, date, time, partySize, specialRequests);
    }

    public boolean isTableAvailable(int tableId, LocalDate date, LocalTime time) throws SQLException {
        return reservationDAO.isTableAvailable(tableId, date, time);
    }

    public List<Reservation> getCompletedReservations(int customerId) throws SQLException {
        return reservationDAO.getCompletedReservationsByCustomerId(customerId);
    }

    public List<Reservation> getPendingCompletedReservations() throws SQLException {
        return reservationDAO.getPendingCompletedReservations();
    }


    public boolean completeReservation(int reservationId) throws SQLException {
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        if (reservation == null) {
            System.out.println("Reservation not found: " + reservationId);
            return false;
        }

        boolean updated = reservationDAO.updateReservationStatus(reservationId, "COMPLETED");

        if (updated) {
            int points = reservation.calculatePoints();
            System.out.println("Base points calculated: " + points);

            Customer customer = customerDAO.getCustomerById(reservation.getCustomerId());
            if (customer != null && "PREMIUM".equals(customer.getCustomerType())) {
                int bonusPoints = (int)(points * 0.5);
                points = points + bonusPoints;
                System.out.println("Premium bonus added: +" + bonusPoints + " = " + points);
            }

            boolean pointsAdded = customerDAO.updateLoyaltyPoints(reservation.getCustomerId(), points);

            if (pointsAdded) {
                System.out.println(" Added " + points + " loyalty points to customer ID: " + reservation.getCustomerId());
            } else {
                System.out.println(" Failed to add loyalty points to customer ID: " + reservation.getCustomerId());
            }

            return pointsAdded;
        }

        return updated;
    }
}