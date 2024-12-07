package com.example.cafe.add_item.dao;

import com.example.cafe.add_item.mapper.AddItemMapper;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public class AddItemDAO {
    @Autowired
    private AddItemMapper addItemMapper;

    public ArrayList<ItemTO> itemList(){
        return addItemMapper.itemAll();
    }
    // Item 데이터 추가
    public int addItem(ItemTO to) {
        int flag = 1;
        int result = addItemMapper.itemAdd(to);
        if( result == 1 ) {
            flag = 0;
        }
        return result;
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
}
