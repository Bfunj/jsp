package kr.co.jboard2.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.ArticleVO;

public class ArticleDAO extends DBHelper{
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}
	
	// 로거 생성
	Logger logger = LoggerFactory.getLogger(this.getClass());
		
	// list 
	public List<ArticleVO> selectArticles(int start) {
		
		List<ArticleVO> articleList =new ArrayList<>();
		try{		
			logger.info("selectArticles...");
			conn = getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1,start);
			
			ResultSet rs = psmt.executeQuery();
						
			while(rs.next()){
				
				ArticleVO ab = new ArticleVO();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getString(2));
				ab.setComment(rs.getString(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				ab.setNick(rs.getString(12));
				
				articleList.add(ab);			
			}		
			close();
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return articleList;
	}
	
	//전체 게시물 카운트
		public int selectCountTotal() {
			int total =0;	
			try{
				logger.info("selectCountTotal");
				conn = getConnection();
				Statement stmt = conn.createStatement();	
				ResultSet rs =stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
				if(rs.next()) {
					total = rs.getInt(1);
				}
				close();
			}catch(Exception e) {
				logger.error(e.getMessage());
			}
			return total;
		}
		
		
	// 게시물 쓰기
		
		public int insertArticle(ArticleVO article) {
			int parent =0;
			
			try{
				logger.info("insertArticle start...");
				
				conn = getConnection();
				//트랜잭션 시작	
				conn.setAutoCommit(false);	// autocommit	
				
				Statement stmt = conn.createStatement();
				PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
				psmt.setString(1, article.getTitle());
				psmt.setString(2, article.getContent());
				psmt.setInt(3, article.getFname() == null ? 0 : 1);
				psmt.setString(4, article.getUid());
				psmt.setString(5, article.getRegip());
				
				psmt.executeUpdate();
				ResultSet rs =stmt.executeQuery(Sql.SELECT_MAX_NO);
				
				conn.commit();	// autocommit
				
				if(rs.next()){
					parent = rs.getInt(1);
				}
							
				psmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				logger.error(e.getMessage());
			}
			
			return parent;
		}
		
		// 파일 추가
		
		public void insertFile(int parent, String newFname, String fname) {
			try{
				logger.info("insertFile start...");
				conn = getConnection();
				PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_FILE);
				
				psmt.setInt(1, parent);
				psmt.setString(2, newFname);
				psmt.setString(3, fname);
				psmt.executeUpdate();
				
				close();
				
			}catch(Exception e){				
				logger.error(e.getMessage());
			}
		}
		
		
		
		public ArticleVO selectArticle(String no) {
			ArticleVO article = null;
			
			try{
				logger.info("selectArticle...");
				conn = getConnection();
				PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
				psmt.setString(1, no);
				
				ResultSet rs = psmt.executeQuery();
				
				if(rs.next()){
					article = new ArticleVO();
					article.setNo(rs.getInt(1));
					article.setParent(rs.getString(2));
					article.setComment(rs.getString(3));
					article.setCate(rs.getString(4));
					article.setTitle(rs.getString(5));
					article.setContent(rs.getString(6));
					article.setFile(rs.getInt(7));
					article.setHit(rs.getInt(8));
					article.setUid(rs.getString(9));
					article.setRegip(rs.getString(10));
					article.setRdate(rs.getString(11));
					article.setFno(rs.getInt(12));
					article.setOriName(rs.getString(13));
					article.setDownload(rs.getInt(14));
				}
				
				close();
			}catch(Exception e){
				logger.error(e.getMessage());
			}
			
			return article;
		}
		
		
		// 댓글
		public List<ArticleVO> selectComments(String parent) {
			
			List<ArticleVO> comments = new ArrayList<>();
			
			try {
				logger.info("selectComments...");
				conn = getConnection();
				PreparedStatement psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
				psmt.setString(1, parent);
				
				ResultSet rs = psmt.executeQuery();
				
				while(rs.next()) {
					ArticleVO comment =new ArticleVO();
					comment.setNo(rs.getInt(1));
					comment.setParent(rs.getString(2));
					comment.setComment(rs.getString(3));
					comment.setCate(rs.getString(4));
					comment.setTitle(rs.getString(5));
					comment.setContent(rs.getString(6));
					comment.setFile(rs.getInt(7));
					comment.setHit(rs.getInt(8));
					comment.setUid(rs.getString(9));
					comment.setRegip(rs.getString(10));
					comment.setRdate(rs.getString(11).substring(2, 10));
					comment.setNick(rs.getString(12));

					comments.add(comment);
				}
				close();
				
			}catch(Exception e) {
				logger.error(e.getMessage());
			}
			return comments;
		}
		
}
