package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.QnaBoardDTO;
import com.nexfit.domain.ReplyDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class QnaBoardDAO {
	private Connection conn = DBConn.getConnection();
	
		// 데이터 추가
		public void insertBoard(QnaBoardDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "INSERT INTO qnaBoard(num, userId, subject, content, hitCount, reg_date) "
						+ " VALUES (qnaBoard_seq.NEXTVAL, ?, ?, ?, 0, SYSDATE)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getUserId());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());

				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}
		
		
		// 데이터 개수
		public int dataCount() {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT NVL(COUNT(*), 0) FROM qnaBoard";
				pstmt = conn.prepareStatement(sql);

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
		
		
		// 검색에서의 데이터 개수
		public int dataCount(String schType, String kwd) {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT NVL(COUNT(*), 0) "
						+ " FROM qnaBoard q "
						+ " JOIN member_detail m ON q.userId = m.userId ";
				if (schType.equals("all")) {
					sql += "  WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1";
				} else if (schType.equals("reg_date")) {
					kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
					sql += "  WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ? ";
				} else {
					sql += "  WHERE INSTR(" + schType + ", ?) >= 1 ";
				}

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, kwd);
				if (schType.equals("all")) {
					pstmt.setString(2, kwd);
				}

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
		
		
		// 검색 없는 경우 게시물 리스트
		public List<QnaBoardDTO> listBoard(int offset, int size) {
		    List<QnaBoardDTO> list = new ArrayList<QnaBoardDTO>();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    StringBuilder sb = new StringBuilder();

		    try {
		        sb.append("SELECT q.num, nickname, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
		        sb.append("(SELECT COUNT(*) FROM qnaBoard_Reply r WHERE r.num = q.num) AS replyCount ");
		        sb.append("FROM qnaboard q ");
		        sb.append("JOIN member_detail m ON m.userId = q.userId ");
		        sb.append("ORDER BY q.num DESC ");
		        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

		        pstmt = conn.prepareStatement(sb.toString());
		        pstmt.setInt(1, offset);
		        pstmt.setInt(2, size);

		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            QnaBoardDTO dto = new QnaBoardDTO();

		            dto.setNum(rs.getLong("num"));
		            dto.setNickname(rs.getString("nickname"));
		            dto.setSubject(rs.getString("subject"));
		            dto.setHitCount(rs.getInt("hitCount"));
		            dto.setReg_date(rs.getString("reg_date"));
		            dto.setReplyCount(rs.getInt("replyCount"));

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
		
		
		// 검색 있는 경우 게시물 리스트
		public List<QnaBoardDTO> listBoard(int offset, int size, String schType, String kwd) {
		    List<QnaBoardDTO> list = new ArrayList<QnaBoardDTO>();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    StringBuilder sb = new StringBuilder();

		    try {
		        sb.append("SELECT q.num, nickname, subject, content, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
		        sb.append("(SELECT COUNT(*) FROM qnaBoard_reply r WHERE r.num = q.num) AS replyCount ");
		        sb.append("FROM qnaBoard q ");
		        sb.append("JOIN member_detail m ON m.userId = q.userId ");
		        
		        if (schType.equals("all")) {
		            sb.append("WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ");
		        } else if (schType.equals("reg_date")) {
		            kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
		            sb.append("WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ?");
		        } else {
		            sb.append("WHERE INSTR(" + schType + ", ?) >= 1 ");
		        }
		        sb.append("ORDER BY q.num DESC ");
		        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

		        pstmt = conn.prepareStatement(sb.toString());
		        
		        int paramIndex = 1;
		        if (schType.equals("all")) {
		            pstmt.setString(paramIndex++, kwd);
		            pstmt.setString(paramIndex++, kwd);
		        } else {
		            pstmt.setString(paramIndex++, kwd);
		        }
		        pstmt.setInt(paramIndex++, offset);
		        pstmt.setInt(paramIndex, size);

		        

		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		            QnaBoardDTO dto = new QnaBoardDTO();

		            dto.setNum(rs.getLong("num"));
		            dto.setNickname(rs.getString("nickname"));
		            dto.setSubject(rs.getString("subject"));
		            dto.setHitCount(rs.getInt("hitCount"));
		            dto.setReg_date(rs.getString("reg_date"));
		            dto.setReplyCount(rs.getInt("replyCount"));

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
		
		
		// 조회수 증가하기
		public void updateHitCount(long num) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE qnaBoard SET hitCount=hitCount+1 WHERE num=?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}

		}
		
		
		// 해당 게시물 보기
		public QnaBoardDTO findById(long num) {
			QnaBoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {
				sql = "SELECT q.num, q.userId, nickname, subject, content, reg_date, hitCount "
						+ " FROM qnaboard q "
						+ " JOIN member_detail m ON q.userId = m.userId "
						+ " WHERE q.num = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new QnaBoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setUserId(rs.getString("userId"));
					dto.setNickname(rs.getString("nickname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setHitCount(rs.getInt("hitCount"));
					dto.setReg_date(rs.getString("reg_date"));
								
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}

			return dto;
		}
		
		
		// 이전글
		public QnaBoardDTO findByPrev(long num, String schType, String kwd) {
			QnaBoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();

			try {
				if (kwd != null && kwd.length() != 0) {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM qnaboard q ");
					sb.append(" JOIN member_detail m ON q.userId = m.userId ");
					sb.append(" WHERE ( num > ? ) ");
					if (schType.equals("all")) {
						sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
					} else if (schType.equals("reg_date")) {
						kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
						sb.append("   AND ( TO_CHAR(reg_date, 'YYYYMMDD') = ? ) ");
					} else {
						sb.append("   AND ( INSTR(" + schType + ", ?) >= 1 ) ");
					}
					sb.append(" ORDER BY num ASC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setLong(1, num);
					pstmt.setString(2, kwd);
					if (schType.equals("all")) {
						pstmt.setString(3, kwd);
					}
				} else {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM qnaboard ");
					sb.append(" WHERE num > ? ");
					sb.append(" ORDER BY num ASC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setLong(1, num);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new QnaBoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setSubject(rs.getString("subject"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}

			return dto;
		}

		// 다음글
		public QnaBoardDTO findByNext(long num, String schType, String kwd) {
			QnaBoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();

			try {
				if (kwd != null && kwd.length() != 0) {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM qnaboard q ");
					sb.append(" JOIN member_detail m ON q.userId = m.userId ");
					sb.append(" WHERE ( num < ? ) ");
					if (schType.equals("all")) {
						sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 ) ");
					} else if (schType.equals("reg_date")) {
						kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
						sb.append("   AND ( TO_CHAR(reg_date, 'YYYYMMDD') = ? ) ");
					} else {
						sb.append("   AND ( INSTR(" + schType + ", ?) >= 1 ) ");
					}
					sb.append(" ORDER BY num DESC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setLong(1, num);
					pstmt.setString(2, kwd);
					if (schType.equals("all")) {
						pstmt.setString(3, kwd);
					}
				} else {
					sb.append(" SELECT num, subject ");
					sb.append(" FROM qnaboard ");
					sb.append(" WHERE num < ? ");
					sb.append(" ORDER BY num DESC ");
					sb.append(" FETCH FIRST 1 ROWS ONLY ");

					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setLong(1, num);
				}

				rs = pstmt.executeQuery();

				if (rs.next()) {
					dto = new QnaBoardDTO();
					
					dto.setNum(rs.getLong("num"));
					dto.setSubject(rs.getString("subject"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}

			return dto;
		}
		
		
		// 게시물 수정
		public void updateBoard(QnaBoardDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "UPDATE qnaboard SET subject=?, content=? WHERE num=? AND userId=?";
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setLong(3, dto.getNum());
				pstmt.setString(4, dto.getUserId());
				
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}

		}
		
		
		// 게시물 삭제
		public void deleteBoard(long num, String userId) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;
			

			try {
				
				if (userId.equals("admin")) {
					sql = "DELETE FROM qnaboard WHERE num=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, num);
					
					pstmt.executeUpdate();
				} else {
					sql = "DELETE FROM qnaboard WHERE num=? AND userId=?";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, num);
					pstmt.setString(2, userId);
					
					pstmt.executeUpdate();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
		}

		
		// 게시물의 댓글 및 답글 추가
		public void insertReply(ReplyDTO dto) throws SQLException {
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				sql = "INSERT INTO qnaboard_Reply(replyNum, num, userId, content, answer, reg_date) "
						+ " VALUES (qnaboard_Reply_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE)";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, dto.getNum());
				pstmt.setString(2, dto.getUserId());
				pstmt.setString(3, dto.getContent());
				pstmt.setLong(4, dto.getAnswer());
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
				throw e;
			} finally {
				DBUtil.close(pstmt);
			}
			
		}
		
		
		// 게시물의 댓글 개수
		public int dataCountReply(long num) {
			int result = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				sql = "SELECT NVL(COUNT(*), 0) "
						+ " FROM qnaboard_Reply "
						+ " WHERE num = ? AND answer = 0";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, num);
				
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
		
		
		// 게시물 댓글 리스트
		public List<ReplyDTO> listReply(long num, int offset, int size) {
			List<ReplyDTO> list = new ArrayList<>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			StringBuilder sb = new StringBuilder();
			
			try {
				sb.append(" SELECT r.replyNum, r.userId, nickname, num, content, r.reg_date, ");
				sb.append("     NVL(answerCount, 0) answerCount ");
				sb.append(" FROM qnaboard_Reply r ");
				sb.append(" JOIN member m ON r.userId = m.userId ");
				sb.append(" JOIN member_detail d ON d.userId = m.userId ");
				sb.append(" LEFT OUTER  JOIN (");
				sb.append("	    SELECT answer, COUNT(*) answerCount ");
				sb.append("     FROM qnaboard_Reply ");
				sb.append("     WHERE answer != 0 ");
				sb.append("     GROUP BY answer ");
				sb.append(" ) a ON r.replyNum = a.answer ");
				sb.append(" WHERE num = ? AND r.answer=0 ");
				sb.append(" ORDER BY r.replyNum DESC ");
				sb.append(" OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

				
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setLong(1, num);
				pstmt.setInt(2, offset);
				pstmt.setInt(3, size);

				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ReplyDTO dto = new ReplyDTO();
					
					dto.setReplyNum(rs.getLong("replyNum"));
					dto.setNum(rs.getLong("num"));
					dto.setUserId(rs.getString("userId"));
					dto.setNickname(rs.getString("nickname")); 
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getString("reg_date"));
					dto.setAnswerCount(rs.getInt("answerCount"));
					
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

		public ReplyDTO findByReplyId(long replyNum) {
			ReplyDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				sql = "SELECT replyNum, num, r.userId, nickname, content, r.reg_date "
						+ " FROM qnaboard_reply r  "
						+ " JOIN member m ON r.userId = m.userId "
						+ " JOIN member_detail d ON d.userId = m.userId "
						+ " WHERE replyNum = ? ";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setLong(1, replyNum);

				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					dto=new ReplyDTO();
					
					dto.setReplyNum(rs.getLong("replyNum"));
					dto.setNum(rs.getLong("num"));
					dto.setUserId(rs.getString("userId"));
					dto.setNickname(rs.getString("nickname"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getString("reg_date"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				DBUtil.close(rs);
				DBUtil.close(pstmt);
			}
			
			return dto;
		}
		
		
		// 게시물의 댓글 삭제
		public void deleteReply(long replyNum, String userId) throws SQLException {
				PreparedStatement pstmt = null;
				String sql;
				
				if(! userId.equals("admin")) {
					ReplyDTO dto = findByReplyId(replyNum);
					if(dto == null || (! userId.equals(dto.getUserId()))) {
						return;
					}
				}
				
				try {
					sql = "DELETE FROM qnaBoard_Reply "
							+ " WHERE replyNum IN  "
							+ " (SELECT replyNum FROM qnaBoard_Reply START WITH replyNum = ?"
							+ "     CONNECT BY PRIOR replyNum = answer)";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, replyNum);
					
					pstmt.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
					throw e;
				} finally {
					DBUtil.close(pstmt);
				}		
			}
		
		
		// 댓글의 답글 리스트
		public List<ReplyDTO> listReplyAnswer(long answer) {
				List<ReplyDTO> list = new ArrayList<>();
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				StringBuilder sb=new StringBuilder();
				
				try {
					sb.append(" SELECT replyNum, num, r.userId, nickname, content, r.reg_date, answer ");
					sb.append(" FROM qnaboard_Reply r ");
					sb.append(" JOIN member m ON r.userId = m.userId ");
					sb.append(" JOIN member_detail d ON d.userId = m.userId ");
					sb.append(" WHERE answer = ? ");
					sb.append(" ORDER BY replyNum DESC ");
					pstmt = conn.prepareStatement(sb.toString());
					
					pstmt.setLong(1, answer);

					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						ReplyDTO dto=new ReplyDTO();
						
						dto.setReplyNum(rs.getLong("replyNum"));
						dto.setNum(rs.getLong("num"));
						dto.setUserId(rs.getString("userId"));
						dto.setNickname(rs.getString("nickname"));
						dto.setContent(rs.getString("content"));
						dto.setReg_date(rs.getString("reg_date"));
						dto.setAnswer(rs.getLong("answer"));
						
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
		
		
		// 댓글의 답글 개수
		public int dataCountReplyAnswer(long answer) {
				int result = 0; 
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql;
				
				try {
					sql = "SELECT NVL(COUNT(*), 0) "
							+ " FROM qnaBoard_Reply WHERE answer = ?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setLong(1, answer);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						result=rs.getInt(1);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					DBUtil.close(rs);
					DBUtil.close(pstmt);
				}
				
				return result;
			}


		public List<QnaBoardDTO> listRecentQnaBoardPosts(int count) {
		    List<QnaBoardDTO> recentPosts = new ArrayList<>();
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql;

		    try {
		        sql = "SELECT num, subject, reg_date FROM qnaBoard ORDER BY reg_date DESC FETCH FIRST ? ROWS ONLY";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, count);

		        rs = pstmt.executeQuery();

		        // 결과를 QnaBoardDTO 객체에 담아 리스트에 추가
		        while (rs.next()) {
		            QnaBoardDTO post = new QnaBoardDTO();
		            post.setNum(rs.getLong("num"));
		            post.setSubject(rs.getString("subject"));
		            post.setReg_date(rs.getString("reg_date"));
		            recentPosts.add(post);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        DBUtil.close(rs);
		        DBUtil.close(pstmt);
		    }

		    return recentPosts;
		}

}
