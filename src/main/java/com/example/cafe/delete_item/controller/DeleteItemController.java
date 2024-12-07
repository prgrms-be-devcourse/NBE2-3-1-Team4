package com.example.cafe.delete_item.controller;

import com.example.cafe.delete_item.dao.OrdersDAO;
import com.example.cafe.dto.OrdersTO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DeleteItemController {
    @Autowired
    private OrdersDAO ordersDAO;

    @RequestMapping("/main.do")
    public String main(String order) {
        return "main";
    }

    @RequestMapping("/login.do")
    public String login() {
        return "login";
    }

    @RequestMapping("/login_ok.do")
    public String login_ok(
            HttpServletRequest request,
            Model model) {
        try {
            String email = request.getParameter( "email" );
            String password = request.getParameter( "password" );

            List<OrdersTO> orders = ordersDAO.getOrdersByEmailAndPassword(email, password);
            System.out.println("orders.size() : " + orders.size());
            //  주문이 없을 때
            if (orders.isEmpty()) {
                // 비밀번호 오류로 List 가 안나올 수 있으므로 이메일 검색을 한번 더 진행
                if(ordersDAO.getOrderCount(email) > 1) {
                    model.addAttribute("flag", 1);  // 비밀번호 오류
                } else {
                    model.addAttribute("flag", 2);  // 주문내역 없음
                }
                return "login_ok";
            }
            model.addAttribute("flag", 0);    // 정상

            // 성공 시, 이메일과 비밀번호가 맞는 OrdersTO List 를 view 에 전달
            model.addAttribute("toList", orders);

        } catch (Exception e) {
            System.out.println("[ERROR] : " + e.getMessage());
            model.addAttribute("flag", 3);   // 기타 오류
        }
        return "login_ok";
    }

    // 로그인 후 주문목록 리스트 반환
    @RequestMapping("/orderlist_search.do")
    public String orderlist_search(String email, Model model) {

        System.out.println("orderlist_search : " + email);
        // email로 주문목록들을 조회 후 view에 반환
        model.addAttribute("orders", ordersDAO.getOrderList(email));
        model.addAttribute("email", email);

        return "orderlist_search";
    }

    // 선택한 주문목록 반환
    @RequestMapping("/orderlist_modifyanddelete.do")
    public String orderlist_modifyanddelete(
            @RequestParam("selectedOrder") String orderId,
            @RequestParam("email") String email,
           Model model
    ){
        model.addAttribute("email", email);
        model.addAttribute("orderTo", ordersDAO.getOrdersById(orderId));

        return "orderlist_modifyanddelete";
    }

    @PostMapping("/delete_item_ok.do")
    public String delete_item_ok(
            @RequestParam("orderId") String orderId,
            Model model
    ) {
       OrdersTO ordersTO = ordersDAO.getOrdersById(orderId);
        model.addAttribute( "flag", ordersDAO.orderDeleteOk( ordersTO ));
        return "orderlist_delete_ok";
    }

    /*@DeleteMapping("/orders/{orderId}")
    @ResponseBody
    public Map<String, Object> delete_item_ok(
            @PathVariable("orderId") String orderId
    ) {
        OrdersTO ordersTO = ordersDAO.getOrdersById(orderId);
        int flag = ordersDAO.orderDeleteOk(ordersTO);

        Map<String, Object> response = new HashMap<>();
        response.put("flag", flag);
        return response;
    }*/
}
