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
			sql = "INSERT INTO certifiedboard(certifiednum, applnumber, subject, reg_date, content, acceptance ,imgfilename) "
					+ " VALUES(certifiedboard_seq.NEXTVAL, ?, ?, SYSDATE, ?, 0 ,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, dto.getApplNumber());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getImageFilename());
			
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
			sql = "SELECT certifiednum, c.subject, c.content,imgfilename,acceptance,f.applnumber, "
					+ " TO_CHAR(c.reg_date, 'YYYY-MM-DD') reg_date ,m.userid, nickname "
					+ " FROM certifiedboard c "
					+ " JOIN ch_applform f ON f.applnumber = c.applnumber "
					+ " JOIN member m ON f.userid = m.userid"
					+ " JOIN member_detail d ON m.userid = d.userid"
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
				dto.setImageFilename(rs.getString("imgfilename"));
				dto.setAcceptance(rs.getInt("acceptance"));
				dto.setApplNumber(rs.getLong("applnumber"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setUserId(rs.getString("userid"));
				dto.setNickname(rs.getString("nickname"));
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
	
	public CertifiedBoardDTO findById(long num) {
		CertifiedBoardDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT certifiednum, c.subject, c.content,imgfilename,acceptance,f.applnumber, "
					+ " TO_CHAR(c.reg_date, 'YYYY-MM-DD') reg_date, m.userid,nickname "
					+ " FROM certifiedboard c "
					+ " JOIN ch_applform f ON f.applnumber = c.applnumber "
					+ " JOIN member m ON f.userid = m.userid"
					+ " JOIN member_detail d ON m.userid = d.userid"
					+ " WHERE certifiednum  = ? ";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new CertifiedBoardDTO();
				
				dto.setCertifiedNum(rs.getLong("certifiednum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setImageFilename(rs.getString("imagefilename"));
				dto.setAcceptance(rs.getInt("acceptance"));
				dto.setApplNumber(rs.getLong("applnumber"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setUserId(rs.getString("userid"));
				dto.setNickname(rs.getString("nickname"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return dto;
	}
	
	public void updatePhoto(CertifiedBoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE certifiedboard SET subject=?, content=?, imgFilename= ? "
					+ " WHERE certifiednum = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getImageFilename());
			pstmt.setLong(4, dto.getCertifiedNum());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void deletePhoto(long num) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "DELETE FROM certifiedboard WHERE certifiednum = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}	
}
