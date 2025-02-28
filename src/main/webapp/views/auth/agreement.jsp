<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

body {
    background-color: #f7f7f7;
    display: flex;
    flex-direction: column; /* 요소들을 수직으로 정렬 */
    align-items: center; /* 수평 중앙 정렬 */
    min-height: 100vh;
    justify-content: flex-start; /* 위쪽에 배치 */
    padding-top: 20px; /* 최상단에 너무 붙지 않도록 여백 추가 */
}

.container {
	position: relative;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 30px;
	width: 800px;
	
}

.title1, .title2 {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #333;
}

.contents1, .contents2 {
	background-color: #f0f0f0;
	padding: 15px;
	border-radius: 5px;
	height: 150px;
	overflow-y: auto;
	margin-bottom: 20px;
	line-height: 1.5;
	color: #555;
}

.sellect_all, .contents1_check, .contents2_check {
	display: flex;
	justify-content: end;
	margin-bottom: 15px;
	font-size: 16px;
	color: #333;
}

.sellect_all input[type="checkbox"], .contents1_check input[type="checkbox"],
	.contents2_check input[type="checkbox"] {
	width: 18px;
	height: 18px;
	margin-right: 10px;
}

button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	margin-right: 10px;
	transition: background-color 0.3s;
}

button:first-of-type {
	background-color: #4CAF50;
	color: white;
}

button:first-of-type:hover {
	background-color: #45a049;
}

button:last-of-type {
	background-color: #f44336;
	color: white;
}

button:last-of-type:hover {
	background-color: #d32f2f;
}

.button-group {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.title {
	height: 200px;
	width: 400px;
}

.title img {
	height: 100%;
	width: 100%;
}
</style>

</head>
<body>

	<div class="title">
		<img src="/assets/img/logoB.png" alt="">
	</div>
	<div class="container">


		<div class="conditions_agreement">

			<div class="title1">TechX 이용약관</div>
			<div class="contents1">
				제 1 장 총칙<br> 제 1 조 (목적)<br> 1. 이 약관은 TecxX가 제공하는 웹사이트를 포함한
				모든 서비스(이하 "서비스"라 한다)의 이용조건 및 운영에 관한 기본적인 사항을 규정함을 목적으로 합니다.<br>
				<br> 제 2 조 (용어의 정의)<br> 1. 이 약관에서 사용하는 용어의 정의는 다음 각호와
				같습니다.<br> - 회원 : 재단과 서비스 이용계약을 체결하고 회원가입에 필요한 개인정보(실명확인)를 제공하여
				회원등록을 한 자로서, 회원아이디를 부여받은 자<br> - ID : 회원식별과 회원의 서비스 이용을 위하여 회원이
				선정하고 재단이 승인하는 문자와 숫자의 조합<br> - 비밀번호 : 비밀 보호를 위해 회원 자신이 설정한 문자,
				숫자의 조합<br> - 이용자 : 본 약관에 따라 재단이 제공하는 서비스를 이용하는 자<br> - 운영자
				: 서비스의 전반적인 관리와 원활한 운영을 위하여 서비스 제공자에서 선정한 사람<br> - 탈퇴(해지) : 회원의
				이용계약을 종료시키는 행위<br> <br> 제 3 조 (효력의 발생과 변경)<br> 1. 이
				약관의 내용은 재단 웹사이트 화면에 게시하거나 기타의 방법으로 공지함으로써 효력이 발생됩니다.<br> 2. 재단은
				필요하다고 인정되는 경우 이 약관을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 효력이 발생됩니다.<br>
				3. 회원은 변경된 약관의 변경사항에 동의한 것으로 간주됩니다.
			</div>
			<div class="contents1_check">
				<input type="checkbox" id="terms1">&nbsp;TechX 이용약관에 동의합니다.
			</div>

			<div class="title2">개인정보 수집 및 이용</div>
			<div class="contents2">
				TecxX 홈페이지 회원 가입을 위한 개인정보 수집 및 이용에 대한 동의<br> <br> TecxX
				홈페이지는 회원 서비스를 제공하기 위하여 다음과 같이 개인정보를 수집·이용하고자 하오니, 다음 내용을 자세히 읽으신 후
				동의 여부를 결정하고 선택하여 주십시오.<br> <br> 1. 개인정보의 수집·이용 목적<br>
				TecxX는 다음과 같이 개인정보를 수집 및 이용합니다. 수집된 개인정보는 정해진 목적 이외의 용도로는 이용되지 않으며
				수집 목적이 변경될 경우 사전에 알리고 동의를 받을 예정입니다.<br> - 홈페이지 회원에게 정보 서비스 제공<br>
				- 회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 가입의사 확인, 가입 및 가입횟수 제한 등
				회원관리<br> - 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달<br>
				<br> 2. 수집하려는 개인정보의 항목<br> - 필수항목 : 아이디, 비밀번호, 이름, 생년월일,
				휴대폰번호, 이메일<br> - 서비스 이용과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
				(IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록)<br> <br> 3.
				개인정보의 보유 및 이용 기간: 탈퇴시까지<br> ※ 회원 이용자의 개인정보는 원칙적으로 개인정보의 수집 및
				이용목적이 달성되면 지체 없이 파기합니다. 따라서, TecxX는 정보주체의 회원 탈퇴 시에 회원의 개인정보를 즉시
				파기합니다.<br> <br> 4. 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익<br>
				정보주체는 당 사이트의 개인정보 수집 및 이용 동의를 거부할 권리가 있습니다. 단, 거부할 경우 회원가입이 불가함을
				알려드립니다.
			</div>

			<div class="contents2_check">
				<input type="checkbox" id="terms2">&nbsp;개인정보 수집 및 이용에
				동의합니다.
			</div>
			<div class="sellect_all"
				style="display: flex; justify-content: flex-end;">
				<input type="checkbox" id="selectAll">&nbsp;전체 이용약관에 동의합니다.
			</div>

			<div class="button-group">
				<button id="nextBtn">다음단계</button>
				<button onclick="history.back();">가입취소</button>
			</div>

		</div>
	</div>

	<script>
		const selectAll = document.getElementById('selectAll');
		const terms1 = document.getElementById('terms1');
		const terms2 = document.getElementById('terms2');
		const nextBtn = document.getElementById('nextBtn');

		// 전체 동의 체크박스 클릭 시
		selectAll.addEventListener('change', function() {
			const isChecked = this.checked;
			terms1.checked = isChecked;
			terms2.checked = isChecked;
		});

		// 개별 체크박스 클릭 시 전체 동의 체크박스 상태 업데이트
		function updateSelectAll() {
			if (terms1.checked && terms2.checked) {
				selectAll.checked = true;
			} else {
				selectAll.checked = false;
			}
		}

		terms1.addEventListener('change', updateSelectAll);
		terms2.addEventListener('change', updateSelectAll);

		// 다음단계 버튼 클릭 시 체크 확인
		nextBtn.addEventListener('click', function() {
			if (terms1.checked && terms2.checked) {
				alert('회원가입 창으로 이동합니다.');
				// 다음 단계로 넘어갈 페이지
				window.location.href = 'signup.jsp';
			} else {
				alert('모든 필수 약관에 동의해야 합니다.');
			}
		});
	</script>

</body>
</html>