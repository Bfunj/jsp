package kr.co.Farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.Farmstory2.VO.UserVO;

import kr.co.Farmstory2.service.UserService;



@WebServlet("/login.do")
public class loginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	@Override
	public void init() throws ServletException {

	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid  = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		UserVO vo = service.selectUser(uid, pass);
	
		// 로그인 처리
		if(vo != null) {
			// 회원 맞음
			HttpSession session = req.getSession(); // 현재 클라이언트 세션 구함
			session.setAttribute("sessUser", vo);		
			resp.sendRedirect("./index.do");
			
		}else {
			// 회원 아님
			resp.sendRedirect("./login.do?success=100");			
		}	
	}

}
