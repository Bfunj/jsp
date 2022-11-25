package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/view.do")
public class ViewController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");

		ArticleDAO dao = ArticleDAO.getInstance();
		
	 	// 글 가져오기
		ArticleVO ab  = ArticleDAO.getInstance().selectArticle(no);
		
		// 댓글 가져오기
		List<ArticleVO> comments = dao.selectComments(no);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/view.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
