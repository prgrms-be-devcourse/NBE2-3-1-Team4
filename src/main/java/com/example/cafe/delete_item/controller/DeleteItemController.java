package com.example.cafe.delete_item.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DeleteItemController {

    @RequestMapping("/delete_item")
    public String cafeTeam4() {
        return "main";
    }
}
