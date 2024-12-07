<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>이메일 조회</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
  
  <style>
    body {
      background-color: #dddddd;
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
<script type="text/javascript">
  window.onload = function () {
    document.getElementById( 'btn_search' ).onclick = function () {
      if ( document.frm_login.email.value == '' ) {
        alert( '이메일을 입력하셔야 합니다.' );
        return false;
      }
      if ( document.frm_login.password.value == '' ) {
        alert( '비밀번호를 입력하셔야 합니다.' );
        return false;
      }
      document.frm_login.submit();
    };
  };
</script>
<body>

<div class="container">
  <div class="form-container">
    <h2 class="text-center mb-4" style="color: #8C8C8C;">본인인증</h2>

    <form action="login_ok.do" method="post" name="frm_login" id="email-query-form">
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control" name="email" id="email" placeholder="이메일을 입력하세요" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력하세요" required>
      </div>

      <button type="button" style="background-color:#202428" id="btn_search" class="btn btn-primary w-100">조회</button>
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

</body>
</html>
