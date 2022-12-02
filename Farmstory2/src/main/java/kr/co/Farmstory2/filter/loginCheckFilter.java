package kr.co.Farmstory2.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory2.VO.UserVO;

@WebFilter("/*")
public class loginCheckFilter implements Filter {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private List<String> uriList;

	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 필터를 동작할 요청주소 리스트 구성
		uriList = new ArrayList<>();
		uriList.add("/Farmstory2/board/write.do");
		uriList.add("/Farmstory2/board/view.do");
		uriList.add("/Farmstory2/index.do");
		uriList.add("/Farmstory2/board/modify.do");
		uriList.add("/Farmstory2/delete.do");
		uriList.add("/Farmstory2/board/download.do");
		uriList.add("/Farmstory2/board/comment.do");
		uriList.add("/Farmstory2/board/commentDelete.do");
		uriList.add("/Farmstory2/board/commentModify.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		logger.info("LoginCheckFilter...0");
		
		HttpServletRequest req = (HttpServletRequest) request;
		String uri = req.getRequestURI();
		
		logger.debug("LoginCheckFilter...1");
		
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO)sess.getAttribute("sessUser");
		
		if(uriList.contains(uri)) {
			logger.debug("LoginCheckFilter...2");
			
			// 로그인을 안했으면
			if(sessUser == null) {
				logger.debug("LoginCheckFilter...3");
				((HttpServletResponse) response).sendRedirect("/Farmstory2/login.do");
				return;
			}
		}else if(uri.contains("/Farmstory2/user/login.do")) {
			
			// 로그인을 했으면
			if(sessUser != null) {
				logger.debug("LoginCheckFilter...3");
				((HttpServletResponse) response).sendRedirect("/Farmstory2/index.do");
				return;
			}
		}
		
		logger.debug("LoginCheckFilter...4");
		chain.doFilter(request, response);
	}
}