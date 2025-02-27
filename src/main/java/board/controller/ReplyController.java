package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import auth.dto.UsersDTO;
import board.dao.ReplyDAO;
import board.dto.ReplyDTO;

@WebServlet("*.reply")
public class ReplyController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);

		//dao 인스턴스 생성
		ReplyDAO rdao = ReplyDAO.getInstance();
		Gson g = new Gson();

		try {
			//요청은 필요에 따라 추가/삭제 
			if (cmd.equals("/add.reply")) {
				int parentBoardSeq = Integer.parseInt(request.getParameter("parentBoardSeq"));
				String writer = request.getParameter("writer");
				String contents = request.getParameter("contents");
				int parentReplySeq = Integer.parseInt(request.getParameter("parentReplySeq"));
				
				// SEQ	PARENTBOARDSEQ  WRITER  CONTENTS  WRITEDATE  PARENTREPLYSEQ
				rdao.insert(new ReplyDTO(0, parentBoardSeq, writer, contents, null, parentReplySeq));
				
				response.sendRedirect("/detail.board?seq=" + parentBoardSeq);
				
			} else if (cmd.equals("/list.reply")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				List<ReplyDTO> replyList = rdao.selectByParentBoardSeq(seq);
				
				response.getWriter().append(g.toJson(replyList));
				
			} else if (cmd.equals("/subList.reply")) {
				int parentReplySeq = Integer.parseInt(request.getParameter("parentReplySeq"));
				List<ReplyDTO> subReplyList = rdao.selectByParentReplySeq(parentReplySeq);
				
				response.getWriter().append(g.toJson(subReplyList));
				
			} else if (cmd.equals("/update.reply")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String contents = request.getParameter("contents");
				
				rdao.updateBySeq(new ReplyDTO(seq, 0, null, contents, null, 0));
				
			} else if (cmd.equals("/delete.reply")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				int parentBoardSeq = Integer.parseInt(request.getParameter("parentBoardSeq"));
				
				System.out.println();
				System.out.println(rdao.deleteBySeq(seq));
				System.out.println();
			} 
		} catch(Exception e) {
			if (!"POST".equalsIgnoreCase(request.getMethod())) {
                response.sendRedirect("/403.error");
                return;
            }
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
