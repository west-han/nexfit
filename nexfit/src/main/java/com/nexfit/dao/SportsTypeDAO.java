package com.nexfit.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nexfit.annotation.Controller;
import com.nexfit.domain.SportTypeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

@Controller
public class SportsTypeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insert(SportTypeDTO dto) throws SQLException, IOException {
		String sql;
		PreparedStatement pstmt = null;
		
		
		try {
			conn.setAutoCommit(false);
			// 운동 타입 데이터 삽입
			sql = "INSERT INTO sportsTypeBoard(num, name, bodyPart, description, userId, hitCount) "
					+ "VALUES(sportsTypeBoard_seq.NEXTVAL, ?, ?, ?, ?, 0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getBodyPart());
			pstmt.setString(3, dto.getDescription());
			pstmt.setString(4, dto.getUserId());
			
			pstmt.executeUpdate();
			
			sql = "INSERT INTO sportsType_file(id, filename, num) VALUES(sportsType_file_SEQ.NEXTVAL, ?, sportsTypeBoard_seq.CURRVAL)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSaveFilename());
			
			pstmt.executeUpdate();
			
			conn.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
			conn.rollback();
			throw e;
		} finally {
			DBUtil.close(pstmt);
			conn.setAutoCommit(true);
		}
	}
}
