package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.protocol.Resultset;

import kr.co.jboard1.bean.FileBean;
import kr.co.jboard1.bean.articleBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.sql;

public class ArticleDAO {
	private static ArticleDAO instance = new ArticleDAO();
	public static ArticleDAO getInstance() {
		return instance;
	}
	private ArticleDAO() {}

	// 기본 CRUD
	public int insertArticle(articleBean article) {
		int parent =0;
		
		try{
			Connection conn = DBCP.getConnection();
			//트랜잭션 시작
			conn.setAutoCommit(false);	// autocommit	
			
			Statement stmt = conn.createStatement();
			PreparedStatement psmt = conn.prepareStatement(sql.INSERT_ARTICLE);
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFname() == null ? 0 : 1);
			psmt.setString(4, article.getUid());
			psmt.setString(5, article.getRegip());
			
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
		}
		
		return parent;
	}
	
	public void insertFile(int parent, String newFname, String fname) {
		try{
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
		}
	}
	
	public articleBean insertComment(articleBean comment){
		articleBean article = null;
		try{
			Connection conn = DBCP.getConnection();
			
			// 트랜잭션 시작
			conn.setAutoCommit(false);
			
			PreparedStatement psmt = conn.prepareStatement(sql.INSERT_COMMENT);
			Statement stmt =conn.createStatement();
			
			
			psmt.setString(1, comment.getParent());
			psmt.setString(2, comment.getContent());
			psmt.setString(3, comment.getUid());
			psmt.setString(4, comment.getRegip());
			psmt.executeUpdate();
			ResultSet rs = stmt.executeQuery(sql.SELECT_COMMENT_LATEST);
			
			//작업 확정
			conn.commit();
			
			if(rs.next()) {
				article = new articleBean();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getString(2));
				article.setContent(rs.getString(6));
				article.setRdate(rs.getString(11).substring(2, 10));
				article.setNick(rs.getString(12));
			}
			
			rs.close();
			psmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return article;
	}
	
	
	public articleBean selectArticle(String no) {
		articleBean ab= null;

		try{
			Connection conn =DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			PreparedStatement psmt2 = conn.prepareStatement(sql.SELECT_ARTICLE);
			psmt2.setString(1, no);
			
			ResultSet rs = psmt2.executeQuery();
			
			if(rs.next()){
				ab = new articleBean();
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
	
	public List<articleBean> selectArticles(int start) {
		
		List<articleBean> artiB =new ArrayList<>();
		try{
			Connection conn = DBCP.getConnection();
			
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_ARTICLES);
			psmt.setInt(1,start);
			
			ResultSet rs = psmt.executeQuery();
			
			
			while(rs.next()){
				
				articleBean ab = new articleBean();
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
	
	public void updateArticle() {}
	public void deleteArticle() {}
	
	//전체 게시물 카운트
	public int selectCountTotal() {
		int total =0;	
		try{
			Connection conn = DBCP.getConnection();
			Statement stmt = conn.createStatement();
			
			ResultSet rs =stmt.executeQuery(sql.SELECT_COUNT_TOTAL);
			if(rs.next()) {
				total = rs.getInt(1);
			}rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return total;
	}
	
	
	public FileBean selectFile(String fno) {

		
		FileBean fb = null;
		
		try{
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_FILE);
			psmt.setString(1, fno);
			
			PreparedStatement psmt2 = conn.prepareStatement(sql.UPDATE_DOWNLOAD_COUNT);
			psmt2.setString(1, fno);
			psmt2.executeUpdate();
			
			ResultSet rs = psmt.executeQuery();
			
			if(rs.next()){
				fb = new FileBean();
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
	
	public List<articleBean> selectComments(String parent) {
		
		List<articleBean> comments = new ArrayList<>();
		
		try {
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			
			ResultSet rs = psmt.executeQuery();
			
			while(rs.next()) {
				articleBean comment =new articleBean();
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
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return comments;
	}
}


