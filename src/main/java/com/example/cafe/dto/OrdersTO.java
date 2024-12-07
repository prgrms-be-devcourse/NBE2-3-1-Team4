package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Alias(value = "to")
@Getter
@Setter
public class OrdersTO {
    private String order_id;
    private String order_date;
    private String orderStatus;
    private String email;
    private String password;
    private String address;
    private String zip_code;

    private List<OrderItemTO> orderItems;
    private List<ItemTO> items;

}
