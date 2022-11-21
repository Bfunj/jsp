package kr.co.jboard2.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.UserVO;

public class UserDAO extends DBHelper {

	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	// 로거 생성
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	public void insertUser(UserVO vo) {
		
		try {
			
			logger.info("insertUser...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_USER);
			
			psmt.setNString(1, vo.getUid());
			psmt.setNString(2, vo.getPass());
			psmt.setNString(3, vo.getName());
			psmt.setNString(4, vo.getNick());
			psmt.setNString(5, vo.getEmail());
			psmt.setNString(6, vo.getHp());
			psmt.setNString(7, vo.getZip());
			psmt.setNString(8, vo.getAddr1());
			psmt.setNString(9, vo.getAddr2());
			psmt.setNString(10, vo.getRegip());
			
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public TermsVO selectTerms() {
		
		TermsVO vo = null;
		try {
			logger.info("selectTerms start...");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_TERMS);
			
			if(rs.next()) {
				vo = new TermsVO();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		logger.debug("vo : " + vo);
		return vo;
	}
	
	public int selectCountUid(String uid) {
		int result=0;
		try {
			logger.info("slecetCheckUid");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_UID);
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
			logger.info("slecetCheckNick");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_NICK);
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
	
	public void selectUser() {}
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
}
