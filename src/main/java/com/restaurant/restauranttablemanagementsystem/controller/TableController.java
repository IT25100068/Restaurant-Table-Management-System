package com.restaurant.restauranttablemanagementsystem.controller;


import com.restaurant.restauranttablemanagementsystem.model.Table;
import com.restaurant.restauranttablemanagementsystem.service.TableService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Controller
@RequestMapping("/admin/tables")
public class TableController {

    @Autowired
    private TableService tableService;

    @GetMapping("/list")
    public String listTables(@RequestParam(required = false) Integer capacity,
                             @RequestParam(required = false) String location,
                             @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
                             @RequestParam(required = false) @DateTimeFormat(pattern = "HH:mm") LocalTime time,
                             HttpSession session, Model model) throws SQLException {

        List<Table> tables;


        if (capacity != null || location != null || date != null || time != null) {
            tables = tableService.searchTables(capacity, location, date, time);
            model.addAttribute("searchPerformed", true);
        } else {
            tables = tableService.getAllTables();
        }

        model.addAttribute("tables", tables);
        return "admin/tables/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("table", new Table());
        return "admin/tables/add";
    }

    @PostMapping("/add")
    public String addTable(@ModelAttribute Table table,
                           @RequestParam(required = false) Boolean weatherProtected,
                           HttpSession session, Model model) throws SQLException {

        boolean success = tableService.addTable(
                table.getTableNumber(),
                table.getSeatingCapacity(),
                table.getLocation(),
                table.getPricePerHour(),
                weatherProtected != null
        );

        if (success) {
            return "redirect:/admin/tables/list";
        } else {
            model.addAttribute("error", "Failed to add table. Table number may already exist.");
            return "admin/tables/add";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) throws SQLException {
        Table table = tableService.getTableById(id);
        model.addAttribute("table", table);
        return "admin/tables/edit";
    }

    @PostMapping("/edit/{id}")
    public String updateTable(@PathVariable int id,
                              @RequestParam int seatingCapacity,
                              @RequestParam String location,
                              @RequestParam double pricePerHour,
                              @RequestParam boolean isAvailable,
                              HttpSession session) throws SQLException {

        tableService.updateTable(id, seatingCapacity, location, pricePerHour, isAvailable);
        return "redirect:/admin/tables/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteTable(@PathVariable int id) throws SQLException {
        tableService.deleteTable(id);
        return "redirect:/admin/tables/list";
    }

    @GetMapping("/search")
    @ResponseBody
    public List<Table> searchAvailableTables(@RequestParam int capacity,
                                             @RequestParam String date,
                                             @RequestParam String time) throws SQLException {
        LocalDate searchDate = LocalDate.parse(date);
        LocalTime searchTime = LocalTime.parse(time);
        return tableService.searchAvailableTables(capacity, searchDate, searchTime);
    }
}