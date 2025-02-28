<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 기본 메타 태그 -->
<title>TECH X - 게임 상세 정보 | Rhythm Game</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
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

<title>TECH X - Rhythm Game</title>
<!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
<link rel="stylesheet" href="/assets/css/reset.css">
<!-- 헤더 & 푸터 css  -->
<link rel="stylesheet" href="/assets/css/layout.css">
<!-- 전체 게임 css -->
<link rel="stylesheet" href="/assets/css/all-games.css">

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- 게임 css -->
<link rel="stylesheet" href="/assets/css/game.css"> 
<!-- 게임 js -->
<style>
.container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #1a1a1a;
	border: none;
}

#gameCanvas {
	position: absolute;
	border: 1px solid white;
	top: 202px;
	left: 126px;
	width: 960px;
	height: 550px;
	border: none;
}

#startButton {
	position: absolute;
	top: 762px;
	left: 500px;
	padding: 10px 20px;
	font-size: 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 20px;
}

#startButton:hover {
	background-color: #45a049;
}

#playTime {
	position: absolute;
	top: 10px;
	right: 10px;
	color: white;
	font-size: 20px;
	font-family: Arial, sans-serif;
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
			<h1 class="my-game-title">Snake Game</h1>

			<div class="my-game-wrap">
				<div class="game-hero" id="gamebox"></div>

				<!-- 게임::s -->
				<div class="container1">
					<button id="startButton">게임 시작</button>
					<canvas id="gameCanvas" width="960" height="540"></canvas>

					<script>
        const canvas = document.getElementById("gameCanvas");
        const ctx = canvas.getContext("2d");
        const startButton = document.getElementById("startButton");

        const box =  20;
        const rows = canvas.height / box;
        const columns = canvas.width / box;
        let score, snake, food, d, game, changingDirection, startTime;

        function initGame() {
            score = 0;
            snake = [{ x: 10 * box, y: 10 * box }];
            food = {
                x: Math.floor(Math.random() * columns) * box,
                y: Math.floor(Math.random() * rows) * box
            };
            d = "RIGHT";
            changingDirection = false;
            startTime = Date.now();

            document.addEventListener("keydown", direction);
            game = setInterval(draw, 100);
        }

        startButton.addEventListener("click", () => {
            startButton.style.display = "none";
            canvas.style.display = "block";
            initGame();
        });

        function direction(event) {
        	event.preventDefault();
            if (changingDirection) return;
            changingDirection = true;

            if (event.keyCode == 37 && d != "RIGHT") d = "LEFT";
            else if (event.keyCode == 38 && d != "DOWN") d = "UP";
            else if (event.keyCode == 39 && d != "LEFT") d = "RIGHT";
            else if (event.keyCode == 40 && d != "UP") d = "DOWN";

            setTimeout(() => changingDirection = false, 100);
        }

        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            for (let i = 0; i < snake.length; i++) {
                ctx.fillStyle = (i == 0) ? "green" : "white";
                ctx.fillRect(snake[i].x, snake[i].y, box, box);
            }

            ctx.fillStyle = "red";
            ctx.fillRect(food.x, food.y, box, box);

            ctx.fillStyle = "white";
            ctx.font = "20px Arial";
            ctx.fillText("Score: " + score, box, box);

            // 플레이 타임 표시
            const elapsedTime = Math.floor((Date.now() - startTime) / 1000);
            ctx.fillText("Time: " + elapsedTime + "s", canvas.width - 120, 30);

            let snakeX = snake[0].x;
            let snakeY = snake[0].y;

            if (d == "LEFT") snakeX -= box;
            if (d == "UP") snakeY -= box;
            if (d == "RIGHT") snakeX += box;
            if (d == "DOWN") snakeY += box;

            if (snakeX < 0 || snakeX >= canvas.width || snakeY < 0 || snakeY >= canvas.height) {
                endGame(elapsedTime);
                return;
            }

            for (let i = 1; i < snake.length; i++) {
                if (snake[i].x == snakeX && snake[i].y == snakeY) {
                    endGame(elapsedTime);
                    return;
                }
            }

            let newHead = { x: snakeX, y: snakeY };

            if (snakeX == food.x && snakeY == food.y) {
                score+=10;
                food = {
                    x: Math.floor(Math.random() * columns) * box,
                    y: Math.floor(Math.random() * rows) * box
                };
            } else {
                snake.pop();
            }

            snake.unshift(newHead);
        }

        function endGame(elapsedTime) {
            clearInterval(game);
            if(confirm("점수 : " + score + "\n플레이 타임 : " + elapsedTime + "s")){
            	sendGameRecord(score);
            }
            startButton.style.display = "block";
        }
    </script>
				</div>
				<!-- 게임::e -->


				<div class="game-about">
					<div class="game-description-section">
						<h2 class="section-title _1">ABOUT</h2>
						<div class="game-description">
							<p>
								길어질수록 더 어려워진다! 클래식 스네이크 게임<br> <br> 배고픈 뱀의 모험! 먹이를 먹고 성장하자!
								<br> <br> [게임방법]<br> <br>
								1. 플레이어는 화살표 키(← ↑ → ↓) 를 사용해 뱀을 이동시킵니다.<br> 2. 화면 내에 나타나는 먹이를 먹으면
								점수가 올라가고 뱀의 길이가 길어집니다.<br> 3. 벽이나 자신의 몸에 부딪히면 게임이 종료됩니다.
								
							</p>
						</div>
					</div>

					<div class="game-info-wrap">
						<h2 class="section-title _1">게임 정보</h2>
						<ul class="game-info-list">
							<li class="game-info-item"><span class="info-label">게임
									장르</span> <span class="info-value">아케이드, 캐주얼, 고전</span></li>
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
	<input type="hidden" id="gameId" value="4004">
	<input type="hidden" id="finalScore">

	<script>
      					function sendGameRecord(currentScore){
         					$("#finalScore").val(currentScore);
              
           					$.ajax({
              					type: "POST",
              					url: "/add.record",
             					data: {
                 					userId: "${nickname}",
                 					gameId: $("#gameId").val(),
                 					record: $("#finalScore").val()
              							}
           							});
        						}
    				</script>

	<!-- 스코어 기록법 ::e-->
</body>
</html>