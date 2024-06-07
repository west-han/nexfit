package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.Ch_applFormDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class Ch_applFormDAO {
	private Connection conn = DBConn.getConnection();
	
	public void insertApplForm(Ch_applFormDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			
			sql = "INSERT INTO ch_applform(APPLNUMBER, APPL_DATE, APPL_STATE, COMENT, BOARDNUMBER, USERID,APPL_SCORE)"
					+" VALUES (ch_applform_seq.NEXTVAL, SYSDATE, '진행중', ?, ?, ? ,0)";
			
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getComent());
			pstmt.setLong(2, dto.getBoardNumber());
			pstmt.setString(3, dto.getUserId());;
			
			
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
		}
	}
	
	//신청중복 막기위해 신청한횟수 카운트
	public int CountApplForm(long num, String userid) throws SQLException {
		int count=0;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		try {
			sql = "SELECT COUNT(*) FROM ("
					+" SELECT c.userid,coment,appl_state,applnumber, TO_CHAR(compl_date, 'YYYY-MM-DD') compl_date,"
					+" appl_score, TO_CHAR(appl_date, 'YYYY-MM-DD') appl_date,ch_subject,ch.fee,subject,nickname"
					+" FROM ch_applform c"
					+" JOIN challengeboard b ON c.boardnumber=b.boardnumber"
					+" JOIN challenge ch ON b.challengeid =ch.challengeid"
					+" JOIN member m ON c.userid = m.userid"
					+" JOIN member_detail t ON m.userid = t.userid"
					+" where c.boardnumber= ? AND c.userid = ? "
					+" ORDER BY applnumber DESC )";
					
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			pstmt.setString(2, userid);
			
			rs=pstmt.executeQuery();
			
			 if (rs.next()) {
		            count = rs.getInt(1); 
		        }
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
			DBUtil.close(rs);
		}
		
		return count;
	}
	
	public List<Ch_applFormDTO> findApplFormByNum(long num) throws SQLException {
		List<Ch_applFormDTO> list = new ArrayList<Ch_applFormDTO>();
		
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		try {
			sql = 
					"SELECT *FROM ( "
					+"SELECT c.userid,coment,appl_state,applnumber, TO_CHAR(compl_date, 'YYYY-MM-DD') compl_date,"
					+" appl_score, TO_CHAR(appl_date, 'YYYY-MM-DD') appl_date,ch_subject,ch.fee,subject,nickname"
					+" FROM ch_applform c"
					+" JOIN challengeboard b ON c.boardnumber=b.boardnumber"
					+" JOIN challenge ch ON b.challengeid =ch.challengeid"
					+" JOIN member m ON c.userid = m.userid"
					+" JOIN member_detail t ON m.userid = t.userid"
					+" where c.boardnumber= ?"
					+" ORDER BY applnumber DESC)"
					+" WHERE ROWNUM <= 20";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Ch_applFormDTO dto = new Ch_applFormDTO();
				
				dto.setUserId(rs.getString("userid"));
				dto.setNickname(rs.getString("nickname"));
				dto.setComent(rs.getString("coment"));
				dto.setCompl_Date(rs.getString("compl_date"));
				dto.setAppl_Score(rs.getInt("appl_score"));
				dto.setAppl_date(rs.getString("appl_date"));
				dto.setCh_subject(rs.getString("ch_subject"));
				dto.setFee("fee");
				dto.setSubject("subject");
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			DBUtil.close(pstmt);
			DBUtil.close(rs);
		}
		
		return list;
	}
	
	
	public List<Ch_applFormDTO> findApplFormByuserId(String userid) throws SQLException {
	    List<Ch_applFormDTO> list = new ArrayList<Ch_applFormDTO>();
	    
	    PreparedStatement pstmt = null;
	    String sql;
	    ResultSet rs = null;
	    try {
	        sql =    " SELECT c.userid,coment,appl_state,applnumber, TO_CHAR(compl_date, 'YYYY-MM-DD') compl_date, applnumber"
	                +" appl_score, TO_CHAR(appl_date, 'YYYY-MM-DD') appl_date,ch_subject,ch.fee,b.subject,nickname,ch.ch_content,b.content"
	                +" FROM ch_applform c"
	                +" JOIN challengeboard b ON c.boardnumber=b.boardnumber"
	                +" JOIN challenge ch ON b.challengeid =ch.challengeid"
	                +" JOIN member m ON c.userid = m.userid"
	                +" JOIN member_detail t ON m.userid = t.userid"
	                +" where m.userid= ?";
	        
	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setString(1, userid);
	        
	        rs=pstmt.executeQuery();
	        
	        while(rs.next()) {
	            Ch_applFormDTO dto = new Ch_applFormDTO();
	            
	            
	            dto.setUserId(rs.getString("userid"));
	            dto.setNickname(rs.getString("nickname"));
	            dto.setComent(rs.getString("coment"));
	            dto.setCompl_Date(rs.getString("compl_date"));
	            dto.setAppl_Score(rs.getInt("appl_score"));
	            dto.setAppl_date(rs.getString("appl_date"));
	            dto.setCh_subject(rs.getString("ch_subject"));
	            dto.setFee(rs.getString("fee"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setCh_content(rs.getString("ch_content"));
	            dto.setContent(rs.getString("content"));
	            dto.setApplNumber(rs.getLong("applnumber"));
	            list.add(dto);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }finally {
	        DBUtil.close(pstmt);
	        DBUtil.close(rs);
	    }
	    
	    if (list.isEmpty()) {
	        return null;
	    }
	    
	    return list;
	}
	
	
	public int countappl(long num) throws SQLException {
		int count=0;
		PreparedStatement pstmt = null;
		String sql;
		ResultSet rs = null;
		
		try {
			sql = "SELECT COUNT(*) FROM ch_applform WHERE boardnumber=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setLong(1, num);
			
			rs=pstmt.executeQuery();
			
			 if (rs.next()) {
		            count = rs.getInt(1); 
		        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
		
	}
}
