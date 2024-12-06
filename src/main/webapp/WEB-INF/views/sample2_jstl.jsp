<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.cafe.dto.ItemTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //jstl 테스트 jsp 파일

    ArrayList<ItemTO> lists = (ArrayList<ItemTO>) request.getAttribute("lists");
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
                <!-- JSTL로 반복문 처리 -->

                <c:forEach var="item" items="${lists}">
                    <li class="list-group-item d-flex mt-2">
                        <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
                        <div class="col">
                            <div class="row text-muted">커피콩</div>
                            <div class="row">${item.name}</div>
                        </div>
                        <div class="col text-center price">${item.price}원</div>
                        <div class="col text-end action">
                            <a class="btn btn-sm btn-outline-dark me-2" href="javascript:void(0)" onclick="addToCart('${item.name}')">추가</a>
                            <a class="btn btn-sm btn-outline-danger" href="javascript:void(0)" onclick="removeFromCart('${item.name}')">삭제</a>
                        </div>
                    </li>
                </c:forEach>

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
                <h5 class="col text-end">0원</h5>
            </div>
            <button class="btn btn-dark col-12">결제하기</button>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // 제품 이름과 개수를 관리할 객체
    const cartSummary = {
        "Columbia Nariñó": 0,
        "Brazil Serra Do Caparaó": 0,
        "Ethiopia Yirgacheffe": 0,
        "Guatemala Antigua": 0
    };

    // "추가" 버튼 클릭 시 실행되는 함수
    function addToCart(productName) {
        cartSummary[productName]++;
        const badge = document.querySelector(`#badge-${CSS.escape(productName)}`);
        if (badge) {
            badge.textContent = `${cartSummary[productName]}개`;
        }
    }

    // "삭제하기" 버튼 클릭 시 실행되는 함수
    function removeFromCart(productName) {
        if (cartSummary[productName] > 0) {
            cartSummary[productName]--;
        }
        const badge = document.querySelector(`#badge-${CSS.escape(productName)}`);
        if (badge) {
            badge.textContent = `${cartSummary[productName]}개`;
        }
    }
</script>
</body>
</html>