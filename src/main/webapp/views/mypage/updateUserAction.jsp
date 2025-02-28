<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="auth.dto.UsersDTO" %>
<%@ page import="auth.dao.UsersDAO" %>
<%
// 세션에서 로그인 사용자 정보 가져오기
UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");

// 로그인하지 않은 경우
if (loginUser == null) {
    response.sendRedirect("login.jsp");
    return;
}

// 입력된 정보 가져오기
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("userId");
String userName = request.getParameter("userName");
String userNickname = request.getParameter("userNickname");
String userEmail = request.getParameter("userEmail");
String userPhone = request.getParameter("userPhone");
String userRnum = request.getParameter("userRnum");
String isGoogleUser = request.getParameter("isGoogleUser");

// 구글 로그인 사용자 확인
boolean googleUser = "true".equals(isGoogleUser) || (userId != null && userId.startsWith("google_"));

// JSON 응답 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

try {
    // 구글 로그인 사용자는 이메일 변경 불가
    if (googleUser) {
        userEmail = loginUser.getEmail();
    }
    
    // 현재 사용자 정보를 복사한 새 DTO 생성
    UsersDTO updateUser = new UsersDTO(
        loginUser.getId(),
        loginUser.getPw(),      // 기존 비밀번호 유지
        userNickname,           // 새 닉네임
        userName,               // 새 이름
        userPhone,              // 새 전화번호
        userEmail,              // 새 이메일 (구글 사용자는 기존 이메일)
        userRnum,               // 새 생년월일
        0, // 기존 경고 수 유지
        0,     // 기존 탈퇴 상태 유지
        0,       // 기존 상태 유지
        0      // 기존 관리자 상태 유지
    );

    // DAO를 통해 데이터베이스에 업데이트
    UsersDAO usersDAO = new UsersDAO();
    boolean result = usersDAO.updateUserDB(updateUser);

    if (result) {
        // 업데이트된 사용자 정보를 다시 조회하여 세션에 저장
        UsersDTO refreshedUser = usersDAO.findUserById(loginUser.getId());
        if (refreshedUser != null) {
            session.setAttribute("loginUser", refreshedUser);
            session.setAttribute("nickname", refreshedUser.getNickname());
            session.setAttribute("id", refreshedUser.getId());
            session.setAttribute("isAdmin", refreshedUser.getIsAdmin());
        } else {
            // 새로 조회 실패 시 업데이트된 객체 사용
            session.setAttribute("loginUser", updateUser);
            session.setAttribute("nickname", updateUser.getNickname());
            session.setAttribute("id", updateUser.getId());
            session.setAttribute("isAdmin", updateUser.getIsAdmin());
        }
        
        out.print("{\"status\": \"success\", \"message\": \"회원정보가 성공적으로 수정되었습니다.\"}");
    } else {
        out.print("{\"status\": \"fail\", \"message\": \"회원정보 수정에 실패했습니다.\"}");
    }
} catch (Exception e) {
    e.printStackTrace(); // 서버 로그에 오류 출력
    out.print("{\"status\": \"fail\", \"message\": \"서버 오류: " + e.getMessage().replace("\"", "\\\"") + "\"}");
}
%>