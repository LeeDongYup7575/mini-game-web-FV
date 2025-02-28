<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/assets/css/findmyid.css">	

</head>
<body>
    <div class="container1">
        <div class="title">
        	<a href="/">
            	<img src="/assets/img/logoW.png" alt="">
            </a>
        </div>

        <div class="subtitle">FIND MY ID</div>
        <form id="findIdForm" action="/findId.users" method="post">
            <input type="text" class="id" name="name" placeholder="이름 입력">
            <input type="text" class="pw" name="email" placeholder="이메일 주소 입력">
            <button type="submit" class="signIn">FIND MY ID</button>
        </form>

        <script>
            // 폼 제출 시 서버로 요청을 보내고, 결과를 처리하는 함수
            $("#findIdForm").on("submit", function(e){
                e.preventDefault(); // 폼 기본 제출 방지
                var name = $("input[name='name']").val();
                var email = $("input[name='email']").val();
                
                
                $.ajax({
                    url: '/findId.users',
                    type: 'POST',
                    data: { name: name, email: email },
                    success: function(response) {
                        if (response.id) {
                            // 아이디를 찾은 경우, 새 창을 열어 결과 표시
                            var newWindow = window.open("", "_blank", "width=500,height=300,top=250,left=500");
                            
                            var newDocument = newWindow.document;
                            newDocument.write(`
                                <html>
                                <head>
                                    <title>아이디 찾기 결과</title>
                                    <style>
                                        body {
                                            font-family: Arial, sans-serif;
                                            text-align: center;
                                            background-color: black;
                                            padding: 20px;
                                        }
                                        .container {
                                            background: white;
                                            padding: 20px;
                                            border-radius: 10px;
                                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                                            display: inline-block;
                                        }
                                        h1 {
                                            color: #333;
                                        }
                                        p {
                                            font-size: 18px;
                                            color: #555;
                                        }
                                        .close-btn {
                                            background-color: #868789;
                                            color: white;
                                            padding: 10px 20px;
                                            border: none;
                                            border-radius: 5px;
                                            cursor: pointer;
                                            margin-top: 20px;
                                            font-size: 16px;
                                        }
                                        .close-btn:hover {
                                            background-color: #000;
                                        }
                                    </style>
                                </head>
                                <body>
                                    <div class="container">
                                        <h1>아이디 찾기 결과</h1>
                                        <p>회원님의 아이디: ` + response.id + `</p>
                                        <button class="close-btn" onclick="window.close()">닫기</button>
                                    </div>
                                </body>
                                </html>
                            `);
                            newDocument.close(); // 문서 작성 완료
                            
                            
                            //newWindow.document.write("<p>아이디: " + response.id + "</p>");
                            
                        } else if ($(".id").val()==""&$(".pw").val()==""){
                        	alert("이름 또는 이메일을 입력해주세요");
                        } else if (response.error) {
                            // 아이디를 찾지 못한 경우, 오류 메시지 표시
                            alert(response.error);
                        }
                    },
                    error: function() {
                        alert("서버와의 연결에 실패했습니다.");
                    }
                });
            });
        </script>

        <div class="container2">
            <img src="/assets/img/auth.jpg" alt="" class="sing"> <img src="/assets/img/logoW.png" alt="" class="logo">
        </div>
        
        <a href="/views/auth/login.jsp">
        	<div class="to-login">로그인</div>
       	</a>
		<a href="/views/auth/agreement.jsp">
        	<div class="join_membership">회원가입</div>
       	</a>
        <a href="/views/auth/findmypw.jsp">
            <div class="findPw">비밀번호 찾기</div>
        </a>
    </div>
</body>
</body>
</html>