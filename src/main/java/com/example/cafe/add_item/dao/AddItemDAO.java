package com.example.cafe.add_item.dao;

import com.example.cafe.add_item.mapper.AddItemMapper;
import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
