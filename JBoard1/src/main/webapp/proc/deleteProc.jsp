<%@page import="java.io.File"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String no 	=	request.getParameter("no");
	String pg	= 	request.getParameter("pg");
	
	
	ArticleDAO dao  = ArticleDAO.getInstance();
	
	// article 삭제
	dao.deleteArticle(no);
	
	
	// 파일삭제(테이블)
		String fileName = dao.deleteFile(no);
		
		// 파일삭제(디렉토리)
		if(fileName != null){
			
			String path = application.getRealPath("/file");
			
			File file = new File(path, fileName);
			
			if(file.exists()){
				file.delete();
			}
		}


	response.sendRedirect("/JBoard1/lsit.jsp?no="+no+"&pg="+pg);
%>