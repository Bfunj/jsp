package kr.co.Farmstory2.controller.board;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;


import kr.co.Farmstory2.service.ArticleService;

@WebServlet("/board/commentModify.do")
public class commentModifyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no = req.getParameter("no");
		String content = req.getParameter("content");
		
		int result = service.updateComment(no, content);
		
		// json 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		json.addProperty("no", no);
		json.addProperty("content", content);
		
		resp.setContentType("application/json;charset=UTF-8");
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
