<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
    <style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        margin: 50px;
        background-color: #000;
    }
    .container {
        width: 300px;
        margin: auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 5px 5px 10px rgba(255, 255, 255, 0.3);
        background-color: white;
    }
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        box-sizing: border-box;
    }
    .button-container {
        display: flex;
        justify-content: space-between; /* 좌우로 버튼 배치 */
    }
    button {
        width: 48%; /* 버튼 크기를 48%로 설정하여 간격을 확보 */
        padding: 10px;
        background-color: #868789;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    
    button:hover {
	background-color: #000;
	}
    
    
    .error {
        color: red;
        margin-top: 10px;
    }
</style>

</head>
<body>
    <div class="container">
        <h2>비밀번호 확인</h2>
        <form id="checkPwForm" method="POST">
            <input type="password" id="password" name="password" placeholder="비밀번호 입력">
            <input type="hidden" id="hashedPassword" name="hashedPassword">  <!-- 해싱된 비밀번호 전송 필드 -->
            <button type="submit" class="modify-btn">확인</button>
            <button type="button" class="cancel">취소</button>
        </form>
        <p class="error" id="errorMsg"></p>
    </div>

    <script>
    $(".cancel").on("click",()=>{
    	window.close();
    })
    
    $(document).ready(function () {
    	$("#password").focus();
        function handlePasswordValidation(event) {
            event.preventDefault(); // 기본 제출 방지

            let pwField = $("#password");
            let hashedPwField = $("#hashedPassword");  // 숨겨진 필드
            let pw = pwField.val().trim();

            if (!pw) {
                $("#errorMsg").text("비밀번호를 입력하세요.");
                alert("비밀번호를 입력해주세요.");
                return;
            }

            // SHA-256 해싱 후 숨겨진 필드에 설정
            let hashedPw = CryptoJS.SHA256(pw).toString();
            hashedPwField.val(hashedPw);

            // 원본 비밀번호 필드 초기화 (보안을 위해)
            pwField.val("");

            // 버튼 클릭 시 폼 제출 여부 확인
            if ($(this).hasClass("modify-btn")) {
                $("#checkPwForm").off("submit").submit(); // 중복 이벤트 방지 후 제출
            } else {
                $.ajax({
                    type: "POST",
                    url: "/views/mypage/checkPasswordAction.jsp",
                    data: { password: hashedPw },
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                        	window.opener.location.href = "/views/mypage/modifyUser.jsp";
                        	window.close();
                        } else {
                            $("#errorMsg").text("비밀번호가 올바르지 않습니다.");
                        }
                    },
                    error: function (xhr) {
                        console.error("AJAX Error:", xhr.statusText);
                        console.error("Response:", xhr.responseText);
                        $("#errorMsg").text("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    },
                });
            }
        }

        // 이벤트 바인딩
        $("#checkPwForm").on("submit", handlePasswordValidation);

    });
    </script>
</body>
</html>
