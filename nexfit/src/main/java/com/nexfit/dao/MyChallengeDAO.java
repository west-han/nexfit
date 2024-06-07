package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.MyChallengeDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class MyChallengeDAO {
	private Connection conn = DBConn.getConnection();
	
	public int dataCount(String userid) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT COUNT(*) FROM ch_applform WHERE userid=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
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
	
	public List<MyChallengeDTO> listMyChallenge(int offset, int size, String userid){
		List<MyChallengeDTO> list = new ArrayList<MyChallengeDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql="SELECT b.subject AS board_subject, appl_score, appl_state, ch_subeject,applnumber "
					+ " TO_CHAR(appl_date, 'YYYY-MM-DD') appl_date,"
					+ " TO_CHAR(compl_date, 'YYYY-MM-DD') compl_date, "
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') start_date,"
					+ " TO_CHAR(start_date, 'YYYY-MM-DD') end_date,"
					+ " FROM ch_applform a"
					+ " JOIN challengeboard b ON a.boardnumber = b.boardnumber"
					+ " JOIN challenge c ON b.challengeid = c.challengeid"
					+ " WHERE userid = ??"
					+ " ORDER BY applnumber DESC "
				    + " OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";;
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, userid);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MyChallengeDTO dto = new MyChallengeDTO();

				dto.setBoard_subject(rs.getString("board_subject"));
				dto.setAppl_score(rs.getInt("appl_score"));
				dto.setAppl_state(rs.getString("appl_state"));
				dto.setAppl_date(rs.getString("appl_date"));
				dto.setCompl_date(rs.getString("compl_date"));
				dto.setStart_date(rs.getString("start_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setApplnumber(rs.getLong("applnumber"));
				
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
	
	public void updateApplscore(int count,long applnumber) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE ch_applform SET appl_score=? WHERE applnumber=?";
			
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setLong(2, applnumber);
			
			pstmt.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public int countAcceptance (long applnumber) {
		int count =0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "SELECT COUNT(*) FROM certifiedboard WHERE applnumber=? AND acceptance=1";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, applnumber);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
		
		return count;
	}
}
