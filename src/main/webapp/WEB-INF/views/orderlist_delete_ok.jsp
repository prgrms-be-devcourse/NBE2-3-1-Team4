<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int flag = (Integer)request.getAttribute( "flag" );

    out.println( "<script type='text/javascript'>" );
    if ( flag == 0 ) {
        // 정상
        out.println("alert( '주문취소 성공 \\n확인 버튼을 클릭하시면 메인으로 돌아갑니다.' );");
        out.println("location.href='/main.do';");
    } else if ( flag == 1 ) {
        out.println( "alert( '이미 배송 처리 중입니다.' );" );
        out.println( "history.back();" );
    } else {
        // 비정상
        out.println( "alert( '주문취소 실패 \\n확인 버튼을 클릭하시면 메인으로 돌아갑니다.' );" );
        out.println( "location.href='/main.do';" );
    }
    out.println( "</script>" );
%>