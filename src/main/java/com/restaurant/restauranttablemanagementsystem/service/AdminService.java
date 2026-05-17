
package com.restaurant.restauranttablemanagementsystem.service;


import com.restaurant.restauranttablemanagementsystem.dao.AdminDAO;
import com.restaurant.restauranttablemanagementsystem.model.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class AdminService {

    @Autowired
    private AdminDAO adminDAO;

    public Admin authenticate(String email, String password) throws SQLException {
        return adminDAO.authenticate(email, password);
    }

    public Admin getAdminByEmail(String email) throws SQLException {
        return adminDAO.getAdminByEmail(email);
    }

    public Admin getAdminById(int id) throws SQLException {
        return adminDAO.getAdminById(id);
    }

    public List<Admin> getAllAdmins() throws SQLException {
        return adminDAO.getAllAdmins();
    }

    public boolean registerAdmin(String username, String email, String password, String fullName, String role) throws SQLException {
        if (adminDAO.getAdminByEmail(email) != null) {
            return false;
        }

        Admin admin = new Admin(username, email, password, fullName, role);
        return adminDAO.createAdmin(admin);
    }

    public boolean updateAdmin(int id, String fullName, String role, boolean isActive) throws SQLException {
        return adminDAO.updateAdmin(id, fullName, role, isActive);
    }

    public boolean changePassword(int id, String newPassword) throws SQLException {
        return adminDAO.changePassword(id, newPassword);
    }

    public boolean deleteAdmin(int id) throws SQLException {
        return adminDAO.deleteAdmin(id);
    }
}