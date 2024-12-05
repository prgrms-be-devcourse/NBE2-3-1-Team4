<%@ page import="com.example.cafe.dto.ItemTO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.cafe.dto.OrderItemTO" %>
<%@ page import="com.example.cafe.dto.OrdersTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  OrdersTO orders = (OrdersTO) request.getAttribute("orders");
  ArrayList<OrderItemTO> orderItems =(ArrayList<OrderItemTO>) request.getAttribute("orderItem");
  List<ItemTO> items = (List<ItemTO>) request.getAttribute("items");

  String email = orders.getEmail();
  String address = orders.getAddress();
  String zip_code = orders.getZip_code();
  String orderId = (String) request.getAttribute("order_id");

  if (orderId == null) {
    out.println("order_id is null");
  } else {
    out.println("order_id: " + orderId);
  }

%>
<!doctype html>
<html lang="en">
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
      max-width: 950px;
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

    .products .price, .products .action {
      line-height: 38px;
    }

    .products .action {
      line-height: 38px;
    }
  </style>
  <!-- JavaScript -->
  <script type="text/javascript">
    // 제품 이름과 개수를 관리할 객체
    const cartSummary = {
      "Columbia Nariñó": 0,
      "Brazil Serra Do Caparaó": 0,
      "Ethiopia Yirgacheffe": 0,
      "Guatemala Antigua": 0
    };

    // "추가" 버튼 클릭 시 실행되는 함수
    function addToCart(productName) {
      // 개수 증가
      cartSummary[productName]++;

      // UI 업데이트
      const badge = document.querySelector(`#badge-${CSS.escape(productName)}`);
      if (badge) {
        badge.textContent = `${cartSummary[productName]}개`;
      }
    }

    // "삭제하기" 버튼 클릭 시 실행되는 함수
    function removeFromCart(productName) {
      // 개수가 0 이하로 내려가지 않도록 처리
      if (cartSummary[productName] > 0) {
        cartSummary[productName]--;
      }

      // UI 업데이트
      const badge = document.querySelector(`#badge-${CSS.escape(productName)}`);
      if (badge) {
        badge.textContent = `${cartSummary[productName]}개`;
      }
    }
    // 수정버튼 클릭시
    document.getElementById('mbtn').onclick = function(){
      if(document.mfrm.address.value == ''){
        alert('주소를 입력하세요');
        return false;
      }
      if(document.mfrm.zip_code.value == ''){
        alert('우편번호를 입력하세요');
        return false;
      }
      document.mfrm.submit();
    };

  </script>
  <title>주문 목록</title>
</head>
<body class="container-fluid">
<div class="row justify-content-center m-4 align-items-center">
  <h1 class="text-center col">상품 목록</h1>
  <div class="col-auto">
    <button class="btn btn-small btn-outline-info">주문조회</button>
  </div>
</div>
<div class="card">
  <div class="row">
    <div class="col-md-8 mt-4 d-flex flex-column align-items-start p-3 pt-0">
      <h5 class="flex-grow-0"><b>상품 목록</b></h5>
      <ul class="list-group products">
        <%
          // 상단에서 items 선언
          for (ItemTO item : items) {
        %>
        <li class="list-group-item d-flex mt-3">
          <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
          <div class="col">
            <div class="row text-muted">카페 메뉴</div>
            <div class="row"><%= item.getName() %></div>
          </div>
          <div class="col text-center price"><%= item.getPrice() %>원</div>
          <div class="col text-end action">
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('<%= item.getName() %>')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('<%= item.getName() %>')">삭제</a>
          </div>
        </li>
        <%
          }
        %>
      </ul>
    </div>

    <%--      <input type="hidden" name="email" value="<%=email%>"/>--%>
    <%--주문 목록 & 주소 불러오기 --%>
    <div class="col-md-4 summary p-4">
      <div>
        <h5 class="m-0 p-0"><b>Summary</b></h5>
      </div>
      <hr>
      <%
        for (OrderItemTO orderItem : orderItems) {
      %>
      <div class="row">
        <h6 class="p-0"><%= orderItem.getItemName() %> <span id="badge-<%= orderItem.getItemName() %>" class="badge bg-dark"><%=orderItem.getItemQuantity()%></span></h6>
      </div>
      <%
        }
      %>
      <%
        for (ItemTO item : items) {
      %>
      <div class="row">
        <h6 class="p-0"><%= item.getName() %> <span id="badge-<%= item.getName() %>" class="badge bg-dark"><%=item.getItemQuantity()%></span></h6>
      </div>
      <%
        }
      %>

      <form action="update_item_ok" method="post" name="mfrm">
        <input type="hidden" name="order_id" value="<%= orderId %>">
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
          <input type="text" class="form-control" id="zip_code" name="zip_code" value="<%= zip_code %>">
        </div>
        <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>

        <div class="row pt-2 pb-2 border-top">
          <h5 class="col">총금액</h5>
          <h5 class="col text-end">0원</h5>
        </div>
        <button type="submit" class="btn btn-dark col-6" id="mbtn" onclick="location.href='update_item_ok'">주문수정</button>
        <button class="btn btn-dark col-5">주문취소</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
