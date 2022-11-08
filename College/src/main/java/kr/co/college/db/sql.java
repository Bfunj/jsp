package kr.co.college.db;

public class sql {

	public static final String SELECT_LECTURE= "select * from `lecture`";
	
	public static final String INSERT_LECTURE = "insert into `lecture` set "
			+ "`lecNO`=?,"
			+ "`lecName`=?,"
			+ "`lecCredit`=?,"
			+ "`lecTime`=?,"
			+ "`lecClass`=?";
	
	public static final String SELECT_LECTURE_LATEST = "select * from `lecture` ORDER BY `lecNo` DESC LIMIT 1";

	
	public static final String SELECT_STUDENT= "SELECT a.`stdNo`,a.`stdName`,c.`lecName`,  b.* "
						+" FROM `student` AS a "
						+" JOIN `register` AS b "
						+" ON a.`stdNo` = b.`regStdNo` "
						+" JOIN `lecture` AS c "
						+" ON b.`regLecNo` = c.`lecNo` "
						+" WHERE a.`stdNo` = ? ";
	
	
	
	public static final String SELECT_STUDENTS= "select * from `student`";
	
	
	public static final String INSERT_REGISTER= "insert into `register` set "
			+ "`regStdNo`=?, "
			+ "`regLecNo`=?";
	
	public static final String SELECT_REGISTER_LATEST = "select * from `register` ORDER BY `lecNo` DESC LIMIT 1";
			
	
	public static final String INSERT_STUDENT = "insert into `student` set "
			+ "`stdNO`=?,"
			+ "`stdName`=?,"
			+ "`stdHp`=?,"
			+ "`stdYear`=?,"
			+ "`stdAddress`=?";
	
	public static final String SELECT_STUDENT_LATEST = "select * from `student` ORDER BY `stdNo` DESC LIMIT 1";
}
