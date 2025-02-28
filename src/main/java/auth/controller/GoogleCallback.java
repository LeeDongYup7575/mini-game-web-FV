package auth.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import auth.dao.UsersDAO;
import auth.dto.UsersDTO;

@WebServlet("/auth/callback")
public class GoogleCallback extends HttpServlet {
	private static final String CLIENT_ID = "46682588205-mko9vul9elog285487mklc827ef615sn.apps.googleusercontent.com";
	private static final String CLIENT_SECRET = "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";
	private static final String REDIRECT_URI = "http://localhost:80/auth/callback";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 String code = request.getParameter("code");

	        if (code == null || code.isEmpty()) {
	            response.getWriter().write("Google 로그인 실패");
	            return;
	        }

	        // 1. Google OAuth 토큰 요청
	        String tokenUrl = "https://oauth2.googleapis.com/token";
	        String params = "code=" + code +
	                        "&client_id=" + CLIENT_ID +
	                        "&client_secret=" + CLIENT_SECRET +
	                        "&redirect_uri=" + REDIRECT_URI +
	                        "&grant_type=authorization_code";

	        JSONObject tokenResponse = getAccessToken(tokenUrl, params);
	        if (tokenResponse == null) {
	            response.getWriter().write("Access Token 요청 실패");
	            return;
	        }
	        
	        String accessToken = (String) tokenResponse.get("access_token");
	        if (accessToken == null) {
	            response.getWriter().write("Access Token이 없습니다");
	            return;
	        }

	        // 2. Google 사용자 정보 요청
	        JSONObject userInfo = getUserInfo(accessToken);
	        if (userInfo == null) {
	            response.getWriter().write("사용자 정보 요청 실패");
	            return;
	        }

	        // 3. Google 사용자 정보에서 필요한 값 추출
	        String email = (String) userInfo.get("email");
	        String name = (String) userInfo.get("name");
	        String googleId = (String) userInfo.get("id");

	        if (email == null || googleId == null) {
	            response.getWriter().write("필수 사용자 정보가 없습니다.");
	            return;
	        }

	        UsersDAO dao = new UsersDAO();
	        UsersDTO user = null;
			try {
				user = dao.findUserByEmail(email);
				if (user == null) {
		            // 신규 유저 -> DB에 저장 후 로그인 처리
		            try {
						user = createNewUser(email, name, googleId);
						dao.signup(user);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						System.out.println("회원가입 실패");
						e.printStackTrace();
					}
		        }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("유저 찾는 도중 실패");
				e.printStackTrace();
			} 

	        

	        // 4. 세션에 사용자 정보 저장
	        HttpSession session = request.getSession();
	        session.setAttribute("loginUser", user);
	        session.setAttribute("nickname", user.getNickname());
	        session.setAttribute("id", user.getId());
	        session.setAttribute("isAdmin", user.getIsAdmin());

	        response.sendRedirect("/index.jsp"); // 로그인 후 메인 페이지로 리다이렉트
	    }

	    // Google OAuth 토큰 요청
	    private JSONObject getAccessToken(String url, String params) throws IOException {
	        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        try (OutputStream os = conn.getOutputStream()) {
	            os.write(params.getBytes());
	            os.flush();
	        }
	        return extractJsonResponse(conn);
	    }

	    // Google 사용자 정보 요청
	    private JSONObject getUserInfo(String accessToken) throws IOException {
	        String userInfoUrl = "https://www.googleapis.com/oauth2/v2/userinfo";
	        HttpURLConnection conn = (HttpURLConnection) new URL(userInfoUrl + "?access_token=" + accessToken).openConnection();
	        conn.setRequestMethod("GET");
	        return extractJsonResponse(conn);
	    }

	    // JSON 응답 처리
	    private JSONObject extractJsonResponse(HttpURLConnection conn) throws IOException {
	        try {
	            Scanner scanner = new Scanner(conn.getInputStream());
	            String responseBody = scanner.useDelimiter("\\A").next();
	            scanner.close();
	            
	            JSONParser parser = new JSONParser();
	            return (JSONObject) parser.parse(responseBody);
	        } catch (ParseException e) {
	            System.err.println("JSON 파싱 오류: " + e.getMessage());
	            return null;
	        }
	    }

	    // 신규 Google 사용자 생성
	    private UsersDTO createNewUser(String email, String name, String googleId) throws Exception {
	        String id = "google_" + googleId; // 고유한 ID 생성
	        String pw = null; // Google 로그인 사용자는 비밀번호 없음
	        String nickname = generateUniqueNickname(name);
	        String phone = null; // 전화번호 없음
	        String rnum = generateRandomRnum(); // 랜덤 생년월일 생성
	        Timestamp joinDate = Timestamp.valueOf(LocalDateTime.now());

	        return new UsersDTO(id, pw, nickname, name, phone, email, rnum, joinDate, 0, 0, 0, 0, null);
	    }

	    // 랜덤 닉네임 생성 (기존 유저 닉네임과 겹치지 않도록)
	    private String generateUniqueNickname(String name) throws Exception {
	        UsersDAO dao = new UsersDAO();
	        String baseNickname = name.replaceAll("\\s+", "") + new Random().nextInt(1000);
	        while (dao.isNicknameExist(baseNickname)) {
	            baseNickname = name.replaceAll("\\s+", "") + new Random().nextInt(1000);
	        }
	        return baseNickname;
	    }

	    // 랜덤 생년월일 생성 (YYYYMMDD 형식)
	    private String generateRandomRnum() {
	        int year = 1980 + new Random().nextInt(30); // 1980~2009
	        int month = 1 + new Random().nextInt(12);
	        int day = 1 + new Random().nextInt(28); // 최대 28일
	        return String.format("%02d%02d%02d", year % 100, month, day);
	    }
}