package com.example.cafe.add_item.controller;

import com.example.cafe.add_item.dao.AddItemDAO;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AddItemController {
    @Autowired
    private AddItemDAO addItemDAO;

    @GetMapping("/add_item")
    public String getItemList(Model model) {
        List<ItemTO> lists = addItemDAO.itemList();
        model.addAttribute("lists", lists);
        return "main";
    }
    @PostMapping("/add_item")
    @ResponseBody
    public int createOrder(@RequestBody Map<String, Object> requestData) {
        int flag = 1;
//      . Orders 데이터 삽입
        OrdersTO ordersTO = new OrdersTO();
        ordersTO.setEmail((String) requestData.get("email"));
        ordersTO.setAddress((String) requestData.get("address"));
        ordersTO.setZip_code((String) requestData.get("postcode"));
        ordersTO.setPassword((String) requestData.get("password"));
//        int result = addItemDAO.addOrders(ordersTO);
//        System.out.println(addItemDAO.addOrders(ordersTO));
//        System.out.println(ordersTO.getOrder_id());


        List<Map<String, Object>> cartSummary = (List<Map<String, Object>>) requestData.get("cartSummary");
        for (Map<String, Object> item : cartSummary) {
            OrderItemTO orderItemTO = new OrderItemTO();
//            orderItemTO.setOrder_id((String) item.get("order_id"));
            orderItemTO.setOrder_id("10");
            orderItemTO.setItem_id(String.valueOf(item.get("id")));
            orderItemTO.setOrderCount(String.valueOf(item.get("count")));
            orderItemTO.setOrderPrice(String.valueOf(item.get("price")));
            System.out.println(orderItemTO);
            System.out.println(addItemDAO.addOrderItem(orderItemTO));
//            int result = addItemDAO.addOrderItem(orderItemTO);
        }
//        if (result == 0) {
//            flag = 0;
//        }

        return flag;
    }
}
