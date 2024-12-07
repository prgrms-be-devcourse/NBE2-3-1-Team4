<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String orderId = (String)request.getAttribute( "order_id" );
    int flag = (Integer)request.getAttribute( "flag" );

    out.println( "<script type='text/javascript'>" );
    if ( flag == 0 ) {
        // 정상
        out.println("alert( '수정 성공' );");
        out.println("location.href='./main;");
    } else if ( flag == 1 ) {
        out.println( "alert( '오류' );" );
        out.println( "history.back();" );
    } else {
        // 비정상
        out.println( "alert( '수정 실패' );" );
        out.println( "history.back();" );
    }
    out.println( "</script>" );
%>

<!doctype html>
<html lang="ko">
<head>
</head>
<body>
<h1>수정이 완료되었습니다.</h1>
<a href="javascript:void(0);" onclick="location.href='/main';">메인페이지 돌아가기</a>
</body>
</html>
