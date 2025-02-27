<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<title>${post.title }</title>
<link rel="stylesheet" href="/assets/css/detail.css">
<!--             <link rel="stylesheet" href="/assets/css/reset.css"> -->
<link rel="stylesheet" href="/assets/css/layout.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<script>
	// 댓글 로드 메소드
	function loadReplies(){
		$.ajax({
			url:"/list.reply",
            data: {seq: "${post.seq }"}
		}).done(function(resp){
			$("#replyUl").empty();
			
			let replyList = JSON.parse(resp);
			$("#replyCount").html("댓글\t" + replyList.length);
			$("#replyCountSm").html("댓글\t" + replyList.length);
			
            replyList.forEach(replyData => {
            	let replyLi = $("<li>").addClass("reply-li");
            	let reply = $("<div>").addClass("reply parent-reply").attr("id", replyData.seq);
            	let replyWriter = $("<div>").addClass("reply-writer").html(replyData.writer);
            	let replyContents = $("<div>").css({"white-space": "pre-wrap", "word-wrap": "break-word"}).addClass("reply-contents").html(replyData.contents);
            	let replyInfo = $("<div>").addClass("reply-info");
            	let replyWriteDate = $("<p>").addClass("reply-write-date").html(replyData.writeDate);
            	replyInfo.append(replyWriteDate);
            	
            	let subReplyBtn = $("<button>").addClass("sub-reply-btn").html("답글달기");
            	replyInfo.append(subReplyBtn);
            	
            	if(("${nickname}" == replyData.writer) || ("${isAdmin}" == "1")){
            		if("${nickname}" == replyData.writer){
	            		let updateReplyBtn = $("<button>").addClass("update-reply-btn").html("수정");
	            		replyInfo.append(updateReplyBtn);
            		}
            		let deleteReplyBtn = $("<button>").addClass("delete-reply-btn").html("삭제");
            		replyInfo.append(deleteReplyBtn);
            	}
            	
            	reply.append(replyWriter, replyContents, replyInfo);
            	replyLi.append(reply);
            	
            	
            	$.ajax({
        			url:"/subList.reply",
                    data: {parentReplySeq: replyData.seq}
            	}).done(function(resp){
            		let subReplyList = JSON.parse(resp);
            		
            		subReplyList.forEach(subReplyData => {
	                	let subReply = $("<div>").addClass("reply sub-reply").attr("id", subReplyData.seq);
    	            	let subReplyWriter = $("<div>").addClass("reply-writer sub-reply-writer").css("margin-top", "0px").html(subReplyData.writer);
        	        	let subReplyContents = $("<div>").css({"white-space": "pre-wrap", "word-wrap": "break-word"}).addClass("reply-contents sub-reply-contents").html(subReplyData.contents);
            	    	let subReplyInfo = $("<div>").addClass("reply-info sub-reply-info");
                		let subReplyWriteDate = $("<p>").addClass("reply-write-date sub-reply-write-date").html(subReplyData.writeDate);
                		subReplyInfo.append(subReplyWriteDate)
                		
                    	if(("${nickname}" == subReplyData.writer) || ("${isAdmin}" == "1")){
                    		if("${nickname}" == subReplyData.writer){
	                    		let updateReplyBtn = $("<button>").addClass("update-reply-btn").html("수정");
	                    		subReplyInfo.append(updateReplyBtn);
                    		}
                    		let deleteReplyBtn = $("<button>").addClass("delete-reply-btn").html("삭제");
                    		subReplyInfo.append(deleteReplyBtn);
                    	}
                    	
                		subReply.append(subReplyWriter, subReplyContents, subReplyInfo);
                		
	            		replyLi.append(subReply);
            		});
            	});
            	
            	
            	$("#replyUl").append(replyLi);
            });
		});
	}
	
	// 답글 달기 버튼 클릭 이벤트
	$(document).on("click", ".sub-reply-btn", function(){
		if("${nickname}" == ""){
			alert("답글을 작성하려면 로그인 해주세요.");
			return;
		}
		
		$(this).closest(".parent-reply").css("background-color", "rgb(250, 250, 250)");
		
	    let replyLi = $(this).closest(".reply-li");
	    
	    // 이미 입력창이 존재하면 추가하지 않음
	    if (replyLi.find(".sub-reply-inbox").length > 0) {
	        return;
	    }
		
		let replyInbox = $("<div>").addClass("reply-inbox sub-reply-inbox");
		
		let replyInboxName = $("<p>").addClass("reply-inbox-name").html("${nickname}");
		let replyInboxText = $("<textarea>").addClass("reply-inbox-text").attr({name: "contents", maxlength: 200});
		
		let replyBtns = $("<div>").addClass("reply-btns");		
		let replyCancelBtn = $("<button>").addClass("reply-cancel-btn").attr("id", "replyCancelBtn").html("취소");
		let replySaveBtn = $("<button>").addClass("reply-save-btn").attr("id", "replySaveBtn").html("등록");
		
		let hdParentBoardSeq = $("<input>").attr({type: "hidden", name: "parentBoardSeq", value:"${post.seq}"});
		let hdWriter = $("<input>").attr({type: "hidden", name: "writer", value:"${nickname}"});
	
		replyBtns.append(replyCancelBtn, replySaveBtn);
		replyInbox.append(replyInboxName, replyInboxText, replyBtns, hdParentBoardSeq, hdWriter)
		
		$(this).closest(".parent-reply").after(replyInbox);
		
		// 답글달기 취소
		replyCancelBtn.on("click", function(){
			$(this).closest(".sub-reply-inbox").prev(".parent-reply").css("background-color", "white");
			$(this).closest(".sub-reply-inbox").remove();
		});
		
		// 답글달기
		replySaveBtn.on("click", function(){	
			if(replyInboxText.val().trim() == ""){
				alert("답글 내용을 입력해주세요.");
				return;
			}
			
			let contents = replyInboxText.val();
			let parentReplySeq = replyLi.find(".reply").attr("id");
			
			$.ajax({
	    		url:"/add.reply",
	    		type: "POST",
	    		data: { parentBoardSeq: "${post.seq}", writer: "${nickname}", contents: contents, parentReplySeq: parentReplySeq }
	    	}).done(function(){
	    		loadReplies();
	    	});
		}); 
	});
	
	
	// 댓글 삭제 버튼 클릭 이벤트
	$(document).on("click", ".delete-reply-btn", function(){
		if(!confirm("댓글을 삭제하시겠습니까?")){
			return false;
		}
		
    	let seq = $(this).closest(".reply").attr("id");
    	
    	$.ajax({
    		url:"/delete.reply",
    		data: {seq: seq, parentBoardSeq: "${post.seq }"}
    	}).done(function(){
    		loadReplies();
    	});
	});
	
	// 댓글 수정 버튼 클릭 이벤트
	$(document).on("click", ".update-reply-btn", function(){
		// 한번에 하나의 댓글 수정폼만 열리도록 함.
		$(".update-reply-inbox").closest(".reply").each(function(){
 			// 각 댓글에 대해 검사 -> $(this).data("originalReply")가 존재하면 수정 폼 열려있다는 의미 -> 기존 댓글로 복원 (수정 폼 닫기)
 			// $(this).data("originalReply") -> 수정 버튼 누를 시 기존 댓글 담아놓음
	        let originalReply = $(this).data("originalReply");
	        if (originalReply) {
	            $(this).html(originalReply);
	        }
		});
		
		let originalReply = $(this).closest(".reply").html();
	    let currentContents = $(this).closest(".reply").find(".reply-contents").html();
	    
	    // 기존 댓글 내용 저장하여 복원 가능
	    $(this).closest(".reply").data("originalReply", originalReply);
		
	    // 댓글 수정 클릭 시 나올 inbox 생성
		let replyInbox = $("<div>").addClass("reply-inbox update-reply-inbox");
		
		let replyInboxName = $("<p>").addClass("reply-inbox-name").html("${nickname}");
		let replyInboxText = $("<textarea>").addClass("reply-inbox-text").attr({name: "contents", maxlength: 200}).html(currentContents);
		
		let replyBtns = $("<div>").addClass("reply-btns");		
		let replyCancelBtn = $("<button>").addClass("reply-cancel-btn").attr("id", "replyCancelBtn").html("취소");
		let replySaveBtn = $("<button>").addClass("reply-save-btn").attr("id", "replySaveBtn").html("등록");
		
		let hdParentBoardSeq = $("<input>").attr({type: "hidden", name: "parentBoardSeq", value:"${post.seq}"});
		let hdWriter = $("<input>").attr({type: "hidden", name: "writer", value:"${nickname}"});
	
		replyBtns.append(replyCancelBtn, replySaveBtn);
		replyInbox.append(replyInboxName, replyInboxText, replyBtns, hdParentBoardSeq, hdWriter)
		
		// 기존 댓글 inbox로 대체  
		$(this).closest(".reply").html(replyInbox);
		
		// 댓글 수정 취소 버튼 클릭 이벤트
		replyCancelBtn.on("click", function(){
			$(this).closest(".reply").html(originalReply);
		});
		
		// 댓글 수정 완료 버튼 클릭 이벤트
		replySaveBtn.on("click", function(){
			if($(this).closest(".reply").find(".reply-inbox-text").val().trim() == ""){
				alert("답글 내용을 입력해주세요.");
				return;
			}
			
			if(!confirm("수정을 완료하시겠습니까?")){
				return false;
			};
			
			let seq = $(this).closest(".reply").attr("id");
			let updateReplyContents = $(this).closest(".reply").find(".reply-inbox-text").val();
			
			$.ajax({
	    		url:"/update.reply",
	    		data: {seq: seq, contents: updateReplyContents }
	    	}).done(function(){
	    		loadReplies();
	    	});
		}); 
	});
	
	
	$(function(){
		// 로그인한 유저가 작성한 게시글일 경우 드롭다운 메뉴 생성
		if(("${nickname}" == "${post.writer}") || ("${isAdmin}" == "1")){
			let postMenu = $("<div>").addClass("post-menu");
			let menuBtn = $("<button>").addClass("menu-btn").html('<i class="fa-solid fa-ellipsis-vertical fa-2xs"></i>');
			let menuDropdown = $("<div>").addClass("menu-dropdown").attr("id", "menuDropdown");
			if(("${nickname}" == "${post.writer}")){
				let updatePostBtn = $("<button>").addClass("menu-item").attr("id", "updatePostBtn").html("수정하기");
				menuDropdown.append(updatePostBtn);
			}
			
			let deletePostBtn = $("<button>").addClass("menu-item").attr("id", "deletePostBtn").html("삭제하기");
			menuDropdown.append(deletePostBtn);
			postMenu.append(menuBtn, menuDropdown);
		
			$("#postInfoRight").append(postMenu);
		}
		
	    // 드롭다운 메뉴 클릭 이벤트
	    $(document).on("click", ".menu-btn", function() {
	        $("#menuDropdown").toggleClass("show");
	    });
	    
		// 드롭다운 메뉴 외 공간 클릭 시 드롭다운 닫기 이벤트	    
	    $(document).on("click", function(event) {
	    	// 클릭된 요소가 #menuBtn 또는 #menuDropdown 내부 요소인지 확인
	   		if (!$(event.target).closest(".menu-btn, .menu-dropdown").length) {
	        	$("#menuDropdown").removeClass("show"); // 다른 곳 클릭 시 닫기
	    	}
		});
	    	
	    
	    // 로그인 안했을 경우 댓글 작성 불가
	    if("${nickname}" == ""){
	    	$("#replyInboxText").attr({"disabled": true, "placeholder": "댓글을 남기시려면 로그인 해주세요."});
	    	$("#replyResisterBtn").attr("disabled", true).css("background-color", "gray");
	    }
                        
	    // 공지 게시판일 경우 댓글 섹션 삭제
	    if ("${post.boardCategory}" == "notice") {
	    	$("#replyCountSm").remove();
        	$("#replySection").remove();
        	$("#boardNameH2").html("공지사항");
    	}else if ("${post.boardCategory}" == "general"){// 자유 게시판일 경우 댓글 로드
    		$("#boardNameH2").html("자유 게시판");
    		loadReplies();
    	}
	

	    $("#menuBtn").on("click", function () {
	        $("#menuDropdown").toggleClass("show");
	    });
	    
	    // 게시글 삭제 버튼 클릭 이벤트
	    $("#deletePostBtn").on("click", function(){
	    	if(confirm("게시글을 삭제하시겠습니까?")){
	    		$.ajax({
	    			url: "delete.board",
	    			type: "POST",
	    			data: {seq: "${post.seq}", boardCategory: "${post.boardCategory}"}
	    			
	    		}).done(function(){
    				if("${post.boardCategory}" == "notice") {
    					window.location.href = "/noticeList.board?cpage=1";
    				}else if("${post.boardCategory}" == "general") {
    					window.location.href = "/generalList.board?cpage=1";
    				}
		    	});
	    	}
	    });
	
	    // 게시글 수정 버튼 클릭 이벤트
	    $("#updatePostBtn").on("click", function(){
	    	let last_cpage = sessionStorage.getItem("last_cpage");
	    	let seq = "${post.seq}";
	    	let boardCategory = "${post.boardCategory}";
	    	
	    	location.href = "/updateList.board?seq=" + seq + "&boardCategory=" + boardCategory;	
	    });
	    

	    // 스크롤 이벤트 감지
	    $(window).scroll(function() {
	        if ($(this).scrollTop() > 200) { // 200px 이상 스크롤되면 버튼 표시
	        	$(".scroll-top-btn").show();
	        } else {
	        	$(".scroll-top-btn").hide();
	        }
	    });

	    // 버튼 클릭 시 최상단 이동
	    $(".scroll-top-btn").on("click", function() {
	        $("html, body").animate({ scrollTop: 0 }, "slow");
	    });
	    
	    // 목록으로 버튼 클릭 이벤트
	    $("#toBoardBtn").on("click", function(){
	    	let last_cpage = sessionStorage.getItem("last_cpage");
	    	
	    	if(last_cpage == null){
	    		last_cpage = 1;
	    	}
	    	
	    	if ("${post.boardCategory}" == "notice"){
	    		location.href="/noticeList.board?cpage=" + last_cpage;
	    	}else if ("${post.boardCategory}" == "general"){
	    		location.href="/generalList.board?cpage=" + last_cpage;
	    	}
	    });
	    
	    
	    // 링크 공유 버튼 이벤트
	    $("#shareBtn").on("click", async function() {
	        try {
	            await navigator.clipboard.writeText(window.location.href);
	            alert("URL이 복사되었습니다. 원하는 곳에 붙여넣으세요.");
	        } catch (err) {
	            console.error("복사 실패: ", err);
	            alert("복사에 실패했습니다. 수동으로 복사해 주세요.");
	        }
	    });
	    
	});
	
