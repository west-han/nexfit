package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nexfit.domain.ChellengeBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChellengeBoardDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertchBoard(ChellengeBoardDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO chellengeboard(boardnumber, subject, mod_date, start_date, end_date, content,chellengeid)"
					+" VALUES (chellengeboard_seq.NEXTVAL, ?, ?, ?, ?, ? ,?)";
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getMod_date());
			pstmt.setString(3, dto.getStart_date());
			pstmt.setString(4, dto.getEnd_date());
			pstmt.setString(5, dto.getContent());
			pstmt.setLong(6, dto.getChellengeId());
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	} 
}
