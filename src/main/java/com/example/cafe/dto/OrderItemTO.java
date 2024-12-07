package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//@Alias(value = "")
@Getter
@Setter
//@AllArgsConstructor
//@NoArgsConstructor
@ToString
public class OrderItemTO {
    private int order_item_id;
    private String order_id;
    private String item_id;
    private String orderCount;
    private String orderPrice;
}
