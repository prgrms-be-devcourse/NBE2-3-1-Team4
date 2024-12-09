<%@ page import="com.example.cafe.dto.OrdersTO" %>
<%@ page import="com.example.cafe.dto.OrderItemTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.cafe.dto.ItemTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
  OrdersTO orders = (OrdersTO) request.getAttribute("orderTo");
  int orderId = orders.getOrder_id();
  String email = orders.getEmail();
  System.out.println(orders.getEmail());
  String address = orders.getAddress();
  String zipCode = orders.getZip_code();

  int totalPrice = 0;
  for(OrderItemTO orderitem : orders.getOrderItems()){
    totalPrice+= Integer.parseInt(orderitem.getOrderPrice());
  }

  StringBuilder jsonBuilder = new StringBuilder("[");
  for(int i=0; i<orders.getItems().size();i++){
    ItemTO item = orders.getItems().get(i);

    jsonBuilder.append("{")
            .append("\"name\": \"").append(item.getName()).append("\", ")
            .append("\"count\": 0, ")
            .append("\"price\": ").append(item.getPrice()).append(", ")
            .append("\"id\": ").append(item.getItem_id())
            .append("}");
    if(i<orders.getItems().size()-1){
      jsonBuilder.append(", ");

    }

  }
  jsonBuilder.append("]");
  String jsonString = jsonBuilder.toString();
  /*for (int i=0; i<orders.getItems().size(); i++) {
    String itemName = orders.getItems().get(i).getName();
    String orderCount = orders.getOrderItems().get(i).getOrderCount();
    String orderPrice = orders.getOrderItems().get(i).getOrderPrice();
    System.out.println("itemName: " + itemName + "   orderCount: " + orderCount+ "   orderPrice"+ orderPrice);
  }*/
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
  <style>
    body {
      background: #ddd;
    }

    .card {
      margin: auto;
      max-width: 800px;
      width: 90%;
      box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      border-radius: 1rem;
      border: transparent;
    }

    .summary {
      background-color: #ddd;
      border-top-right-radius: 1rem;
      border-bottom-right-radius: 1rem;
      padding: 4vh;
      color: rgb(65, 65, 65);
    }

    @media (max-width: 767px) {
      .summary {
        border-top-right-radius: unset;
        border-bottom-left-radius: 1rem;
      }
    }

    .row {
      margin: 0;
    }

    .title b {
      font-size: 1.5rem;
    }

    .col-2,
    .col {
      padding: 0 1vh;
    }

    img {
      width: 3.5rem;
    }

    hr {
      margin-top: 1.25rem;
    }

    .products {
      width: 100%;
    }

    #btn_cancelorder{
      width : 370px;
    }

    #mbtn{
      width : 370px;
    }

    .products .price, .products .action {
      line-height: 38px;
    }

    .products .action {
      line-height: 38px;
    }
  </style>
  <!-- JavaScript -->

  <title>주문 목록</title>
</head>
<body class="container-fluid">
<div class="row justify-content-center m-4 align-items-center">
  <h1 class="text-center col">주문 상세</h1>
</div>
<div class="card">
  <form action="update_item_ok" method="post" name="mfrm">
  <div class="row">
    <%--      <input type="hidden" name="email" value="<%=email%>"/>--%>
    <%--주문 목록 & 주소 불러오기 --%>
    <div class="col-md summary p-4">
      <form action="update_item_ok" method="post" name="mfrm">
        <input type="hidden" name="order_id" value="<%= orderId %>" />
        <div>
          <h5 class="m-0 p-0"><b>Summary</b></h5>
        </div>
        <hr>
          <%
           for (int i=0; i<orders.getOrderItems().size();i++) {
      %>
        <div class="row">
          <h6 class="p-0"><%= orders.getItems().get(i).getName() %> <span id="badge-<%= orders.getItems().get(i).getName() %>" class="badge bg-dark"><%=orders.getOrderItems().get(i).getOrderCount()%>개</span></h6>
        </div>
          <%
          }

      %>

        <form>

          <div class="mb-3">
            <label type="hidden" for="order_id" class="form-label">주문번호</label>
            <input type="text" class="form-control mb-1" id="order_id" name="order_id" value="<%= orderId %>" readonly>
          </div>
          <div class="mb-3">
            <label type="hidden" for="email" class="form-label">이메일</label>
            <input type="text" class="form-control mb-1" id="email" name="email" value="<%= email %>" readonly>
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">주소</label>
            <input type="text" class="form-control mb-1" id="address" name="address" value="<%= address %>">
          </div>
          <div class="mb-3">
            <label for="zip_code" class="form-label">우편번호</label>
            <input type="text" class="form-control" id="zip_code" name="zip_code" value="<%= zipCode %>">
          </div>
        <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>
      </form>
      <div class="row pt-2 pb-2 border-top">
        <h5 class="col">총금액</h5>
        <h5 class="col text-end"> <%=totalPrice%></h5>
      </div>
        <button type="submit" class="btn btn-dark" id="mbtn" onclick="location.href='update_item_ok'">주문수정</button>
        <button class="btn btn-dark" id="btn_cancelorder">주문취소</button>
    </div>
  </div>
  </form>
</div>

<script>
  // 총 가격 계산
  let orderPrice = 0;
  // 주문 삭제 루틴
  window.onload = function () {
    document.getElementById( 'btn_cancelorder' ).onclick = function () {
      if (confirm("주문을 취소 하시겠습니까?")) {
        const form = document.getElementById('myForm');
        form.id = "deleteForm" + <%= orderId%>;
        form.action = "/delete_item_ok.do"; // action을 동적으로 변경
        form.submit();        // 폼 제출
      } else {
        alert("주문 취소 요청이 취소 되었습니다.");
      }
    };
  };

  // 제품 이름과 개수를 관리할 객체
  const cartSummary = <%=jsonString%>

  // "추가" 버튼 클릭 시 실행되는 함수
  function addToCart(productName) {
    //cartSummary에서 productName 찾기
    const product = cartSummary.find(item => item.name === productName);
    // 개수 증가
    product.count++;
    // UI 업데이트
    const badge = document.querySelector(`#badge-${'${CSS.escape(productName)}'}`);
    if (badge) {
      badge.textContent = `${'${product.count}'}개`;
    }
    orderPrice += product.price;
    document.getElementById('orderPrice').textContent = `${'${orderPrice}'}원`;
    // 콘솔에 count 값 출력
    console.log(`${productName}' count: ${product.count}`);
  }

</script>
</body>
</html>
