<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String email = (String)request.getAttribute( "email" );
    int flag = (Integer)request.getAttribute( "flag" );

    out.println( "<script type='text/javascript'>" );
    if ( flag == 0 ) {
        // 정상
        out.println("alert( '수정 성공' );");
        out.println("location.href='./update_item?email=" + email + "';");
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
update_ok
</body>
</html>
