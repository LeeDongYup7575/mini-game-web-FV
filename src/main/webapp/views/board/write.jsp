<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성하기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/write.css">
<link rel="stylesheet" href="/assets/summernote/summernote-lite.css">
<script src="/assets/summernote/summernote-lite.js"></script>
<script src="/assets/summernote/summernote-ko-KR.js"></script>
<script>
	$(function(){
        $('#summernote').summernote({
            height: 350,
            lang: 'ko-KR',
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                //['table', ['table']],
                ['insert', ['link', 'video']], // 'picture'
                // ['view', ['fullscreen', 'codeview', 'help']]
            ]
        });
		
        console.log("${isAdmin}");
        if("${isAdmin}" == "1"){
        	let boardCategorySelect = $("<select>").attr({"id": "boardCategorySelect", "name": "boardCategory"});
        	let optionNotice = $("<option>").attr("value", "notice").html("공지사항");
        	let optionGeneral = $("<option>").attr("value", "general").html("자유 게시판");
        	
        	boardCategorySelect.append(optionNotice, optionGeneral);
        	
        	$("#writeForm").prepend(boardCategorySelect);
        }else {
            // admin이 아니면 기본 카테고리로 general 설정
            let hiddenInput = $("<input>").attr({
                "type": "hidden",
                "name": "boardCategory",
                "value": "general"
            });
            $("#writeForm").prepend(hiddenInput);
        }
	});
	
</script>
</head>
<body>

    <%@ include file="/includes/header.jsp" %>

    <main class="main-content">
        <div class="write-container">
            <div class="write-header">
                <h2>게시글 작성</h2>
                <div>
                	<button type="button" class="cancel-btn" onclick="history.back();">취소</button>
                	<button type="submit" class="submit-btn" form="writeForm">등록</button>
                </div>
            </div>

            <form id="writeForm" action="/write.board" method="post" enctype="multipart/form-data">
                <div class="title-input">
                    <input type="text" name="title" placeholder="제목을 입력해주세요" required maxlength="50">
                </div>
	
				<input type="file" name="file1">   	
				<input type="file" name="file2">

                <div class="content-input">
                    <textarea id="summernote" name="contents" required></textarea>
                </div>
            </form>
        </div>
    </main>

    <%@ include file="/includes/footer.jsp" %>
    
</body>

</html>