<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="javax.servlet.http.HttpSession" %>
            <!DOCTYPE html>
            <%
    // 서버 세션에서 값 가져오기
    String nickname = (String) session.getAttribute("nickname");
    // 주의: 객체일 경우 JSON 직렬화 필요
%>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description" content="TechX Games - 최고의 온라인 게임 포털. 다양한 게임을 무료로 즐겨보세요.">
                <meta name="keywords" content="온라인게임, 웹게임, 무료게임, TechX, 게임포털">
                <meta name="author" content="TechX Games">
                <meta property="og:title" content="TechX Games - 최고의 게임 포털">
                <meta property="og:description" content="다양한 온라인 게임을 무료로 즐겨보세요">
                <meta property="og:type" content="website">
                <title>TechX Games - 최고의 온라인 게임 포털</title>
                <script type="text/javascript">
   					 // 서버에서 넘겨받은 값을 자바스크립트 변수에 할당
   					 let nickname = "<%= nickname %>";
    				// 클라이언트 sessionStorage에 저장
   					 sessionStorage.setItem('nickname', nickname);
  					</script>
                <!-- font-awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
                <!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
                <link rel="stylesheet" href="/assets/css/reset.css">
                <!-- 헤더 & 푸터 css  -->
                <link rel="stylesheet" href="/assets/css/layout.css">
                <!-- 커스텀 css -->
                <link rel="stylesheet" href="/assets/css/main.css">
                <link rel="stylesheet" href="/assets/css/all-games.css">

                <!-- GSAP -->
                <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
                <!-- jQuery CDN  -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                    function goToPage(url) {
                        window.location.href = url;
                    }
                </script>


            </head>

            <body>
                <!-- 공통 Header -->
                <%@ include file="/includes/header.jsp" %>


                    <!-- 메인 화면 ::s-->
                    <main>
                        <!-- 인트로 ::s  -->
                        <section class="intro-section">
                            <div class="title-container">
                                <h1>CONNECTING THE REAL<br>TO GAME-WORLD</h1>
                            </div>
                            <div class="content-container">
                                <div class="image-container">
                                    <img src="/assets/img/rhythm_game_banner.png" alt="Office collaboration">
                                </div>
                                <div class="right-container">
                                    <% if (loginUser !=null) { %>
                                        안녕하세요, <%= loginUser.getNickname() %>님!
                                            <% } else { %>
                                                <div class="login-box">
                                                    <button class="login-button"
                                                        onclick="goToPage('views/auth/login.jsp')">ID 로그인</button>
                                                    <button class="login-button"
                                                        onclick="goToPage('/login.google')" 
                                                        style="background-color:white; color:black;">Google 로그인</button>    
                                                    <div class="login-options">
                                                        <span>OR</span>
                                                        <div class="login-links">
                                                            <a href="/views/auth/findmyid.jsp">아이디 찾기</a>
                                                            <a href="/views/auth/findmypw.jsp">비밀번호 찾기</a>
                                                            <a href="/views/auth/agreement.jsp">회원가입</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } %>
                                                    <% if (loginUser !=null) { %>

                                                        <script>
                                                            let ws;
                                                            let chatNickName = "<%= loginUser.getNickname() %>";  // 서버에서 JSP로 전달된 닉네임

                                                            function connectWebSocket() {
                                                                ws = new WebSocket("ws://" + window.location.host + "/chat");

                                                                ws.onopen = function () {
                                                                    console.log("✅ WebSocket 연결됨");
                                                                };

                                                                ws.onmessage = function (event) {
                                                                    displayMessage(event.data);
                                                                };

                                                                ws.onerror = function (error) {
                                                                    console.error("❌ WebSocket 오류:", error);
                                                                };

                                                                ws.onclose = function () {
                                                                    console.log("❌ WebSocket 연결 종료됨");
                                                                };
                                                            }

                                                            function sendMessage() {
                                                                let messageInput = document.getElementById("message-input");
                                                                let messageText = messageInput.value.trim();
                                                                let chatBox = document.getElementById("chat-messages"); // 스크롤 대상 명확히 지정


                                                                if (messageText !== "") {
                                                                    let fullMessage = chatNickName + ": " + messageText;
                                                                    ws.send(fullMessage);
                                                                    messageInput.value = "";  // 입력 필드 초기화
                                                                }
                                                            }

                                                            function displayMessage(message) {
                                                                let chatBox = document.getElementById("chat-messages");

                                                                if (chatBox.children.length === 0) {
                                                                    let noticeDiv = document.createElement("div");
                                                                    noticeDiv.classList.add("notice");
                                                                    noticeDiv.textContent = "채팅이 시작되었습니다.";
                                                                    chatBox.appendChild(noticeDiv);
                                                                }

                                                                let messageDiv = document.createElement("div");
                                                                messageDiv.classList.add("message");
                                                                messageDiv.textContent = message;
                                                                chatBox.appendChild(messageDiv);

                                                                // 채팅창이 완전히 아래로 가도록 보정
                                                                setTimeout(() => {
                                                                    chatBox.scrollTop = chatBox.scrollHeight;
                                                                }, 50); // 살짝 딜레이를 줘서 스크롤이 더 정확하게 적용되도록 함.
                                                            }


                                                            // WebSocket 연결 시작
                                                            window.onload = connectWebSocket;
                                                        </script>
                                                        <div class="chat-interface">
                                                            <div id="chat-messages" class="chat-messages"></div>
                                                            <div class="message-input">
                                                                <input id="message-input" type="text"
                                                                    placeholder="메시지를 입력하세요"
                                                                    onkeypress="if(event.key === 'Enter') sendMessage()">
                                                                <button onclick="sendMessage()">
                                                                    <i class="fa-regular fa-paper-plane"
                                                                        style="color: var(--color-primary);"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <% } else { %>
                                                            <div class="chat-interface">
                                                                <div class="chat-messages">
                                                                    <div class="message">실시간 채팅을 이용해보세요!</div>
                                                                </div>
                                                                <div class="message-input">
                                                                    <input type="text" placeholder="Message">
                                                                    <button
                                                                        style="background: none; border: none; cursor: pointer;">
                                                                        <i class="fa-regular fa-paper-plane"
                                                                            style="color: var(--color-primary);"></i>
                                                                    </button>
                                                                </div>
                                                            </div>

                                                            <% } %>
                                </div>
                            </div>
                        </section>
                        <!-- 인트로 ::e  -->

                        <!-- Text Scale ::s -->
                        <section class="first-section">
                            <div class="vertical-line"></div>
                            <div class="quote">
                                CREATE ALL THE THINGS<br>
                                THAT WE IMAGINE
                            </div>
                        </section>

                        <section class="techx-section">
                            <canvas id="particle-canvas"></canvas>
                            <div class="content-wrapper">
                                <div class="techx-text">TECH X</div>
                                <div class="description">
                                    <h2>TECH X는 게임 개발 팀입니다</h2>
                                    <p>유저 경험을 최우선으로 고려하여,<br>누구나 쉽고 재밌게 플레이할 수 있는 게임을 만들어 나갑니다.</p>
                                </div>
                            </div>
                        </section>
                        <!-- Text Scale ::e -->

                        <!-- 인기게임 ::s -->
                        <section class="popular-section">
                            <div>
                                <div class="category">인기 게임</div>
                                <h1 class="title">TECH X의 인기게임을 소개합니다</h1>
                            </div>

                            <div class="games-container" id="gameList">
                            </div>
                        </section>
                        <!-- 인기게임 ::e -->


                        <!-- 공통 전체게임 -->
                        <%@ include file="../../includes/all-games.jsp" %>
                    </main>
                    <!-- 메인 화면 ::e-->

                    <!-- 공통 Footer -->
                    <%@ include file="/includes/footer.jsp" %>

                        <script src="/assets/js/main.js"></script>
                        <script>
                            $(function () {
                            	
                            	$(document).on("click", ".game-link", function(event) {
                                	<% if (loginUser == null) { %>
                                		event.preventDefault(); // 기본 이동 차단
                                		let result = confirm("로그인 후 게임을 시작할 수 있어요! 지금 로그인하시겠어요?");
                            		<% } %>
                            		if(result){
                            			window.location.href = "/views/auth/login.jsp";
                            		}
                                });
                            	
                            	
                                //인기 게임 목록
                                $.ajax({
                                    url: "/popular.record", // 인기 게임 목록을 가져오는 URL
                                    dataType: "json" // JSON 형식으로 응답 받음
                                }).done(function (data) { // success -> done 으로 변경
                                    if (data && data.length > 0) { // 데이터가 있는지 확인
                                        $("#gameList").empty(); // 기존 내용을 비우고 시작

                                        // 게임 목록을 순서대로 나열
                                        for (let i = 0; i < 3; i++) {
                                            let game = data[i];
                                            let topGame = getGameInfo(game.gameName); // 함수를 사용하여 게임 카드 생성
                                            console.log(game);

                                            // 화면에 추가
                                            $("#gameList").append(topGame);
                                        }
                                    } else {
                                        // 데이터가 없을 경우
                                        $("#gameList").html("<p>인기 게임이 없습니다.</p>");
                                    }
                                }).fail(function (error) { // 에러 발생 시
                                    console.error("인기 게임 목록을 불러오는 중 오류 발생:", error);
                                    $("#gameList").html("<p>인기 게임 목록을 불러오는 중 오류가 발생했습니다.</p>");
                                });
                            });

                            function getGameInfo(gameName) {
                                let gameCard = $("<div>").addClass("game-card");
                                let gameContent = $("<div>").addClass("game-content");
                                let gameType = $("<div>").addClass("game-type"); // 게임 종류 데이터 추가 필요
                                let gameTitle = $("<h2>").addClass("game-title");
                                let gameTags = $("<div>").addClass("game-tags");
                                let gameDescription = $("<div>").addClass("game-description");

                                let descriptionText, descriptionList, playButton;

                                if (gameName === "Rythme_Game") {
                                    gameType.html("리듬게임");
                                    gameTitle.html("Rhythm Game");
                                    gameContent.css("background", "url('/assets/img/rhythm_game_banner.png')");

                                    // 태그 추가 (예시)
                                    let tags = ["#리듬게임", "#음악게임", "#아케이드"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("사용자가 음악에 맞춰 떨어지는 블럭을 간격에 맞춘다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>음악에 맞춰 위에서 아래로 네모난 직사각형의 블록 4개가 떨어진다.</li>", "<li>사용자는 S,D,J,K 키를 이용하여 떨어지는 블록에 맞춰 키를 눌러야한다.</li>", "<li>정확히 맞춘 개수에 따라서 점수가 측정된다.</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/rhythmGame.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                                } else if (gameName === "크로스 로드") {
                                    gameType.html("길건너기 게임");
                                    gameTitle.html("Cross Road");
                                    gameContent.css("background", "url('/assets/img/cross_road_banner.png')");

                                    // 태그 추가 (예시)
                                    let tags = ["#아케이드", "#캐주얼", "#액션"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("사용자는 게임 내에서 캐릭터를 조작하여 도로 위의 장애물을 피해 길을 건넌다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>사용자는 방향키를 이용해 캐릭터를 이동시키며 장애물을 피한다.</li><li>일정 시간이 지나거나 장애물에 충돌하면 게임 오버가 되며, 플레이한 시간이 점수로 계산된다.</li><li>게임 오버 후, 사용자는 최고 점수를 확인하고 게임을 다시 시작할 수 있다.</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/crossRoad.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                                } else if (gameName === "Barbecue_Game") {
                                    gameType.html("고기굽기 게임");
                                    gameTitle.html("Barbecue Game");
                                    gameContent.css("background", "url('/assets/img/barbecue_banner.jpg')");

                                    // 태그 추가 (예시)
                                    let tags = ["#액션게임", "#타이밍게임", "#캐주얼게임"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("플레이어는 제한 시간 안에 불판 위에서 고기를 앞뒤로 구워 적절한 타이밍에 접시에 옮겨 담아야 합니다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>플레이어는 제한 시간 안에 고기를 알맞게 구워 접시에 담아야 합니다.</li><li>고기는 앞면과 뒷면을 번갈아 가며 구워야 합니다.</li><li>고기가 너무 익거나 덜 익으면 실패합니다.</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/barbecue.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                                } else if (gameName === "참참참!") {
                                    gameType.html("참참참 게임");
                                    gameTitle.html("참참참!");
                                    gameContent.css("background", "url('/assets/img/chamchamcham_banner.png)");


                                    // 태그 추가 (예시)
                                    let tags = ["#반응속도", "#두뇌게임", "#캐주얼게임"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("플레이어는 카메라를 응시하고 타이머에 맞춰 고개를 좌/우로 움직여 승패를 결정합니다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>카메라 이용 동의 후 게임 시작</li><li>타이머에 맞춰 고개 좌/우 움직임</li><li>총 3번 플레이 후 승리 횟수에 따라 점수 획득</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/chamchamcham.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                                } else if (gameName === "Zombie_Crusher") {
                                    gameType.html("좀비 디펜스 게임");
                                    gameTitle.html("Zombie Crusher");
                                    gameContent.css("background", "url('/assets/img/Zombie_Crusher_banner.jpg')");

                                    // 태그 추가 (예시)
                                    let tags = ["#전략게임", "#디펜스게임", "#시뮬레이션게임"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("당신은 Zombie Crusher라는 좀비 디펜스 게임의 세계에 들어왔습니다. 이 게임에서는 끊임없이 몰려오는 좀비 무리들을 막아내야 합니다. 당신의 목표는 모든 좀비들을 물리치고 도시를 구하는 것입니다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>게임 시작 시, 초기 자원으로 방어 유닛을 생산할 수 있습니다.</li><li>각 스테이지마다 다양한 유형의 좀비들이 등장하며, 이를 막기 위해 적절한 전략을 세워야 합니다.</li><li>좀비 유닛을 처치할 때마다 점수를 획득하며, 높은 점수를 얻을수록 더 강력한 무기와 방어 시설을 건설할 수 있습니다.</li><li>하지만, 당신의 생명력은 한정되어 있으며, 생명력이 모두 소진되면 게임이 종료됩니다.</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/zombieCrusher.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                                } else if (gameName === "스네이크 게임") {
                                    gameType.html("스네이크 게임");
                                    gameTitle.html("Snake Game");
                                    gameContent.css("background", "url('/assets/img/sanke_thm.png')");

                                    // 태그 추가 (예시)
                                    let tags = ["#아케이드게임", "#스네이크게임", "#캐주얼게임"];
                                    tags.forEach(tag => {
                                        let tagSpan = $("<span>").addClass("tag").text(tag);
                                        gameTags.append(tagSpan);
                                    });

                                    // 설명 추가 (예시)
                                    descriptionText = $("<p>").text("플레이어는 벽에 부딪히지 않고 빨간 네모를 먹으며 뱀의 길이를 늘려나갑니다.");
                                    descriptionList = $("<ul>");
                                    descriptionItems = ["<li>랜덤 위치에 빨간 네모 생성</li><li>방향키로 뱀 이동</li><li>빨간 네모 획득 시 뱀 길이 증가 및 점수 획득</li><li>벽에 충돌 시 게임 종료</li>"];
                                    descriptionItems.forEach(item => {
                                        descriptionList.append(item);
                                    });

                                    let playButton = $("<a>").addClass("play-button game-link").text("게임하기").attr("href", "/snakeGame.games"); // 게임 URL 수정 필요
                                    gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                                }

                                gameContent.append(gameType, gameTitle, gameTags, gameDescription); // gameContent에 요소 추가
                                gameCard.append(gameContent); // gameCard에 요소 추가

                                return gameCard;
                            }
                        </script>
            </body>

            </html>
