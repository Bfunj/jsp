package dao;

import java.util.ArrayList;
import java.util.List;

import config.DBHelper;
import vo.BookVo;


public class BookDAO extends DBHelper {

	private static BookDAO instance = new BookDAO();
	
	public static BookDAO getInstance() {
		return instance;
	}
	
	private BookDAO() {}
	
	public List<BookVo> selectBooks() {
		List<BookVo> books =new ArrayList<>(); // arraylist 선언
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT *FROM `book`");
			
			while(rs.next()){	// rs의 데이터가 없을때까지
			BookVo bv = new BookVo();// bean
			
			bv.setBookId(rs.getString(1));		//rs의 첫번째	
			bv.setBookName(rs.getString(2));	//rs의 두번쨰
			bv.setPublisher(rs.getString(3));	//rs의 세번째
			bv.setPrice(rs.getString(4));		//rs의 네번째
			books.add(bv);	// arraylist에서 받아온 위의 데이터를 저장
			}	//rs의 데이터가 없다면 반복문 종료
		
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return books;
		
	}
	
	public void insertBook(BookVo bv) {
		
		try{
			conn = getConnection();
			// SQL명령어 저장
			psmt = conn.prepareStatement("INSERT INTO `book` VALUES(?,?,?,?)");
		// PreparedSttement로 선언하여  첫번째 ? 부터 마지막? 까지 순번으로 들어갈 데이터 선언
			psmt.setString(1, bv.getBookId());
			psmt.setString(2, bv.getBookName());
			psmt.setString(3, bv.getPublisher());
			psmt.setString(4, bv.getPrice());
	
			psmt.executeUpdate(); // psmt 동작 실행
			close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
			
	}
	public BookVo selectBook(String bookId) {
		BookVo bv =null;
		try{
			conn = getConnection();
			
			psmt = conn.prepareStatement("select * from `book` where `bookId`=?");
			psmt.setString(1, bookId);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				bv = new BookVo();
				bv.setBookId(rs.getString(1));
				bv.setBookName(rs.getString(2));
				bv.setPublisher(rs.getString(3));
				bv.setPrice(rs.getString(4));				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return bv;
	}
	public void updateBook(BookVo bv) {			
		try {
			conn = getConnection();
			String sql = "UPDATE `book` SET `bookName`=?, `publisher`=?,`price`=?";
			sql += "WHERE `bookId`=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(4, bv.getBookId());
			psmt.setString(1, bv.getBookName());
			psmt.setString(2, bv.getPublisher());
			psmt.setString(3, bv.getPrice());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
		
	
	public void deleteBook(String bookId) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `book` where `bookId`=?");
			psmt.setString(1, bookId);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
