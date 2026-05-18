package com.restaurant.restauranttablemanagementsystem.service;


import com.restaurant.restauranttablemanagementsystem.dao.ReservationDAO;
import com.restaurant.restauranttablemanagementsystem.model.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class ReservationService {

    @Autowired
    private ReservationDAO reservationDAO;




    public List<Reservation> getMyReservations(int customerId) throws SQLException {
        return reservationDAO.getReservationsByCustomerId(customerId);
    }


}