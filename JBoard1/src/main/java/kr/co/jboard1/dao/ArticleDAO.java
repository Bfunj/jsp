package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
	public void insertArticle() {}
	public void selectArticle() {}
	
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
}