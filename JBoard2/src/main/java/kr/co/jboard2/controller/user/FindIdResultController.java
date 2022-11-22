package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/findIdResult.do")
public class FindIdResultController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/findIdResult.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name  = req.getParameter("name");
		String email = req.getParameter("email");
		
		UserVO vo = UserDAO.getInstance().findUser(name, email);
		
		// 페이지 이동
		if(vo != null) {
			// 회원 맞음
			HttpSession session = req.getSession(); // 현재 클라이언트 세션 구함
			session.setAttribute("sessUser", vo);
			resp.sendRedirect("/JBoard2/findIdResult.do");
		}else {
			resp.sendRedirect("/JBoard2/findId.do?success=100");
		}
	}
}
