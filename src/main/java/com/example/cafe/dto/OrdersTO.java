package com.example.cafe.dto;

import lombok.*;
import org.apache.ibatis.type.Alias;

//@Alias(value = "")
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
    private String password;
    private String order_date;
    private String orderStatus;
}
