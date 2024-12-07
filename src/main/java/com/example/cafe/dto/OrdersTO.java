package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.*;

import org.apache.ibatis.type.Alias;

import java.util.List;

@Getter
@Setter
//@AllArgsConstructor
//@NoArgsConstructor
@ToString
public class OrdersTO {
    private int order_id;
    private String email;
    private String address;
    private String zip_code;
    private List<OrderItemTO> orderItems;
    private List<ItemTO> items;
    private String password;
    private String order_date;
    private String orderStatus;
}
