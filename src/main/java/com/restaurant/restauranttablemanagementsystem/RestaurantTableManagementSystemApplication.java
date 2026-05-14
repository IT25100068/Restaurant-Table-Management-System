package com.restaurant.restauranttablemanagementsystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RestaurantTableManagementSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(RestaurantTableManagementSystemApplication.class, args);
        System.out.println("=========================================");
        System.out.println("Restaurant Reservation Platform Started!");
        System.out.println("Access at: http://localhost:8080/customer/login");
        System.out.println("Access at: http://localhost:8080/admin/login");
        System.out.println("=========================================");
    }

}
