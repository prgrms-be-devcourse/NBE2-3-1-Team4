package com.example.cafe.updateitem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UpdateItemController {

    @RequestMapping("/update_item")
    public String cafeTeam4() {
        return "main";
    }
    @RequestMapping("/update_item_ok")
    public String cafeTeam4_ok() {

        return "main";
    }

    @RequestMapping("/email_check")
    public String check(){
        return "check";
    }
}
