package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("*.jsp") // 모든 JSP 파일에 필터 적용
public class JspAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 (필요하면 추가)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String requestURI = req.getRequestURI();
        String referer = req.getHeader("referer");
        // admin, mypage 폴더 안에 jsp에 직접 접근시 403페이지로 리턴
        if (requestURI.matches(".*/admin/.*\\.jsp$") || requestURI.matches(".*/mypage/.*\\.jsp$")&& (referer == null || referer.isEmpty())&& !requestURI.endsWith("/mypage/modifyUser.jsp") ||requestURI.endsWith("/auth/signup.jsp")) {
            System.out.println("🚨 차단된 관리자 JSP 접근: " + requestURI);
           //403 페이지로 보내기
            req.getRequestDispatcher("/includes/error403.jsp").forward(request, response);
            return;
        } else {
        	
        	chain.doFilter(request, response);
        }
        

       
    }

    @Override
    public void destroy() {
        // 필터 종료 처리 (필요하면 추가)
    }
}
