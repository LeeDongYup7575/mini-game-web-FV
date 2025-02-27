<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정하기</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/updateBoard.css">
<link rel="stylesheet" href="/assets/summernote/summernote-lite.css">
<script src="/assets/summernote/summernote-lite.js"></script>
<script src="/assets/summernote/summernote-ko-KR.js"></script>
<script>

   $(function(){
	  $("#title").val('${updateList.title}');
	   
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
        var initialContent = `<c:out value="${updateList.contents}" escapeXml="false" />`;
        $('#summernote').summernote('code', initialContent);
        
        // 파일 선택 시 파일 이름 및 이미지 미리보기 표시 함수
        function handleFileInput(fileInputId, filenameSpanId, previewImgId){
            $('#' + fileInputId).on('change', function(){
                var file = this.files[0];
                if(file) {
                    $('#' + filenameSpanId).text(file.name);
                    // 파일 타입이 이미지인 경우 미리보기
                    if(file.type.match('image.*')){
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            $('#' + previewImgId).attr('src', e.target.result).show();
                        }
                        reader.readAsDataURL(file);
                    } else {
                        $('#' + previewImgId).hide();
                    }
                } else {
                    $('#' + filenameSpanId).text('');
                    $('#' + previewImgId).hide();
                }
            });
        }
        
        handleFileInput('file1', 'filename1', 'preview1');
        handleFileInput('file2', 'filename2', 'preview2');
        
        $('#back-btn').on('click', function () {
        	
            location.href = "/detail.board?seq=${updateList.seq}";
        });
        
     // 폼 제출 이벤트 처리
        $('#update-btn').on('click', function () {
        	$("#hiddenTitle").val($("#title").val());
        	$("#hiddenFile1").val($("#file1").val());
        	$("#hiddenFile2").val($("#file2").val());
        	
        	
            $("#hiddenContents").val($("#summernote").summernote('code'));
            // 폼 제출
            $("#uFrm").submit();
            
        });
     
     
     
     // 첨부 파일 삭제 버튼 클릭 시 Ajax로 파일 삭제 요청
        $(document).on('click', '.delete-btn', function(){
            var fileSeq = $(this).data('file-seq');
            var $listItem = $(this).closest('li');
            if(confirm("파일을 삭제하시겠습니까?")) {
                $.ajax({
                    url: '/delete.files',  // 파일 삭제를 처리할 백엔드 URL 
                    type: 'POST',
                    data: { seq: fileSeq },
                    success: function(response) {
                        // 삭제 성공 후 UI에서 파일 항목 제거
                        alert("파일이 삭제되었습니다.");
                        $listItem.remove();
                    },
                    error: function(xhr, status, error) {
                        alert("파일 삭제 중 오류가 발생하였습니다: " + error);
                    }
                });
            }
        });
     
     
     
    });
        
</script>
</head>
<body>
	<%@ include file="/includes/header.jsp" %>
	
	<form action="/updateComplete.board" method="post" id="uFrm" enctype="multipart/form-data">   
		<input type="hidden" name="seq" value="${updateList.seq}" /> 
		<input type="hidden" name="boardCategory" value="${updateList.boardCategory}" /> 
		<input type="hidden" name="title" id="hiddenTitle" /> 
		<input type="hidden" name="contents" id="hiddenContents" /> 
		<input type="hidden" name="file1" id="hiddenFile1"/> 
		<input type="hidden" name="file2" id="hiddenFile2"/> 

    	<main class="main-content">
        	<div class="write-container">
        
 				<h2>게시글 수정</h2>
 			
            	<div class="write-header">
                	<button type="button" id=update-btn class="update-btn">수정</button>
                	<button type="button" id=back-btn class="back-btn">돌아가기</button>
            	</div>

       			
            	<div class="title-input">
            	<h4> 제목 </h4>
            	<input type="text" id="title" name="title" placeholder="제목을 입력하세요" required maxlength="50">
   
             	<!-- 첨부 파일 목록 표시 -->
            	<div class="file-list">
            		<h4>첨부된 파일</h4>
            		<ul>
            			<c:forEach var="file" items="${files}">
            				<li>
            					<a href="/download.file?seq=${file.seq}">${file.originName}</a>
            					<!-- 삭제 버튼 추가 -->
            					<button type="button" class="delete-btn" data-file-seq="${file.seq}">삭제</button>
            				</li>
            			</c:forEach>
            		</ul>
            	</div>
	
				<hr>
				<!-- 새 파일 업로드 -->
            	<div class="file-upload">
	            	<div>
                		<input type="file" name="file1" id="file1">
                		<span id="filename1"></span>
                		<br>
                		<img id="preview1" src="" alt="미리보기" style="display:none; max-width:200px; margin-top:10px;"/>
            		</div>
            		<div>
	            		<input type="file" name="file2" id="file2">
                		<span id="filename2"></span>
                		<br>
                		<img id="preview2" src="" alt="미리보기" style="display:none; max-width:200px; margin-top:10px;"/>
            		</div>
				</div>
					<hr>
					<h4 id=contentTitle> 내용 </h4>
                	<div class="content-input">
	                    <textarea id="summernote" name="contents" required></textarea>
                	</div>
	        	</div>
    	</main>
	</form>

    <footer>
         <%@ include file="/includes/footer.jsp" %>
        </footer>
</body>

</html>