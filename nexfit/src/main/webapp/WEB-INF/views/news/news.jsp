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
							News
						</h1>
					</div>
				</div>
				
				<c:forEach var="i" begin="0" end="5"> <!-- 컬럼 중앙에 배치하려면 카드 크기 말고 열의 크기를 제어 -->
					<div class="row row-cols-3 g-3 justify-content-center">
						<div class="col justify-content-center">
							<div class="card w-75">
								<img src="${pageContext.request.contextPath}/resources/images/noimage.png" class="card-img-top" alt="기사 사진">
								<div class="card-body">
									<h5 class="card-title">Card title</h5>
									<p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
								</div>
							</div>
						</div>
						<div class="col justify-content-center">
							<div class="card">
								<img src="${pageContext.request.contextPath}/resources/images/noimage.png" class="card-img-top" alt="기사 사진">
								<div class="card-body">
									<h5 class="card-title">Card title</h5>
									<p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
								</div>
							</div>						
						</div>
						<div class="col justify-content-center">
							<div class="card">
								<img src="${pageContext.request.contextPath}/resources/images/noimage.png" class="card-img-top" alt="기사 사진">
								<div class="card-body">
									<h5 class="card-title">Card title</h5>
									<p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
								</div>
							</div>						
						</div>
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