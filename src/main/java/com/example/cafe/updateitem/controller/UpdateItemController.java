package com.example.cafe.updateitem.controller;

import com.example.cafe.dao.UpdateItemDAO;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UpdateItemController {
    @Autowired
    UpdateItemDAO updateItemDAO;

    @RequestMapping("/update_item")
    public String updateItemPage(@RequestParam(value = "order_id") String orderId, Model model, HttpServletRequest request) {
        // orderId가 null인지 확인
        System.out.println("Received order_id: " + orderId);

        // orderId를 request에 설정
        request.setAttribute("order_id", orderId);

        // 나머지 코드
        List<ItemTO> items = updateItemDAO.getAllItems();
        model.addAttribute("items", items);

        OrdersTO orders = updateItemDAO.getUserByOrderId(orderId);
        model.addAttribute("orders", orders);

        List<OrderItemTO> orderItems = updateItemDAO.getOrderByOrderId(orderId);
        model.addAttribute("orderItem", orderItems);

        return "update";
    }

    @PostMapping("/update_item_ok")
    public String updateItemOk(HttpServletRequest request, Model model) {
        System.out.println("Received order_id: " + request.getParameter("order_id"));
        System.out.println("Received address: " + request.getParameter("address"));
        System.out.println("Received zip_code: " + request.getParameter("zip_code"));
        System.out.println("Received orderPrice: " + request.getParameter("orderPrice"));
        System.out.println("Received orderCount: " + request.getParameter("orderCount"));// 추가된 부분
        System.out.println("Received itemName: " + request.getParameter("item_id")); // 추가된 부분

        // OrdersTO 객체 생성
        OrdersTO orders = new OrdersTO();
        orders.setOrder_id(request.getParameter("order_id"));
        orders.setAddress(request.getParameter("address"));
        orders.setZip_code(request.getParameter("zip_code"));

        /// OrderItemTO 객체 생성 및 값 설정
        OrderItemTO orderItem = new OrderItemTO();
        orderItem.setOrderPrice(request.getParameter("orderPrice")); // 주문 가격 (String)
        orderItem.setOrderCount(request.getParameter("orderCount"));
        orderItem.setItem_id(request.getParameter("item_id"));// 주문 개수 (String)

        // 주문 개수 업데이트
        //int flag1= updateItemDAO.updateOrderCount(orderItem);
        int flag2= updateItemDAO.updateOrders(orders);

        // 결과를 플래그로 설정
        //model.addAttribute("flag", flag1);
        model.addAttribute("flag", flag2);

        return "update_ok";
    }

    @RequestMapping("/main")
    public String mainPage() {
        return "main";
    }
}
