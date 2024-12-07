<%@ page import="com.example.cafe.dto.OrdersTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
  OrdersTO ordersTO = (OrdersTO)request.getAttribute("orderTo");
  int orderId = ordersTO.getOrder_id();

  String email = (String)request.getAttribute("email");
  String address = ordersTO.getAddress();
  String zipCode = ordersTO.getZip_code();

  /*for (int i=0; i<ordersTO.getItems().size(); i++) {
    String itemName = ordersTO.getItems().get(i).getName();
    String orderCount = ordersTO.getOrderItems().get(i).getOrderCount();
    String orderPrice = ordersTO.getOrderItems().get(i).getOrderPrice();
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
  <script>
    // 주문 삭제 루틴
    window.onload = function () {
      document.getElementById( 'dtn_cancelorder' ).onclick = function () {
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
  </script>
  <title>주문 목록</title>
</head>
<body class="container-fluid">
<div class="row justify-content-center m-4 align-items-center">
  <h1 class="text-center col">상품 목록</h1>
</div>
<div class="card">
  <div class="row">
    <div class="col-md-8 mt-4 d-flex flex-column align-items-start p-3 pt-0">
      <h5 class="flex-grow-0"><b>상품 목록</b></h5>
      <ul class="list-group products">
        <li class="list-group-item d-flex mt-3">
          <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
          <div class="col">
            <div class="row text-muted">커피콩</div>
            <div class="row">Columbia Nariñó</div>
          </div>
          <div class="col text-center price">5000원</div>
          <div class="col text-end action">
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('Columbia Nariñó')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('Columbia Nariñó')">삭제</a>
          </div>
        </li>
        <li class="list-group-item d-flex mt-2">
          <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
          <div class="col">
            <div class="row text-muted">커피콩</div>
            <div class="row">Brazil Serra Do Caparaó</div>
          </div>
          <div class="col text-center price">6000원</div>
          <div class="col text-end action">
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('Brazil Serra Do Caparaó')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('Brazil Serra Do Caparaó')">삭제</a>
          </div>
        </li>
        <li class="list-group-item d-flex mt-2">
          <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
          <div class="col">
            <div class="row text-muted">커피콩</div>
            <div class="row">Ethiopia Yirgacheffe</div>
          </div>
          <div class="col text-center price">7000원</div>
          <div class="col text-end action">
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('Ethiopia Yirgacheffe')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('Ethiopia Yirgacheffe')">삭제</a>
          </div>
        </li>
        <li class="list-group-item d-flex mt-2">
          <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
          <div class="col">
            <div class="row text-muted">커피콩</div>
            <div class="row">Guatemala Antigua</div>
          </div>
          <div class="col text-center price">8000원</div>
          <div class="col text-end action">
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('Guatemala Antigua')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('Guatemala Antigua')">삭제</a>
          </div>
        </li>
      </ul>
    </div>
    <div class="col-md-4 summary p-4">
      <div>
        <h5 class="m-0 p-0"><b>Summary</b></h5>
      </div>
      <hr>
      <div class="row">
        <h6 class="p-0">Columbia Nariñó <span id="badge-Columbia Nariñó" class="badge bg-dark">0개</span></h6>
      </div>
      <div class="row">
        <h6 class="p-0">Brazil Serra Do Caparaó <span id="badge-Brazil Serra Do Caparaó" class="badge bg-dark">0개</span></h6>
      </div>
      <div class="row">
        <h6 class="p-0">Ethiopia Yirgacheffe <span id="badge-Ethiopia Yirgacheffe" class="badge bg-dark">0개</span></h6>
      </div>
      <div class="row">
        <h6 class="p-0">Guatemala Antigua <span id="badge-Guatemala Antigua" class="badge bg-dark">0개</span></h6>
      </div>
      <form id="myForm" method="post">
        <input type="hidden" name="orderId" value="<%= orderId %>" />
        <div class="mb-3">
          <label for="email" class="form-label" >이메일</label>
          <input type="email" class="form-control mb-1" id="email" readonly="readonly" value="<%=email%>" />
        </div>
        <div class="mb-3">
          <label for="address" class="form-label">주소</label>
          <input type="text" class="form-control mb-1" id="address" value="<%= address %>" />
        </div>
        <div class="mb-3">
          <label for="postcode" class="form-label">우편번호</label>
          <input type="text" class="form-control" id="postcode" value="<%= zipCode %>">
        </div>
        <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>
      </form>
      <div class="row pt-2 pb-2 border-top">
        <h5 class="col">총금액</h5>
        <h5 class="col text-end">0원</h5>
      </div>
      <button class="btn btn-dark col-6">주문수정</button>
      <button class="btn btn-dark col-5" id="dtn_cancelorder">주문취소</button>
    </div>
  </div>
</div>


</body>
</html>
