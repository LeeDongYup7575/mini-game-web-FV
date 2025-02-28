<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
  // 세션에서 사용자 정보 가져오기
  String nickname = (String)session.getAttribute("nickname");
  if(nickname == null) nickname = "guest";
  

  nickname = java.net.URLEncoder.encode(nickname, "UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 기본 메타 태그 -->
<title>TECH X - 게임 상세 정보 | 게임 제목</title>
<meta name="description"
	content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
<meta name="keywords"
	content="게임, 게임 상세 정보, TECH X, 게임 장르, 게임 플레이, 게임 설명">
<meta name="author" content="TECH X">

<!-- Open Graph (SNS 공유 최적화) -->
<meta property="og:title" content="TECH X - 게임 제목 상세 정보">
<meta property="og:description"
	content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
<meta property="og:type" content="website">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="TECH X - 게임 제목 상세 정보">
<meta name="twitter:description"
	content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">

<title>TECH X - 크로스 로드</title>
<!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
<link rel="stylesheet" href="/assets/css/reset.css">
<!-- 헤더 & 푸터 css  -->
<link rel="stylesheet" href="/assets/css/layout.css">
<!-- 전체 게임 css -->
<link rel="stylesheet" href="/assets/css/all-games.css">
<!-- phaser -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.87.0/phaser.min.js"></script>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 게임 css -->
<link rel="stylesheet" href="/assets/css/game.css">
<!-- <link rel="stylesheet" href="/views/games/chamchamcham/start-cham.css"> -->
<!-- 게임 js -->
<!-- <script src="/views/games/chamchamcham/GamePlay.js"></script> -->

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

<style>
/* 

    CSS3 Page Transition - 컨테이너 버전
    --------------------------------------------------
    다른 페이지에 삽입 가능하도록 수정됨

*/

/* 1.0 - 유틸리티 */
.gamebox {
	background-color: white;
}

.gamebox * {
	box-sizing: border-box;
}

.gamebox .sr-only {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.gamebox .hide {
	display: none;
}

/* 1.1 - 게임박스 기본 구조 */
.gamebox {
	position: relative;
	width: 100%;
	height: 100%;
	color: #212121;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica,
		Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji",
		"Segoe UI Symbol";
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	will-change: transform;
	perspective: 600px;
	min-height: 400px; /* 최소 높이 설정 */
}

/* 1.2 - 수정자 */
.gamebox.is-open {
	color: white;
	background-color: #212121;
}

.gamebox.is-open .square {
	padding: 0;
}

.gamebox.is-open .card {
	transform: scale(1);
}

.gamebox.is-open .card:hover {
	mix-blend-mode: normal;
	opacity: 1;
	filter: grayscale(0);
}

.gamebox.is-open .copy-wrap {
	transform: translate3d(0, -100%, 0);
}

.gamebox.is-open .title {
	color: white;
	mix-blend-mode: normal;
}

.gamebox.is-open .btn:hover {
	background-color: #212121;
	color: white;
}

.gamebox.is-open .btn:hover .btn-icon {
	fill: white;
}

/* 1.3 - 사각형 배경 */
.gamebox .square {
	cursor: pointer;
	border: solid 0px transparent;
	padding: 120px;
	width: 100%;
	height: 100%;
	transform: translate3d(-50%, -50%, 0);
	position: absolute;
	top: 50%;
	left: 50%;
	background: linear-gradient(230deg, #a24bcf, #4b79cf, #4bc5cf);
	background-clip: content-box;
	background-size: 400% 400%;
	border-color: currentColor;
	animation: partytime 7s cubic-bezier(0.46, 0.03, 0.52, 0.96) infinite;
	transition: padding 1s cubic-bezier(0.215, 0.61, 0.355, 1);
	will-change: transform;
}

@
keyframes partytime { 0%{
	background-position: 83% 0%
}

50




%
{
background-position




:




18


%
100


%
}
100




%
{
background-position




:




83


%
0


%
}
}
.gamebox .card {
	width: 100%;
	height: 100%;
	background-color: transparent;
	transition: transform 1.25s cubic-bezier(0.215, 0.61, 0.355, 1),
		box-shadow 1.25s cubic-bezier(0.215, 0.61, 0.355, 1), filter 1.25s
		cubic-bezier(0.215, 0.61, 0.355, 1), opacity 1.25s
		cubic-bezier(0.215, 0.61, 0.355, 1);
	transform: perspective(1600px) translate3d(0, 0, 0) scale(0.5);
	will-change: transform;
	cursor: pointer;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	position: relative;
	z-index: 400;
	min-height: 200px;
}

.gamebox .card:hover {
	box-shadow: 0 0 75px rgba(0, 0, 0, 0.20), 0 5px 20px rgba(0, 0, 0, 0.2);
	mix-blend-mode: hard-light;
	filter: grayscale(100%);
	opacity: 0.8;
}

.gamebox .card-title-wrap {
	transform: perspective(1600px) translate3d(0, 0, 100px);
	position: relative;
	z-index: 200;
	transition: transform 0.25s linear;
}

.gamebox .card-img {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-size: cover;
	background-position: 50% 50%;
	background-image:
		url(https://www.pauldecotiis.com/assets/img/contact/img-1.jpg?ts=1509977393);
	will-change: transform;
	transform: perspective(600px);
	z-index: 100;
}

/* 1.4 - 버튼 */
.gamebox .btn {
	position: absolute;
	top: 65%;
	left: 50%;
	transform: translate3d(-50%, -50%, 0);
	transition: all .25s ease-in-out;
	border: 0;
	background-color: black;
	padding: 12px 24px;
	color: white;
	font-size: 14px;
	text-transform: uppercase;
	letter-spacing: 0.2em;
	mix-blend-mode: overlay;
	box-shadow: 0 0 25px rgba(0, 0, 0, 0.8) 0 4px 12px rgba(0, 0, 0, 0.9);
	will-change: transform;
	cursor: pointer;
	z-index: 900;
	margin-top: 60px;
}

.gamebox .btn:active, .gamebox .btn:focus {
	outline: none;
}

.gamebox .btn:hover {
	background-color: white;
	mix-blend-mode: normal;
	color: #212121;
}

.gamebox .btn:hover .btn-icon {
	fill: black;
}

.gamebox .btn-icon {
	fill: white;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate3d(-50%, -50%, 0);
	transition: all .25s cubic-bezier(0.46, 0.03, 0.52, 0.96);
}

/* 1.5 - 타이포그래피 */
.gamebox .title {
	font-size: 5vw; /* 반응형 폰트 크기 */
	letter-spacing: 0.1em;
	text-transform: uppercase;
	margin: 0;
	font-weight: 900;
	overflow: hidden;
	color: black;
	mix-blend-mode: overlay;
	text-align: center;
}

.gamebox .name, .gamebox .copyright {
	text-transform: uppercase;
	color: currentColor;
	position: absolute;
	left: 50%;
	margin: 0;
	padding: 0;
	transition: all .5s cubic-bezier(0.46, 0.03, 0.52, 0.96);
	transform: translate3d(-50%, 0, 0);
	font-weight: 800;
	overflow: hidden;
	font-size: 16px;
	font-weight: 800;
	letter-spacing: 0.4em;
	text-align: center;
	width: 100%;
}

.gamebox .name {
	top: 10px;
}

.gamebox .copy-wrap {
	display: block;
	transition: all 0.7s 0s ease-in-out;
	position: relative;
}

.gamebox .copyright {
	bottom: 10px;
	overflow: hidden;
	height: 72px;
	line-height: 60px;
}

.gamebox .copyright .copy-wrap:before {
	content: "";
	width: 15px;
	height: 2px;
	background-color: currentColor;
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate3d(-50%, -50%, 0);
}

/* 반응형 스타일 */
@media ( max-width : 768px) {
	.gamebox .title {
		font-size: 8vw;
	}
	.gamebox .name, .gamebox .copyright {
		font-size: 12px;
		letter-spacing: 0.2em;
	}
	.gamebox .square {
		padding: 60px;
	}
}

/* 범위가 지정된 로딩 애니메이션 CSS */
.loading-container * {
	border: 0;
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

.loading-container {
	--loader-bg: hsl(223, 10%, 30%);
	--loader-fg: hsl(223, 10%, 90%);
	--loader-fg-t: hsla(223, 10%, 90%, 0.5);
	--loader-primary1: hsl(223, 90%, 55%);
	--loader-primary2: hsl(223, 90%, 65%);
	--loader-trans-dur: 0.3s;
	font-size: calc(16px + ( 20 - 16)* (100vw- 320px)/(1280- 320));
	font-family: "Varela Round", Helvetica, sans-serif;
	line-height: 1.5;
	display: grid;
	place-items: center;
	height: 100%;
	min-height: 200px; /* 컨테이너 내에서 더 작게 */
	position: relative;
	overflow: hidden;
	transition: background-color var(--loader-trans-dur), color
		var(--loader-trans-dur);
}

.loading-container .pl {
	box-shadow: 2em 0 2em hsla(0, 0%, 0%, 0.2) inset, -2em 0 2em
		hsla(0, 0%, 100%, 0.1) inset;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	letter-spacing: 0.1em;
	text-transform: uppercase;
	transform: rotateX(30deg) rotateZ(45deg);
	width: 15em;
	height: 15em;
	color: var(--loader-fg);
}

.loading-container .pl, .loading-container .pl__dot {
	border-radius: 50%;
}

.loading-container .pl__dot {
	animation-name: shadow;
	box-shadow: 0.1em 0.1em 0 0.1em hsl(0, 0%, 0%), 0.3em 0 0.3em
		hsla(0, 0%, 0%, 0.5);
	top: calc(50% - 0.75em);
	left: calc(50% - 0.75em);
	width: 1.5em;
	height: 1.5em;
	position: absolute;
	animation-duration: 2s;
	animation-iteration-count: infinite;
}

.loading-container .pl__dot:before, .loading-container .pl__dot:after {
	content: "";
	display: block;
	left: 0;
	width: inherit;
	position: absolute;
	animation-duration: 2s;
	animation-iteration-count: infinite;
	transition: background-color var(--loader-trans-dur);
}

.loading-container .pl__dot:before {
	animation-name: pushInOut1;
	background-color: var(--loader-bg);
	border-radius: inherit;
	box-shadow: 0.05em 0 0.1em hsla(0, 0%, 100%, 0.2) inset;
	height: inherit;
	z-index: 1;
}

.loading-container .pl__dot:after {
	animation-name: pushInOut2;
	background-color: var(--loader-primary1);
	border-radius: 0.75em;
	box-shadow: 0.1em 0.3em 0.2em hsla(0, 0%, 100%, 0.4) inset, 0 -0.4em
		0.2em hsl(223, 10%, 20%) inset, 0 -1em 0.25em hsla(0, 0%, 0%, 0.3)
		inset;
	bottom: 0;
	clip-path: polygon(0 75%, 100% 75%, 100% 100%, 0 100%);
	height: 3em;
	transform: rotate(-45deg);
	transform-origin: 50% 2.25em;
}

/* 점 위치 설정 */
.loading-container .pl__dot:nth-child(1) {
	transform: rotate(-0deg) translateX(5em) rotate(0deg);
	z-index: 5;
}

.loading-container .pl__dot:nth-child(1), .loading-container .pl__dot:nth-child(1):before,
	.loading-container .pl__dot:nth-child(1):after {
	animation-delay: 0s;
}

.loading-container .pl__dot:nth-child(2) {
	transform: rotate(-30deg) translateX(5em) rotate(30deg);
	z-index: 4;
}

.loading-container .pl__dot:nth-child(2), .loading-container .pl__dot:nth-child(2):before,
	.loading-container .pl__dot:nth-child(2):after {
	animation-delay: -0.16666666667s;
}

.loading-container .pl__dot:nth-child(3) {
	transform: rotate(-60deg) translateX(5em) rotate(60deg);
	z-index: 3;
}

.loading-container .pl__dot:nth-child(3), .loading-container .pl__dot:nth-child(3):before,
	.loading-container .pl__dot:nth-child(3):after {
	animation-delay: -0.33333333333s;
}

.loading-container .pl__dot:nth-child(4) {
	transform: rotate(-90deg) translateX(5em) rotate(90deg);
	z-index: 2;
}

.loading-container .pl__dot:nth-child(4), .loading-container .pl__dot:nth-child(4):before,
	.loading-container .pl__dot:nth-child(4):after {
	animation-delay: -0.5s;
}

.loading-container .pl__dot:nth-child(5) {
	transform: rotate(-120deg) translateX(5em) rotate(120deg);
	z-index: 1;
}

.loading-container .pl__dot:nth-child(5), .loading-container .pl__dot:nth-child(5):before,
	.loading-container .pl__dot:nth-child(5):after {
	animation-delay: -0.66666666667s;
}

.loading-container .pl__dot:nth-child(6) {
	transform: rotate(-150deg) translateX(5em) rotate(150deg);
	z-index: 1;
}

.loading-container .pl__dot:nth-child(6), .loading-container .pl__dot:nth-child(6):before,
	.loading-container .pl__dot:nth-child(6):after {
	animation-delay: -0.83333333333s;
}

.loading-container .pl__dot:nth-child(7) {
	transform: rotate(-180deg) translateX(5em) rotate(180deg);
	z-index: 2;
}

.loading-container .pl__dot:nth-child(7), .loading-container .pl__dot:nth-child(7):before,
	.loading-container .pl__dot:nth-child(7):after {
	animation-delay: -1s;
}

.loading-container .pl__dot:nth-child(8) {
	transform: rotate(-210deg) translateX(5em) rotate(210deg);
	z-index: 3;
}

.loading-container .pl__dot:nth-child(8), .loading-container .pl__dot:nth-child(8):before,
	.loading-container .pl__dot:nth-child(8):after {
	animation-delay: -1.16666666667s;
}

.loading-container .pl__dot:nth-child(9) {
	transform: rotate(-240deg) translateX(5em) rotate(240deg);
	z-index: 4;
}

.loading-container .pl__dot:nth-child(9), .loading-container .pl__dot:nth-child(9):before,
	.loading-container .pl__dot:nth-child(9):after {
	animation-delay: -1.33333333333s;
}

.loading-container .pl__dot:nth-child(10) {
	transform: rotate(-270deg) translateX(5em) rotate(270deg);
	z-index: 5;
}

.loading-container .pl__dot:nth-child(10), .loading-container .pl__dot:nth-child(10):before,
	.loading-container .pl__dot:nth-child(10):after {
	animation-delay: -1.5s;
}

.loading-container .pl__dot:nth-child(11) {
	transform: rotate(-300deg) translateX(5em) rotate(300deg);
	z-index: 6;
}

.loading-container .pl__dot:nth-child(11), .loading-container .pl__dot:nth-child(11):before,
	.loading-container .pl__dot:nth-child(11):after {
	animation-delay: -1.66666666667s;
}

.loading-container .pl__dot:nth-child(12) {
	transform: rotate(-330deg) translateX(5em) rotate(330deg);
	z-index: 6;
}

.loading-container .pl__dot:nth-child(12), .loading-container .pl__dot:nth-child(12):before,
	.loading-container .pl__dot:nth-child(12):after {
	animation-delay: -1.83333333333s;
}

.loading-container .pl__text {
	font-size: 0.75em;
	max-width: 5rem;
	position: relative;
	text-shadow: 0 0 0.1em var(--loader-fg-t);
	transform: rotateZ(-45deg);
}

/* 애니메이션 */
@
keyframes shadow {from { animation-timing-function:ease-in;
	box-shadow: 0.1em 0.1em 0 0.1em hsl(0, 0%, 0%), 0.3em 0 0.3em
		hsla(0, 0%, 0%, 0.3);
}

25




%
{
animation-timing-function




:




ease-out


;
box-shadow




:




0


.1em




0


.1em




0




0


.1em




hsl


(




0
,
0


%
,
0


%
)
,
0


.8em




0




0


.8em




hsla


(




0
,
0


%
,
0


%
,
0


.5




)


;
}
50




%
,
to {
	box-shadow: 0.1em 0.1em 0 0.1em hsl(0, 0%, 0%), 0.3em 0 0.3em
		hsla(0, 0%, 0%, 0.3);
}

}
@
keyframes pushInOut1 {from { animation-timing-function:ease-in;
	background-color: var(--loader-bg);
	transform: translate(0, 0);
}

25




%
{
animation-timing-function




:




ease-out


;
background-color




:




var


(




--loader-primary2




)


;
transform




:




translate


(




-71


%
,
-71


%
)


;
}
50




%
,
to {
	background-color: var(--loader-bg);
	transform: translate(0, 0);
}

}
@
keyframes pushInOut2 {from { animation-timing-function:ease-in;
	background-color: var(--loader-bg);
	clip-path: polygon(0 75%, 100% 75%, 100% 100%, 0 100%);
}

25




%
{
animation-timing-function




:




ease-out


;
background-color




:




var


(




--loader-primary1




)


;
clip-path




:




polygon


(




0




25


%
,
100


%
25


%
,
100


%
100


%
,
0




100


%
)


;
}
50




%
,
to {
	background-color: var(--loader-bg);
	clip-path: polygon(0 75%, 100% 75%, 100% 100%, 0 100%);
}

}
@media ( max-width : 768px) {
	.loading-container {
		font-size: calc(12px + ( 16 - 12)* (100vw- 320px)/(768- 320));
	}
}
</style>


</head>

<body>
	<c:if test="${empty loginUser}">
    	<c:redirect url="/403.error"/>
	</c:if>
	<!-- 공통 Header -->
	<%@ include file="/includes/header.jsp"%>

	<main>
		<section class="my-game-section">
			<h1 class="my-game-title">참참참!</h1>

			<div class="my-game-wrap">
				<div class="game-hero" id="gamebox">


					<div class="gamebox">
						<h1 class="name">
							<span class="copy-wrap"> 긴장감 넘치는 컴퓨터와의 눈치 게임! </span>
						</h1>
						<div class="square">

							<!-- 로딩 애니메이션을 포함하는 컨테이너 -->
							<div class="loading-container">
								<div class="pl">
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__dot"></div>
									<div class="pl__text">new window Loading…</div>
								</div>
							</div>



						</div>
						<div class="card">
							<div class="card-title-wrap">
								<h1 class="title">
									<span class="copy-wrap" id="startButton"> START </span>
								</h1>
								<button class="btn hide">View</button>
							</div>
							<div class="card-img"></div>
						</div>
						<h2 class="copyright">
							<span class="copy-wrap"> 참참참! </span>
						</h2>


						<!-- <script>
					    document.getElementById("startButton").addEventListener("click", function() {
					        window.open("chamchamcham.html", "_blank", "width=800,height=600");
					    });
					</script> -->



					</div>
					<!-- 게임::s -->
					<script>
						
					</script>
					<!-- 게임::e -->

					<div class="game-about">
						<div class="game-description-section">
							<h2 class="section-title _1">ABOUT</h2>
							<div class="game-description">
								<p>
									참참참! 긴장감 넘치는 컴퓨터와의 눈치 게임!<br> <br> 웹캠으로 고개를 돌려 컴퓨터와
									승부를 겨뤄보세요!<br> <br> [게임방법]<br> <br> 1. 웹캠
									권한을 허용하고 게임을 시작합니다.<br> 2. '게임시작' 버튼을 누르고 고개를 모니터에 나오는
									'참참참' 신호에 맞춰 고개를 좌 또는 우측으로 움직입니다.<br> 3. 세 번째 '참'이 출력될 때
									고개를 돌린 뒤 잠시 유지하고 있으면 됩니다.<br> 4. '패'하였을 경우 -30점, '승'하였을 경우
									+20점이 주어집니다! .<br> 5. 컴퓨터의 예측을 뚫고 최고의 기록에 도전하세요!<br>
								</p>
							</div>
						</div>

						<div class="game-info-wrap">
							<h2 class="section-title _1">게임 정보</h2>
							<ul class="game-info-list">
								<li class="game-info-item"><span class="info-label">게임
										장르</span> <span class="info-value">두뇌, 인공지능, 캐주얼 오락</span></li>
								<li class="game-info-item"><span class="info-label">난이도</span>
									<span class="info-value">하</span></li>
								<li class="game-info-item"><span class="info-label">개발
										상태</span> <span class="info-value">완료</span></li>
							</ul>
						</div>
					</div>
				</div>
		</section>

		<!-- 공통 전체게임 -->
		<%@ include file="/includes/all-games.jsp"%>
	</main>

	<!-- 공통 Footer -->
	<%@ include file="/includes/footer.jsp"%>

	<!-- 스코어 기록법 ::s-->
	<input type="hidden" id="gameId" value="4006">
	<input type="hidden" id="finalScore">

	<script>
	console.log("닉네임:", "<%= nickname %>");

	$(function() {
	    // 초기에 로딩 애니메이션 숨기기
	    $('.loading-container').hide();
	    
	    // 기존 startButton 이벤트 리스너 제거 (충돌 방지)
	    $("#startButton").off("click");
	    
	 // START 버튼 클릭 이벤트 처리
	    $("#startButton").on("click", (e) => {
	      e.preventDefault();
	      e.stopPropagation(); // 카드 클릭 이벤트와 중복 방지

	      console.log("START 버튼 클릭됨"); // 디버깅용

	      // 로딩 애니메이션 표시
	      $('.loading-container').show();

	      // 게임박스 열기 (애니메이션을 위해)
	      $('.gamebox').addClass('is-open');

	      // setTimeout을 사용하여 브라우저가 이벤트 처리를 완료할 시간을 줌
	      setTimeout(() => {
	        // 새 창 열기 (전체 화면으로)
	        // 매번 다른 타임스탬프를 URL에 추가하여 브라우저 캐시 방지
	        const timestamp = new Date().getTime();
	       	const nickname = "<%= nickname %>";
	        // JavaScript의 encodeURIComponent 사용
	        /* const encodedNickname = encodeURIComponent(nickname); */
	        const gameWindow = window.open(`chamchamcham.html?t=${timestamp}&userId=${nickname}`, "_blank", "fullscreen=yes");

	        // 창이 차단되었는지 확인
	        if(!gameWindow || gameWindow.closed || typeof gameWindow.closed === 'undefined') {
	          // 팝업이 차단된 경우 처리
	          alert("팝업이 차단되었습니다. 팝업 차단을 해제해 주세요.");
	          // 로딩 애니메이션 숨기기
	          $('.loading-container').hide();
	          $('.gamebox').removeClass('is-open');
	        } else {
	          // window 객체에 직접 데이터 전달
	          gameWindow.parentData = nickname;
	          console.log("사용자 ID가 새 창에 전달됨:", nickname);
	          console.log("새 창이 성공적으로 열렸습니다.");

	          // 3초 후에 로딩 애니메이션 숨기기
	          setTimeout(() => {
	            $('.loading-container').hide();
	            // 여기서 is-open 클래스 제거하지 않으면 게임 화면이 유지됨
	            // $('.gamebox').removeClass('is-open');
	          }, 3000);
	        }
	      }, 100);
	    });
	 
	    // 게임박스 카드 클릭 이벤트 (기존 기능)
	    const EASE = Power4.easeOut;
	    
	    const Engine = {
	        ui: {
	            initBtn() {
	                // START 버튼 제외 카드 영역 클릭 시 처리
	                $('.card').on('click', (e) => {
	                    // START 버튼을 클릭한 경우는 제외
	                    if($(e.target).closest('#startButton').length > 0) {
	                        return;
	                    }
	                    
	                    const gamebox = $('.gamebox');
	                    const btn = $('.btn');
	                    const loadingContainer = $('.loading-container');
	                    
	                    if (gamebox.hasClass('is-open')) {
	                        // 게임박스가 열려있을 때 닫기
	                        gamebox.removeClass('is-open');
	                        btn.html('View');
	                        loadingContainer.hide();
	                    } else {
	                        // 게임박스 열기 (일반 모드)
	                        gamebox.addClass('is-open');
	                        btn.html('close');
	                        // 일반 모드에서는 로딩 애니메이션 표시하지 않음
	                        TweenMax.set('.card', {clearProps: 'all'});
	                    }
	                });
	            },
	            initHover(e) {
	                $(document).on("mousemove", ".card", function(e) {
	                    if ($('.gamebox').hasClass('is-open')) {
	                        e.preventDefault();
	                    } else {
	                        const halfW = (this.clientWidth / 2);
	                        const halfH = (this.clientHeight / 2);

	                        const coorX = (halfW - (e.pageX - this.offsetLeft));
	                        const coorY = (halfH - (e.pageY - this.offsetTop));

	                        const degX = ((coorY / halfH) * 10) + 'deg';
	                        const degY = ((coorX / halfW) * -10) + 'deg';

	                        $(this).css('transform', () => {
	                            return `perspective(1600px) translate3d(0, 0px, 0) scale(0.6) rotateX(${degX}) rotateY(${degY})`;
	                        }).children('.card-title-wrap').css('transform', () => {
	                            return `perspective(1600px) translate3d(0, 0, 200px) rotateX(${degX}) rotateY(${degY})`;
	                        });
	                    }
	                }).on("mouseout", ".card", function() {
	                    $(this).removeAttr('style').children('.card-title-wrap').removeAttr('style');
	                });
	            }
	        }
	    };
	    
	    Engine.ui.initBtn();
	    Engine.ui.initHover();
	    
	    // HTML 엘리먼트에 직접 적용된 onclick 이벤트 리스너도 제거
	    document.getElementById("startButton").removeAttribute("onclick");
	});
	</script>
</body>

</html>