package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Alias(value = "OrderItem")
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


    private ItemTO item;

    public String getItemName(){
        return item !=null ? item.getName() : "상품없음";
    }

    public String getItemQuantity(){
        return orderCount != null ? orderCount : "0";
    }
}
