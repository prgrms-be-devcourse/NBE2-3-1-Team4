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

import java.util.List;
import java.util.Map;

@Controller
public class AddItemController {
    @Autowired
    private AddItemDAO addItemDAO;

    @GetMapping("/add_item")//사용안함
    public String getItemList(Model model) {
        List<ItemTO> lists = addItemDAO.itemList();
        model.addAttribute("lists", lists);
        return "main";
    }

    @PostMapping("/add_item")
    @ResponseBody
    public int createOrder(@RequestBody Map<String, Object> requestData) {
        int flag = 1;
//      Orders 데이터 추가
        OrdersTO ordersTO = new OrdersTO();
        ordersTO.setEmail((String) requestData.get("email"));
        ordersTO.setAddress((String) requestData.get("address"));
        ordersTO.setZip_code((String) requestData.get("postcode"));
        ordersTO.setPassword((String) requestData.get("password"));
        // INSERT 수행
        addItemDAO.addOrders(ordersTO);

        List<Map<String, Object>> cartSummary = (List<Map<String, Object>>) requestData.get("cartSummary");
        for (Map<String, Object> item : cartSummary) {
            OrderItemTO orderItemTO = new OrderItemTO();
            // INSERT 후 ordersTO.getOrder_id() 호출 시 자동 생성된 값이 반환됨
            orderItemTO.setOrder_id(String.valueOf(ordersTO.getOrder_id()));
            orderItemTO.setItem_id(String.valueOf(item.get("id")));
            orderItemTO.setOrderCount(String.valueOf(item.get("count")));
            int count = Integer.parseInt(String.valueOf(item.get("count")));
            int price = Integer.parseInt(String.valueOf(item.get("price")));
            orderItemTO.setOrderPrice(String.valueOf(count * price));

            int result = addItemDAO.addOrderItem(orderItemTO);
            if (result != 1) { // 하나라도 실패하면 실패 플래그로 설정
                flag = 0;
                break;
            }
        }

        return flag;
    }

    @RequestMapping("/sample2page")
    public String Sample2Page(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        List<ItemTO> lists = addItemDAO.cafeList(pageSize, offset); // 현제 페이지의 항목 수랑, db에서 잘라야 할 offset정의
        List<ItemTO> allLists = addItemDAO.itemList();// 전체 데이터 가져오기
        int totalItemsCount = addItemDAO.getTotalItemsCount(); //전체 데이터 수 조회
        int totalPages = (int) Math.ceil((double) totalItemsCount / pageSize); // 총 페이지 수 계산

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("lists", lists);
        model.addAttribute("allLists", allLists);

        return "sample2_paging";
    }


    @RequestMapping("/main.do")
    public String main(@RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
                       @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
                       Model model) {
        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        List<ItemTO> lists = addItemDAO.cafeList(pageSize, offset); // 현제 페이지의 항목 수랑, db에서 잘라야 할 offset정의
        List<ItemTO> allLists = addItemDAO.itemList();// 전체 데이터 가져오기
        int totalItemsCount = addItemDAO.getTotalItemsCount(); //전체 데이터 수 조회
        int totalPages = (int) Math.ceil((double) totalItemsCount / pageSize); // 총 페이지 수 계산

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("lists", lists);
        model.addAttribute("allLists", allLists);

        return "sample2_paging";
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

            List<OrdersTO> orders = addItemDAO.getOrdersByEmailAndPassword(email, password);
            System.out.println("orders.size() : " + orders.size());
            //  주문이 없을 때
            if (orders.isEmpty()) {
                // 비밀번호 오류로 List 가 안나올 수 있으므로 이메일 검색을 한번 더 진행
                if(addItemDAO.getOrderCount(email) > 1) {
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
        model.addAttribute("orders", addItemDAO.getOrderList(email));
        model.addAttribute("email", email);

        return "orderlist_search";
    }

    // 선택한 주문목록 반환
    @RequestMapping("/orderlist_modifyanddelete.do")
    public String orderlist_modifyanddelete(
            @RequestParam("selectedOrder") int orderId,
            @RequestParam("email") String email,
            Model model
    ){
        model.addAttribute("email", email);
        model.addAttribute("orderTo", addItemDAO.getOrdersById(orderId));

        return "orderlist_modifyanddelete";
    }

    @PostMapping("/delete_item_ok.do")
    public String delete_item_ok(
            @RequestParam("orderId") int orderId,
            Model model
    ) {
        OrdersTO ordersTO = addItemDAO.getOrdersById(orderId);
        model.addAttribute( "flag", addItemDAO.orderDeleteOk( ordersTO ));
        return "orderlist_delete_ok";
    }
}
