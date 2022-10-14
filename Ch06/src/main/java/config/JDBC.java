package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class JDBC {

	private static JDBC instance = new JDBC();
	
	public static JDBC getInstance() {
		return instance;
	}
	
	private JDBC() {
		
	}
	
	private final String HOST= "jdbc:mysql://127.0.0.1:3306/java1db";
	private final String USER= "root";
	private final String PASS= "1234";
	
	public Connection getConnection() throws SQLException, ClassNotFoundException {
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 2단계
		return DriverManager.getConnection(HOST, USER, PASS);
	}
	
	public static Connection getDBCP()  throws NamingException, SQLException{
		// 1단계 - JNDI 서비스 객체생성
					Context initCtx= new InitialContext();
					Context ctx = (Context) initCtx.lookup("java:comp/env");
					// 2단계 - 커넥션 풀 얻기
					DataSource ds =(DataSource) ctx.lookup("dbcp_java1db");
					return ds.getConnection();
	}
}
