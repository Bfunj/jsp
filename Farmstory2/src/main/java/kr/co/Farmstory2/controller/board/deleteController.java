package kr.co.Farmstory2.controller.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.Farmstory2.VO.ArticleVO;
import kr.co.Farmstory2.service.ArticleService;

@WebServlet("/board/delete.do")
public class deleteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("no", no);
		req.setAttribute("pg", pg);
		
		// article 삭제
		service.deleteArticle(no);
	
		// 파일삭제(테이블)
			String fileName = service.deleteFile(no);
			
			// 파일삭제(디렉토리)
			if(fileName != null){
				
				ServletContext ctx = req.getServletContext();
				String path = ctx.getRealPath("/file");
				
				File file = new File(path, fileName);		
				if(file.exists()){
					file.delete();
				}
			}
			resp.sendRedirect("/Farmstory2/board/list.do?group="+group+"&cate="+cate+"&no="+no+"&pg="+pg);
			

	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
	}
	

}