</script>

</head>

<body>

	<%@ include file="/includes/header.jsp" %>


        <!-- 게시글 -->
        <main class="main-content">
            <div class="board-name">
                <h2 id="boardNameH2"></h2>
            </div>
            
            <!-- 게시글 섹션 -->
            <section class="post-section">
                <div class="post-title">
                    <h2>${post.title }</h2>
                </div>

                <div class="post-info">
                    <div class="post-info-left">
                        <p class="post-writer">${post.writer }</p>
                        <p class="post-write-date">${post.writeDate }</p>
                    </div>
                    <div class="post-info-right" id="postInfoRight">
                        <p class="view-count">조회수 ${post.viewCount }</p>
                        <p id="replyCountSm">댓글</p>
                        <button class="share-btn" id="shareBtn">
                            <i class="fa-regular fa-share-from-square"></i>
                        </button>
                    </div>
                </div>
                
				<c:if test="${not empty files}">
					<div class="file-area">
						<div class="file-title">첨부파일</div>
						<div class="file-list">
							<c:forEach var="file" items="${files }">
                				<div class="content-cell" id="file" name="file">
									<a href="/download.files?fileName=${file.fileName }&originName=${file.originName }">${file.originName }</a>
	                			</div>
        	        		</c:forEach>
    	            	</div>
					</div>
                </c:if>
				
                <div class="post-contents">
                	${post.contents }              
                </div>

                <div class="post-btn-area">
                    <button class="to-board-btn" id="toBoardBtn">목록으로</button>
                </div>
            </section>
            

            <!-- 댓글 섹션 -->
            <section class="reply-section" id="replySection">
                <!-- 댓글 작성란 -->
                
                <form action="/add.reply" method="post">
                <div class="reply-inbox">
                    <p class="reply-inbox-name">${nickname}</p>
                    <textarea class="reply-inbox-text" name="contents" id="replyInboxText" placeholder="댓글을 작성해주세요." required maxlength="200"></textarea>
                    <div class="reply-btns">
                    	<button class="reply-resister-btn" id="replyResisterBtn">등록</button>
                    </div>
                    
                    <!-- 댓글 정보 넘기기 위한 hidden input -->
                    <input type="hidden" name="parentBoardSeq" value="${post.seq }">
        			<input type="hidden" name="writer" value="${nickname}">
        			<input type="hidden" name="parentReplySeq" value="0">
                </div>
                </form>
                
                
        
                <div>
                    <h2 class="reply-count" id="replyCount"></h2>
                </div>
                
                <!-- 댓글 영역 -->
                <ul class="reply-ul" id="replyUl">
                    
                </ul>
            </section>

        </main>
        
        <button class="scroll-top-btn">
            <i class="fa-solid fa-arrow-up fa-2xl" style="color: #B197FC;"></i>
        </button>

    
    <%@ include file="/includes/footer.jsp" %>

</body>
</html>