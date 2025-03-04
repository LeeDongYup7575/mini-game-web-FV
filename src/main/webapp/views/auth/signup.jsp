<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/reset.css">
<!-- font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="/assets/css/signup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<style>
.email-container {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.email-container input[type="text"] {
    flex: 1;
}

.email-container span {
    margin: 0 3px;
}

.email-container select {
    width: 120px;
    height: 40px;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

#emailId, #emailDomain {
    width: 40%;
}

.alert {
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 4px;
}

.alert-danger {
    color: #721c24;
    background-color: #f8d7da;
    border: 1px solid #f5c6cb;
}

.alert-success {
    color: #155724;
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
}

.error-msg{
	color: red;
	
}
</style>

<script>
$(document).ready(function () {
    const idRegex = /^(?!google_)[a-zA-Z][a-zA-Z0-9]{5,14}$/;
    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;
    const nicknameRegex = /^[\w가-힣]{1,9}$/;
    const nameRegex = /^[가-힣]{2,5}$/;
    const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const rnumRegex = /^\d{6}$/;
    
    // 각 필드의 유효성 상태를 추적하는 객체
    let validationState = {
        id: false,
        pw: false,
        pwMatch: false,
        nickname: false,
        name: false,
        phone: false,
        email: false,
        rnum: false,
        idDuplicateChecked: false,
        nicknameDuplicateChecked: false,
        emailDuplicateChecked: false
    };
    
    // 각 필드의 유효성 결과를 업데이트하는 함수
    function updateValidationState(field, isValid) {
        validationState[field] = isValid;
        console.log("유효성 상태 업데이트:", field, isValid);
    }

    // 모든 유효성 조건이 충족되었는지 확인하는 함수
    function isFormValid() {
        return validationState.id && 
               validationState.pw && 
               validationState.pwMatch && 
               validationState.nickname && 
               validationState.name && 
               validationState.phone && 
               validationState.email && 
               validationState.rnum && 
               validationState.idDuplicateChecked && 
               validationState.nicknameDuplicateChecked && 
               validationState.emailDuplicateChecked;
    }

 // 일반 회원가입에서만 google_ 아이디 차단
    function validateInput(selector, regex, errorMsg, field) {
        $(selector).on("input", function () {
            let value = $(this).val().trim();
            let errorDiv = $(selector + "Error");

            if (value === "") {
                errorDiv.hide();
                updateValidationState(field, false);
                return;
            }

            // 일반 회원가입에서 아이디에 대한 특별 검사 추가
            if(field === "id" && value.toLowerCase().startsWith("google_")) {
                errorDiv.removeClass("success-msg").addClass("error-msg").text("'google_'로 시작하는 아이디는 사용할 수 없습니다.").show();
                updateValidationState(field, false);
                return;
            }

            if (regex.test(value)) {
                errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
                updateValidationState(field, true);
                
                // 아이디나 닉네임이 변경되면 중복체크 상태 초기화
                if(field === "id") {
                    updateValidationState("idDuplicateChecked", false);
                } else if(field === "nickname") {
                    updateValidationState("nicknameDuplicateChecked", false);
                }
            } else {
                errorDiv.removeClass("success-msg").addClass("error-msg").text(errorMsg).show();
                updateValidationState(field, false);
            }
        });
        
        // 초기 값이 있는 경우 즉시 검증
        let initialValue = $(selector).val().trim();
        if (initialValue) {
            $(selector).trigger("input");
        }
    }

    validateInput("#id", idRegex, "아이디는 영문자로 시작하며 6~15자여야 합니다.", "id");
    validateInput("#pw", pwRegex, "비밀번호는 대소문자, 숫자, 특수문자를 포함한 8자 이상이어야 합니다.", "pw");
    validateInput("#nickname", nicknameRegex, "닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.", "nickname");
    validateInput("#name", nameRegex, "이름은 한글 2~5자여야 합니다.", "name");
    validateInput("#phone", phoneRegex, "전화번호 형식이 올바르지 않습니다.", "phone");
    validateInput("#rnum", rnumRegex, "생년월일은 6자리 숫자여야 합니다.", "rnum");

    // 생년월일 유효성 추가 검사 (실제 날짜 확인)
    $("#rnum").on("blur", function() {
        let value = $(this).val().trim();
        let errorDiv = $("#rnumError");
        
        if (value === "" || !rnumRegex.test(value)) {
            updateValidationState("rnum", false);
            return; // 기본 정규식 검사에서 처리
        }
        
        // 실제 유효한 날짜인지 확인
        try {
        	let yearPrefix = value.substring(0, 2);
        	let year = parseInt("20" + yearPrefix);
        	if (year > new Date().getFullYear()) {
        	    year = parseInt("19" + yearPrefix);
        	}

            let month = parseInt(value.substring(2, 4)) - 1; // JS는 월이 0부터 시작
            let day = parseInt(value.substring(4, 6));
            
            let date = new Date(year, month, day);
            if (date.getFullYear() !== year || date.getMonth() !== month || date.getDate() !== day) {
                errorDiv.removeClass("success-msg").addClass("error-msg").text("유효하지 않은 날짜입니다.").show();
                updateValidationState("rnum", false);
            } else {
                updateValidationState("rnum", true);
            }

        } catch (e) {
            errorDiv.removeClass("success-msg").addClass("error-msg").text("유효하지 않은 날짜입니다.").show();
            updateValidationState("rnum", false);
        }
    });
    
    // 비밀번호 확인 검사
    $("#pw, #pwConfirm").on("input", function () {
        let pw = $("#pw").val().trim();
        let pwConfirm = $("#pwConfirm").val().trim();
        let errorDiv = $("#pwMatchError");

        if (pw === "" || pwConfirm === "") {
            errorDiv.hide();
            updateValidationState("pwMatch", false);
            return;
        }

        if (pw === pwConfirm) {
            errorDiv.removeClass("error-msg").addClass("success-msg").text("비밀번호가 같습니다.").show();
            updateValidationState("pwMatch", true);
        } else {
            errorDiv.removeClass("success-msg").addClass("error-msg").text("비밀번호가 다릅니다.").show();
            updateValidationState("pwMatch", false);
        }
    });

    // 이메일 도메인 선택
	$("#domainSelect").on("change", function() {
	    let selectedDomain = $(this).val();
	    if (selectedDomain) {
	        $("#emailDomain").val(selectedDomain);
	        // 도메인 선택시 즉시 중복 체크 트리거
	        $("#emailDomain").trigger("blur");
	    } else {
	        $("#emailDomain").val("").focus();
	    }
	});
    
    // 이메일 아이디나 도메인 변경 시 전체 이메일 조합하고 검증
    function combineAndValidateEmail() {
        let emailId = $("#emailId").val().trim();
        let emailDomain = $("#emailDomain").val().trim();
        
        if (emailId && emailDomain) {
            let fullEmail = emailId + "@" + emailDomain;
            $("#email").val(fullEmail);
            
            let errorDiv = $("#emailError");
            if (emailRegex.test(fullEmail)) {
                errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
                updateValidationState("email", true);
            } else {
                errorDiv.removeClass("success-msg").addClass("error-msg").text("올바른 이메일 형식이 아닙니다.").show();
                updateValidationState("email", false);
            }
            return fullEmail;
        }
        updateValidationState("email", false);
        return "";
    }
    
    // 이메일 부분 변경 시 이벤트
    $("#emailId, #emailDomain").on("input", function() {
        combineAndValidateEmail();
        updateValidationState("emailDuplicateChecked", false);
    });
    
    // 이메일 도메인 필드가 비었을 때 직접입력 옵션 선택
    $("#emailDomain").on("focus", function() {
        if (!$(this).val()) {
            $("#domainSelect").val("");
        }
    });
    
    // 아이디, 닉네임, 이메일 중복 검사 (AJAX)
    function checkDuplicate(field, selector, validationField) {
        let checkFn;
        
        if (selector === "#email") {
            // 이메일 중복 검사 특수 처리
            $("#emailId, #emailDomain").on("blur", function() {
                // 둘 다 입력된 경우만 중복 체크 실행
                let emailId = $("#emailId").val().trim();
                let emailDomain = $("#emailDomain").val().trim();
                
                if (!emailId || !emailDomain) return;
                
                let fullEmail = emailId + "@" + emailDomain;
                $("#email").val(fullEmail);
                
                // 이메일 형식 검사
                if (!emailRegex.test(fullEmail)) {
                    $("#emailError").removeClass("success-msg").addClass("error-msg")
                        .text("올바른 이메일 형식이 아닙니다.").show();
                    updateValidationState("email", false);
                    updateValidationState(validationField, false);
                    return;
                }
                
                // 형식이 올바르면 중복 체크 실행
                $.ajax({
                    type: "POST",
                    url: "/checkDuplicate.users",
                    data: { field: field, value: fullEmail },
                    success: function (response) {
                        let errorDiv = $("#emailError");
                        if (response === "duplicate") {
                            errorDiv.removeClass("success-msg").addClass("error-msg")
                                .text("이미 사용 중인 이메일입니다.").show();
                            updateValidationState(validationField, false);
                        } else {
                            errorDiv.removeClass("error-msg").addClass("success-msg")
                                .text("사용 가능한 이메일입니다.").show();
                            updateValidationState("email", true);
                            updateValidationState(validationField, true);
                            console.log("이메일 중복 확인 성공: " + fullEmail);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("이메일 중복 확인 Ajax 오류:", error);
                        // 서버 오류시 일단 통과시킴 (선택사항)
                        let errorDiv = $("#emailError");
                        errorDiv.removeClass("error-msg").addClass("success-msg")
                            .text("서버 확인 실패. 임시로 사용 가능합니다.").show();
                        updateValidationState(validationField, true);
                    }
                });
            });
        } else {
            // 기존 아이디, 닉네임 중복 검사
            checkFn = function () {
                let value = $(selector).val().trim();
                
                // 정규식 검사 먼저 확인
                let regex = (selector === "#id") ? idRegex : nicknameRegex;
                let errorDiv = $(selector + "Error");
                
                if (value === "" || !regex.test(value)) {
                    // 정규식 검사를 통과하지 못하면 중복 검사 실행하지 않음
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "/checkDuplicate.users",
                    data: { field: field, value: value },
                    success: function (response) {
                        if (response === "duplicate") {
                            errorDiv.removeClass("success-msg").addClass("error-msg").text("이미 사용 중입니다.").show();
                            updateValidationState(validationField, false);
                        } else {
                            errorDiv.removeClass("error-msg").addClass("success-msg").text("사용 가능합니다.").show();
                            updateValidationState(validationField, true);
                        }
                    }
                });
            };
            
            $(selector).on("blur", checkFn);
        }
    }

    checkDuplicate("ID", "#id", "idDuplicateChecked");
    checkDuplicate("NICKNAME", "#nickname", "nicknameDuplicateChecked");
    checkDuplicate("EMAIL", "#email", "emailDuplicateChecked");

    // 폼 제출 시 최종 유효성 검사
    function validateForm() {
    	let isValid = true;
        let firstError = null;
        let errors = [];

        // 필수 입력 필드 검사
        $("input[required]").each(function () {
            let value = $(this).val().trim();
            let id = $(this).attr("id");
            let errorDiv = $("#" + id + "Error");
            
            // 값이 비어있는지 확인
            if (value === "") {
                errorDiv.removeClass("success-msg").addClass("error-msg").text("필수 입력 항목입니다.").show();
                isValid = false;
                errors.push(id + " 필드가 비어있습니다.");
            }
        });
        
        // 각 유효성 검사 상태 확인
        if (!validationState.id) {
            errors.push("아이디 형식이 올바르지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.pw) {
            errors.push("비밀번호 형식이 올바르지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.pwMatch) {
            errors.push("비밀번호가 일치하지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.nickname) {
            errors.push("닉네임 형식이 올바르지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.name) {
            errors.push("이름 형식이 올바르지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.phone) {
            errors.push("전화번호 형식이 올바르지 않습니다.");
            isValid = false;
        }
        
        if (!validationState.email) {
            $("#emailError").removeClass("success-msg").addClass("error-msg")
                .text("이메일 형식이 올바르지 않습니다.").show();
            isValid = false;
            if (!firstError) firstError = $("#emailId");
        }
        
        if (!validationState.rnum) {
            errors.push("생년월일이 올바르지 않습니다.");
            isValid = false;
        }
        
        // 중복 검사 완료 여부 확인
        if (!validationState.idDuplicateChecked) {
            $("#idError").removeClass("success-msg").addClass("error-msg").text("아이디 중복 확인이 필요합니다.").show();
            errors.push("아이디 중복 확인이 필요합니다.");
            isValid = false;
        }
        
        if (!validationState.nicknameDuplicateChecked) {
            $("#nicknameError").removeClass("success-msg").addClass("error-msg").text("닉네임 중복 확인이 필요합니다.").show();
            errors.push("닉네임 중복 확인이 필요합니다.");
            isValid = false;
        }
        
        if (!validationState.emailDuplicateChecked) {
            // 이메일 형식이 올바른데 중복체크만 안된 경우 자동으로 체크 시도
            if (validationState.email) {
                let emailId = $("#emailId").val().trim();
                let emailDomain = $("#emailDomain").val().trim();
                let fullEmail = emailId + "@" + emailDomain;
                
                // 서버에 중복 체크 요청
                $.ajax({
                    type: "POST",
                    url: "/checkDuplicate.users",
                    async: false, // 동기 요청으로 처리
                    data: { field: "EMAIL", value: fullEmail },
                    success: function (response) {
                        if (response !== "duplicate") {
                            // 중복 아니면 통과
                            $("#emailError").removeClass("error-msg").addClass("success-msg")
                                .text("사용 가능한 이메일입니다.").show();
                            updateValidationState("emailDuplicateChecked", true);
                        } else {
                            $("#emailError").removeClass("success-msg").addClass("error-msg")
                                .text("이미 사용 중인 이메일입니다.").show();
                            isValid = false;
                            if (!firstError) firstError = $("#emailId");
                        }
                    },
                    error: function() {
                        // 서버 오류시 일단 통과 (선택사항)
                        updateValidationState("emailDuplicateChecked", true);
                    }
                });
            } else {
                $("#emailError").removeClass("success-msg").addClass("error-msg")
                    .text("이메일 중복 확인이 필요합니다.").show();
                isValid = false;
                if (!firstError) firstError = $("#emailId");
            }
        }
        
        // 이메일을 hidden 필드에 최종 조합
        let emailId = $("#emailId").val().trim();
        let emailDomain = $("#emailDomain").val().trim();
        if (emailId && emailDomain) {
            $("#email").val(emailId + "@" + emailDomain);
        }
        
        if (!isValid) {
            console.log("유효성 검사 실패");
            alert("입력값을 다시 확인해주세요.");
            
            // 첫 번째 오류 필드로 스크롤
            if (firstError) {
                firstError.focus();
                $('html, body').animate({
                    scrollTop: firstError.offset().top - 100
                }, 500);
            }
        } else {
            console.log("유효성 검사 성공: 모든 조건 충족");
        }

        return isValid;
    }

    // 비밀번호 암호화 및 폼 제출
    $("form").on("submit", function (e) {
        e.preventDefault(); // 기본 제출 방지

        // 이메일을 hidden 필드에 최종 조합
        let emailId = $("#emailId").val().trim();
        let emailDomain = $("#emailDomain").val().trim();
        if (emailId && emailDomain) {
            let fullEmail = emailId + "@" + emailDomain;
            $("#email").val(fullEmail);
            console.log("전송할 이메일: " + fullEmail);
        }
        
        // 최종 유효성 검사 수행
        if (!validateForm()) {
            return false;
        }

        // 모든 필드가 유효한 경우에만 비밀번호 암호화 및 제출
        let pw = $("#pw").val().trim();
        let pwConfirm = $("#pwConfirm").val().trim();

        // 비밀번호를 SHA-256으로 해싱
        let hashedPw = CryptoJS.SHA256(pw).toString();
        let hashedPwConfirm = CryptoJS.SHA256(pwConfirm).toString();

        // 해싱된 비밀번호를 실제 전송 필드로 설정
        $("#pw").val(hashedPw);
        $("#pwConfirm").val(hashedPwConfirm);

        console.log("폼 제출 - ID: " + $("#id").val() + ", 이메일: " + $("#email").val());
        console.log("모든 유효성 검사 통과, 폼 제출 진행");

        // 폼을 실제로 제출
        this.submit();
        return true;
    });
    
    // 초기값이 있는 필드들에 대해 유효성 검사 트리거
    if ($("#id").val()) $("#id").trigger("input");
    if ($("#nickname").val()) $("#nickname").trigger("input");
    if ($("#name").val()) $("#name").trigger("input");
    if ($("#phone").val()) $("#phone").trigger("input");
    if ($("#rnum").val()) $("#rnum").trigger("input");
    if ($("#emailId").val() && $("#emailDomain").val()) combineAndValidateEmail();
});
</script>
</head>
<body>
    <%@ include file="../../includes/header.jsp" %>
    
    <div class="main-container">
    <div class="container">
        <img src="../../assets/img/logoW.png" id="logo" alt="Tech X" />
        <h2 class="form-title">Sign Up</h2>
        
        <%-- 에러 메시지 표시 --%>
        <% if(request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("errorMsg") %>
            </div>
        <% } %>
        
        <%-- 성공 메시지 표시 --%>
        <% if(session.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success">
                <%= session.getAttribute("successMsg") %>
                <% session.removeAttribute("successMsg"); %> <%-- 메시지 표시 후 제거 --%>
            </div>
        <% } %>
        
        <section class="hero signup-form-box">
        <form action="/signup.users" method="post" class="form-detail">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" value="${id}" required>
                <div class="error-msg" id="idError"></div>
            </div>

            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" required>
                <div class="error-msg" id="pwError"></div>
            </div>

            <div class="form-group">
                <label for="pwConfirm">비밀번호 확인</label>
                <input type="password" id="pwConfirm" required>
                <div class="error-msg" id="pwMatchError"></div>
            </div>

            <div class="form-group">
                <label for="nickname">닉네임</label>
                <input type="text" id="nickname" name="nickname" value="${nickname}" required>
                <div class="error-msg" id="nicknameError"></div>
            </div>
            
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="${name}" required>
                <div class="error-msg" id="nameError"></div>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" value="${phone}" required placeholder="010-1234-5678">
                <div class="error-msg" id="phoneError"></div>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <div class="email-container">
                    <%-- 이메일 주소를 분리하여 표시 --%>
                    <% 
                    String emailValue = (String)request.getAttribute("email");
                    String emailId = "";
                    String emailDomain = "";
                    
                    if(emailValue != null && emailValue.contains("@")) {
                        String[] parts = emailValue.split("@");
                        emailId = parts[0];
                        emailDomain = parts[1];
                    }
                    %>
                    <input type="text" id="emailId" name="emailId" value="<%= emailId %>" required placeholder="이메일 아이디">
                    <span>@</span>
                    <input type="text" id="emailDomain" name="emailDomain" value="<%= emailDomain %>" required>
                    <select id="domainSelect">
                        <option value="">직접입력</option>
                        <option value="gmail.com" <%= "gmail.com".equals(emailDomain) ? "selected" : "" %>>gmail.com</option>
                        <option value="naver.com" <%= "naver.com".equals(emailDomain) ? "selected" : "" %>>naver.com</option>
                        <option value="daum.net" <%= "daum.net".equals(emailDomain) ? "selected" : "" %>>daum.net</option>
                        <option value="hanmail.net" <%= "hanmail.net".equals(emailDomain) ? "selected" : "" %>>hanmail.net</option>
                        <option value="nate.com" <%= "nate.com".equals(emailDomain) ? "selected" : "" %>>nate.com</option>
                        <option value="kakao.com" <%= "kakao.com".equals(emailDomain) ? "selected" : "" %>>kakao.com</option>
                        <option value="outlook.com" <%= "outlook.com".equals(emailDomain) ? "selected" : "" %>>outlook.com</option>
                        <option value="hotmail.com" <%= "hotmail.com".equals(emailDomain) ? "selected" : "" %>>hotmail.com</option>
                    </select>
                    <input type="hidden" id="email" name="email" value="${email}">
                </div>
                <div class="error-msg" id="emailError"></div>
            </div>
            
            <div class="form-group">
                <label for="rnum">생년월일 (YYMMDD)</label>
                <input type="text" id="rnum" name="rnum" value="${rnum}" required placeholder="YYMMDD">
                <div class="error-msg" id="rnumError"></div>
            </div>
            <button class="register-btn" type="submit">가입하기</button>
        </form>
        </section>
    </div>
    </div>
    
    <%@ include file="../../includes/footer.jsp" %>
</body>
</html>