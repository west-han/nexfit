package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.ChellengeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class ChellengeDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertChellenge(ChellengeDTO dto) throws SQLException{
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO chellenge(chellengeId,ch_subject,ch_content,fee)"
					+" VALUES(chellenge_seq.NEXTVAL, ? , ? , ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCh_subject());
			pstmt.setString(2, dto.getCh_content());
			pstmt.setLong(3, dto.getFee());
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
	
	public List<ChellengeDTO> listChellenge(){
		List<ChellengeDTO> list = new ArrayList<ChellengeDTO>();
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT chellengeId,ch_subject,ch_content,fee"
					+" FROM chellenge"
					+" ORDER BY chellengeId DESC";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ChellengeDTO dto = new ChellengeDTO();
				
				dto.setChellengeId(rs.getLong("chellengeId"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setCh_content(rs.getString("ch_content"));
				dto.setFee(rs.getLong("fee"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
	}
	
		
}
