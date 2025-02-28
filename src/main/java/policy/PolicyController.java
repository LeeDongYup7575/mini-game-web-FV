package policy;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.policy")
public class PolicyController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);
		
        // 직접적인 JSP 접근 차단
        if (cmd.endsWith(".jsp")) {
            response.sendRedirect("/403.error");
            return;
        }
		
		try {
			//요청은 필요에 따라 추가/삭제 
			if (cmd.equals("/privacy.policy")) { //개인정보처리방침
				request.getRequestDispatcher("/views/policy/privacy.jsp").forward(request, response);
			} else if (cmd.equals("/rights.policy")) { //이용자 권익 보호정책
				request.getRequestDispatcher("/views/policy/rights.jsp").forward(request, response);
			}else if (cmd.equals("/terms.policy")) { //약관보기
				request.getRequestDispatcher("/views/policy/terms.jsp").forward(request, response);
			}
			
		} catch(Exception e) {
			if (!"POST".equalsIgnoreCase(request.getMethod())) {
				response.sendRedirect("/403.error");
			return;
			
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
