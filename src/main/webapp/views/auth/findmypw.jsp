<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
 * {
            box-sizing: border-box;
        }

        @media screen and (max-width : 768px) {
            .container {
                flex: 10;
            }

            .right {
                display: none;
                border: none;
            }

            .left {
                flex: 10 !important;
                width: 100%;
            }
        }

        body {
            background-color: black;
        }

        .container {
            position: relative;
            flex: 10;
            border: none;
            height: 800px;
            display: flex;
            margin-top:68px
        }

        .left {

            flex: 5;
            float: left;
            width: 50%;
            height: 100%;
        }

        .logo {
            width: 50%;
            margin-top: 50px;
            margin-left: 25%;
            cursor: pointer;
        }

        .logo img {
            width: 100%;
        }

        .signin {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50px;
            font-size: 30px;
            color: white;

        }

        .input-member {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-top: 10px;
            padding: 10px;
        }

        .input-member input {
            width: 350px;
            height: 40px;
            border-radius: 8px;
            background: rgb(77, 76, 77);
            color: white;
            border: none;
        }

        .input-member input::placeholder {
            color: white;
            opacity: 7;
        }

        .rememberId {
            color: white;
            width: 400px;
            margin: auto;
            margin-top: 20px;
        }

        .signin-btn {
            height: 45px;
            width: 250px;
            margin: auto;
            border-radius: 8px;
            margin-top: 30px;

        }

        .signin-btn button {
            width: 100%;
            height: 100%;
            border-radius: 8px;
            cursor: pointer;
            background: rgb(77, 76, 77);
            color: white;
            border: none;
        }

        .signin-btn :hover {
            background: rgba(255, 255, 255, 0.494);
            color: black;
            transition-duration: 0.5s;
        }

        .membership {
            display: flex;
            margin: auto;
            /* 가운데 정렬 */
            gap: 20px;
            /* 요소 간격 조정 */
            color: white;
            width: 250px;
            margin-top: 30px;
        }

        .with {
            color: white;
            text-align: center;
            width: 250px;
            margin: auto;
            margin-top: 25px;
        }

        .google-login {
            margin: auto;
            width: 250px;
            height: 50px;
            margin-top: 25px;
            border-radius: 8px;
        }

        .google-login button {
            width: 100%;
            height: 100%;
            border-radius: 8px;
            cursor: pointer;
            background: rgb(77, 76, 77);
            color: white;
            border: none;
        }

        .google-login :hover {
            background: rgba(255, 255, 255, 0.494);
            color: black;
            transition-duration: 0.5s;
        }

        .right {
            float: right;
            width: 50%;
            height: 100%;
            flex: 5;
        }

        .sign-img {
            position: relative;
            /* 자식 요소의 기준점 */
            width: 100%;
            height: 100%;
        }

        .sign {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 10;
            /* 뒤로 배치 */
        }

        .logo2 {
            position: absolute;
            top: 45%;
            left: 50%;
            transform: translate(-50%, -50%);
            /* 정중앙 배치 */
            width: 400px;
            /* 크기 조정 */
            height: auto;
            z-index: 20;
            /* 앞으로 배치 */
        }

        a{
            color: white;
        }
</style>
</head>
<body>

	<body>

	<div class="container">

		<div class="left">
			<div class="logo">
				<a href="/index.jsp"> <img src="/assets/img/bigLogo.png" alt="">
				</a>
			</div>
			<div class="signin">FIND MY PW</div>

			<form id="findIdForm" action="/findId.users" method="post">
				<div class="input-member">
					<input type="text" class="id" id="userId" name="id" placeholder=" 아이디 입력">
					<input type="text" class="pw" id="userEmail" name="email" placeholder=" 이메일 주소 입력">
				</div>
			

			<div class="signin-btn">
				<button type="button" class="login" id="findPwBtn">비밀번호 찾기</button>
			</div>
			</form>

			<div class="membership">

				<a href="/views/auth/login.jsp">
					<div class="join-membership">로그인</div>
				</a> <a href="/views/auth/agreement.jsp">
					<div class="find-id">회원가입</div>
				</a> <a href="/views/auth/findmyid.jsp">
					<div class="find-pw">아이디 찾기</div>
				</a>

			</div>

		</div>

		<div class="right">
			<div class="sign-img">
				<img src="/assets/img/auth.jpg" class="sign"> <img
					src="/assets/img/bigLogo.png" class="logo2">
			</div>
			

		</div>
	</div>

		<script>
	    $(document).ready(function() {
	        $("#findPwBtn").on("click", function() {
	            let id = $("#userId").val();
	            let email = $("#userEmail").val();
	            
	            if(id === "" || email === "") {
	                alert("아이디와 이메일을 모두 입력해주세요.");
	                return;
	            }

	            $.ajax({
	                type: "POST",
	                url: "/findpw.users",
	                data: { id: id, email: email },
	                dataType: "json",
	                success: function(response) {
	                    if (response.match) {
	                        // 아이디와 이메일이 일치하면 비밀번호 재설정 창으로 이동
	                        window.open("pwcheck.jsp?id=" + id + "&email=" + email, "_blank", "width=600,height=400,top=250,left=500");
	                    } else {
	                        alert("일치하는 계정 정보가 없습니다.");
	                    }
	                },
                    error: function(xhr, status, error) {
                        console.error("AJAX 오류 발생:", status, error);
                        alert("요청 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
                    }
	            });
	        });
	    });
		</script>
	</div>

</body>

</body>
</html>