<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.cafe.dto.ItemTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    ArrayList<ItemTO> lists = (ArrayList<ItemTO>)request.getAttribute( "lists" );
    ArrayList<ItemTO> cafeList = (ArrayList<ItemTO>)request.getAttribute( "cafeList" );
    int pages = (int) request.getAttribute("page");
    int totalPages = (int) request.getAttribute("totalPages");
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
            border: transparent
        }

        .summary {
            background-color: #ddd;
            border-top-right-radius: 1rem;
            border-bottom-right-radius: 1rem;
            padding: 4vh;
            color: rgb(65, 65, 65)
        }

        @media (max-width: 767px) {
            .summary {
                border-top-right-radius: unset;
                border-bottom-left-radius: 1rem
            }
        }

        .row {
            margin: 0
        }

        .title b {
            font-size: 1.5rem
        }

        .col-2,
        .col {
            padding: 0 1vh
        }

        img {
            width: 3.5rem
        }

        hr {
            margin-top: 1.25rem
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
        .data-section {
            max-height: 40vh !important; /* 스크롤 영역의 최대 높이 */
            overflow-y: auto; /* 세로 스크롤 활성화 */
            border: 1px solid #ccc; /* 외곽선 */
            padding: 10px; /* 내부 여백 */
            background-color: #fff; /* 배경색 */
        }

    </style>
    <script type="text/javascript">
        window.onload = function () {
            // 상품 개수를 저장할 객체를 동적으로 생성
            let productQuantities = {};
            let productPrices = {};

            // 로컬 스토리지에서 저장된 데이터를 불러오기
            if (localStorage.getItem('productQuantities')) {
                productQuantities = JSON.parse(localStorage.getItem('productQuantities'));
            }

            if (localStorage.getItem('productPrices')) {
                productPrices = JSON.parse(localStorage.getItem('productPrices'));
            }

            // 모든 상품 아이템에 대해 반복하면서 초기화
            const productItems = document.querySelectorAll('.products li');
            productItems.forEach((productItem) => {
                const productName = productItem.querySelector('.row:nth-of-type(2)').innerText.trim(); // 상품 이름 가져오기
                const productPriceText = productItem.querySelector('.price').innerText.trim(); // 상품 가격 가져오기
                const productPrice = parseInt(productPriceText.replace(/[^0-9]/g, '')); // 숫자만 추출해서 가격으로 변환

                if (!(productName in productQuantities)) {
                    productQuantities[productName] = 0; // 기본값으로 0으로 설정
                }

                if (!(productName in productPrices)) {
                    productPrices[productName] = productPrice; // 가격 저장
                }

                // Summary 섹션에서 해당 제품의 badge 요소 업데이트 및 표시 여부 설정
                const summaryItem = document.querySelector(`.data-section [data-product-name="${productName}"]`);
                if (summaryItem) {
                    const badge = summaryItem.querySelector('.badge');
                    badge.innerText = productQuantities[productName] + "개";

                    if (productQuantities[productName] > 0) {
                        summaryItem.style.display = 'block';
                    } else {
                        summaryItem.style.display = 'none';
                    }
                }
            });

            // 로컬 스토리지에 가격 정보를 저장
            localStorage.setItem('productPrices', JSON.stringify(productPrices));

            // 총금액 초기화
            updateTotalAmount();

            // 모든 상품 아이템에 대해 "추가" 및 "감소" 버튼 이벤트 설정
            productItems.forEach((productItem) => {
                const addButton = productItem.querySelector('.btn-outline-dark'); // 추가 버튼
                const subtractButton = productItem.querySelector('.btn-outline-danger'); // 감소 버튼
                const productName = productItem.querySelector('.row:nth-of-type(2)').innerText.trim(); // 상품 이름 가져오기

                // 추가 버튼 클릭 시 개수 증가
                addButton.addEventListener('click', function (event) {
                    event.preventDefault(); // 기본 동작 막기
                    updateProductQuantity(productName, 1);
                });

                // 감소 버튼 클릭 시 개수 감소
                if (subtractButton) {
                    subtractButton.addEventListener('click', function (event) {
                        event.preventDefault(); // 기본 동작 막기
                        updateProductQuantity(productName, -1);
                    });
                }
            });

            // 상품 개수를 업데이트하는 함수
            function updateProductQuantity(productName, change) {
                // 개수 업데이트 및 최소값 유지
                productQuantities[productName] = Math.max(0, productQuantities[productName] + change);

                // 로컬 스토리지에 업데이트된 수량 저장
                localStorage.setItem('productQuantities', JSON.stringify(productQuantities));

                // Summary 섹션에서 해당 제품의 badge 요소 업데이트 및 표시 여부 설정
                const summaryItem = document.querySelector(`.data-section [data-product-name="${productName}"]`);
                if (summaryItem) {
                    const badge = summaryItem.querySelector('.badge');
                    badge.innerText = productQuantities[productName] + "개";

                    if (productQuantities[productName] > 0) {
                        summaryItem.style.display = 'block';
                    } else {
                        summaryItem.style.display = 'none';
                    }
                }

                // 총금액 업데이트
                updateTotalAmount();

                console.log(productQuantities); // 디버깅을 위해 현재 상품 개수 출력
            }

            // 총금액을 업데이트하는 함수
            function updateTotalAmount() {
                let totalAmount = 0;

                // 각 상품의 개수와 가격을 사용하여 총금액 계산
                for (let productName in productQuantities) {
                    totalAmount += productQuantities[productName] * productPrices[productName];
                }

                // 총금액을 페이지에 업데이트
                const totalAmountElement = document.querySelector('.row.pt-2.pb-2.border-top .col.text-end');
                totalAmountElement.innerText = totalAmount + "원";
            }

            // 결제 버튼 클릭 시 모든 데이터를 JSON으로 전송
            document.getElementById('wbtn').onclick = function (event) {
                event.preventDefault(); // 기본 폼 제출 동작 방지
                var form = document.wfrm;

                // 이메일, 주소, 우편번호 유효성 검사
                if (form.email.value.trim() === "") {
                    alert('이메일을 입력하셔야 합니다.');
                    return false;
                }

                var email = form.email.value.trim();
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('유효한 이메일 주소를 입력해 주세요.');
                    return false;
                }
                if (form.password.value.trim() === "") {
                    alert('비밀번호를 입력하셔야 합니다.');
                    return false;
                }

                if (form.address.value.trim() === "") {
                    alert('주소를 입력하셔야 합니다.');
                    return false;
                }

                if (form.postcode.value.trim() === "") {
                    alert('우편번호를 입력하셔야 합니다.');
                    return false;
                }

                // 상품 개수가 1 이상인 경우만 전송
                const filteredQuantities = {};
                for (let productName in productQuantities) {
                    if (productQuantities[productName] > 0) {
                        filteredQuantities[productName] = productQuantities[productName];
                    }
                }

                // 모든 데이터 JSON으로 구성
                const dataToSend = {
                    email: form.email.value,
                    password: form.password.value,
                    address: form.address.value,
                    postcode: form.postcode.value,
                    productQuantities: filteredQuantities
                };

                // AJAX 요청을 사용하여 서버로 데이터를 전송 (fetch 사용)
                fetch('/endpoint', {
                    method: 'POST', // POST 방식 사용
                    headers: {
                        'Content-Type': 'application/json' // JSON 데이터 전송
                    },
                    body: JSON.stringify(dataToSend) // 데이터 직렬화 (JSON 형태로 변환)
                })
                    .then(response => response.text())
                    .then(data => {
                        // 서버에서 응답을 받았을 때 처리하는 부분
                        console.log('Success:', data);
                        alert('결제가 완료되었습니다!');
                        // 결제 완료 후 로컬 스토리지 초기화
                        localStorage.removeItem('productQuantities');
                        // 모든 badge를 0으로 초기화하고 숨기기
                        for (let productName in productQuantities) {
                            productQuantities[productName] = 0;
                            const summaryItem = document.querySelector(`.data-section [data-product-name="${productName}"]`);
                            if (summaryItem) {
                                const badge = summaryItem.querySelector('.badge');
                                badge.innerText = "0개";
                                summaryItem.style.display = 'none';
                            }
                        }
                        // 총금액 초기화
                        updateTotalAmount();
                    })
                    .catch((error) => {
                        // 에러가 발생했을 때 처리하는 부분
                        console.error('Error:', error);
                        alert('결제 중 오류가 발생했습니다. 다시 시도해 주세요.');
                    });
            };
        };
    </script>


