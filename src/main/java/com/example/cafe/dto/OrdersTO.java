package com.example.cafe.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

//@Alias(value = "")
@Getter
@Setter
//@AllArgsConstructor
//@NoArgsConstructor
public class OrdersTO {
    private String order_id;
    private String order_date;
    private String orderStatus;
    private String email;
    private String password;
    private String address;
    private String zip_code;
}
