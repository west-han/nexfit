<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>

		<main>
			<div class="container-xxl text-center">
				<div class="row py-5 " style="margin-top: 100px;">
					<div class="col">
						<h1 class="fs-1 text-start" style="font-family: nexon lv2 medium; font-size: 24px; letter-spacing: 10px;">
							커뮤니티 활동
						</h1>
					</div>
				</div>
				
					<div class="row gx-2">
						<div class="col-sm-2 mt-5" style="font-family: nexon lv2 medium; ">
			<ol class="list-group list-group" style="width:250px;height: 100px; position: fixed;">
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto ">
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/mypage/mypage">프로필</a></div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start" > 
				    <div class="ms-2 me-auto">
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/mypage/account">계정관리</a></div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start" style="background: aqua;">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/mypage/community"  style="color: white;">커뮤니티 활동</a></div>
				    </div>
				  </li>
				  
			</ol>
						
						</div>
						
						<div class="col-sm-6" style="margin-left:50px;">
							<div style=" border: 1px solid #dedede; width: 800px; height: 700px; border-radius: 20px; padding: 30px;">
								<div style="display: flex;">
								<div style="border: 1px solid red; width: 100px; height: 100px ;border-radius: 50px; float: left"></div>
								<ul style="list-style: none; float: left;">
									<li>${sessionScope.member.nickname}</li>
									<li>작성수 <i class="bi bi-file-earmark-text"></i>${count}
								댓글수 <i class="bi bi-chat-right-text"></i>${rpl_count}</li>
								</ul>
								</div>
								
								<div>
							<div><a href="${pageContext.request.contextPath}/mypage/community">내가 쓴 게시글</a>
							<div><a href="${pageContext.request.contextPath}/mypage/replylist">내가 쓴 댓글</a></div>
							  <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            
				        </div>
						<form action="writeForm" method="post">
							<table class="table table-hover board-list">
								<thead class="table-light">
								
							<tr>
								<th class="board_name"style="width: 100px;">게시판</th> 
								<th class="content" style="width: 400px;">댓글</th>
								<th class="date">작성일</th>
							</tr>
							
							</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td id="board_name">${dto.board_name}</td>
								<td class="left">
									<a href="${pageContext.request.contextPath}/board/article?num=${dto.num}&page=${page}" class="text-reset">${dto.content}</a>
								</td>
								<td>${dto.reg_date}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
										<div>
										</div>
									</form>
									
						
								
								
								
							</div>
							</div>
							</div>
							
							</div>
						
							</div>
							<div class="page-navigation">
							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
						</div> 
						</div>
						<div class="col-sm-3"></div>
					
			</main>
			
			</div>
		
	<div style="width: 100%; height: 200px;"></div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>