</head>
<body class="container-fluid">
<div class="row justify-content-center m-4">
    <h1 class="text-center">상품 목록</h1>
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
                <c:forEach var="item" items="${lists}">
                    <li class="list-group-item d-flex mt-2">
                        <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/HKOFQYa.jpeg" alt=""></div>
                        <div class="col">
                            <div class="row text-muted">커피콩</div>
                            <div class="row">${item.name}</div>
                        </div>
                        <div class="col text-center price">${item.price}원</div>
                        <div class="col text-end action">
                            <a class="btn btn-small btn-outline-dark me-1" href="">추가</a>
                            <a class="btn btn-small btn-outline-danger" href="">삭제</a>
                        </div>
                    </li>
                </c:forEach>
            </ul>


            <!-- 페이지네이션 -->
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <!-- 이전 페이지 -->
                    <c:if test="${pages > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pages - 1}&pageSize=${pageSize}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <!-- 페이지 번호 -->
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == pages ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&pageSize=${pageSize}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 페이지 -->
                    <c:if test="${pages < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pages + 1}&pageSize=${pageSize}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>



        <div class="row">
            <!-- 상품 데이터 영역 -->
            <div class="col-md-6">
                <h5><b>상품 데이터</b></h5>
                <hr>
                <div class="data-section" id="data-section">
                    <c:forEach var="item" items="${cafeList}">
                        <div class="row mb-2" data-product-name="${item.name}">
                            <h6 class="p-0">${item.name}<span class="badge bg-dark ms-2">0개</span></h6>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 결제 폼 영역 -->
            <div class="col-md-6">
                <h5><b>결제 폼</b></h5>
                <hr>
                <form name="wfrm">
                    <div class="mb-3">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control mb-1" id="email" placeholder="이메일을 입력하세요">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="text" class="form-control" id="password" placeholder="비밀번호를 입력하세요">
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" class="form-control mb-1" id="address" placeholder="주소를 입력하세요">
                    </div>
                    <div class="mb-3">
                        <label for="postcode" class="form-label">우편번호</label>
                        <input type="text" class="form-control" id="postcode" placeholder="우편번호를 입력하세요">
                    </div>
                    <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>

                    <div class="row pt-2 pb-2 border-top">
                        <h5 class="col">총금액</h5>
                        <h5 class="col text-end">0원</h5>
                    </div>

                    <button class="btn btn-dark col-12" id="wbtn">결제하기</button>
                </form>
            </div>
        </div>


    </div>
</div>
</body>
</html>
