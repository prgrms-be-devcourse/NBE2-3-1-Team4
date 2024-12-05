<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 정보</title>
</head>
<body>
<h1>주문 정보</h1>
<p><strong>이메일:</strong> ${email}</p>
<p><strong>배송지:</strong> ${address}</p>
<p><strong>우편번호:</strong> ${zip_code}</p>

<c:if test="${error != null}">
    <p style="color: red;">${error}</p>
</c:if>
</body>
</html>
