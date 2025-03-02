package auth.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login.google")
public class GoogleLogin extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
	        Properties prop = new Properties();
	        InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties");

	        if (input == null) {
	            throw new FileNotFoundException("설정 파일을 찾을 수 없습니다: config.properties");
	        }

	        prop.load(input);
	        input.close();
        String clientId = prop.getProperty("google.client.id");
        String clientSecret = prop.getProperty("google.client.secret");
        String clientRedirection = prop.getProperty("google.redirect.uri");
        
        String authUrl = "https://accounts.google.com/o/oauth2/auth" +
        	    "?client_id=" + clientId +
        	    "&redirect_uri=" + clientRedirection +
        	    "&response_type=code" +
        	    "&scope=email profile" +
        	    "&prompt=select_account";  // 계정 선택 강제

        response.sendRedirect(authUrl);
    }
}
