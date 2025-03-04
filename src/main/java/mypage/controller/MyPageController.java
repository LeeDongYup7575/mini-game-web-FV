package mypage.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.dto.UsersDTO;
import board.dao.BoardDAO;
import board.dto.BoardDTO;
import games.dao.GameRecordDAO;
import games.dto.GamesDTO;

@WebServlet("*.mypage")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String ip = request.getLocalAddr();
		// 직접 url 입력차단 (Referer 검사)
		String referer = request.getHeader("referer");
		if (referer == null || (!referer.contains("localhost") && !referer.contains(ip) && (!referer.contains("http://techx.ddns.net:40003/")))) {
			System.out.println("🚨 직접 URL 입력 차단: " + request.getRequestURI());
			response.sendRedirect("/includes/error403.jsp");
			return;
		}

		String cmd = request.getRequestURI();
		System.out.println("클라이언트 요청: " + cmd);

		GameRecordDAO gameRecordDao = GameRecordDAO.getInstance();
		BoardDAO userBoardDao = BoardDAO.getInstance();

		if (cmd.equals("/info.mypage")) {

			HttpSession session = request.getSession();
			UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
			System.out.println("로그인유저 아이디 : " + loginUser.getId());
			try {
				// 유저 게임 스코어
				int totalGameRecord = gameRecordDao.getTotalRecord(loginUser.getNickname());

				int userLevel = (totalGameRecord / 10) < 0 ? 1 : (totalGameRecord / 10);

				// 게임 최고 기록 가져오기
				Map<String, Integer> highestScores = gameRecordDao.getHighestScoresByGame(loginUser.getNickname());

				// 게임 랭킹 가져오기
				Map<String, Integer> userRankings = gameRecordDao.getUserRankingsByGames(loginUser.getNickname());

				// 사용자의 전체 게시글 목록
				List<BoardDTO> userBoardList = userBoardDao.userBoardList(loginUser.getNickname());

				// 최근 플레이한 게임 목록
				List<GamesDTO> recent = gameRecordDao.getRecentPlayedGames(loginUser.getNickname());

				request.setAttribute("loginUser", loginUser);
				request.setAttribute("totalGameRecord", totalGameRecord);
				request.setAttribute("userLevel", userLevel);
				request.setAttribute("highestScores", highestScores);
				request.setAttribute("userRankings", userRankings);
				request.setAttribute("userBoardList", userBoardList);
				request.setAttribute("recent", recent);

				// 마이페이지 JSP로 이동
				request.getRequestDispatcher("/views/mypage/mypage.jsp").forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException(e);
			}
		} else if (cmd.equals("/updateusers.mypage")) {
			request.getRequestDispatcher("/views/mypage/checkPw.jsp").forward(request, response);
		} else if (cmd.equals("/updateusersbygoogle.mypage")) {
			request.getRequestDispatcher("/views/mypage/modifyUser.jsp").forward(request, response);
		} else if (cmd.equals("/modifyuser.mypage")) {
			request.getRequestDispatcher("/views/mypage/modifyUser.jsp").forward(request, response);
		}

	}
}
