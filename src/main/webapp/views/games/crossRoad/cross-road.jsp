<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <!-- 기본 메타 태그 -->
            <title>TECH X - 게임 상세 정보 | 게임 제목</title>
            <meta name="description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
            <meta name="keywords" content="게임, 게임 상세 정보, TECH X, 게임 장르, 게임 플레이, 게임 설명">
            <meta name="author" content="TECH X">

            <!-- Open Graph (SNS 공유 최적화) -->
            <meta property="og:title" content="TECH X - 게임 제목 상세 정보">
            <meta property="og:description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
            <meta property="og:type" content="website">

            <!-- Twitter Card -->
            <meta name="twitter:card" content="summary_large_image">
            <meta name="twitter:title" content="TECH X - 게임 제목 상세 정보">
            <meta name="twitter:description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">

            <title>TECH X - 크로스 로드</title>
            <!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
            <link rel="stylesheet" href="/assets/css/reset.css">
            <!-- 헤더 & 푸터 css  -->
            <link rel="stylesheet" href="/assets/css/layout.css">
            <!-- 전체 게임 css -->
            <link rel="stylesheet" href="/assets/css/all-games.css">
            <!-- phaser -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.87.0/phaser.min.js"></script>
            <!-- jquery -->
            <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
            <!-- 게임 css -->
            <link rel="stylesheet" href="/assets/css/game.css">
            <!-- 게임 js -->
            <script src="GamePlay.js"></script>
 
        </head>

        <body>
        	<c:if test="${empty loginUser}">
    			<c:redirect url="/403.error"/>
			</c:if>
            <!-- 공통 Header -->
            <%@ include file="/includes/header.jsp" %>

                <main>
                    <section class="my-game-section">
                        <h1 class="my-game-title">크로스 로드</h1>

                        <div class="my-game-wrap">
                            <div class="game-hero" id="gamebox">

                            </div>
                            <!-- 게임::s -->
                            <script>
                                let config = {
                                    //key value 형식 
                                    type: Phaser.AUTO, //그림을 그려내는 기술 WebGL or Canvas 자동 적용
                                    parent: "gamebox", //시각적으로 보이는 최대 높이
                                    width: 960, //그 안에 들어갈 사이즈
                                    height: 550,
                                    scale: {
                                        mode: Phaser.Scale.FIT,
                                        autoCenter: Phaser.Scale.CENTER_BOTH,
                                        width: 960,
                                        height: 550
                                    },
                                    physics: {//물리엔진 종류 설정 
                                        default: 'arcade',
                                        arcade: {
                                            //debug: true
                                        }
                                    },
                                    fps: {
                                        target: 60,
                                    },
                                    scene:[GamePlay]
                                };
                                let game = new Phaser.Game(config); ///Phaser 게임 엔진을 사용하여 실제 게임 인스턴스를 생성
                                //게임을 초기화하고, 게임을 실행하는 역할
                            </script>
                            <!-- 게임::e -->


                            <div class="game-about">
                                <div class="game-description-section">
                                    <h2 class="section-title _1">ABOUT</h2>
                                    <div class="game-description">
                                        <p>
                                            크로스 로드: 아슬아슬 도로 횡단 도전!<br>
                                            <br>
                                            짜릿한 긴장감이 넘치는 아기 고양이의 도로 위 모험<br>
                                            제한 시간 안에 위험한 도로를 건너 안전 지대에 도착해 최고의 점수를 기록하세요!<br>
                                            <br>
                                            [게임방법]<br>
                                            <br>
                                            1. 캐릭터를 방향키로 조작하여 도로에 진입합니다.<br>
                                            2. 빠르게 움직이는 차량들 사이를 적절한 타이밍에 피해 지나갑니다.<br>
                                            3. 중간 안전 지대에서 잠시 쉬어갈 수 있습니다.<br>
                                            4. 제한 시간 내에 최대한 빨리 도로를 건너 높은 점수를 얻는 것이 목표입니다..<br>
                                        </p>
                                    </div>
                                </div>

                                <div class="game-info-wrap">
                                    <h2 class="section-title _1">게임 정보</h2>
                                    <ul class="game-info-list">
                                        <li class="game-info-item">
                                            <span class="info-label">게임 장르</span>
                                            <span class="info-value">아케이드, 캐주얼, 타이밍 액션</span>
                                        </li>
                                        <li class="game-info-item">
                                            <span class="info-label">난이도</span>
                                            <span class="info-value">중</span>
                                        </li>
                                        <li class="game-info-item">
                                            <span class="info-label">개발 상태</span>
                                            <span class="info-value">완료</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </section>

                    <!-- 공통 전체게임 -->
                    <%@ include file="/includes/all-games.jsp" %>
                </main>

                <!-- 공통 Footer -->
                <%@ include file="/includes/footer.jsp" %>

                    <!-- 스코어 기록법 ::s-->
                    <input type="hidden" id="gameId" value="4005">
                    <input type="hidden" id="finalScore">

                    <script>
                        function sendGameRecord(currentScore) {
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