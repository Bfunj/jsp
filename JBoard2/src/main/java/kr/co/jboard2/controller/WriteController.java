package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;
@WebServlet("/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/write.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		
		// https://cofs.tistory.com/40 저장경로 참고
		String savePath = req.getSession().getServletContext().getRealPath("/");
		MultipartRequest mr = service.uploadFile(req,savePath);
		
		String title   	= mr.getParameter("title");
		String content 	= mr.getParameter("content");
		String uid     	= mr.getParameter("uid");
		String fname	= mr.getFilesystemName("fname");
		String regip   	= req.getRemoteAddr();
		
		ArticleVO article = new ArticleVO();
		article.setTitle(title);
		article.setContent(content);
		article.setUid(uid);
		article.setFname(fname);
		article.setRegip(regip);
		
		int parent = service.insertAtricle(article);
		
		// 파일을 첨부 했으면 파일명 수정 작업
		if(fname != null){	
			String newFname = service.renameFile(uid, fname, savePath);
			service.insertFile(parent, newFname, fname);
		}
		
		resp.sendRedirect("/JBoard2/list.do");
	}
}
