package kr.co.Farmstory2.service;

import kr.co.Farmstory2.VO.TermsVO;
import kr.co.Farmstory2.VO.UserVO;
import kr.co.Farmstory2.dao.UserDao;

public enum UserService {
	
	INSTANCE;
	private UserDao dao = UserDao.getInstance();
	
	public void insertUser(UserVO ub) {
			dao.insertUser(ub);
	}
	
	
	public TermsVO selectTerms() {
		return dao.selectTerms();
	}
	
	public UserVO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	
	
}
