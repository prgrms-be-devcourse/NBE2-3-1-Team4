package com.example.cafe.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

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


    //private List<ItemTO> item;
    private ItemTO item;
    private List<OrderItemTO> order;
    public String getItemName(){
        return item != null ? item.getName() : "상품없음";
    }

    public String getItemQuantity(){
        return orderCount != null ? orderCount : "0";
    }

}
