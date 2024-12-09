package com.example.cafe.add_item.dao;

import com.example.cafe.add_item.mapper.AddItemMapper;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AddItemDAO {

    @Autowired
    private AddItemMapper addItemMapper;

    public ArrayList<ItemTO> itemList(){
        return addItemMapper.itemAll();
    }

    // Orders 데이터 추가
    public int addOrders(OrdersTO to) {
        int flag = 1;
        int result = addItemMapper.ordersAdd(to);
        if( result != 1 ) {
            flag = 0;
        }
        return flag;
    }

    // OrderItem 데이터 추가
    public int addOrderItem(OrderItemTO to) {
        int flag = 1;
        int result = addItemMapper.orderItemAdd(to);
        if(result != 1 ) {
            flag = 0;
        }
        return flag;
    }

    public List<ItemTO> cafeList(int limit, int offset) {
        Map<String, Object> params = new HashMap<>();
        params.put("limit", limit);
        params.put("offset", offset);
        return addItemMapper.listPage(params);
    }

    public int getTotalItemsCount() {
        return addItemMapper.totalCount();
    }

    // 아이디 패스워드로 리스트를 반환
    public List<OrdersTO> getOrdersByEmailAndPassword(String email, String password) {
        return addItemMapper.findOrdersByEmailAndPassword(email, password);
    }

    // 현재 이메일에 해당하는 아이디의 개수 반환
    public int getOrderCount(String email) {
        return addItemMapper.findOrdersCountByEmail(email);
    }

    public OrdersTO getAboutOrder(int orderId) {
        return addItemMapper.findAboutOrder(orderId);
    }

    // 이메일에 해당하는 상품 리스트를 반환
    public List<OrdersTO> getOrderList(String email) {
        return addItemMapper.findOrdersWithItems(email);
    }

    // delete 에 대한 플래그 처리
    public int orderDeleteOk(OrdersTO ordersTO) {
        int flag = 2;

        if (ordersTO == null) {
            return flag;
        }

        // TODO DB 자동 백업 구현 후 14시에 배송상태 업데이트 했을때 주석 풀어서 사용
        // 현재 시스템 시간대의 ZonedDateTime을 가져옴
        ZoneId systemZoneId = ZoneId.systemDefault(); // 현재 시스템 시간대
        ZonedDateTime now = ZonedDateTime.now(systemZoneId); // 현재 시간
        ZonedDateTime today14 = now.withHour(14).withMinute(0).withSecond(0).withNano(0);
        boolean isAfter14 = now.isAfter(today14);  // 14시 이후인지 확인

        String orderStatus =  ordersTO.getOrderStatus();
        if (orderStatus.equals("beforeDelivery")) {
            // orderStatus before 인데 금일 14시 이후에 삭제를 눌렀을 때
            // (14시 이전에 페이지를 넘겼으나, 페이지에 머무르다 14시 이후가 된 경우)
            if (isAfter14) {
                flag = 1;
                return flag;
            }
        }

        int result = addItemMapper.deleteOkOrders(ordersTO);
        if( result == 1 ) {
            flag = 0;       // 정상
        }

        return flag;
    }


    // 주문 ID로 주문 내역 조회
    public List<OrderItemTO> getOrderByOrderId(int orderId) {
        return addItemMapper.findOrderItemByOrderId(orderId);
    }

    // 주문자 배송 정보 업데이트
    public int updateOrders(OrdersTO orders) {
        int flag = 2;
        int result = addItemMapper.updateOrders(orders);
        System.out.println(result);
        if (result == 0) {
            flag = 1;
        } else if (result == 1) {
            flag = 0;
        }
        return flag;
    }

    public int updateOrderCount(OrderItemTO orderItem) {
        int flag = 2;
        int result = addItemMapper.updateOrderCount(orderItem);
        if(result == 0) {
            flag = 1;
        }else if(result == 1) {
            flag = 0;
        }
        return flag;
    }

}
