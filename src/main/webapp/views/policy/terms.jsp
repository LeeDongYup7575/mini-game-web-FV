<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TechX - 이용약관</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/reset.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<!-- ✅ Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- ✅ Bootstrap JS (Bundle - includes Popper) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="/assets/css/policy.css">
</head>


<body>
	<%@ include file="/includes/header.jsp"%>

	<main>
		<div class="title">이용약관</div>
		<button class="print-btn" onclick="window.print()">
			<i class="fa-solid fa-print"></i> 인쇄하기
		</button>

		<ul class="nav nav-tabs terms-tabs" id="termsTab" role="tablist">
			<li class="nav-item" role="presentation">
				<a class="nav-link active" id="terms-tab" href="/terms.policy">약관보기</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link" id="privacy-tab" href="/privacy.policy">개인정보처리방침</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link" id="rights-tab" href="/rights.policy">이용자
					권익 보호정책</a>
			</li>
		</ul>

		<div class="tab-content" id="termsTabContent">
			<div class="tab-pane fade show active terms-container"
				id="terms-content" role="tabpanel" aria-labelledby="terms-tab">
				<h2>제1장 총칙</h2>
				<h3>제1조 (목적)</h3>
				<p>이 약관은 TechX(이하 "회사"라고 함)가 제공하는 게임 및 제반 서비스의 이용과 관련하여 회사와 회원의
					권리, 의무 및 기타 필요한 사항을 규정함을 목적으로 합니다.</p>

				<h3>제2조 (용어의 정의)</h3>
				<p>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
				<ol>
					<li>"서비스"라 함은 회사가 제공하는 게임 서비스 등에 대한 이용계약을 체결하고 회사에서 제공하는 모든
						게임서비스 등을 이용할 수 있는 권한을 의미합니다.</li>
					<li>"플랫폼"이라 함은 PC, 휴대폰, 태블릿, 휴대용 게임기, 콘솔 게임기, VR 등의 기기를 통해서
						콘텐츠를 다운로드 받거나 설치하여 사용할 수 있도록 제공하는 제반 프로그램과 서비스를 의미합니다.</li>
					<li>"게임서비스 등"이라 함은 회사가 회원에게 콘텐츠를 통하여 제공하는 게임 및 이에 부수된 제반 서비스를
						의미합니다.</li>
					<li>"콘텐츠"라 함은 회사가 게임서비스 등의 제공과 관련하여 디지털 방식으로 제작된 유료 또는 무료의
						내용물(캐릭터, 게임아이템, 아이템 등)을 의미합니다.</li>
					<li>"회원 ID"라 함은 "회원"이라 함은 회원의 식별과 게임서비스 등의 이용을 위하여 회원이 선정하고,
						회사가 승인하는, 문자, 특수문자, 숫자 등의 조합 또는 기존에 회원이 사용하고 있던 타 소셜 계정을 의미합니다.</li>
				</ol>

				<h2>제2장 서비스 이용계약</h2>
				<h3>제3조 (이용계약의 성립)</h3>
				<p>① 이용계약은 회원이 되고자 하는 자(이하 "가입신청자")가 약관의 내용에 대하여 동의를 한 다음
					회원가입신청을 하고 회사가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</p>
				<p>② 회사는 가입신청자의 신청에 대하여 회원가입을 승낙함을 원칙으로 합니다. 다만, 회사는 다음 각 호에
					해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.</p>
				<ol>
					<li>가입신청자가 이 약관에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 단 회사의 회원 재가입 승낙을
						얻은 경우에는 예외로 함</li>
					<li>회원가입 신청 시 실명이 아니거나 타인의 명의를 이용한 경우</li>
					<li>회원가입 신청 시 허위의 정보를 기재하거나, 회사가 요구하는 내용을 기재하지 않은 경우</li>
					<li>가입신청자가 만 14세 미만인 경우</li>
					<li>가입신청자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우</li>
				</ol>

				<h3>제4조 (회원정보의 변경)</h3>
				<p>① 회원은 개인정보관리화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스
					관리를 위해 필요한 실명, 주민등록번호, 아이디 등은 수정이 불가능합니다.</p>
				<p>② 회원은 회원가입 신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 또는 기타
					방법으로 회사에 대하여 그 변경사항을 알려야 합니다.</p>
				<p>③ 제2항의 변경사항을 회사에 알리지 않아 발생한 불이익에 대하여 회사는 책임을 지지 않습니다.</p>

				<h2>제3장 계약 당사자의 의무</h2>
				<h3>제5조 (회사의 의무)</h3>
				<p>① 회사는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 서비스를
					제공하기 위하여 최선을 다하여 노력합니다.</p>
				<p>② 회사는 회원이 안전하게 서비스를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위해 보안시스템을 갖추어야
					하며 개인정보처리방침을 공시하고 준수합니다.</p>
				<p>③ 회사는 서비스이용과 관련하여 회원으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야
					합니다. 회원이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 회원에게 처리과정 및 결과를
					전달합니다.</p>

				<h3>제6조 (회원의 의무)</h3>
				<p>① 회원은 다음 행위를 하여서는 안 됩니다.</p>
				<ol>
					<li>신청 또는 변경 시 허위내용의 등록</li>
					<li>타인의 정보도용</li>
					<li>회사가 게시한 정보의 변경</li>
					<li>회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시</li>
					<li>회사와 기타 제3자의 저작권 등 지적재산권에 대한 침해</li>
					<li>회사 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위</li>
					<li>외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는
						행위</li>
					<li>관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)의 전송 또는 게시</li>
					<li>회사의 직원이나 운영자를 가장하거나 사칭하여 또는 타인의 명의를 도용하여 글을 게시하거나 메일을 발송하는
						행위</li>
					<li>컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어
						바이러스, 기타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위</li>
					<li>스토킹(stalking) 등 다른 회원을 괴롭히는 행위</li>
					<li>다른 회원에 대한 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위</li>
					<li>서비스의 운영을 고의로 방해하거나 서비스의 안정적 운영을 방해할 수 있는 행위</li>
					<li>본 약관을 포함하여 기타 회사가 정한 규정 또는 이용 조건을 위반하는 행위</li>
					<li>기타 관계 법령에 위배되는 행위</li>
				</ol>

				<h2>제4장 서비스 이용</h2>
				<h3>제7조 (서비스의 제공 및 변경)</h3>
				<p>① 회사는 회원에게 아래와 같은 서비스를 제공합니다.</p>
				<ol>
					<li>모바일 웹 게임 서비스</li>
					<li>PC 웹 게임 서비스</li>
					<li>기타 회사가 추가 개발하거나 다른 회사와의 제휴계약 등을 통해 회원에게 제공하는 일체의 서비스</li>
				</ol>
				<p>② 회사는 서비스를 일정범위로 분할하여 각 범위 별로 이용가능시간, 이용 가능한 서비스의 종류를 구분하여 이를
					회원에게 고지 후 서비스를 제공할 수 있습니다.</p>
				<p>③ 회사는 서비스의 내용 및 이용조건은 변경될 수 있으며, 이 경우 회사는 변경된 서비스 내용 및 이용조건을
					사전에 공지합니다. 회원이 이에 대한 명시적인 거부를 하지 않는 경우 변경된 서비스 내용 및 이용조건을 승인한 것으로
					간주합니다.</p>

				<h3>제8조 (서비스 이용 시간)</h3>
				<p>① 서비스 이용은 회사의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간 운영을 원칙으로
					합니다. 단, 회사는 시스템 정기점검, 증설 및 교체를 위해 회사가 정한 날이나 시간에 서비스를 일시 중단할 수 있으며,
					예정되어 있는 작업으로 인한 서비스 일시 중단은 서비스 제공 사이트를 통해 사전에 공지합니다.</p>
				<p>② 회사는 긴급한 시스템 점검, 증설 및 교체, 설비의 장애, 서비스 이용의 폭주, 국가비상사태, 정전 등
					부득이한 사유가 발생한 경우 사전 예고 없이 일시적으로 서비스의 전부 또는 일부를 중단할 수 있습니다.</p>
				<p>③ 회사는 서비스 개편 등 서비스 운영 상 필요한 경우 전부 또는 일부 서비스의 제공을 중단할 수 있으며, 이
					경우 사전 공지합니다. 다만, 회사가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.</p>

				<div class="terms-date">시행일: 2025년 02월 27일</div>
			</div>
		</div>
	</main>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>