package auth.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.dao.UsersDAO;
import auth.dto.UsersDTO;

@WebServlet("*.users")
public class UsersController extends HttpServlet {

	// post, get 요청 모두 수용
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response); // POST 요청도 동일하게 처리
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response); // GET 요청도 동일하게 처리
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmd = request.getRequestURI();

		System.out.println("클라이언트 요청: " + cmd);

		// 유저 기능 인스턴스 생성
		UsersDAO dao = UsersDAO.getInstance();

		try {
			if (cmd.equals("/login.users")) {
				System.out.println("Processing /login.users...");

				String id = request.getParameter("id");
				String pw = request.getParameter("pw");

				UsersDTO dto = dao.login(id, pw); // 로그인한 유저 정보를 가져옴
				
				String errorMessage; //에러메시지 변수 생성
				
				// 유저 정보가 존재할 경우, 세션에 사용자 정보 저장
				if (dto != null) {
					
					if (dto.getWarningCount() == 0) {
						dao.insertLastLogin(id);
						HttpSession session = request.getSession();
						dao.updateUserStatus(id,0);
						session.setAttribute("loginUser", dto);
						session.setAttribute("nickname", dto.getNickname());
						session.setAttribute("id", dto.getId());
						session.setAttribute("isAdmin", dto.getIsAdmin());
						
						// 디버깅용
						System.out.println("로그인 성공 - 세션 저장 완료: " + dto.getNickname());
						System.out.println("isadmin: "+ dto.getIsAdmin());
						request.getRequestDispatcher("/index.jsp").forward(request, response);

					} else {
						System.out.println("로그인 실패 - 차단된 유저입니다.");
						errorMessage = "로그인 실패 - 차단된 유저입니다";
						request.setAttribute("errorMessage", errorMessage);
						request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
					}
				} else {
					System.out.println("로그인 실패 - 아이디 또는 비밀번호 불일치");
					errorMessage = "로그인 실패 - 아이디 또는 비밀번호 불일치";
					request.setAttribute("errorMessage", errorMessage);
					request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
				}
			}
			// 로그아웃 요청
			else if (cmd.trim().equals("/logout.users")) {
				HttpSession session = request.getSession();
				session.invalidate(); // 세션 초기화

				response.sendRedirect(request.getContextPath() + "/index.jsp"); // 로그아웃 후 메인 페이지로 이동
			}else if (cmd.trim().equals("/withdraw.users")) {
				  String withdrawId = request.getParameter("withdrawId");
				  
				  if(withdrawId != null && !withdrawId.isEmpty()) {
				    dao.withdraw(withdrawId);
				    HttpSession session = request.getSession();
				    session.invalidate(); // 세션 초기화
				    response.sendRedirect("/index.jsp");
				  } else {
				    // 오류 처리 - withdrawId가 없는 경우
				    response.sendRedirect("/error.jsp");
				  }
				}
			// 회원가입 처리 컨트롤러 부분 - 유효성 검사 개선
			else if (cmd.trim().equals("/signup.users")) {
			    String id = request.getParameter("id");
			    String pw = request.getParameter("pw");
			    String nickname = request.getParameter("nickname");
			    String name = request.getParameter("name");
			    String email = request.getParameter("email");
			    String rnum = request.getParameter("rnum");
			    String phone = request.getParameter("phone");
			    
			    // 디버깅을 위한 로그 추가
			    System.out.println("회원가입 요청 정보:");
			    System.out.println("ID: " + id);
			    System.out.println("닉네임: " + nickname);
			    System.out.println("이름: " + name);
			    System.out.println("이메일: " + email);
			    System.out.println("생년월일: " + rnum);
			    System.out.println("전화번호: " + phone);
			    System.out.println("비밀번호 길이: " + (pw != null ? pw.length() : "null"));

			    try {
			        // 서버측 유효성 검사 수행
			        if (id == null || id.trim().isEmpty() || !id.matches("^[a-zA-Z][a-zA-Z0-9]{5,14}$")) {
			            request.setAttribute("errorMsg", "아이디 형식이 올바르지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        if (nickname == null || nickname.trim().isEmpty() || !nickname.matches("^[\\w가-힣]{1,9}$")) {
			            request.setAttribute("errorMsg", "닉네임 형식이 올바르지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        if (name == null || name.trim().isEmpty() || !name.matches("^[가-힣]{2,5}$")) {
			            request.setAttribute("errorMsg", "이름 형식이 올바르지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        if (phone == null || phone.trim().isEmpty() || !phone.matches("^01[0|1|6|7|8|9][- ]?\\d{3,4}[- ]?\\d{4}$")) {
			            request.setAttribute("errorMsg", "전화번호 형식이 올바르지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        // 이메일 확인 및 조합
			        if (email == null || email.trim().isEmpty()) {
			            // emailId와 emailDomain을 직접 받아 결합
			            String emailId = request.getParameter("emailId");
			            String emailDomain = request.getParameter("emailDomain");
			            
			            if (emailId != null && !emailId.trim().isEmpty() && 
			                emailDomain != null && !emailDomain.trim().isEmpty()) {
			                email = emailId + "@" + emailDomain;
			                System.out.println("이메일 조합: " + email);
			            }
			        }
			        
			        // 이메일 유효성 검사
			        if (email == null || email.trim().isEmpty() || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
			            request.setAttribute("errorMsg", "이메일 형식이 올바르지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        // 생년월일 유효성 검사
			        if (rnum == null || rnum.trim().isEmpty() || !UsersDTO.isValidRnum(rnum)) {
			            request.setAttribute("errorMsg", "생년월일이 유효하지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        // 비밀번호 필드 검사 (클라이언트에서 이미 해시되어 전송됨)
			        if (pw == null || pw.trim().isEmpty()) {
			            request.setAttribute("errorMsg", "비밀번호가 누락되었습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }
			        
			        // SHA-256으로 해시된 비밀번호는 64자리의 16진수 문자열
			        if (pw.length() != 64 || !pw.matches("[0-9a-fA-F]{64}")) {
			            System.out.println("비밀번호 해시가 유효하지 않습니다. 길이: " + pw.length());
			            request.setAttribute("errorMsg", "비밀번호 형식이 유효하지 않습니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        }

			        // 중복 검사
			        if (dao.isDuplicate("ID", id)) {
			            request.setAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        } else if (dao.isDuplicate("NICKNAME", nickname)) {
			            request.setAttribute("errorMsg", "이미 사용 중인 닉네임입니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        } else if (dao.isDuplicate("EMAIL", email)) {
			            request.setAttribute("errorMsg", "이미 사용 중인 이메일입니다.");
			            
			            // 입력 정보 유지
			            request.setAttribute("id", id);
			            request.setAttribute("nickname", nickname);
			            request.setAttribute("name", name);
			            request.setAttribute("email", email);
			            request.setAttribute("rnum", rnum);
			            request.setAttribute("phone", phone);
			            
			            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            return;
			        } else {
			            // 모든 유효성 검증 통과 - 회원가입 진행
			            UsersDTO loginUser = new UsersDTO(id, pw, nickname, name, phone, email, rnum, 0, 0, 0, 0);
			            
			            try {
			                System.out.println("회원가입 시도: DB 저장 직전");
			                int result = dao.signup(loginUser);
			                System.out.println("회원가입 결과: " + result);
			                
			                if (result > 0) {
			                    // 회원가입 성공 - DB에서 사용자 정보 조회
			                    try {
			                        // 새로 추가한 findUserAfterSignup 메서드 사용
			                        UsersDTO newUser = dao.findUserAfterSignup(id);
			                        
			                        if (newUser != null) {
			                            // 세션에 사용자 정보 저장
			                            HttpSession session = request.getSession();
			                            session.setAttribute("loginUser", newUser);
			                            session.setAttribute("nickname", newUser.getNickname());
			                            session.setAttribute("id", newUser.getId());
			                            session.setAttribute("isAdmin", newUser.getIsAdmin());
			                            
			                            // 로그인 시간 기록 업데이트
			                            dao.insertLastLogin(id);
			                            
			                            // 회원가입 성공 메시지 설정
			                            session.setAttribute("successMsg", "회원가입에 성공했습니다!");
			                            
			                            // 회원가입 성공 시 메인 페이지로 리다이렉트
			                            response.sendRedirect(request.getContextPath() + "/index.jsp");
			                        } else {
			                            // 사용자 찾기 실패 시 기본 정보로 세션 설정
			                            System.out.println("신규 가입 사용자 조회 실패, 기본 정보 사용");
			                            HttpSession session = request.getSession();
			                            session.setAttribute("loginUser", loginUser);
			                            session.setAttribute("nickname", loginUser.getNickname());
			                            session.setAttribute("id", loginUser.getId());
			                            session.setAttribute("isAdmin", loginUser.getIsAdmin());
			                            
			                            // 회원가입 성공 메시지 설정
			                            session.setAttribute("successMsg", "회원가입에 성공했습니다!");
			                            
			                            // 회원가입 성공 시 메인 페이지로 리다이렉트
			                            response.sendRedirect(request.getContextPath() + "/index.jsp");
			                        }
			                        return;
			                    } catch (Exception e) {
			                        System.out.println("사용자 정보 조회 실패: " + e.getMessage());
			                        e.printStackTrace();
			                        
			                        // 기본 정보로 세션 설정
			                        HttpSession session = request.getSession();
			                        session.setAttribute("loginUser", loginUser);
			                        session.setAttribute("nickname", loginUser.getNickname());
			                        session.setAttribute("id", loginUser.getId());
			                        session.setAttribute("isAdmin", loginUser.getIsAdmin());
			                        
			                        // 회원가입 성공 메시지 설정
			                        session.setAttribute("successMsg", "회원가입에 성공했습니다!");
			                        
			                        // 회원가입 성공 시 메인 페이지로 리다이렉트
			                        response.sendRedirect(request.getContextPath() + "/index.jsp");
			                        return;
			                    }
			                } else {
			                    // DB 삽입 실패
			                    System.out.println("회원가입 실패 - DB 오류");
			                    request.setAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
			                    
			                    // 회원가입 실패 시 입력 정보 유지하여 폼으로 돌아감
			                    request.setAttribute("id", id);
			                    request.setAttribute("nickname", nickname);
			                    request.setAttribute("name", name);
			                    request.setAttribute("email", email);
			                    request.setAttribute("rnum", rnum);
			                    request.setAttribute("phone", phone);
			                    request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			                }
			            } catch (Exception e) {
			                System.out.println("회원가입 DB 처리 중 오류: " + e.getMessage());
			                e.printStackTrace();
			                request.setAttribute("errorMsg", "회원가입 처리 중 오류가 발생했습니다: " + e.getMessage());
			                
			                // 입력 정보 유지
			                request.setAttribute("id", id);
			                request.setAttribute("nickname", nickname);
			                request.setAttribute("name", name);
			                request.setAttribute("email", email);
			                request.setAttribute("rnum", rnum);
			                request.setAttribute("phone", phone);
			                
			                request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			            }
			        }
			    } catch (Exception e) {
			        System.out.println("회원가입 처리 중 오류 발생: " + e.getMessage());
			        e.printStackTrace();
			        request.setAttribute("errorMsg", "오류가 발생했습니다: " + e.getMessage());
			        
			        // 입력 정보 유지
			        request.setAttribute("id", id);
			        request.setAttribute("nickname", nickname);
			        request.setAttribute("name", name);
			        request.setAttribute("email", email);
			        request.setAttribute("rnum", rnum);
			        request.setAttribute("phone", phone);
			        
			        request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			    }  
			}
			else if(cmd.equals("/tosignup.users")) {
				
				request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
			}
			// 아이디 찾기 기능
			else if (cmd.equals("/findId.users")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");

				String result = dao.isExistID(name, email);

				if (result != null && !result.isEmpty()) {
					// 아이디를 찾은 경우, JSON 응답으로 반환
					response.setContentType("application/json");
					response.getWriter().write("{\"id\":\"" + result + "\"}");
				} else {
					// 아이디를 찾지 못한 경우, 에러 메시지 반환
					response.setContentType("application/json");
					response.getWriter().write("{\"error\":\"아이디를 찾을 수 없습니다.\"}");
				}
			}
			// 비밀번호 찾기 기능
			else if (cmd.equals("/findpw.users")) {
				String id = request.getParameter("id");
				String email = request.getParameter("email");

				boolean result = dao.isExistPW(id, email);

				// JSON 응답으로 처리
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();

				if (result) {
					// 일치하는 아이디와 이메일이 있으면 "match" true로 응답
					out.write("{\"match\": true}");
				} else {
					// 일치하지 않으면 "match" false로 응답
					out.write("{\"match\": false}");
				}
				out.flush();
			} // 컨트롤러 부분 수정
			else if (cmd.equals("/resetpw.users")) { // 비밀번호 찾기 후 수정
			    String id = request.getParameter("userId");
			    String newPassword = request.getParameter("newPassword"); // hashedPw에서 newPassword로 변경
			    System.out.println("컨트롤러: " + id + " " + newPassword);
			    
			    // 비밀번호 변경
			    boolean isUpdated = dao.updatePassword(id, newPassword);
			    
			    if (isUpdated) {
			        response.getWriter().write("비밀번호 변경 성공");
			    } else {
			        response.getWriter().write("비밀번호 변경 실패");
			    }
			} else if (cmd.equals("/checkPassword.users")) {
				HttpSession session = request.getSession();
				String pw = request.getParameter("pw");
				String id = (String) session.getAttribute("id"); // 로그인한 유저 ID

				boolean isMatch = dao.checkPassword(id, pw);

				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");

				if (isMatch) {
					response.getWriter().write("success");
				} else {
					response.getWriter().write("fail");
				}
			} else if (cmd.equals("/checkDuplicate.users")) {
				// 요청에서 파라미터 가져오기
				String field = request.getParameter("field");
				String value = request.getParameter("value");
				System.out.println(field + ", " + value);

				// field와 value가 유효한지 확인
				if (field != null && value != null) {
					boolean isDuplicate = dao.isDuplicate(field, value);

					// 클라이언트에게 응답 보내기
					response.setContentType("text/plain");
					response.setCharacterEncoding("UTF-8");
					PrintWriter out = response.getWriter();

					if (isDuplicate) {
						out.write("duplicate");
					} else {
						out.write("available");
					}
					out.flush();
				} else {
					response.sendError(HttpServletResponse.SC_BAD_REQUEST, "필수 파라미터가 누락되었습니다");
				}

				return; // 추가 처리 방지를 위해 중요
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}