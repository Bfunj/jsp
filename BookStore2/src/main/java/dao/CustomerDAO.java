package dao;

import java.util.ArrayList;
import java.util.List;

import config.DBHelper;
import vo.BookVo;
import vo.CustomerVo;


public class CustomerDAO  extends DBHelper{

private static CustomerDAO instance = new CustomerDAO();
	
	public static CustomerDAO getInstance() {
		return instance;
	}
	
	private CustomerDAO() {}
	
	public List<CustomerVo> selectBooks() {
		List<CustomerVo> customers =new ArrayList<>(); // arraylist 선언
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT *FROM `customer`");
			
			while(rs.next()){	// rs의 데이터가 없을때까지
			CustomerVo cv = new CustomerVo();// bean
			
			cv.setCusId(rs.getString(1));		//rs의 첫번째	
			cv.setName(rs.getString(2));	//rs의 두번쨰
			cv.setAddress(rs.getString(3));	//rs의 세번째
			cv.setPhone(rs.getString(4));		//rs의 네번째
			customers.add(cv);	// arraylist에서 받아온 위의 데이터를 저장
			}	//rs의 데이터가 없다면 반복문 종료
		
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return customers;
		
	}
	
	public void insertCustomer(CustomerVo cv) {
		
		try{
			conn = getConnection();
			// SQL명령어 저장
			psmt = conn.prepareStatement("INSERT INTO `customer` VALUES(?,?,?,?)");
		// PreparedSttement로 선언하여  첫번째 ? 부터 마지막? 까지 순번으로 들어갈 데이터 선언
			psmt.setString(1, cv.getCusId());
			psmt.setString(2, cv.getName());
			psmt.setString(3, cv.getAddress());
			psmt.setString(4, cv.getPhone());
	
			psmt.executeUpdate(); // psmt 동작 실행
			close();
		}
		catch(Exception e){
			e.printStackTrace();
		}		
	}
	
	public CustomerVo selectCustomer(String cusId) {
		CustomerVo cv =null;
		try{
			conn = getConnection();
			
			psmt = conn.prepareStatement("select * from `customer` where `cusId`=?");
			psmt.setString(1, cusId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				cv = new CustomerVo();
				cv.setCusId(rs.getString(1));
				cv.setName(rs.getString(2));
				cv.setAddress(rs.getString(3));
				cv.setPhone(rs.getString(4));				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return cv;
	}
	
	public void updateCustomer(CustomerVo cv) {			
		try {
			conn = getConnection();
			String sql = "UPDATE `customer` SET `Name`=?, `address`=?,`phone`=?";
			sql += "WHERE `cusId`=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(4, cv.getCusId());
			psmt.setString(1, cv.getName());
			psmt.setString(2, cv.getAddress());
			psmt.setString(3, cv.getPhone());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
		
	
	public void deleteCustomer(String cusId) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `customer` where `cusId`=?");
			psmt.setString(1, cusId);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
}
