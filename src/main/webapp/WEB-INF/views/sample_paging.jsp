<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.cafe.dto.ItemTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    ArrayList<ItemTO> lists = (ArrayList<ItemTO>) request.getAttribute("lists");
    int pages = (int) request.getAttribute("page");
    int totalPages = (int) request.getAttribute("totalPages");

    StringBuilder sb = new StringBuilder();

    for (ItemTO list : lists) {
        String name = list.getName();
        String price = list.getPrice();

        sb.append("<li class=\"list-group-item d-flex mt-2\">");
        sb.append("<div class=\"col-2\"><img class=\"img-fluid\" src=\"https://i.imgur.com/HKOFQYa.jpeg\" alt=\"\"></div>");
        sb.append("<div class=\"col\">");
        sb.append("<div class=\"row text-muted\">커피콩</div>");
        sb.append("<div class=\"row\">" + name + "</div>");
        sb.append("</div>");
        sb.append("<div class=\"col text-center price\">" + price + "원</div>");
        sb.append("<div class=\"col text-end action\">");
        sb.append("<a class=\"btn btn-sm btn-outline-dark me-2\" href=\"javascript:void(0)\" onclick=\"addToCart('" + name + "')\">추가</a>");
        sb.append("<a class=\"btn btn-sm btn-outline-danger\" href=\"javascript:void(0)\" onclick=\"removeFromCart('" + name + "')\">삭제</a>");
        sb.append("</div>");
        sb.append("</li>");
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

        .products {
            width: 100%;
        }

        .products .price, .products .action {
            line-height: 38px;
        }
    </style>
    <title>상품 목록</title>
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
                <%= sb.toString() %>
            </ul>
            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination mt-4">
                    <% if (pages > 1) { %>
                    <li class="page-item">
                        <a class="page-link" href="?page=<%= pages - 1 %>">이전</a>
                    </li>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= (i == pages) ? "active" : "" %>">
                        <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                    </li>
                    <% } %>
                    <% if (pages < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="?page=<%= pages + 1 %>">다음</a>
                    </li>
                    <% } %>
                </ul>
            </nav>
        </div>
        <div class="col-md-4 summary p-4">
            <div>
                <h5 class="m-0 p-0"><b>Summary</b></h5>
            </div>
            <hr>
            <div class="row">
                <h6 class="p-0">Columbia Nariño <span id="badge-Columbia Nariño" class="badge bg-dark">0개</span></h6>
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
</body>
</html>
