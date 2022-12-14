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
	
	public void updateUser(UserVO vo) {
		
		try {
			
			logger.info("updatetUser...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_USER);
			
			
			psmt.setNString(1, vo.getName());
			psmt.setNString(2, vo.getNick());
			psmt.setNString(3, vo.getEmail());
			psmt.setNString(4, vo.getHp());
			psmt.setNString(5, vo.getZip());
			psmt.setNString(6, vo.getAddr1());
			psmt.setNString(7, vo.getAddr2());
			psmt.setNString(8, vo.getUid());
			
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
	
	public UserVO selectUser(String uid, String pass) {
		
		UserVO vo= null;
		try {
			logger.info("selectUser");
			
			conn= getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
public int matchPass(String uid, String pass) {
		
		int result=0;
		try {
			logger.info("matchPass...");
			
			conn= getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs=psmt.executeQuery();
			
			if(rs.next()) {
				result=1;
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	

	
	public UserVO selectUserForFindId(String name, String email) {
			
			UserVO vo = null;
			
			try {
				logger.info("selectUserForFindId...");
				
				conn = getConnection();
				psmt = conn.prepareStatement(Sql.SELECT_USER_FOR_FIND_ID);
				psmt.setString(1, name);
				psmt.setString(2, email);
				rs = psmt.executeQuery();
				
				if(rs.next()) {
					vo = new UserVO();
					vo.setUid(rs.getString(1));
					vo.setName(rs.getString(2));
					vo.setEmail(rs.getString(3));
					vo.setRdate(rs.getString(4));
				}
				close();
				
			}catch (Exception e) {
				logger.error(e.getMessage());
			}
			
			return vo;
		}
	
	
	public int selectUserForFindPw(String uid, String email) {
		
		int result = 0;
		
		try {
			logger.info("selectUserForFindPw...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER_FOR_FIND_PW);
			psmt.setString(1, uid);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return result;
	}
	
	public int updateUserPassword(String uid, String pass) {
		
		int result = 0;
		
		try {
			logger.info("updateUserPassword...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_USER_PASSWORD);
			
			psmt.setString(1, pass);
			psmt.setString(2, uid);
			result = psmt.executeUpdate();
			
			close();			
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public void updateUserForSession(String uid, String sessId) {
		
		try {
			logger.info("updateUserForSession...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_USER_FOR_SESSION);
			
			psmt.setString(1,sessId); 
			psmt.setString(2,uid);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		logger.info("updateUserForSession.. complete");
	}
	
	public UserVO  selectUserBySessId(String sessId) {
		UserVO vo = null;
		try {
			logger.info("selectUserBySessId...");
			conn=getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_USER_BY_SESSID);
			psmt.setString(1, sessId);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
			logger.info("selectUserBySessId.. complete");
			return vo;
	}
	
	public void updateUserForSessionOut(String uid) {
		try {
			logger.info("selectUserBySessId...");
			conn=getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_USER_FOR_SESSION_OUT);
			psmt.setString(1, uid);
			
			rs = psmt.executeQuery();
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	public void offUser(String uid) {
		
		try {
			logger.info("offUser...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.OFF_USER);
			psmt.setString(1, uid);
			psmt.executeUpdate();
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}


	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
	
}
