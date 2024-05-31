<%@ page contentType="text/html; charset=UTF-8" %>
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

</head>

<body>
<div class="container-fluid px-0">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
	</header>
	<main>
		<div class="container-xxl text-center">
			<div class="row py-5 mt-5">
				<div class="col">
					<img src="/nexfit/resources/images/freelounge.png" style="width:450px; height:90px;">
				</div>
			</div>
						
	<div class="row gx-2">
		<div class="col-sm-3 mt-5">
			<h3>CATEGORY</h3>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
			  <label class="btn btn-outline-dark" for="btnradio1">전체</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio2">잡담</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio3">건강</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio4">축구</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio5">야구</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio6">농구</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio7" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio7">배구</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio8" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio8">기타종목</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio9" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio9">동물</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio10" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio10">식단</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio11" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio11">게임</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio12" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio12">영화</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio13" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio13">문학</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio14" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio14">유머</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio15" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio15">연애</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio16" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio16">여행</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio17" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio17">음악</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio18" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio18">취업</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio19" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio19">재테크</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio20" autocomplete="off">
			  <label class="btn btn-outline-dark" for="btnradio20">IT</label>
			</div>
	</div>
	
	
	<div class="col-sm-6">
		<main>
			<div class="container">
				<div class="body-container">	
					<div class="body-title">
						<h3>자유 게시판</h3>
					</div>
					<form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/board/list" method="post" >
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
							<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 400px;">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
						</div>
					</form>
					<br>
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            <div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/write';">글쓰기</button></div>
				        </div> 
				     				
						<table class="table table-hover board-list">
							<thead class="table-light">
								<tr>
									<th class="num">번호</th>
									<th class="categoryName">제목</th>
									<th class="name">작성자</th>
									<th class="date">작성일</th>
									<th class="hit">조회수</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr>
										<td>${dataCount - (page-1) * size - status.index}</td>
										<td class="left">
									
											<a href="${articleUrl}&num=${dto.num}" class="text-reset">
											<span style="color: orange;">[${dto.categoryName}]</span> ${dto.subject}
											 </a> 
										
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
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/list';" style="float: left;"><i class="bi bi-arrow-clockwise"></i></button>
							</div>
							
						</div>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-3">여기에는 우측 공간에 들어갈 거 작성</div>
				
		</div>
	
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