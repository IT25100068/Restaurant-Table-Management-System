package com.restaurant.restauranttablemanagementsystem.service;


import com.restaurant.restauranttablemanagementsystem.dao.MenuDAO;
import com.restaurant.restauranttablemanagementsystem.model.MenuItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class MenuService {

    @Autowired
    private MenuDAO menuDAO;

    public List<MenuItem> getAllMenuItems() throws SQLException {
        return menuDAO.getAllMenuItems();
    }

    public List<MenuItem> getAppetizers() throws SQLException {
        return menuDAO.getMenuItemsByCategory("APPETIZER");
    }

    public List<MenuItem> getMainCourses() throws SQLException {
        return menuDAO.getMenuItemsByCategory("MAIN_COURSE");
    }

    public List<MenuItem> getDesserts() throws SQLException {
        return menuDAO.getMenuItemsByCategory("DESSERT");
    }

    public List<MenuItem> getBeverages() throws SQLException {
        return menuDAO.getMenuItemsByCategory("BEVERAGE");
    }

    public MenuItem getMenuItemById(int id) throws SQLException {
        return menuDAO.getMenuItemById(id);
    }
}