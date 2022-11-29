
package kr.co.Farmstory2.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.Farmstory2.VO.TermsVO;
import kr.co.Farmstory2.VO.UserVO;
import kr.co.Farmstory2.db.DBCP;
import kr.co.Farmstory2.db.DBHelper;
import kr.co.Farmstory2.db.sql;

public class UserDao extends DBHelper{
	
	private static UserDao instance = new UserDao();
	public static UserDao getInstance() {
		return instance;
	}	
	// 로거 생성	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private UserDao() {		
	}
	
	public void insertUser(UserVO ub) {
		
		// 데이터베이스 작업
		try{
			logger.info("insertUser...");
			
			conn = getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.INSERT_USER);
			psmt.setString(1, ub.getUid());
			psmt.setString(2, ub.getPass());
			psmt.setString(3, ub.getName());
			psmt.setString(4, ub.getNick());
			psmt.setString(5, ub.getEmail());
			psmt.setString(6, ub.getHp());
			psmt.setString(7, ub.getZip());
			psmt.setString(8, ub.getAddr1());
			psmt.setString(9, ub.getAddr2());
			psmt.setString(10, ub.getRegip());
			
			psmt.executeUpdate();
			
			close();	
		}catch(Exception e){
			logger.error(e.getMessage());
		}
	}
	
	public TermsVO selectTerms() {
		
		TermsVO tb =null;
		try {
			logger.info("selectTerms...");
			conn = getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql.SELECT_TERMS);
			
			if(rs.next()) {
				tb = new TermsVO();
				tb.setTerms(rs.getString(1));
				tb.setPrivacy(rs.getString(2));
			}
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
		return tb;
	}
	
	public UserVO selectUser(String uid, String pass) {
		
		UserVO ub =null;
		try {
			logger.info("selectUser...");
			Connection conn = DBCP.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				 ub = new UserVO();
				ub.setUid(rs.getString(1));
				ub.setPass(rs.getString(2));
				ub.setName(rs.getString(3));
				ub.setNick(rs.getString(4));
				ub.setEmail(rs.getString(5));
				ub.setHp(rs.getString(6));
				ub.setGrade(rs.getInt(7));
				ub.setZip(rs.getString(8));
				ub.setAddr1(rs.getString(9));
				ub.setAddr2(rs.getString(10));
				ub.setRegip(rs.getString(11));
				ub.setRdate(rs.getString(12));
			}
			rs.close();
			psmt.close();
			conn.close();
		
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
		return ub;
	}
	
	
	public int selectCountUid(String uid) {
		int result=0;
		try {
			logger.info("slecetCheckUid");
			
			conn = getConnection();
			psmt = conn.prepareStatement(sql.SELECT_COUNT_UID);
			psmt.setString(1, uid);
			rs=psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	
	public int selectCountNick(String nick) {
		int result=0;
		try {
			logger.info("slecetCheckNick..");
			
			conn = getConnection();
			psmt = conn.prepareStatement(sql.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			rs=psmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	public void selectUsers() {}
	public void updateUser() {
	
	}
	public void deleteUser() {}
}
