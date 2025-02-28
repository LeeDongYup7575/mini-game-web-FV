<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login Page</title>
<link rel="stylesheet" href="/assets/css/login-page.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
	<div class="container">

		<div class="left">
			<div class="logo">
				<a href="/index.jsp"> <img src="/assets/img/bigLogo.png" alt="">
				</a>
			</div>
			<div class="signin">Welcome</div>

			<form action="/login.users" method="post">
				<div class="input-member">
					<input type="text" class="id" name="id" placeholder=" TechX 아이디 입력">
					<input type="password" class="pw" name="pw" placeholder=" 비밀번호 입력">
				</div>
			

			<div class="rememberId">
				<input type="checkbox" id="rememberId"> remember Id
			</div>

			<div class="signin-btn">
				<button type="submit" class="login">Login</button>
			</div>
			</form>

			<div class="membership">

				<a href="/views/auth/agreement.jsp">
					<div class="join-membership">회원가입</div>
				</a> <a href="/views/auth/findmyid.jsp">
					<div class="find-id">아이디 찾기</div>
				</a> <a href="/views/auth/findmypw.jsp">
					<div class="find-pw">비밀번호 찾기</div>
				</a>

			</div>

			<div class="with">Or sign in with</div>

			<div class="google-login">
				<button>Google 계정으로 로그인</button>
			</div>


		</div>




		<div class="right">
			<div class="sign-img">
				<img src="/assets/img/auth.jpg" class="sign"> <img
					src="/assets/img/bigLogo.png" class="logo2">
			</div>
			

		</div>
	</div>
</body>
<script>
	function goToPage(url) {
		window.location.href = url;
	}
</script>

<script>
	// 아이디 기억하기(로컬 스토리지 작업) 
	$(document).ready(function() {
		// 로컬 스토리지에서 아이디 불러오기 
		if (localStorage.getItem("rememberId") === "true") {
			$(".id").val(localStorage.getItem("savedId"));
			$("#rememberId").prop("checked", true);
		}

		// 체크박스 클릭 시 아이디 저장 또는 삭제
		$("#rememberId").on("change", function() {
			if ($(this).is(":checked")) {
				localStorage.setItem("rememberId", "true");
				localStorage.setItem("savedId", $(".id").val());
			} else {
				localStorage.removeItem("rememberId");
				localStorage.removeItem("savedId");
			}
		});

		// 로그인 버튼 클릭 시 ID 저장 확인
		$(".login").on("click", function() {
			if ($("#rememberId").is(":checked")) {
				localStorage.setItem("savedId", $(".id").val());
			}
		});

		let errorMessage = "<c:out value='${errorMessage}'/>";
		if (errorMessage != "") {
			alert(errorMessage);
		}
	});

	$(document).ready(function() {
		$(".login").on("click", function(e) {
			e.preventDefault(); // 기본 제출 방지

			let pwField = $(".pw");
			let pw = pwField.val().trim();

			if (pw === "") {
				alert("비밀번호를 입력해주세요.");
				return;
			}

			// 비밀번호 SHA-256 해싱
			let hashedPw = CryptoJS.SHA256(pw).toString();

			// 해싱된 비밀번호를 실제 전송 필드로 설정
			pwField.val(hashedPw);

			// 폼 제출
			$("form").submit();
		});

		let errorMessage = "<c:out value='${errorMessage}'/>";
		if (errorMessage !== "") {
			alert(errorMessage);
		}
	});
</script>


</html>