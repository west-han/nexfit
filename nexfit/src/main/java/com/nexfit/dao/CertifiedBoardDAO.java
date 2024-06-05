package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.CertifiedBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;




public class CertifiedBoardDAO {

	private Connection conn = DBConn.getConnection();
	
	public void insertPhoto(CertifiedBoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "INSERT INTO certifiedboard(certifiednum, applnumber, subject, reg_date, content, acceptance) "
					+ " VALUES(certifiedboard.NEXTVAL, ?, ?, SYSDATE, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getApplNumber());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getAcceptance());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM certifiedboard";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return result;
	}
	
	public List<CertifiedBoardDTO> listCertified(int offset, int size) {
		List<CertifiedBoardDTO> list = new ArrayList<CertifiedBoardDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT certifiednum, subject, content,imagefilename,acceptance,applnumber "
					+ " TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date "
					+ " FROM certifiedboard c "
					+ " JOIN ch_applform f ON f.applnumber = c.applnumber "
					+ " JOIN member m ON f.userid = m.userid"
					+ " ORDER BY certifiednum DESC " 
					+ " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, offset);
			pstmt.setInt(2, size);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CertifiedBoardDTO dto = new CertifiedBoardDTO();
				
				dto.setCertifiedNum(rs.getLong("certifiednum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setImageFilename(rs.getString("imagefilename"));
				dto.setAcceptance(rs.getInt("acceptance"));
				dto.setApplNumber(rs.getLong("applnumber"));
				dto.setReg_date(rs.getString("reg_date"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return list;
	}
}
