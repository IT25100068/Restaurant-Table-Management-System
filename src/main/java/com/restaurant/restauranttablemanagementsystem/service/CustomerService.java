package com.restaurant.restauranttablemanagementsystem.service;



import com.restaurant.restauranttablemanagementsystem.dao.CustomerDAO;
import com.restaurant.restauranttablemanagementsystem.model.Customer;
import com.restaurant.restauranttablemanagementsystem.model.PremiumCustomer;
import com.restaurant.restauranttablemanagementsystem.model.RegularCustomer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class CustomerService {

    @Autowired
    private CustomerDAO customerDAO;

    public boolean registerCustomer(String name, String email, String password,
                                    String phone, String address, boolean isPremium) throws SQLException {
        if (customerDAO.getCustomerByEmail(email) != null) {
            return false;
        }

        Customer customer;
        if (isPremium) {
            customer = new PremiumCustomer(name, email, password, phone);
        } else {
            customer = new RegularCustomer(name, email, password, phone);
        }
        customer.setAddress(address);

        return customerDAO.createCustomer(customer);
    }

    public Customer loginCustomer(String email, String password) throws SQLException {
        Customer customer = customerDAO.getCustomerByEmail(email);
        if (customer != null && customer.getPassword().equals(password)) {
            return customer;
        }
        return null;
    }

    public Customer getCustomerById(int id) throws SQLException {
        return customerDAO.getCustomerById(id);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDAO.getAllCustomers();
    }

    public boolean updateProfile(Customer customer) throws SQLException {
        return customerDAO.updateCustomer(customer);
    }

    public boolean deleteAccount(int customerId) throws SQLException {
        return customerDAO.deleteCustomer(customerId);
    }

    public double calculateCustomerDiscount(Customer customer, double amount) {
        return customer.calculateDiscount(amount);
    }

    public boolean addPointsToCustomer(Customer customer, double amount) throws SQLException {
        int points = customer.addLoyaltyPoints(amount);
        return customerDAO.updateLoyaltyPoints(customer.getId(), points);
    }

    public List<Customer> searchCustomers(String keyword) throws SQLException {
        return customerDAO.searchCustomersByName(keyword);
    }

    public boolean updateCustomer(Customer customer) throws SQLException {
        return customerDAO.updateCustomer(customer);
    }

    public boolean addLoyaltyPointsToCustomer(int customerId, int points) throws SQLException {
        return customerDAO.updateLoyaltyPoints(customerId, points);
    }

    public boolean upgradeToPremium(int customerId) throws SQLException {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null && "REGULAR".equals(customer.getCustomerType())) {
            PremiumCustomer premiumCustomer = new PremiumCustomer();
            premiumCustomer.setId(customer.getId());
            premiumCustomer.setName(customer.getName());
            premiumCustomer.setEmail(customer.getEmail());
            premiumCustomer.setPassword(customer.getPassword());
            premiumCustomer.setPhone(customer.getPhone());
            premiumCustomer.setAddress(customer.getAddress());
            premiumCustomer.setLoyaltyPoints(customer.getLoyaltyPoints());
            premiumCustomer.setCustomerType("PREMIUM");
            premiumCustomer.setDiscountRate(15.0);
            return customerDAO.upgradeToPremium(premiumCustomer);
        }
        return false;
    }

    public boolean downgradeToRegular(int customerId) throws SQLException {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null && "PREMIUM".equals(customer.getCustomerType())) {
            RegularCustomer regularCustomer = new RegularCustomer();
            regularCustomer.setId(customer.getId());
            regularCustomer.setName(customer.getName());
            regularCustomer.setEmail(customer.getEmail());
            regularCustomer.setPassword(customer.getPassword());
            regularCustomer.setPhone(customer.getPhone());
            regularCustomer.setAddress(customer.getAddress());
            regularCustomer.setLoyaltyPoints(customer.getLoyaltyPoints());
            regularCustomer.setCustomerType("REGULAR");
            return customerDAO.downgradeToRegular(regularCustomer);
        }
        return false;
    }
}