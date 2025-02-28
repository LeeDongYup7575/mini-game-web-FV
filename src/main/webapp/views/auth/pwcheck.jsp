<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<style>
  /* 전체 페이지 스타일 */
  body {
    font-family: 'Arial', sans-serif;
    background: black;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }

  /* 비밀번호 변경 컨테이너 */
  .container {
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    width: 350px;
    text-align: center;
  }

  h2 {
    margin-bottom: 20px;
    color: #333;
  }

  /* 입력 필드 스타일 */
  .input-group {
    margin-bottom: 15px;
    text-align: left;
  }

  .input-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #555;
  }

  .input-group input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 14px;
    transition: 0.3s;
  }

  .input-group input:focus {
    border-color: #007BFF;
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
  }

  /* 에러 & 성공 메시지 */
  .error-msg {
    color: red;
    font-size: 13px;
    margin-top: 5px;
    display: none;
  }

  .success-msg {
    color: green;
    font-size: 13px;
    margin-top: 5px;
    display: none;
  }

  /* 버튼 스타일 */
  .btn-submit {
    background: #000;
    color: white;
    border: none;
    padding: 12px;
    width: 100%;
    font-size: 16px;
    border-radius: 6px;
    cursor: pointer;
    transition: 0.3s;
    margin-top:10px
  }

  .btn-submit:hover {
    background: #868789;
  }
</style>
</head>
<body>

<div class="container">
  <h2>비밀번호 변경</h2>
  <form id="resetPwForm" action="resetpw.users" method="post">
    <input type="hidden" name="userId" value="<%= request.getAttribute("userId") %>">

    <div class="input-group">
      <label for="newPassword">새로운 비밀번호 입력</label>
      <input type="password" id="newPassword" name="newPassword" required>
    </div>

    <div class="input-group">
      <label for="confirmPassword">비밀번호 확인</label>
      <input type="password" id="confirmPassword" name="confirmPassword" required>
    </div>

    <div class="error-msg" id="pwMatchError"></div>
    
    <button type="button" id="resetPwBtn" class="btn-submit">비밀번호 변경</button>
  </form>
</div>

<script>
$(document).ready(function() {
  // 비밀번호 확인 검사
  $("#newPassword, #confirmPassword").on("input", function() {
    let pw = $("#newPassword").val().trim();
    let pwConfirm = $("#confirmPassword").val().trim();
    let errorDiv = $("#pwMatchError");

    if (pw === "" || pwConfirm === "") {
      errorDiv.hide();
      return;
    }

    if (pw === pwConfirm) {
      errorDiv.removeClass("error-msg").addClass("success-msg").text("비밀번호가 같습니다.").show();
    } else {
      errorDiv.removeClass("success-msg").addClass("error-msg").text("비밀번호가 다릅니다.").show();
    }
  });

  // 비밀번호 변경 버튼 클릭 이벤트
  $("#resetPwBtn").on("click", function() {
    let userId = $("input[name='userId']").val();
    let newPassword = $("#newPassword").val().trim();
    let confirmPassword = $("#confirmPassword").val().trim();

    // 비밀번호 정규식 (대문자, 소문자, 숫자, 특수문자 포함 8자 이상)
    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;

    if (!pwRegex.test(newPassword)) {
      alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.");
      return;
    }

    if (newPassword !== confirmPassword) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }

    // 비밀번호 해싱
    let hashedPw = CryptoJS.SHA256(newPassword).toString();

    // AJAX 요청
    $.ajax({
      type: "POST",
      url: "resetpw.users",
      data: { 
        userId: userId, 
        newPassword: hashedPw 
      },
      success: function(response) {
        if (response.trim() === "비밀번호 변경 실패") {
          alert("비밀번호 변경에 실패했습니다.");
        } else {
          alert("비밀번호 변경 성공! 로그인 페이지로 이동합니다.");
          window.opener.location.href = "/index.jsp";
          window.close();
        }
      },
      error: function() {
        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
      }
    });
  });
});
</script>

</body>
</html>
