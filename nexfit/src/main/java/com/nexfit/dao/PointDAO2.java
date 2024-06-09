package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.Point;
import com.nexfit.domain.PointDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class PointDAO2 {
	Connection conn = DBConn.getConnection();
	
	public PointDTO findById(String userId) {
		String sql;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PointDTO dto = new PointDTO();
		
		try {
			sql = "SELECT pointNum, reg_date, description, pointVar, currentPoint FROM point "
					+ "WHERE userId = ? "
					+ "ORDER BY pointNum DESC "
					+ "FETCH FIRST 1 ROWS ONLY";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setPointNum(rs.getLong("pointNum"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setDescription(rs.getString("description"));
				dto.setPorintVar(rs.getLong("pointVar"));
				dto.setCurrentPoint(rs.getLong("currentPoint"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}

		return dto;
	}
	
	public void updatePoint(String userId, Point point) {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			sql = "INSERT INTO point (pointNum, reg_date, description, pointVar, currentPoint, userId) "
					+ "VALUES(point_seq.NEXTVAL, SYSDATE, ?, ?, ?, ?) ";
			
			long currentPoint = findById(userId).getCurrentPoint();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, point.getDescription());
			pstmt.setLong(2, point.getValue());
			pstmt.setLong(3, currentPoint + point.getValue());
			pstmt.setString(4, userId);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public void updatePointforCh(String userId, int point) {
		String sql;
		PreparedStatement pstmt = null;
		
		try {
			sql = "INSERT INTO point (pointNum, reg_date, description, pointVar, currentPoint, userId) "
					+ "VALUES(point_seq.NEXTVAL, SYSDATE, ?, ?, ?, ?) ";
			
			long currentPoint = findById(userId).getCurrentPoint();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "챌린지성공");
			pstmt.setLong(2, point);
			pstmt.setLong(3, currentPoint + point);
			pstmt.setString(4, userId);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt);
		}
	}
	
	public List<PointDTO> listPoints(String userId, int offset, int size) {
		List<PointDTO> list = new ArrayList<PointDTO>();
		String sql;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "SELECT * FROM point WHERE userId = ? ORDER BY reg_date DESC "
					+ "OFFSET ? FETCH FIRST ? ROWS ONLY";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, offset);
			pstmt.setInt(3, size);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				PointDTO dto = new PointDTO();
				dto.setPointNum(rs.getLong("pointNum"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setDescription(rs.getString("description"));
				dto.setPorintVar(rs.getLong("pointVar"));
				dto.setCurrentPoint(rs.getLong("currentPoint"));
				list.add(dto);
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
