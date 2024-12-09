package com.example.cafe.add_item.mapper;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.dto.OrderItemTO;
import com.example.cafe.dto.OrdersTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface AddItemMapper {
    ArrayList<ItemTO> itemAll();
    int ordersAdd(OrdersTO orders);
    int orderItemAdd(OrderItemTO orderItem);
    ArrayList<ItemTO> list(); // list.merge !
    List<ItemTO> listPage(Map<String, Object> params); // 수정
    int totalCount();

    //delete
    List<OrdersTO> findOrdersByEmailAndPassword(String email, String password);
    int findOrdersCountByEmail(String email);
    List<OrdersTO> findOrdersWithItems(String email);
    OrdersTO findAboutOrder(int orderId);
    int deleteOkOrders(OrdersTO ordersTO);
    OrdersTO findOrdersByOrderId(int orderId);


    // update
    //주문자 정보 update
    int updateOrders(OrdersTO ordersTO);
    //개수 update
    int updateOrderCount(OrderItemTO orderItem);

}
