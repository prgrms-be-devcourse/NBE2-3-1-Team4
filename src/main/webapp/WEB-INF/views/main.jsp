<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.cafe.dto.ItemTO" %>
<%
  ArrayList<ItemTO> lists = (ArrayList<ItemTO>) request.getAttribute("lists");
//  System.out.println(lists);

  // JSON 형식으로 변환
  StringBuilder jsonBuilder = new StringBuilder("[");
  for (int i = 0; i < lists.size(); i++) {
    ItemTO item = lists.get(i);
    jsonBuilder.append("{")
            .append("\"name\": \"").append(item.getName()).append("\", ")
            .append("\"count\": 0, ")
            .append("\"price\": ").append(item.getPrice()).append(", ")
            .append("\"id\": ").append(item.getItem_id())
            .append("}");
    if (i < lists.size() - 1) {
      jsonBuilder.append(", ");
    }
  }
  jsonBuilder.append("]");
  String jsonString = jsonBuilder.toString();
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

    #summaryList {
      height: 60px; /* 기본 높이 설정 */
      max-height: 60px; /* 최대 높이 설정 120px*/
      overflow-y: auto; /* 높이를 초과하면 스크롤바 활성화 */
      }
  </style>
  <title>상품 목록</title>
</head>
<body class="container-fluid">
<div class="row justify-content-center m-4 align-items-center">
  <h1 class="text-center col">상품 목록</h1>
  <div class="col-auto">
    <button class="btn btn-small btn-outline-info">주문조회</button>
    <button class="btn btn-small btn-outline-danger">삭제하기</button>
  </div>
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
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('아메리카노')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('아메리카노')">삭제</a>
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
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('카푸치노')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('카푸치노')">삭제</a>
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
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('치즈케이크')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('치즈케이크')">삭제</a>
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
            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('샌드위치')">추가</a>
            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('샌드위치')">삭제</a>
          </div>
        </li>
      </ul>
    </div>
    <div class="col-md-4 summary p-4">
      <!-- 영수증 -->
      <div>
        <h5 class="m-0 p-0"><b>Summary</b></h5>
        <hr>
        <div id="summaryList"></div>
      </div>
      <form>
        <div class="mb-3">
          <label for="email" class="form-label">이메일</label>
          <input type="email" class="form-control mb-1" id="email">
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">비밀번호</label>
          <input type="text" class="form-control" id="password">
        </div>
        <div class="mb-3">
          <label for="address" class="form-label">주소</label>
          <input type="text" class="form-control mb-1" id="address">
        </div>
        <div class="mb-3">
          <label for="postcode" class="form-label">우편번호</label>
          <input type="text" class="form-control" id="postcode">
        </div>
        <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>
      </form>
      <div class="row pt-2 pb-2 border-top">
        <h5 class="col">총금액</h5>
        <h5 class="col text-end" id="totalPrice">0원</h5>

      </div>
      <button class="btn btn-dark col-12" id="checkoutButton" onclick="checkoutOrder()">결제하기</button>
    </div>
  </div>
</div>

<!-- JavaScript -->
<script>
  // 총 가격 계산
  let total = 0;

  // 제품 이름과 개수
  const cartSummary = <%= jsonString %>;
  console.log(cartSummary);
  // "추가" 버튼 클릭 시 실행되는 함수
  function addToCart(productName) {
    //cartSummary에서 productName 찾기
    const product = cartSummary.find(item => item.name === productName);
    // 개수 증가
    product.count++;

    const summaryList = document.getElementById("summaryList");
    let itemElement = document.querySelector(`#summary-${'${CSS.escape(productName)}'}`);

    if (!itemElement) {
      // 항목이 없으면 추가
      itemElement = document.createElement("div");
      itemElement.classList.add("row");
      itemElement.id = `summary-${'${CSS.escape(productName)}'}`; // 안전한 ID 사용
      itemElement.innerHTML = `
      <h6 class="p-0 col">${'${productName}'}</h6>
      <h6 class="p-0 col text-end">
        <span id="badge-${'${CSS.escape(productName)}'}" class="badge bg-dark">${'${product.count}'}개</span>
      </h6>
    `;
      summaryList.appendChild(itemElement);
    } else {
      // 항목이 이미 있으면 업데이트
      const badgeElement = itemElement.querySelector(`#badge-${'${CSS.escape(productName)}'}`);
      badgeElement.textContent = `${'${product.count}'}개`;
    }

    total += product.price;
    document.getElementById('totalPrice').textContent = `${'${total}'}원`;
  }

  // "삭제하기" 버튼 클릭 시 실행되는 함수
  function removeFromCart(productName) {
    //cartSummary에서 productName 찾기
    const product = cartSummary.find(item => item.name === productName);

    if (product.count > 0) {
      product.count--;
      const itemElement = document.getElementById(`summary-${'${CSS.escape(productName)}'}`);
      if (product.count > 0) {
        const badgeElement = itemElement.querySelector(`#badge-${'${CSS.escape(productName)}'}`);
        badgeElement.textContent = `${'${product.count}'}개`;
      } else {
        itemElement.remove();
      }

      total -= product.price;
      document.getElementById('totalPrice').textContent = `${'${total}'}원`;
    }
  }

  // 결제하기 버튼, json 데이터 서버로 전송
  function checkoutOrder() {
    // 사용자 데이터 가져오기
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const address = document.getElementById("address").value;
    const postcode = document.getElementById("postcode").value;

    // 필수 입력값 확인
    if (!email) {
      alert("이메일을 입력해주세요.");
      return;
    }
    if (!password) {
      alert("비밀번호를 입력해주세요.");
      return;
    }
    if (!address) {
      alert("주소를 입력해주세요.");
      return;
    }
    if (!postcode) {
      alert("우편번호를 입력해주세요.");
      return;
    }
    if (total === 0) {
      alert("주문할 상품을 선택해주세요.");
      return;
    }


    // 주문 JSON 생성
    const orderData = {
      email,
      password,
      address,
      postcode,
      total,
      cartSummary
    };

    //test
    // const orderData = {
    //   email: "test@example.com",
    //   password: "securePassword",
    //   address: "123 Test St",
    //   postcode: "12345",
    //   total,
    //   cartSummary
    // };
    // orderData.cartSummary.forEach(item => {
    //   item.price = item.count * item.price;
    // });
    // console.log(orderData);

    // POST 요청으로 JSON 데이터 전송
    fetch("/add_item", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(orderData)
    })
            .then(response => response.json())
            .then(flag => {
              if (flag === 1) {
                alert("정상 등록되었습니다.");
              } else {
                alert("등록 실패하였습니다.");
              }
            })
            .catch(error => {
              console.error("에러 발생:", error);
              alert("오류가 발생하였습니다.");
            });
    console.log(orderData);
  }
</script>
</body>
</html>
