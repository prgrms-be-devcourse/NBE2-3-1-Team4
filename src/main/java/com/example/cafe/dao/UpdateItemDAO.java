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
    //해당 이메일로 주문 내역 조회
    public List<OrderItemTO> getOrderByEmail(String email) {
        return updateItemMapper.findOrdersByEmail(email);
    }

    public OrdersTO getUserByEmail(String email) {
        return updateItemMapper.findUserByEmail(email);
    }
}
