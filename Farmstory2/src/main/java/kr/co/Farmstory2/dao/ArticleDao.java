package kr.co.Farmstory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory2.db.DBCP;
import kr.co.Farmstory2.db.sql;
import kr.co.Farmstory2.VO.ArticleVO;
import kr.co.Farmstory2.VO.FileVO;




public class ArticleDao {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static ArticleDao instance = new ArticleDao();
	public static ArticleDao getInstance() {
		return instance;
	}
	private ArticleDao() {}
	
	public int insertArticle(ArticleVO ab) {
		int parent=0;
		try {
			
			logger.info("insertArticle start...");
			Connection conn = DBCP.getConnection();
			//트랜잭션 시작
			conn.setAutoCommit(false);	// autocommit	
			Statement stmt = conn.createStatement();
			
			PreparedStatement psmt = conn.prepareStatement(sql.INSERT_ARTICLE);
			psmt.setString(1, ab.getCate());
			psmt.setString(2, ab.getTitle());
			psmt.setString(3, ab.getContent());
			psmt.setInt(4, ab.getFname() == null ? 0 : 1);
			psmt.setString(5, ab.getUid());
			psmt.setString(6, ab.getRegip());

			psmt.executeUpdate();
			ResultSet rs =stmt.executeQuery(sql.SELECT_MAX_NO);
			
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
	
	public void insertFile(int parent, String newFname, String fname) {
		try{
			logger.info("insertFile start...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.INSERT_FILE);
			
			psmt.setInt(1, parent);
			psmt.setString(2, newFname);
			psmt.setString(3, fname);
			psmt.executeUpdate();
			
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
public FileVO selectFile(String fno) {

		
		FileVO fb = null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_FILE);
			psmt.setString(1, fno);
			
			PreparedStatement psmt2 = conn.prepareStatement(sql.UPDATE_DOWNLOAD_COUNT);
			psmt2.setString(1, fno);
			psmt2.executeUpdate();
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				fb = new FileVO();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewname(rs.getString(3));
				fb.setOriname(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				fb.setRdate(rs.getString(6));
			}
			
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return fb;
	}
	
	
	public ArticleVO selectArticle(String no) {
		ArticleVO ab= null;

		try{
			Connection conn =DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			PreparedStatement psmt2 = conn.prepareStatement(sql.SELECT_ARTICLE);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt2.executeQuery();
			
			if(rs.next()){
				ab = new ArticleVO();
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
				ab.setFno(rs.getInt(12));
				ab.setOriName(rs.getString(13));
				ab.setDownload(rs.getInt(14));
			}
			
			rs.close();
			psmt.close();
			psmt2.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	
		return ab;
		
	}
	
	
	public List<ArticleVO> selectArticles(int start, String cate) {
		
		List<ArticleVO> artiB =new ArrayList<>();
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_ARTICLES);
			psmt.setInt(2,start);
			psmt.setString(1,cate);
			
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
				
				artiB.add(ab);			
			}	
		
			rs.close();
			psmt.close();
			conn.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return artiB;
	}
	
	public int selectCountTotal(String cate) {
		int total =0;	
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_COUNT_TOTAL);
			psmt.setString(1,cate);
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return total;
	}
	


	
	public void updateArticle() {}
	public void deleteArticle() {}
	
}