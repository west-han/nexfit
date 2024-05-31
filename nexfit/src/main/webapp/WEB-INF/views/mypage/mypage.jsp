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
							내정보
						</h1>
					</div>
				</div>
				
					<div class="row gx-2">
						<div class="col-sm-2 mt-5" style="font-family: nexon lv2 medium; ">
			<ol class="list-group list-group" style="width:200px; position: fixed;">
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto ">
				      <div class="fw-bold" >프로필</div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold">계정관리</div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold">커뮤니티 활동</div>
				    </div>
				  </li>
				  
			</ol>
						
						</div>
						<div class="col-sm-6">
							<div class="myMain" style="border:1px solid black; width: ">
							
							</div>
							
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