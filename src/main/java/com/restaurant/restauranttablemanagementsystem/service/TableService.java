package com.restaurant.restauranttablemanagementsystem.service;

import com.restaurant.restauranttablemanagementsystem.dao.TableDAO;
import com.restaurant.restauranttablemanagementsystem.model.Table;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class TableService {

    @Autowired
    private TableDAO tableDAO;

    public boolean addTable(int tableNumber, int seatingCapacity, String location,
                            double pricePerHour, boolean weatherProtected) throws SQLException {
        return tableDAO.addTable(tableNumber, seatingCapacity, location, pricePerHour, weatherProtected);
    }

    public List<Table> getAllTables() throws SQLException {
        return tableDAO.getAllTables();
    }

    public List<Table> getAvailableTables(int capacity, LocalDate date, LocalTime time) throws SQLException {
        return tableDAO.getAvailableTables();
    }

    public Table getTableById(int id) throws SQLException {
        return tableDAO.getTableById(id);
    }

    public boolean updateTable(int id, int seatingCapacity, String location,
                               double pricePerHour, boolean isAvailable) throws SQLException {
        return tableDAO.updateTable(id, seatingCapacity, location, pricePerHour, isAvailable);
    }

    public boolean deleteTable(int id) throws SQLException {
        return tableDAO.deleteTable(id);
    }


    public List<Table> searchTables(Integer capacity, String location, LocalDate date, LocalTime time) throws SQLException {
        return tableDAO.searchTables(capacity, location, date, time);
    }

    public List<Table> searchAvailableTables(int capacity, LocalDate date, LocalTime time) throws SQLException {
        return tableDAO.searchAvailableTables(capacity, date, time);
    }

    public boolean isTableAvailable(int tableId, LocalDate date, LocalTime time) throws SQLException {
        return tableDAO.isTableAvailable(tableId, date, time);
    }
}