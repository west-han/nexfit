<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<div class="container-fluid px-0">
	<div class="row gx-2">
		
		<div class="col-sm-12">
			<c:forEach var="dto" items="${listReplyAnswer}">
				<div class='answer-article'>
					<div class='answer-article-header'>
						<div class='answer-left'>└</div>
						<div class='answer-right'>
							<div><span class='bold'>${dto.nickname}</span></div>
							<div>
								<span>${dto.reg_date}</span> |
								<span class='deleteReplyAnswer' data-replyNum='${dto.replyNum}' data-answer='${dto.answer}'>삭제</span>
							</div>
						</div>
					</div>
					<div class='answer-article-body' style="text-align: left;">
						${dto.content}
					</div>
				</div>
			</c:forEach>
		
		</div>
		
	</div>
</div>

</body>
</html>