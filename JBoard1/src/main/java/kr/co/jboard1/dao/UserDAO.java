package kr.co.jboard1.dao;

public class UserDAO {
	private static UserDAO instance= new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	public void insertUser() {}
	public void selectUser() {}
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
}
