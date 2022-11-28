<%@page import="kr.co.Farmstory1.dao.ArticleDao"%>
<%@page import="kr.co.Farmstory1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>


<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	
	ArticleBean ab = new ArticleBean();
	
	// multipart 전송 데이터 수신
	int maxSize = 1024*1024*10;
	String savePath = application.getRealPath("/file");
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize,"utf-8", new DefaultFileRenamePolicy());
	
	
	String group   	= mr.getParameter("group");
	String cate   	= mr.getParameter("cate");
	String title   	= mr.getParameter("title");
	String content 	= mr.getParameter("content");
	String uid     	= mr.getParameter("uid");
	String fname	= mr.getFilesystemName("fname");
	String regip   	= request.getRemoteAddr();
	
	ab.setCate(cate);
	ab.setTitle(title);
	ab.setContent(content);
	ab.setUid(uid);
	ab.setFname(fname);
	ab.setRegip(regip);
	
	ArticleDao dao = ArticleDao.getInstance();
	
	int parent = dao.insertArticle(ab);
	
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
	
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate);
%>