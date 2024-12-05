package com.example.cafe.dao;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import com.example.cafe.mapper.UpdateItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UpdateItemDAO {
    @Autowired
    private UpdateItemMapper updateItemMapper;

    public List<ItemTO> getAllItems() {
        return updateItemMapper.findAllItems();
    }

    // 주문 ID로 사용자 정보 조회
    public OrdersTO getUserByOrderId(String orderId) {
        return updateItemMapper.findUserByOrderId(orderId);
    }

    // 주문 ID로 주문 내역 조회
    public List<OrderItemTO> getOrderByOrderId(String orderId) {
        return updateItemMapper.findOrdersByOrderId(orderId);
    }

    // 주문자 배송 정보 업데이트
    public int updateOrders(OrdersTO orders) {
        int flag = 2;
        int result = updateItemMapper.updateOrders(orders);
        if (result == 0) {
            flag = 1;
        } else if (result == 1) {
            flag = 0;
        }
        return flag;
    }
}
