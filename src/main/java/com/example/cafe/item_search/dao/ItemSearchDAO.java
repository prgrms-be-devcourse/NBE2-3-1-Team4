/*package com.example.cafe.item_search.dao;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.item_search.mapper.ItemSearchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ItemSearchDAO {

    @Autowired
    private ItemSearchMapper itemSearchMapper;


    public ArrayList<ItemTO> cafeList() {
        return itemSearchMapper.list();
    }

    public List<ItemTO> cafeList(int limit, int offset) {
        Map<String, Object> params = new HashMap<>();
        params.put("limit", limit);
        params.put("offset", offset);
        return itemSearchMapper.listPage(params);
    }

    public int getTotalItemsCount() {
        return itemSearchMapper.totalCount();
    }

}*/
