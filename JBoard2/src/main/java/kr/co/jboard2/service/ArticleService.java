package kr.co.jboard2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao = ArticleDAO.getInstance();
	
		public int insertAtricle(ArticleVO article) {
			return dao.insertArticle(article);
		}
		public void insertFile(int parent, String newFname, String fname) {
			dao.insertFile(parent, newFname, fname);
		}
		public ArticleVO selectArticle(String no) {
			return dao.selectArticle(no);
		}
		public List<ArticleVO> selectArticles(int start) {
			return dao.selectArticles(start);
		}
		public void updateAtricle() {}
		public void deleteAtricle() {}
		
		public int selectCountTotal() {
			return dao.selectCountTotal();
		}
		
		//
		public MultipartRequest uploadFile(HttpServletRequest req,String savePath) throws IOException {		
			int maxSize = 1024*1024*10;			
			return new MultipartRequest(req, savePath, maxSize,"utf-8", new DefaultFileRenamePolicy());
		}
		
		public String renameFile(String uid, String fname, String savePath) {
			// 파일명 수정
			int idx = fname.lastIndexOf(".");
			String ext = fname.substring(idx);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			
			String newFname = now+uid+ext; // 202210261114_baekhj9.txt
			
			File oriFile = new File(savePath+"/"+fname);
			File newFile = new File(savePath+"/"+newFname);
			
			oriFile.renameTo(newFile);
			
			return newFname;
		}
		
		public int getLastPageNum(int total) {
			
			int lastPageNum = 0;
			
			if(total % 10 == 0){
				lastPageNum = total / 10;
			}else{
				lastPageNum = total / 10 + 1;
			}
			
			return lastPageNum;
		}
		
		public int[] getPageGroupNum(int currentPage, int lastPageNum) {
			int currentPageGroup = (int)Math.ceil(currentPage / 10.0);
			int pageGroupStart = (currentPageGroup - 1) * 10 + 1;
			int pageGroupEnd = currentPageGroup * 10;
			
			if(pageGroupEnd > lastPageNum){
				pageGroupEnd = lastPageNum;
			}
			
			int[] result = {pageGroupStart, pageGroupEnd};
			
			return result;
		}
		
		public int getPageStartNum(int total, int currentPage) {
			int start = (currentPage - 1) * 10;
			return total - start;
		}
		
		public int getCurrentPage(String pg) {
			int currentPage = 1;
			
			if(pg != null){
				currentPage = Integer.parseInt(pg);	
			}
			
			return currentPage;
		}
		
		public int getStartNum(int currentPage) {
			return (currentPage - 1) * 10;
		}
}
