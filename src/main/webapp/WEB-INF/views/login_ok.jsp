<%@ page import="com.example.cafe.dto.OrdersTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int flag = (Integer)request.getAttribute( "flag" );
    out.println( "<script type='text/javascript'>" );
    if ( flag == 0 ) {
        List<OrdersTO> toList  = (List<OrdersTO>)request.getAttribute("toList");

        String email = toList.get(0).getEmail();

        out.println("location.href='./orderlist_search.do?email=" + email + "';");
    } else if ( flag == 1 ) {
        out.println( "alert( '아이디 또는 비밀번호 오류' );" );
        out.println( "history.back();" );
    } else if ( flag == 2 ) {
        out.println( "alert( '주문 내역이 없습니다.' );" );
        out.println( "history.back();" );
    } else {
        // 비정상
        out.println( "alert( '주문조회 실패' );" );
        out.println( "history.back();" );
    }
    out.println( "</script>" );
%>