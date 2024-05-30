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
				<div class="row py-5">
					<div class="col">
						<h1 class="fs-1 text-start">
							화면 타이틀
						</h1>
					</div>
				</div>
				
				<c:forEach var="i" begin="0" end="1">
					<div class="row gx-2">
						<div class="col-sm-3">여기에는 좌측 공간에 들어갈 거 작성</div>
						<div class="col-sm-6">여기에 메인 컨텐츠 작성</div>
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