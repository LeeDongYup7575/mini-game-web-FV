<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TechX - 이용자 권익 보호정책</title>
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
				<a class="nav-link" id="terms-tab" href="/terms.policy">약관보기</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link" id="privacy-tab" href="/privacy.policy">개인정보처리방침</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link active" id="rights-tab" href="/rights.policy">이용자
					권익 보호정책</a>
			</li>
		</ul>

		<div class="tab-content" id="termsTabContent">

			<div class="tab-pane fade show active terms-container" id="rights-content"
				role="tabpanel" aria-labelledby="rights-tab">
				<h2 class="text-xl font-bold text-text-200 mt-1 -mb-0.5" level="2">이용자
					권익 보호정책</h2>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제1조
					(목적)</h3>
				<p class="whitespace-pre-wrap break-words">본 이용자 권익 보호정책은
					TechX(이하 '회사')가 제공하는 게임 서비스를 이용하는 회원의 권익을 보호하고, 회원과 회사 간의 분쟁을 예방하며,
					발생한 분쟁의 신속하고 공정한 해결을 도모하기 위하여 수립된 정책입니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제2조
					(적용범위)</h3>
				<p class="whitespace-pre-wrap break-words">본 정책은 회사가 제공하는 모든 게임
					서비스 및 이와 관련된 부가서비스에 적용됩니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제3조
					(이용자 권익 보호의 기본원칙)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자의 정당한 이익과
					권리가 침해되지 않도록 최선의 노력을 다합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 회사는 이용자에게 안정적이고 신뢰할
					수 있는 서비스를 제공하기 위하여 지속적으로 노력합니다.</p>
				<p class="whitespace-pre-wrap break-words">③ 회사는 이용자의 의견을 경청하고,
					합리적인 의견은 서비스 운영에 반영하도록 노력합니다.</p>
				<p class="whitespace-pre-wrap break-words">④ 회사는 이용자 간의 분쟁이 발생한
					경우 이를 합리적으로 조정하고 해결하도록 노력합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제4조
					(이용자 고충처리)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자의 불만이나 고충사항을
					신속하게 처리하기 위한 고객센터를 운영합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 이용자는 서비스 이용 중
					불만사항이나 문의사항이 있는 경우 다음의 방법으로 회사에 그 처리를 요청할 수 있습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">고객센터 전화:
						OO-OOO-OOOO</li>
					<li class="whitespace-normal break-words" index="1">이메일: <a
						class="underline" href="mailto:support@techx.com">support@techx.com</a></li>
					<li class="whitespace-normal break-words" index="2">홈페이지 내 1:1
						문의</li>
					<li class="whitespace-normal break-words" index="3">기타 회사가 별도로
						공지하는 방법</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">③ 회사는 제2항에 따라 이용자로부터
					불만사항 등을 접수받은 경우, 그 내용을 확인하고 중요도에 따라 다음과 같은 기간 내에 처리합니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">일반 문의사항:
						24시간 이내</li>
					<li class="whitespace-normal break-words" index="1">계정 관련 문의:
						48시간 이내</li>
					<li class="whitespace-normal break-words" index="2">결제 관련 문의:
						3영업일 이내</li>
					<li class="whitespace-normal break-words" index="3">기타 중요 사항:
						7영업일 이내</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">④ 회사는 다음과 같은 상황에서는 처리
					기간이 연장될 수 있으며, 이 경우 이용자에게 연장 사유와 처리 예정 일정을 안내합니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">추가적인 사실
						확인이 필요한 경우</li>
					<li class="whitespace-normal break-words" index="1">제3자 또는
						외부기관과의 협의가 필요한 경우</li>
					<li class="whitespace-normal break-words" index="2">이용자의 협조가
						추가로 필요한 경우</li>
					<li class="whitespace-normal break-words" index="3">천재지변, 전산장애
						등 불가항력적인 사유가 발생한 경우</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제5조
					(환불 정책)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 「전자상거래 등에서의
					소비자보호에 관한 법률」, 「콘텐츠산업진흥법」, 「게임산업진흥에 관한 법률」 등 관련 법령에 따라 이용자의 환불 요청을
					처리합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 디지털 콘텐츠의 특성상 다음의
					경우에는 환불이 제한될 수 있습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">이용자의 귀책사유로
						콘텐츠가 멸실 또는 훼손된 경우</li>
					<li class="whitespace-normal break-words" index="1">이용자가 이미
						콘텐츠를 사용한 경우</li>
					<li class="whitespace-normal break-words" index="2">구매 후 7일이
						경과한 경우</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">③ 콘텐츠에 결함이 있거나 회사의
					귀책사유로 서비스를 이용할 수 없는 경우에는 환불이 가능합니다.</p>
				<p class="whitespace-pre-wrap break-words">④ 환불 절차 및 방법에 관한 구체적인
					사항은 고객센터를 통해 안내합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제6조
					(계정 보호 및 복구)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자의 계정을 보호하기
					위해 보안시스템을 구축하고 유지합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 이용자의 계정이 타인에 의해
					부정하게 사용된 것이 확인된 경우, 회사는 해당 계정의 이용을 제한하고 정당한 이용자에게 계정을 복구해 주기 위한 조치를
					취합니다.</p>
				<p class="whitespace-pre-wrap break-words">③ 계정 복구를 위해서는 본인 확인
					절차가 필요하며, 회사가 요구하는 자료를 제출해야 할 수 있습니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제7조
					(게임 내 재화 및 아이템 보호)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자가 정당하게 획득한
					게임 내 재화와 아이템을 보호하기 위해 노력합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 시스템 오류나 회사의 귀책사유로
					인해 이용자의 게임 내 재화나 아이템이 소실된 경우, 회사는 이를 복구하거나 적절한 보상을 제공합니다.</p>
				<p class="whitespace-pre-wrap break-words">③ 이용자의 귀책사유로 인한 게임 내
					재화나 아이템의 소실에 대해서는 복구나 보상이 제한될 수 있습니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제8조
					(게임 서비스 중단에 대한 보상)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사의 귀책사유로 인해 서비스가
					중단된 경우, 회사는 그에 상응하는 적절한 보상을 제공할 수 있습니다.</p>
				<p class="whitespace-pre-wrap break-words">② 다음과 같은 경우에는 서비스 중단에
					대한 보상이 제한될 수 있습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">천재지변,
						국가비상사태 등 불가항력적인 사유로 인한 서비스 중단</li>
					<li class="whitespace-normal break-words" index="1">정기점검 등 사전에
						공지한 서비스 중단</li>
					<li class="whitespace-normal break-words" index="2">이용자의 귀책사유로
						인한 서비스 이용 불가</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">③ 보상의 구체적인 내용과 방법은
					서비스 상황, 중단 시간, 범위 등을 고려하여 회사가 합리적으로 결정하고 공지합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제9조
					(미성년자 보호)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 만 18세 미만 미성년자의
					건전한 게임 이용을 위해 다음과 같은 조치를 취합니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">게임 이용시간
						제한(셧다운제) 준수</li>
					<li class="whitespace-normal break-words" index="1">결제 한도 설정</li>
					<li class="whitespace-normal break-words" index="2">연령에 적합한
						콘텐츠 제공</li>
					<li class="whitespace-normal break-words" index="3">보호자 동의 확인</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">② 미성년자의 법정대리인은 미성년자의
					게임 이용 및 결제에 대한 동의를 철회할 수 있으며, 이 경우 회사는 미성년자의 서비스 이용을 제한할 수 있습니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제10조
					(게임 중독 예방)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자의 건전한 게임 이용을
					위해 다음과 같은 조치를 취합니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">일정 시간 게임
						이용 시 휴식 권고 메시지 표시</li>
					<li class="whitespace-normal break-words" index="1">장시간 게임 이용
						시 게임 이용 제한</li>
					<li class="whitespace-normal break-words" index="2">게임 중독 예방 및
						상담에 관한 정보 제공</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">② 회사는 게임 중독 예방 및 해소를
					위한 국가 정책에 적극 협조합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제11조
					(불공정 행위 금지)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 다음과 같은 불공정 행위를
					하지 않습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">게임 내 확률형
						아이템의 획득 확률을 허위로 표시하는 행위</li>
					<li class="whitespace-normal break-words" index="1">이용자에게 중요한
						정보를 제공하지 않거나 왜곡하여 제공하는 행위</li>
					<li class="whitespace-normal break-words" index="2">부당하게 게임의
						진행이나 결과에 영향을 미치는 행위</li>
					<li class="whitespace-normal break-words" index="3">기타 이용자의
						합리적 선택을 방해하는 행위</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">② 회사는 확률형 아이템의 경우 그
					획득 확률을 이용자가 확인할 수 있도록 공개합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제12조
					(운영정책 변경)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 서비스의 안정적 운영을
					위하여 운영정책을 변경할 수 있습니다.</p>
				<p class="whitespace-pre-wrap break-words">② 운영정책을 변경할 경우, 회사는
					변경 내용을 사전에 공지하고 이용자의 의견을 수렴하기 위해 노력합니다.</p>
				<p class="whitespace-pre-wrap break-words">③ 중요한 운영정책 변경의 경우, 최소
					7일 전에 공지하는 것을 원칙으로 합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제13조
					(권익보호정책의 변경)</h3>
				<p class="whitespace-pre-wrap break-words">① 이 권익보호정책은 2025년 2월
					27일부터 시행됩니다.</p>
				<p class="whitespace-pre-wrap break-words">② 회사는 관련 법령의 제·개정이나
					서비스 환경의 변화 등에 따라 본 정책을 변경할 수 있으며, 변경 시에는 변경 내용과 시행일을 명시하여 최소 7일 전에
					공지합니다.</p>
			</div>
		</div>
	</main>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>