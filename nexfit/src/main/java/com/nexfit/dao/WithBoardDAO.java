package com.nexfit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.nexfit.domain.WithBoardDTO;
import com.nexfit.util.DBConn;
import com.nexfit.util.DBUtil;

public class WithBoardDAO {
	private Connection conn = DBConn.getConnection();
	
		// 데이터 추가
		public void insertBoard(WithBoardDTO dto) throws SQLException {
		PreparedStatement pstmt = null;
			String sql;

			try {
				sql = "INSERT INTO withBoard(num, userId, subject, content, x, y, hitCount, reg_date) "
							+ " VALUES (withBoard_seq.NEXTVAL, ?, ?, ?, ?, ?, 0, SYSDATE)";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, dto.getUserId());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());
				pstmt.setDouble(4, dto.getX());
				pstmt.setDouble(5, dto.getY());
				
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
				sql = "SELECT NVL(COUNT(*), 0) FROM withboard";
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
						+ " FROM withBoard w "
						+ " JOIN member_detail m ON w.userId = m.userId ";
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
				public List<WithBoardDTO> listBoard(int offset, int size) {
				    List<WithBoardDTO> list = new ArrayList<WithBoardDTO>();
				    PreparedStatement pstmt = null;
				    ResultSet rs = null;
				    StringBuilder sb = new StringBuilder();

				    try {
				        sb.append("SELECT w.num, nickname, subject, content, x, y, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
				        sb.append("(SELECT COUNT(*) FROM withBoard_Reply r WHERE r.num = w.num) AS replyCount ");
				        sb.append("FROM withboard w ");
				        sb.append("JOIN member_detail m ON m.userId = w.userId ");
				        sb.append("ORDER BY w.num DESC ");
				        sb.append("OFFSET ? ROWS FETCH FIRST ? ROWS ONLY ");

				        pstmt = conn.prepareStatement(sb.toString());
				        pstmt.setInt(1, offset);
				        pstmt.setInt(2, size);

				        rs = pstmt.executeQuery();
				        while (rs.next()) {
				            WithBoardDTO dto = new WithBoardDTO();

				            dto.setNum(rs.getLong("num"));
				            dto.setNickname(rs.getString("nickname"));
				            dto.setSubject(rs.getString("subject"));
				            dto.setX(rs.getDouble("x"));
				            dto.setY(rs.getDouble("y"));
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
				public List<WithBoardDTO> listBoard(int offset, int size, String schType, String kwd) {
				    List<WithBoardDTO> list = new ArrayList<WithBoardDTO>();
				    PreparedStatement pstmt = null;
				    ResultSet rs = null;
				    StringBuilder sb = new StringBuilder();

				    try {
				        sb.append("SELECT w.num, nickname, subject, content, x, y, hitCount, TO_CHAR(reg_date, 'YYYY-MM-DD') reg_date, ");
				        sb.append("(SELECT COUNT(*) FROM qnaBoard_reply r WHERE r.num = w.num) AS replyCount ");
				        sb.append("FROM withBoard w ");
				        sb.append("JOIN member_detail m ON m.userId = w.userId ");
				        
				        if (schType.equals("all")) {
				            sb.append("WHERE INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 OR INSTR(x, ?) >= 1 OR INSTR(y, ?) >= 1 ");
				        } else if (schType.equals("reg_date")) {
				            kwd = kwd.replaceAll("(\\-|\\/|\\.)", "");
				            sb.append("WHERE TO_CHAR(reg_date, 'YYYYMMDD') = ?");
				        } else {
				            sb.append("WHERE INSTR(" + schType + ", ?) >= 1 ");
				        }
				        sb.append("ORDER BY w.num DESC ");
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
				            WithBoardDTO dto = new WithBoardDTO();

				            dto.setNum(rs.getLong("num"));
				            dto.setNickname(rs.getString("nickname"));
				            dto.setSubject(rs.getString("subject"));
				            dto.setHitCount(rs.getInt("hitCount"));
				            dto.setX(rs.getDouble("x"));
				            dto.setY(rs.getDouble("y"));
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
						sql = "UPDATE withBoard SET hitCount=hitCount+1 WHERE num=?";
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
				public WithBoardDTO findById(long num) {
					WithBoardDTO dto = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql;

					try {
						sql = "SELECT w.num, w.userId, nickname, subject, content, x, y, reg_date, hitCount "
								+ " FROM withboard w "
								+ " JOIN member_detail m ON w.userId = m.userId "
								+ " WHERE w.num = ? ";
						pstmt = conn.prepareStatement(sql);
						
						pstmt.setLong(1, num);

						rs = pstmt.executeQuery();

						if (rs.next()) {
							dto = new WithBoardDTO();
							
							dto.setNum(rs.getLong("num"));
							dto.setUserId(rs.getString("userId"));
							dto.setNickname(rs.getString("nickname"));
							dto.setSubject(rs.getString("subject"));
							dto.setContent(rs.getString("content"));
							dto.setX(rs.getDouble("x"));
							dto.setY(rs.getDouble("y"));
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
				public WithBoardDTO findByPrev(long num, String schType, String kwd) {
					WithBoardDTO dto = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					StringBuilder sb = new StringBuilder();

					try {
						if (kwd != null && kwd.length() != 0) {
							sb.append(" SELECT num, subject ");
							sb.append(" FROM withboard w ");
							sb.append(" JOIN member_detail m ON w.userId = m.userId ");
							sb.append(" WHERE ( num > ? ) ");
							if (schType.equals("all")) {
								sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 OR INSTR(x, ?) >= 1 OR INSTR(y, ?) >= 1 ) ");
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
							sb.append(" FROM withboard ");
							sb.append(" WHERE num > ? ");
							sb.append(" ORDER BY num ASC ");
							sb.append(" FETCH FIRST 1 ROWS ONLY ");

							pstmt = conn.prepareStatement(sb.toString());
							
							pstmt.setLong(1, num);
						}

						rs = pstmt.executeQuery();

						if (rs.next()) {
							dto = new WithBoardDTO();
							
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
				public WithBoardDTO findByNext(long num, String schType, String kwd) {
					WithBoardDTO dto = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					StringBuilder sb = new StringBuilder();

					try {
						if (kwd != null && kwd.length() != 0) {
							sb.append(" SELECT num, subject ");
							sb.append(" FROM withboard w ");
							sb.append(" JOIN member_detail m ON w.userId = m.userId ");
							sb.append(" WHERE ( num < ? ) ");
							if (schType.equals("all")) {
								sb.append("   AND ( INSTR(subject, ?) >= 1 OR INSTR(content, ?) >= 1 OR INSTR(x, ?) >= 1 OR INSTR(y, ?) >= 1 ) ");
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
							sb.append(" FROM withboard ");
							sb.append(" WHERE num < ? ");
							sb.append(" ORDER BY num DESC ");
							sb.append(" FETCH FIRST 1 ROWS ONLY ");

							pstmt = conn.prepareStatement(sb.toString());
							
							pstmt.setLong(1, num);
						}

						rs = pstmt.executeQuery();

						if (rs.next()) {
							dto = new WithBoardDTO();
							
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
				public void updateBoard(WithBoardDTO dto) throws SQLException {
					PreparedStatement pstmt = null;
					String sql;

					try {
						sql = "UPDATE withboard SET subject=?, content=?, x=?, y=? WHERE num=? AND userId=?";
						pstmt = conn.prepareStatement(sql);
					
						pstmt.setString(1, dto.getSubject());
						pstmt.setString(2, dto.getContent());
						// pstmt.setDouble(3, dto.getX());
						// pstmt.setDouble(4, dto.getY());
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
							sql = "DELETE FROM withboard WHERE num=?";
							pstmt = conn.prepareStatement(sql);
							
							pstmt.setLong(1, num);
							
							pstmt.executeUpdate();
						} else {
							sql = "DELETE FROM withboard WHERE num=? AND userId=?";
							
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

}
