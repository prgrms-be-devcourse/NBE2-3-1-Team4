package com.example.cafe.mapper;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UpdateItemMapper {
    // 이메일로 해당 주문 내역 조회
    List<OrderItemTO> findOrdersByEmail(String email);

    // 이메일로 사용자 정보 조회
    OrdersTO findUserByEmail(String email);

    // 상품 목록 조회
    List<ItemTO> findAllItems();

    //주문자배송정보 업데이트
    OrdersTO updateOrders(OrdersTO orders);

}
