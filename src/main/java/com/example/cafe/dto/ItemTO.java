package com.example.cafe.dto;

import lombok.*;
import org.apache.ibatis.type.Alias;

//@Alias(value = "")
@Getter
@Setter
//@AllArgsConstructor
//@NoArgsConstructor
@ToString
public class ItemTO {
    private String item_id;
    private String name;
    private String itemQuantity;
    private String price;
}
