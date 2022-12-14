package kr.co.Farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.Farmstory2.VO.ArticleVO;
import kr.co.Farmstory2.service.ArticleService;

@WebServlet("/board/comment.do")
public class commentController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String parent  = req.getParameter("parent");
		String content = req.getParameter("content");
		String uid     = req.getParameter("uid");
		String regip   = req.getRemoteAddr();

		ArticleVO comment = new ArticleVO();
		comment.setParent(parent);
		comment.setContent(content);
		comment.setUid(uid);
		comment.setRegip(regip);
		
		ArticleVO article = service.insertComment(comment);
		
		//json 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", 1);
		json.addProperty("no", article.getNo());
		json.addProperty("parent", article.getParent());
		json.addProperty("nick", article.getNick());
		json.addProperty("date", article.getRdate());
		json.addProperty("content", article.getContent());
		
		resp.setContentType("application/json;charset=UTF-8");
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
		
	}
}
