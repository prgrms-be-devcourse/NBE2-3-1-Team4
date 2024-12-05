package com.example.cafe.item_search.controller;

import com.example.cafe.dto.ItemTO;
import com.example.cafe.item_search.dao.ItemSearchDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class ItemSearchController {

    @Autowired
    ItemSearchDAO itemSearchDAO;

    /**
     *  item 정상 작동. - sample2.jsp
     *  상품 목록만 db에서 조회.
     */
    @RequestMapping("/item_search")
    public String Home(Model model) {
        ArrayList<ItemTO> lists = itemSearchDAO.cafeList();
        model.addAttribute("lists", lists);
        return "sample2";
    }
    /**
     * jstl,el 테스트 - 성공 - sample2_jstl.sjp
     * sample2.jsp에서 out.print() 방식을 jstl,el 방식으로 교환.
     * bulid.gradle  implementation 교환.
     */
    @RequestMapping("/item_search_jstl")
    public String HomeJstlTest(Model model) {
        ArrayList<ItemTO> lists = itemSearchDAO.cafeList();
        model.addAttribute("lists", lists);
        return "sample2_jstl";
    }

    /**
     *  sample2_paging.jsp
     *  sample2에서 + 페이징 구현.
     *  jstl,el 사용안함!
     */
    @RequestMapping("/sample2page")
    public String Sample2Page(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        List<ItemTO> lists = itemSearchDAO.cafeList(pageSize, offset); // 현제 페이지의 항목 수랑, db에서 잘라야 할 offset정의
        int totalItemsCount = itemSearchDAO.getTotalItemsCount(); //전체 데이타 수 조회
        int totalPages = (int) Math.ceil((double) totalItemsCount / pageSize); // 총 페이지 수 계산

        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("lists", lists);
        return "sample2_paging";
    }


    /**
     *  test3_paging
     *  json에 잘 담김.
     *  하지만 페이지 이동시 json, 상품데이터 ui에 값 사라짐.
     */

    @RequestMapping("/items2")
    public String getPagedItems2(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        int totalItems = itemSearchDAO.getTotalItemsCount(); // 전체 항목 수
        int totalPages = (int) Math.ceil((double) totalItems / pageSize); // 총 페이지 수 계산

        // 페이징된 아이템 목록 가져오기
        List<ItemTO> lists = itemSearchDAO.cafeList(pageSize, offset);
        ArrayList<ItemTO> cafeList = itemSearchDAO.cafeList();
        // 모델에 데이터 추가
        model.addAttribute("cafeList", cafeList);
        model.addAttribute("lists", lists);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);

        return "test3_paging"; // JSP 파일 이름
    }

    /**
     *  test4.paging
     *  페이징구현, 상품데이터,결제폼은 아래로 배치
     *  페이지 이동시 json은 유지.
     *  하지만 상품데이터에 값 업데이트가 안됨
     */

    @RequestMapping("/items4")
    public String getPagedItems3(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        int totalItems = itemSearchDAO.getTotalItemsCount(); // 전체 항목 수
        int totalPages = (int) Math.ceil((double) totalItems / pageSize); // 총 페이지 수 계산

        // 페이징된 아이템 목록 가져오기
        List<ItemTO> lists = itemSearchDAO.cafeList(pageSize, offset);
        ArrayList<ItemTO> cafeList = itemSearchDAO.cafeList();
        // 모델에 데이터 추가
        model.addAttribute("cafeList", cafeList);
        model.addAttribute("lists", lists);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);

        return "test4_paging"; // JSP 파일 이름
    }

    /**
     *  test3.5_paging
     *  페이징구현, 상품데이터,결제폼은 아래로 배치
     *  추가 삭제시 상품데이터 1씩 증가
     *  하지만 페이지 이동시 사라짐.
     *  json 안담김.
     */

    @RequestMapping("/items")
    public String getPagedItems(
            @RequestParam(defaultValue = "1") int page, // 현재 페이지 (기본값: 1)
            @RequestParam(defaultValue = "5") int pageSize, // 페이지당 항목 수 (기본값: 5)
            Model model) {

        int offset = (page - 1) * pageSize; // SQL OFFSET 계산
        int totalItems = itemSearchDAO.getTotalItemsCount(); // 전체 항목 수
        int totalPages = (int) Math.ceil((double) totalItems / pageSize); // 총 페이지 수 계산

        // 페이징된 아이템 목록 가져오기
        List<ItemTO> lists = itemSearchDAO.cafeList(pageSize, offset);
        ArrayList<ItemTO> cafeList = itemSearchDAO.cafeList();
        // 모델에 데이터 추가
        model.addAttribute("cafeList", cafeList);
        model.addAttribute("lists", lists);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", pageSize);

        return "test3.5_paging"; // JSP 파일 이름
    }







    /**
     *  프론트, 결제하기 완성본. - test2.jsp
     *  페이징 X, db값 증가시 상품 목록과 Summary 무한증가.
     *  json에 값 잘 담김.
     */
    @GetMapping("/test2")
    public String Test2(Model model) {
        ArrayList<ItemTO> lists = itemSearchDAO.cafeList();
        model.addAttribute("lists", lists);
        return "test2";
    }

    @PostMapping("/endpoint2")
    public ResponseEntity<?> handlePostRequest2(@RequestBody Map<String, Object> data) {
        System.out.println("[Received data]: " + data);
        return ResponseEntity.ok("데이터 수신 성공, 결제 완료!");
    }

}
