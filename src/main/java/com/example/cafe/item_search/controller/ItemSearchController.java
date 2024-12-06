package com.example.cafe.item_search.controller;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.item_search.dao.ItemSearchDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ItemSearchController {

    @Autowired
    ItemSearchDAO itemSearchDAO;
    /**
     *  sample2_paging.jsp => 최종 완성본
     *  sample2에서 + 페이징 구현.
     *  jstl,el 사용안함!
     */
    @RequestMapping("/sample2page")
    public String Sample2Page(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        ArrayList<ItemTO> itemTOS = itemSearchDAO.cafeList();
        List<ItemTO> lists = itemSearchDAO.cafeList(pageSize, offset); // 현제 페이지의 항목 수랑, db에서 잘라야 할 offset정의
        int totalItemsCount = itemSearchDAO.getTotalItemsCount(); //전체 데이타 수 조회
        int totalPages = (int) Math.ceil((double) totalItemsCount / pageSize); // 총 페이지 수 계산

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("lists", lists);
        model.addAttribute("itemTOS", itemTOS);
        return "sample2_paging";
    }
}
