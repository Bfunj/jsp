
<%@page import="kr.co.Farmstory2.VO.FileVO"%>
<%@page import="kr.co.Farmstory2.dao.ArticleDao"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("utf-8");
	String fno = request.getParameter("fno");
	
	ArticleDao dao = ArticleDao.getInstance();
	
	FileVO fb = dao.selectFile(fno);
	

	// 파일 다운로드 헤더정보 수정
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fb.getOriname(), "utf-8"));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "private");
		// 파일 다운로드 스트림 작업
		String savePath = application.getRealPath("/file");
		File file = new File(savePath+"/"+fb.getNewname());

		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		while(true){
			int data = bis.read();
			
			if(data == -1){
				break;
			}
			bos.write(data);
		}
		
		bos.close();
		bis.close();
						
		
%>




