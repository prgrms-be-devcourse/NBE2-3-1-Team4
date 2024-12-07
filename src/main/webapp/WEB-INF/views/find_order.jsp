<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>이메일 조회</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
  
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      max-width: 400px;
      margin-top: 50px;
    }
    .form-container {
      padding: 20px;
      border-radius: 8px;
      background-color: #ffffff;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>

<div class="container">
  <div class="form-container">
    <h2 class="text-center mb-4" style="color: #8C8C8C;">본인인증</h2>

    <form id="email-query-form">
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control" id="email" placeholder="이메일을 입력하세요" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="password" placeholder="비밀번호를 입력하세요" required>
      </div>

      <button type="submit" class="btn btn-primary w-100">조회</button>
    </form>

    <div id="result" class="mt-4" style="display: none;">
      <h5>조회된 정보</h5>
      <p id="order-status"></p>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-W8fXkzAtXh5Nn9j2nHl8f8EkK7cF6er3z0m5BzNJS9rJdo6jFn0z3LU8D5UKnZnF" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0z61Ay8RaUqV+Yp9Utx8pFJpgJ0v0g4Kh0n8CzHkU39h0DhJ" crossorigin="anonymous"></script>

<!-- JavaScript -->
<script>
  document.getElementById('email-query-form').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    if (email && password) {
      // 예시 이메일 목록 (실제 서버 연동을 통해 확인해야 함)
      const existingEmails = ["user@example.com", "customer@domain.com", "test@site.com"];
      
      // 이메일이 목록에 있는지 확인
      if (existingEmails.includes(email)) {
        // 주문 내역이 있다고 표시
        document.getElementById('order-status').textContent = "주문 내역 있음.";
      } else {
        // 주문 내역이 없다고 표시
        document.getElementById('order-status').textContent = "주문 내역 없음.";
      }

      // 결과 표시
      document.getElementById('result').style.display = 'block';
    } else {
      if (!email) {
        alert('이메일을 입력해주세요.');
      }
      if (!password) {
        alert('비밀번호를 입력해주세요.');
      }
    }
  });
</script>

</body>
</html>
