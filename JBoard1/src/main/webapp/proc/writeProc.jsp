<%@page import="kr.co.jboard1.bean.articleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.jboard1.db.sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	// multipart 전송 데이터 수신
	int maxSize = 1024*1024*10;
	String savePath = application.getRealPath("/file");
	//MultipartRequest mr = new MultipartRequest(request, "파일저장경로", "파일 최대 사이즈","utf-8", new defaultFileRenamePolicy());
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize,"utf-8", new DefaultFileRenamePolicy());

	String title   	= mr.getParameter("title");
	String content 	= mr.getParameter("content");
	String uid     	= mr.getParameter("uid");
	String fname	= mr.getFilesystemName("fname");
	String regip   	= request.getRemoteAddr();
	
	articleBean article = new articleBean();
	article.setTitle(title);
	article.setContent(content);
	article.setUid(uid);
	article.setFname(fname);
	article.setRegip(regip);
	
	ArticleDAO dao = ArticleDAO.getInstance();
	int parent = dao.insertArticle(article);
	
	// 파일을 첨부 했으면 파일명 수정 작업
	if(fname != null){
		
		// 파일명 수정
			int idx = fname.lastIndexOf(".");
			String ext = fname.substring(idx);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			
			String newFname = now+uid+ext; // 202210261114_baekhj9.txt
			
			File oriFile = new File(savePath+"/"+fname);
			File newFile = new File(savePath+"/"+newFname);
			
			oriFile.renameTo(newFile);
		// 파일 테이블 수정
		
		//파일 테이블 저장
	dao.insertFile(parent, newFname, fname);
	}
	
	
	response.sendRedirect("/JBoard1/lsit.jsp");
%>