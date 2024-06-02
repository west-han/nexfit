package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.nexfit.domain.ChallengeBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChallengeBoardDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertchBoard(ChallengeBoardDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO challengeboard(boardnumber, subject, mod_date, start_date, end_date, content,challengeid)"
					+" VALUES (challengeboard_seq.NEXTVAL, ?, ?, ?, ?, ? ,?)";
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getMod_date());
			pstmt.setString(3, dto.getStart_date());
			pstmt.setString(4, dto.getEnd_date());
			pstmt.setString(5, dto.getContent());
			pstmt.setLong(6, dto.getChallengeId());
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	} 
}
