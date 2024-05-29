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
*, *::after, *::before {
	margin: 0;
	padding: 0;
}

.body-container {
	max-width: 800px;	
}

</style>

</head>
<body>
	<div class="container-fluid p-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>
			

			<nav>
				<div>
					<img alt="" src="resources/images/nav_run.jpg" style="height: 700px; width: 100%;">
				</div>
				<div>
					<img alt="" src="resources/images/rec_img.jpg" style="height: 400px; width: 58%;margin:20px 15px 15px 40px;">
				</div>
			</nav>
			<main>
				<div class="body-container">	
					<div class="d-grid" style="font-family: nexon lv2 medium">
						메인 화면 입니다.
					</div>
				</div>
			</main>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/> 
</html>