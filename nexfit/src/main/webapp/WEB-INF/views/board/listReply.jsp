<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-0">
<div class="row gx-2">
	
	<div class="col-sm-12">
		<div class='reply-info'>
			<span class='reply-count'>댓글 ${replyCount}개</span>
			<span>[목록, ${pageNo}/${total_page} 페이지]</span>
		</div>
		
		<table class='table table-borderless reply-list'>
			<c:forEach var="dto" items="${listReply}"> 
				<tr class='list-header' style="background: black; color: white;">
					<td width='50%'>
						<span class='bold' style="float: left;">${dto.nickname}</span> 
					</td>  
					<td width='50%' align='right'>
						<span>${dto.reg_date}</span> |
						
						<c:choose>
							<c:when test="${sessionScope.member.userId == dto.userId || sessionScope.member.userId == 'admin'}">
								<span class='deleteReply' data-replyNum='${dto.replyNum}' data-pageNo='${pageNo}'>삭제</span>
							</c:when>
							<c:otherwise>
							<span class='notifyReply'>신고</span>
							</c:otherwise>
						</c:choose>
							
					</td>
				</tr>
				<tr>
					<td colspan='2' valign='top' style="text-align: left;">${dto.content}</td>
				</tr>
		
				<tr>
					<td colspan='2' align="left">
						<button type='button' class='btn btn-light btnReplyAnswerLayout' data-replyNum='${dto.replyNum}'>답글 <span id="answerCount${dto.replyNum}">${dto.answerCount}</span></button>
					</td>
				</tr>
			
			    <tr class='reply-answer'>
			        <td colspan='2'>
			            <div id='listReplyAnswer${dto.replyNum}' class='answer-list'></div>
			            <div class="answer-form">
			                <div class='answer-left'>└</div>
			                <div class='answer-right' style="width: 500px;"><textarea class='form-control'></textarea></div>
			            </div>
			             <div class='answer-footer'>
			                <button type='button' class='btn btn-light btnSendReplyAnswer' data-replyNum='${dto.replyNum}'>답글 등록</button>
			            </div>
					</td>
			    </tr>
			  </c:forEach>
		
		</table>
	</div>
</div>
</div>

<div class="page-navigation">
	${paging}
</div>							
