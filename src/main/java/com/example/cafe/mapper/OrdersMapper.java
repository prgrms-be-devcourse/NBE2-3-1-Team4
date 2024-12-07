package com.example.cafe.mapper;

import com.example.cafe.dto.OrdersTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrdersMapper {
    List<OrdersTO> findOrdersByEmailAndPassword(String email, String password);
    int findOrdersCountByEmail(String email);
    List<OrdersTO> findOrdersWithItems(String email);
    OrdersTO findOrdersByOrderId(String orderId);
    int deleteOkOrders(OrdersTO ordersTO);
}
