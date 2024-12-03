package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;

//@Alias(value = "")
@Getter
@Setter
//@AllArgsConstructor
//@NoArgsConstructor
public class OrderItemTO {
    private String order_item_id;
    private String order_id;
    private String item_id;
    private String orderCount;
    private String orderPrice;
}
