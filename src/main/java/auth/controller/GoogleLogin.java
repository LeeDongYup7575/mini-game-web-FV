package auth.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login.google")
public class GoogleLogin extends HttpServlet {
	
    private static final String CLIENT_ID = "46682588205-mko9vul9elog285487mklc827ef615sn.apps.googleusercontent.com";
    private static final String REDIRECT_URI = "http://localhost:80/auth/callback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String authUrl = "https://accounts.google.com/o/oauth2/auth" +
                "?client_id=" + CLIENT_ID +
                "&redirect_uri=" + REDIRECT_URI +
                "&response_type=code" +
                "&scope=email profile";

        response.sendRedirect(authUrl);
    }
}
