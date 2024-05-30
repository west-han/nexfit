package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nexfit.domain.BoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class RoutineDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertRoutine(BoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO rountineBoard(num, userId, )";
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setInt(0, 0);
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
}
