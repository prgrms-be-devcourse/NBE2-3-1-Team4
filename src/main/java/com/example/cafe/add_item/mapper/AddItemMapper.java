package com.example.cafe.add_item.mapper;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface AddItemMapper {
    ArrayList<ItemTO> itemAll();
    int itemAdd(ItemTO item);
    int ordersAdd(OrdersTO orders);
    int orderItemAdd(OrderItemTO orderItem);
}
