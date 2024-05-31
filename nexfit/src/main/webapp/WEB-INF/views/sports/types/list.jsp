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

		<main class="mt-5">
			<div class="container-xxl text-center">
				<div class="row py-5">
					<div class="col">
						<h1 class="fs-1 text-start">
							운동 목록
						</h1>
					</div>
				</div>

				<div class="row gx-2">
					<div class="col">
						<form class="row justify-content-center pb-5" name="searchForm" action="${pageContext.request.contextPath}/sports/type/list" method="post" >
							<div class="col-auto p-0 pb">
								<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 500px;">
							</div>
							<div class="col-auto p-0">
								<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
							</div>
						</form>
						
						<div class="btn-group-lg" role="group" aria-label="Basic radio toggle button group">
							  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
							  <label class="btn btn-outline-primary" for="btnradio1">전체</label>

<%-- 							<c:forEach begin="0" end="10" var="i"> --%>
<%-- 							  <input type="radio" class="btn-check" name="btnradio" id="btnradio${i}" autocomplete="off" checked> --%>
<%-- 							  <label class="btn btn-outline-primary" for="btnradio${i}">전체</label> --%>
<%-- 							</c:forEach> --%>
						</div>
						
						
						
					</div>
				</div>
				
				<c:if test="${sessionScope.member.userId == 'admin'}">
					<div class="row text-end">
						<div class="col">
							<a class="btn btn-primary" href="${pageContext.request.contextPath}/sports/types/write" role="button">추가</a>
						</div>
					</div>
				</c:if>
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