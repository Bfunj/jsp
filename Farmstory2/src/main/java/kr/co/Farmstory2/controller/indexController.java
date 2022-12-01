package kr.co.Farmstory2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.Farmstory2.VO.ArticleVO;
import kr.co.Farmstory2.service.ArticleService;


@WebServlet("/index.do")
public class indexController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {

	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		List<ArticleVO> arti_story = service.selectArticles(0, "story");
		List<ArticleVO> arti_grow = service.selectArticles(0, "grow");
		List<ArticleVO> arti_school= service.selectArticles(0, "school");
		List<ArticleVO> arti_notice= service.selectArticles(0, "notice");
		List<ArticleVO> arti_faq= service.selectArticles(0, "faq");
		List<ArticleVO> arti_qna= service.selectArticles(0, "qna");
		
		req.setAttribute("arti_story", arti_story);
		req.setAttribute("arti_grow", arti_grow);
		req.setAttribute("arti_school", arti_school);
		req.setAttribute("arti_notice", arti_notice);
		req.setAttribute("arti_faq", arti_faq);
		req.setAttribute("arti_qna", arti_qna);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
}
