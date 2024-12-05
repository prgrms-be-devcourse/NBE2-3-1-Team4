package com.example.cafe.updateitem.controller;

import com.example.cafe.dao.UpdateItemDAO;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UpdateItemController {
    @Autowired
    UpdateItemDAO updateItemDAO;

    @RequestMapping("/update_item")
    public String cafeTeam4(@RequestParam(value = "email") String email, Model model) {
        //상품 목록 조회
        List<ItemTO> items = updateItemDAO.getAllItems(); //DAO -> DB 통해서 데이터 조회
        model.addAttribute("items", items);

        //이메일 -> 사용자 조회
        OrdersTO orders = updateItemDAO.getUserByEmail(email);
        model.addAttribute("orders", orders);

        //주문 상품 조회
        List<OrderItemTO> orderItem = updateItemDAO.getOrderByEmail(email);
        model.addAttribute("orderItem", orderItem);

        return "update";
    }

    @RequestMapping("/update_item_ok")
    public String cafeTeam4_ok(HttpServletRequest request, Model model) {
        System.out.println("Received email: " + request.getParameter("email"));
        System.out.println("Received address: " + request.getParameter("address"));
        System.out.println("Received zip_code: " + request.getParameter("zip_code"));

        OrdersTO orders = new OrdersTO();
        orders.setEmail(request.getParameter("email"));
        orders.setAddress(request.getParameter("address"));
        orders.setZip_code(request.getParameter("zip_code"));

        model.addAttribute("email",orders.getEmail());
        model.addAttribute("flag", updateItemDAO.updateOrders(orders));
        return "update_ok";
    }

    @RequestMapping("/main")
    public String check(){
        return "main";
    }
}
