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
				<div class="row py-5" style="font-family: nexon lv2 medium;">
					<div class="col">
						<h1 class="fs-1 text-start">
							<i class="bi bi-award-fill"></i>Chellenge
						</h1>
					</div>
				</div>
				
				
		<div class="row gx-2">
				<jsp:include page="/WEB-INF/views/chellenge/ch_leftbar.jsp"></jsp:include> <%-- 왼쪽사이드바 --%>
				
						<div class="col-sm-7"> <%-- 메인공간 --%>
						<div class="body-title">
						<h3> 등록된 챌린지 </h3>
						</div>  
						<div class="body-main">
		        <div class="row list-header">
		            <div class="col-auto me-auto">
		            	<p class="form-control-plaintext">
		            		${dataCount}개(${page}/${total_page} 페이지)
		            	</p>
		            </div>
		            <div class="col-auto">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/chellenge/write';">챌린지 등록</button>
					</div>
		        </div>				
				
				 <div class="row row-cols-4 px-1 py-1 g-2">
				 	<c:forEach var="dto" items="${list}" varStatus="status">
				 		<div>
				 			<div class="col border rounded p-1 item"
				 				onclick="location.href='${articleUrl}&num=${dto.num}';">
				 				<img src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}">
				 				<p class="item-title">${dto.subject}</p>
				 			</div>
				 		</div>
				 	</c:forEach>
				 </div>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging }
				</div>

			</div>
						</div>
						<div class="col-sm-2"><%-- 우측공간 --%>
						
						</div>
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