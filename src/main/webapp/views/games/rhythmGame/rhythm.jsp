<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <!-- 기본 메타 태그 -->
            <title>TECH X - 게임 상세 정보 | Rhythm Game</title>
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

            <title>TECH X - Rhythm Game</title>
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
            <script src="rhythmStart.js"></script>
            <script src="rhythmMain.js"></script>
            <script src="rhythmGameOver.js"></script>
            <script src="rhythmComplete.js"></script>
        </head>

        <body>
        	<c:if test="${empty loginUser}">
    			<c:redirect url="/403.error"/>
			</c:if>        
            <!-- 공통 Header -->
            <%@ include file="/includes/header.jsp" %>

                <main>
                    <section class="my-game-section">
                        <h1 class="my-game-title">Rhythm Game</h1>

                        <div class="my-game-wrap">
                            <div class="game-hero" id="gamebox">

                            </div>
                            <!-- 게임::s -->
                            <script>
                            let config = {
                            	      type:Phaser.AUTO, //게임엔진으로 그림을 그릴때 어떻게 그릴것인가
                            	      parent:"gamebox",
                            	      width:960,
                            	      height:550,
                            	      physics:{
                            	          default:'arcade',//어떤 물리엔진을 사용할지.
                            	          arcade:{
                            	            
                            	          },
                            	      },
                            	      scene:[rhythmStart, rhythmMain, rhythmGameOver,rhythmComplete],
                            	      fps:{
                            	        target : 60,
                            	        forceSetTimeOut:true
                            	      }
                            	    };
                            	    let game = new Phaser.Game(config);
                            </script>
                            <!-- 게임::e -->


                            <div class="game-about">
                                <div class="game-description-section">
                                    <h2 class="section-title _1">ABOUT</h2>
                                    <div class="game-description">
                                        <p>
                                            노래와 리듬에 맞춰 블럭을 파괴하라! 리듬의 승리자는 당신이다!<br>
                                            <br>
                                            노래에 따라 블럭을 맞춰 스코어를 획득하세요.<br>
                                            <br>
                                            [게임방법]<br>
                                            <br>
                                            1. 키보드의 D,F,J,K 키를 눌러 블럭을 파괴합니다.<br>
                                            2. 하단 판정선에 정확히 블럭이 일치해야 점수를 획득할 수 있습니다.<br>
                                            3. 판정선에서 정확히 일치 하지 않으면 Miss 카운드가 증가합니댜.<br>
                                            4. Miss 카운드가 5회가 될 경우 게임오버입니다.<br>
                                            5. 노래가 끝나고 Miss 카운드가 5회미만일 때 성공입니다.<br>
                                        </p>
                                    </div>
                                </div>

                                <div class="game-info-wrap">
                                    <h2 class="section-title _1">게임 정보</h2>
                                    <ul class="game-info-list">
                                        <li class="game-info-item">
                                            <span class="info-label">게임 장르</span>
                                            <span class="info-value">아케이드, 캐주얼, Music</span>
                                        </li>
                                        <li class="game-info-item">
                                            <span class="info-label">난이도</span>
                                            <span class="info-value">하</span>
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
                    <input type="hidden" id="gameId" value="4002">
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