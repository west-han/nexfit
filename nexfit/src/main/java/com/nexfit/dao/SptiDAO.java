package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class SptiDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertSpti(String result) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO spti(num, createDate, result) values (spti_seq.NEXTVAL, SYSDATE, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, result);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
}
