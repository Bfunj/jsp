package kr.co.jboard2.service;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;


public enum UserService {
	INSTANCE;
	private UserDAO dao = UserDAO.getInstance();

	public int matchPass(String uid, String pass) {
			return dao.matchPass(uid, pass);
	}
	public void offUser(String uid) {
		dao.offUser(uid);
	}
	public void updateUser(UserVO vo) {
		dao.updateUser(vo);
	}
}
