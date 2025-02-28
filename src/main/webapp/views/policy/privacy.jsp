<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TechX - 개인정보처리방침</title>
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
				<a class="nav-link active" id="privacy-tab" href="/privacy.policy">개인정보처리방침</a>
			</li>
			<li class="nav-item" role="presentation">
				<a class="nav-link" id="rights-tab" href="/rights.policy">이용자
					권익 보호정책</a>
			</li>
		</ul>

		<div class="tab-content" id="termsTabContent">
			
            <div class="tab-pane fade show active terms-container" id="privacy-content"
				role="tabpanel" aria-labelledby="privacy-tab">
				<h2 class="text-xl font-bold text-text-200 mt-1 -mb-0.5" level="2">개인정보처리방침</h2>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제1조
					(개인정보의 처리 목적)</h3>
				<p class="whitespace-pre-wrap break-words">TechX(이하 '회사')는 다음의
					목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이
					변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">회원 가입 및 관리
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">회원 가입의사
								확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정이용 방지, 각종 고지·통지
								등을 목적으로 개인정보를 처리합니다.</li>
						</ul>
					</li>
					<li class="whitespace-normal break-words" index="1">서비스 제공
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">게임 서비스,
								콘텐츠 제공, 맞춤서비스 제공, 본인인증 등을 목적으로 개인정보를 처리합니다.</li>
						</ul>
					</li>
					<li class="whitespace-normal break-words" index="2">마케팅 및 광고에의
						활용
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">신규 서비스
								개발 및 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 서비스의 유효성 확인, 접속빈도 파악
								또는 회원의 서비스 이용에 대한 통계 등을 목적으로 개인정보를 처리합니다.</li>
						</ul>
					</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제2조
					(개인정보의 처리 및 보유기간)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 법령에 따른 개인정보
					보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를
					처리·보유합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 각각의 개인정보 처리 및 보유
					기간은 다음과 같습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">회원 가입 및
						관리: 회원탈퇴 시까지
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">다만, 다음의
								사유에 해당하는 경우에는 해당 사유 종료 시까지
								<ol
									class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
									depth="2">
									<li class="whitespace-normal break-words" index="0">관계 법령
										위반에 따른 수사·조사 등이 진행 중인 경우에는 해당 수사·조사 종료 시까지</li>
									<li class="whitespace-normal break-words" index="1">서비스
										이용에 따른 채권·채무관계 잔존 시에는 해당 채권·채무관계 정산 시까지</li>
								</ol>
							</li>
						</ul>
					</li>
					<li class="whitespace-normal break-words" index="1">재화 또는 서비스
						제공: 재화·서비스 공급완료 및 요금결제·정산 완료시까지
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">다만, 다음의
								사유에 해당하는 경우에는 해당 기간 종료 시까지
								<ol
									class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
									depth="2">
									<li class="whitespace-normal break-words" index="0">「전자상거래
										등에서의 소비자 보호에 관한 법률」에 따른 표시·광고, 계약내용 및 이행 등 거래에 관한 기록
										<ul
											class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
											depth="3">
											<li class="whitespace-normal break-words" index="0">표시·광고에
												관한 기록: 6개월</li>
											<li class="whitespace-normal break-words" index="1">계약
												또는 청약철회, 대금결제, 재화 등의 공급기록: 5년</li>
											<li class="whitespace-normal break-words" index="2">소비자
												불만 또는 분쟁처리에 관한 기록: 3년</li>
										</ul>
									</li>
									<li class="whitespace-normal break-words" index="1">「통신비밀보호법」에
										따른 통신사실확인자료 보관
										<ul
											class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
											depth="3">
											<li class="whitespace-normal break-words" index="0">접속로그,
												접속IP정보: 3개월</li>
										</ul>
									</li>
								</ol>
							</li>
						</ul>
					</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제3조
					(개인정보의 제3자 제공)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 정보주체의 개인정보를
					제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보
					보호법 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 회사는 다음과 같이 개인정보를
					제3자에게 제공하고 있습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">결제서비스 제공업체
						<ul
							class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
							depth="1">
							<li class="whitespace-normal break-words" index="0">제공받는 자:
								(결제대행사명)</li>
							<li class="whitespace-normal break-words" index="1">제공목적:
								결제서비스 제공</li>
							<li class="whitespace-normal break-words" index="2">제공항목:
								성명, 이메일주소, 전화번호, 신용카드 정보, 은행계좌정보 등 결제정보</li>
							<li class="whitespace-normal break-words" index="3">보유기간:
								결제대행 서비스 제공 완료 시까지</li>
						</ul>
					</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제4조
					(정보주체와 법정대리인의 권리·의무 및 행사방법)</h3>
				<p class="whitespace-pre-wrap break-words">① 정보주체는 회사에 대해 언제든지
					개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.</p>
				<p class="whitespace-pre-wrap break-words">② 제1항에 따른 권리 행사는 회사에
					대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며,
					회사는 이에 대해 지체 없이 조치하겠습니다.</p>
				<p class="whitespace-pre-wrap break-words">③ 제1항에 따른 권리 행사는
					정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다. 이 경우 "개인정보 처리 방법에 관한
					고시(제2020-7호)" 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</p>
				<p class="whitespace-pre-wrap break-words">④ 개인정보 열람 및 처리정지 요구는
					「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.</p>
				<p class="whitespace-pre-wrap break-words">⑤ 개인정보의 정정 및 삭제 요구는
					다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.</p>
				<p class="whitespace-pre-wrap break-words">⑥ 회사는 정보주체 권리에 따른 열람의
					요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제5조
					(개인정보의 안전성 확보조치)</h3>
				<p class="whitespace-pre-wrap break-words">회사는 개인정보의 안전성 확보를 위해
					다음과 같은 조치를 취하고 있습니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">관리적 조치:
						내부관리계획 수립·시행, 정기적 직원 교육 등</li>
					<li class="whitespace-normal break-words" index="1">기술적 조치:
						개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화, 보안프로그램 설치</li>
					<li class="whitespace-normal break-words" index="2">물리적 조치:
						전산실, 자료보관실 등의 접근통제</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제6조
					(개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 이용자에게 개별적인
					맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다.</p>
				<p class="whitespace-pre-wrap break-words">② 쿠키는 웹사이트를 운영하는데
					이용되는 서버가 이용자의 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">쿠키의 사용목적:
						이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여
						이용자에게 최적화된 정보 제공을 위해 사용됩니다.</li>
					<li class="whitespace-normal break-words" index="1">쿠키의 설치·운영
						및 거부: 웹브라우저 상단의 도구&gt;인터넷 옵션&gt;개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부할 수
						있습니다.</li>
					<li class="whitespace-normal break-words" index="2">쿠키 저장을 거부할
						경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.</li>
				</ol>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제7조
					(개인정보 보호책임자)</h3>
				<p class="whitespace-pre-wrap break-words">① 회사는 개인정보 처리에 관한 업무를
					총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를
					지정하고 있습니다.</p>
				<p class="whitespace-pre-wrap break-words">▶ 개인정보 보호책임자</p>
				<ul
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">성명: OOO</li>
					<li class="whitespace-normal break-words" index="1">직책: OOO</li>
					<li class="whitespace-normal break-words" index="2">연락처:
						OO-OOO-OOOO, <a class="underline" href="mailto:privacy@techx.com">privacy@techx.com</a>
					</li>
				</ul>
				<p class="whitespace-pre-wrap break-words">② 정보주체께서는 회사의 서비스를
					이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실
					수 있습니다. 회사는 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제8조
					(개인정보 열람청구)</h3>
				<p class="whitespace-pre-wrap break-words">정보주체는 「개인정보 보호법」
					제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. 회사는 정보주체의 개인정보 열람청구가 신속하게
					처리되도록 노력하겠습니다.</p>
				<p class="whitespace-pre-wrap break-words">▶ 개인정보 열람청구 접수·처리 부서</p>
				<ul
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">부서명: 고객지원팀</li>
					<li class="whitespace-normal break-words" index="1">담당자: OOO</li>
					<li class="whitespace-normal break-words" index="2">연락처:
						OO-OOO-OOOO, <a class="underline" href="mailto:cs@techx.com">cs@techx.com</a>
					</li>
				</ul>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제9조
					(권익침해 구제방법)</h3>
				<p class="whitespace-pre-wrap break-words">정보주체는 개인정보침해로 인한 구제를
					받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다.
					이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.</p>
				<ol
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-decimal space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">개인정보분쟁조정위원회:
						1833-6972 (<a class="underline" href="http://www.kopico.go.kr">www.kopico.go.kr</a>)
					</li>
					<li class="whitespace-normal break-words" index="1">개인정보침해신고센터:
						118 (privacy.kisa.or.kr)</li>
					<li class="whitespace-normal break-words" index="2">대검찰청: 1301
						(<a class="underline" href="http://www.spo.go.kr">www.spo.go.kr</a>)
					</li>
					<li class="whitespace-normal break-words" index="3">경찰청: 182
						(ecrm.cyber.go.kr)</li>
				</ol>
				<p class="whitespace-pre-wrap break-words">「개인정보보호법」제35조(개인정보의
					열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이
					행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수
					있습니다.</p>
				<p class="whitespace-pre-wrap break-words">
					※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(<a class="underline"
						href="http://www.simpan.go.kr">www.simpan.go.kr</a>) 홈페이지를 참고하시기
					바랍니다.
				</p>
				<h3 class="text-lg font-bold text-text-200 mt-1 -mb-1.5" level="3">제10조
					(개인정보 처리방침 변경)</h3>
				<p class="whitespace-pre-wrap break-words">① 이 개인정보 처리방침은 2025년
					2월 27일부터 적용됩니다.</p>
				<p class="whitespace-pre-wrap break-words">② 이전의 개인정보 처리방침은 아래에서
					확인하실 수 있습니다.</p>
				<ul
					class="[&amp;:not(:last-child)_ul]:pb-1 [&amp;:not(:last-child)_ol]:pb-1 list-disc space-y-1.5 pl-7"
					depth="0">
					<li class="whitespace-normal break-words" index="0">2024년 1월
						1일 ~ 2025년 2월 26일 적용 (클릭)</li>
				</ul>
			</div>

		</div>
	</main>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>