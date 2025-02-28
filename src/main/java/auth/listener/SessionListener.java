package auth.listener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import auth.dao.UsersDAO;
import auth.dto.UsersDTO;

@WebListener
public class SessionListener implements HttpSessionListener {
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        UsersDTO loginUser = (UsersDTO) event.getSession().getAttribute("loginUser");
        if (loginUser != null) {
            // ✅ 세션이 종료될 때 상태 변경 (로그아웃 or 세션 타임아웃)
            UsersDAO dao = UsersDAO.getInstance();
            try {
				dao.updateUserStatus(loginUser.getId(), 1);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
    }
}
