﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>
</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>
				<main>
					<div class="container-xxl text-center">
						<div class="row py-5">
							<div class="col">
								<img src="/nexfit/resources/images/ROUTINE.png" style="width:450px; height:90px; margin-top: 76px;">
							</div>
						</div>
						
<c:forEach var="i" begin="0" end="0">
	<div class="row gx-2">
	<div class="col-sm-2">여기에는 좌측 공간에 들어갈 거 작성</div>
	<div class="col-sm-7">
		<main>
			<div class="container">
				<div class="body-container">	
					<div class="body-title">
						<h3>ROUTINE</h3>
					</div>
					<form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/routine/list" method="post" >
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
								<option value="nickname" ${schType=="nickname"?"selected":""}>작성자</option>
								<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
								<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
								<option value="content" ${schType=="content"?"selected":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 500px;">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
						</div>
					</form>
					<br>
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            <div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/routine/write';">글쓰기</button></div>
				        </div> 
				     				
						<table class="table table-hover board-list">
							<thead class="table-light">
								<tr>
									<th class="num">번호</th>
									<th class="type">유형</th>
									<th class="Sports">운동</th>
									<th class="subject">제목</th>
									<th class="name">작성자</th>
									<th class="date">작성일</th>
									<th class="hit">조회수</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${listNotice}">
								<tr>
									
									<td><span class="badge bg-primary">공지</span></td>
									<td class="left">
										<span class="d-inline-block text-truncate align-middle" style="max-width: 390px;"><a href="${articleUrl}&num=${dto.num}" class="text-reset">${dto.subject}</a></span>
									</td>
									<td>${dto.userName}</td>
									<td>${dto.reg_date}</td>
									<td>${dto.hitCount}</td>
								</tr>
							</c:forEach>
							
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr>
										<td>${dataCount - (page-1) * size - status.index}</td>
										<td>${dto.postType == 1? "추천" : "질문"}</td>
										<td>
											<c:choose>
												<c:when test="${dto.sports == 1}">헬스</c:when>
												<c:when test="${dto.sports == 2}">수영</c:when>
												<c:when test="${dto.sports == 3}">클라이밍</c:when>
												<c:when test="${dto.sports == 4}">배구</c:when>
												<c:when test="${dto.sports == 5}">킥복싱</c:when>
												<c:when test="${dto.sports == 6}">기타</c:when>
											</c:choose>
										</td>
										<td class="left">
											<a href="${articleUrl}&num=${dto.num}" class="text-reset">${dto.subject}</a>
										</td>
										<td>${dto.nickname}</td>
										<td>${dto.reg_date}</td>
										<td>${dto.hitCount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<div class="page-navigation">
							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
						</div>
						<br>
						<div class="row board-list-footer">
							<div class="col">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/routineBoard/list';" style="float: left;"><i class="bi bi-arrow-clockwise"></i></button>
							</div>
							
						</div>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-3">여기에는 우측 공간에 들어갈 거 작성</div>
				
		</div>
		
	</c:forEach>
			</div>
		</main>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>