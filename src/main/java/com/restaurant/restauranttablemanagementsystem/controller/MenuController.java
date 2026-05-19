package com.restaurant.restauranttablemanagementsystem.controller;


import com.restaurant.restauranttablemanagementsystem.model.MenuItem;
import com.restaurant.restauranttablemanagementsystem.service.MenuService;
import org.eclipse.tags.shaded.org.apache.xpath.operations.String;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @GetMapping("/view")
    public String viewMenu(Model model) throws SQLException {
        List<MenuItem> appetizers = menuService.getAppetizers();
        List<MenuItem> mainCourses = menuService.getMainCourses();
        List<MenuItem> desserts = menuService.getDesserts();
        List<MenuItem> beverages = menuService.getBeverages();

        model.addAttribute("appetizers", appetizers);
        model.addAttribute("mainCourses", mainCourses);
        model.addAttribute("desserts", desserts);
        model.addAttribute("beverages", beverages);

        return "menu";
    }
}