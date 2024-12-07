package com.example.cafe.delete_item.dao;

import com.example.cafe.dto.OrdersTO;
import com.example.cafe.mapper.OrdersMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;

@Repository
public class OrdersDAO {
    @Autowired
    private OrdersMapper ordersMapper;

    // 아이디 패스워드로 리스트를 반환
    public List<OrdersTO> getOrdersByEmailAndPassword(String email, String password) {
        return ordersMapper.findOrdersByEmailAndPassword(email, password);
    }

    // 현재 이메일에 해당하는 아이디의 개수 반환
    public int getOrderCount(String email) {
        return ordersMapper.findOrdersCountByEmail(email);
    }

    // 이메일에 해당하는 상품 리스트를 반환
    public List<OrdersTO> getOrderList(String email) {
        return ordersMapper.findOrdersWithItems(email);
    }

    // 선택한 orderId에 대한 주문목록 반환
    public OrdersTO getOrdersById(String orderId) {
        return ordersMapper.findOrdersByOrderId(orderId);
    }

    // delete 에 대한 플래그 처리
    public int orderDeleteOk(OrdersTO ordersTO) {
        int flag = 2;

        if (ordersTO == null) {
            return flag;
        }

        // TODO DB 자동 백업 구현 후 14시에 배송상태 업데이트 했을때 주석 풀어서 사용
        // 현재 시스템 시간대의 ZonedDateTime을 가져옴
        /*ZoneId systemZoneId = ZoneId.systemDefault(); // 현재 시스템 시간대
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
        }*/

        int result = ordersMapper.deleteOkOrders(ordersTO);
        if( result == 1 ) {
            flag = 0;       // 정상
        }

        return flag;
    }
}
