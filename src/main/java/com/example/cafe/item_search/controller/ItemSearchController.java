package com.example.cafe.item_search.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemSearchController {

    @RequestMapping("/item_search")
    public String cafeTeam4() {
        return "main";
    }
}
