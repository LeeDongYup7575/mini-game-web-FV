package board.controller;

import java.io.File;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.dao.BoardDAO;
import board.dao.FilesDAO;
import board.dto.BoardDTO;
import board.dto.FilesDTO;

import utils.Statics;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();
		System.out.print("클라이언트 요청: " + cmd);

		//dao 인스턴스 생성
		BoardDAO dao = BoardDAO.getInstance();
		FilesDAO fdao = FilesDAO.getInstance();

		
		try {
			if (cmd.equals("/faq.board")) {
				response.sendRedirect("/views/auth/faq.jsp");
			}
			//공지사항게시판 목록 출력
			else if (cmd.equals("/noticeList.board")) {
				// 현재페이지
				String scpage = (String) (request.getParameter("cpage"));

				// 현재 페이지 유효성 검사.
				int cpage = 1;
				
				if (scpage != null) {
				    try {
				        cpage = Integer.parseInt(scpage);
				    } catch(NumberFormatException e) {
				        cpage = 1;  // 숫자가 아닌 값이 들어오면 1페이지로 간주
				    }
				}

				int recordTotalCount = dao.getRecordTotalCountNotice();

				int pageTotalCount = 0;

				if (recordTotalCount % Statics.recordCountPerPage > 0) {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
				} else {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
				}

				if (cpage < 1) {
					cpage = 1;
				} else if (cpage > pageTotalCount) {
					cpage = pageTotalCount;
				}
				request.getSession().setAttribute("last_cpage", cpage);

				// 네이게이션 시작번호
				int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
				// 네이게이션 끝번호
				int end = cpage * Statics.recordCountPerPage;

				// 공지게시판 목록 출력
				List<BoardDTO> noticeList = dao.selectFromToNotice(start, end);

				int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
				int endNavi = startNavi + Statics.naviCountPerPage - 1;
				
				// endNavi 값은 페이지 전체 개수보다 클수없음!
				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				} 
				// 이전
				boolean needPrev = true;
				// 다음
				boolean needNext = true;

				if (startNavi == 1) {
					needPrev = false;
				}
				if (endNavi == pageTotalCount) {
					needNext = false;
				}

				request.setAttribute("noticeList", noticeList);
				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/board/noticeList.jsp").forward(request, response);
			}  
			//자유게시판 게시글 목록 출력
			else if (cmd.equals("/generalList.board")) {
				// 현재페이지
				String scpage = (String) (request.getParameter("cpage"));

				// 현재 페이지 유효성 검사.
				
				int cpage = 1;
				
				if (scpage != null) {
				    try {
				        cpage = Integer.parseInt(scpage);
				    } catch(NumberFormatException e) {
				        cpage = 1;  // 숫자가 아닌 값이 들어오면 1페이지로 간주
				    }
				}
				
				
				int recordTotalCount = dao.getRecordTotalCountGeneral();

				int pageTotalCount = 0;

				if (recordTotalCount % Statics.recordCountPerPage > 0) {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
				} else {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
				}

				if (cpage < 1) {
					cpage = 1;
				} else if (cpage > pageTotalCount) {
					cpage = pageTotalCount;
				}
				request.getSession().setAttribute("last_cpage", cpage);

				// 네이게이션 시작번호
				int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
				// 네이게이션 끝번호
				int end = cpage * Statics.recordCountPerPage;

				// 자유게시판 목록 출력
				List<BoardDTO> generalList = dao.selectFromToGeneral(start, end);
				
				
				int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
				int endNavi = startNavi + Statics.naviCountPerPage - 1;

				// endNavi 값은 페이지 전체 개수보다 클수없음!
				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				} 

				// 이전
				boolean needPrev = true;
				// 다음
				boolean needNext = true;

				if (startNavi == 1) {
					needPrev = false;
				}
				if (endNavi == pageTotalCount) {
					needNext = false;
				}
				
				request.setAttribute("generalList", generalList);
				
				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/board/generalList.jsp").forward(request, response);

			} 
			//공지사항 게시판 검색내용 목록 출력
			else if (cmd.equals("/noticeSearchList.board")) {
				String searchNoticeKeyword = request.getParameter("searchKeyword");
				
				String searchNoticeCategory = request.getParameter("searchCategory");

				// 현재페이지
				String scpage = (String) (request.getParameter("cpage"));

				// 현재 페이지 유효성 검사.
				int cpage = 1;
				
				if (scpage != null) {
				    try {
				        cpage = Integer.parseInt(scpage);
				    } catch(NumberFormatException e) {
				        cpage = 1;  // 숫자가 아닌 값이 들어오면 1페이지로 간주
				    }
				}

				int recordTotalCount = dao.getRecordTotalCountNoticeSearch(searchNoticeKeyword,searchNoticeCategory);

				int pageTotalCount = 0;

				if (recordTotalCount % Statics.recordCountPerPage > 0) {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
				} else {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
				}

				if (cpage < 1) {
					cpage = 1;
				} else if (cpage > pageTotalCount) {
					cpage = pageTotalCount;
				}
				request.getSession().setAttribute("last_cpage", cpage);

				// 네이게이션 시작번호
				int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
				// 네이게이션 끝번호
				int end = cpage * Statics.recordCountPerPage;

				List<BoardDTO> noticeSearchList = dao.searchFromToNotice(start, end, searchNoticeKeyword,searchNoticeCategory);

				int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
				int endNavi = startNavi + Statics.naviCountPerPage - 1;
				
				// endNavi 값은 페이지 전체 개수보다 클수없음!
				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				} 

				// 이전
				boolean needPrev = true;
				// 다음
				boolean needNext = true;

				if (startNavi == 1) {
					needPrev = false;
				}
				if (endNavi == pageTotalCount) {
					needNext = false;
				}

				request.setAttribute("noticeSearchList", noticeSearchList);

				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/board/noticeSearchList.jsp").forward(request, response);

			}
			//자유게시판 검색내용 목록 출력
			else if (cmd.equals("/generalSearchList.board")) {
				String searchGeneralKeyword = request.getParameter("searchKeyword");
				
				String searchGeneralCategory = request.getParameter("searchCategory");

				// 현재페이지
				String scpage = (String) (request.getParameter("cpage"));

				// 현재 페이지 유효성 검사.
				int cpage = 1;
				
				if (scpage != null) {
				    try {
				        cpage = Integer.parseInt(scpage);
				    } catch(NumberFormatException e) {
				        cpage = 1;  // 숫자가 아닌 값이 들어오면 1페이지로 간주
				    }
				}

				int recordTotalCount = dao.getRecordTotalCountGeneralSearch(searchGeneralKeyword,searchGeneralCategory);

				int pageTotalCount = 0;

				if (recordTotalCount % Statics.recordCountPerPage > 0) {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
				} else {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
				}

				if (cpage < 1) {
					cpage = 1;
				} else if (cpage > pageTotalCount) {
					cpage = pageTotalCount;
				}
				request.getSession().setAttribute("last_cpage", cpage);

				// 네이게이션 시작번호
				int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
				// 네이게이션 끝번호
				int end = cpage * Statics.recordCountPerPage;

				List<BoardDTO> generalSearchList = dao.searchFromToGeneral(start, end, searchGeneralKeyword,searchGeneralCategory);

				int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
				int endNavi = startNavi + Statics.naviCountPerPage - 1;
				
				// endNavi 값은 페이지 전체 개수보다 클수없음!
				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				} 

				// 이전
				boolean needPrev = true;
				// 다음
				boolean needNext = true;

				if (startNavi == 1) {
					needPrev = false;
				}
				if (endNavi == pageTotalCount) {
					needNext = false;
				}

				request.setAttribute("generalSearchList", generalSearchList);

				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/board/generalSearchList.jsp").forward(request, response);

			} else if (cmd.equals("/toWrite.board")) {	// 글 작성 페이지로
				response.sendRedirect("/views/board/write.jsp");
			} else if (cmd.equals("/write.board")) {
				int maxSize = 1024 * 1024 * 10;
				String savePath = Statics.filePath;
				File filePath = new File(savePath);
				
				if(!filePath.exists()) {
					filePath.mkdir();
				}
				
				// parameters: 1. request 객체 / 2. 파일 업로드 경로 / 3. 파일 업로드 사이즈 제한 / 4. 인코딩 처리 / 5. 이름 중복 시 이름 변경 규칙
				MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
				
				// 게시글 board 테이블에 insert
				int seq = dao.getNextVal();
				String writer = (String)request.getSession().getAttribute("nickname");
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				int isAdmin = 0;
				String boardCategory = "";
				System.out.println(multi.getParameter("boardCategory"));
				if(multi.getParameter("boardCategory").equals("general")) {
					isAdmin = 0;
					boardCategory = "general";
				}else if(multi.getParameter("boardCategory").equals("notice")) {
					isAdmin = 1;
					boardCategory = "notice";
				}
				dao.insert(new BoardDTO(seq, writer, title, contents, null, 0, isAdmin, boardCategory));
				
				Enumeration<String> fileNames = multi.getFileNames();
				while(fileNames.hasMoreElements()) {
					String id = (String)request.getSession().getAttribute("id");
					String name = fileNames.nextElement();
					String originName = multi.getOriginalFileName(name);
					String fileName = multi.getFilesystemName(name);
					
					if(originName != null) {
						fdao.insert(new FilesDTO(0, seq, id, originName, fileName, null));
					}
				}
				
				response.sendRedirect("/detail.board?seq="+seq);
			}
			//수정하기 페이지로 이동 컨트롤러
			else if (cmd.equals("/updateList.board")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String boardCategory = request.getParameter("boardCategory");
				
				System.out.println(seq + boardCategory);
				//게시글 정보 가져오기
				BoardDTO updateList = dao.selectBySeq(seq);
				request.setAttribute("updateList", updateList);
				// 파일 목록 가져오기
			    List<FilesDTO> fileList = fdao.getFilesBySeq(seq);
			    request.setAttribute("files", fileList);
			    
				
				request.getRequestDispatcher("/views/board/update.jsp").forward(request, response);
				
			}
			// 수정페이지에서 수정 완료 컨트롤러
			else if (cmd.equals("/updateComplete.board")) {
				// 파일 업로드를 위한 설정
			    int maxSize = 1024 * 1024 * 10;
			    String savePath = Statics.filePath;
			    File filePath = new File(savePath);
			    
			    if(!filePath.exists()) {
					filePath.mkdir();
				}
			    // MultipartRequest 생성
			    MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
			    
				
				int seq = Integer.parseInt(multi.getParameter("seq"));
				String title = multi.getParameter("title");
				String boardCategory = multi.getParameter("boardCategory");
				String contents = multi.getParameter("contents");
				System.out.println(seq +" : "+ title +" : "+contents +" : "+ boardCategory);
				
				
				int UpdateResult = dao.updateByBoardList(seq, title, contents);
				
				
				
			 // 파일 업로드 처리
			    Enumeration<String> fileNames = multi.getFileNames();
			    while (fileNames.hasMoreElements()) {
			        String id = (String)request.getSession().getAttribute("id");
			        String name = fileNames.nextElement();
			        String originName = multi.getOriginalFileName(name);
			        String fileName = multi.getFilesystemName(name);

			        if (originName != null) {
			            fdao.insert(new FilesDTO(0, seq, id, originName, fileName, null));
			        }
			    }
				
				response.sendRedirect("/detail.board?seq="+seq);
				
			}			
			else if (cmd.equals("/delete.board")) {
				int seq = Integer.parseInt(request.getParameter("seq"));
				String boardCategory = request.getParameter("boardCategory");
				
				dao.deleteBySeq(seq);
				
//				int seq = Integer.parseInt(request.getParameter("seq"));
//				String boardCategory = request.getParameter("boardCategory");
//				
//				dao.deleteBySeq(seq);
//				response.sendRedirect("/"+boardCategory+"List.board?cpage=1");

			} else if (cmd.equals("/detail.board")) {
				// 게시글 받아오기
				int seq = Integer.parseInt(request.getParameter("seq"));
				
				// 조회수 증가 (중복 조회 방지)
		        dao.increaseViewCount(request.getSession(), seq);
				
				BoardDTO post = dao.selectBySeq(seq);
				request.setAttribute("post", post);
				
				// 파일 받아오기
				List<FilesDTO> fileList = fdao.getFilesBySeq(seq);
				request.setAttribute("files", fileList);
				
				request.getRequestDispatcher("/views/board/detail.jsp").forward(request, response);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
