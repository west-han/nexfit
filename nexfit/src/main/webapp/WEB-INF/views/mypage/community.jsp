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
				      <div class="fw-bold" style="color: white;">커뮤니티 활동</div>
				    </div>
				  </li>
				  
			</ol>
						
						</div>
						<div class="col-sm-6" style="margin-left:50px;">
							<div style=" border: 1px solid #dedede; width: 800px; height: 300px; border-radius: 20px; padding: 30px;">
								<div style="border: 1px solid red; width: 100px; height: 100px ;border-radius: 50px; float: left"></div>
								<ul style="list-style: none; float: left;">
									<li>닉네임</li>
									<li>한 줄 소개를 입력하세요</li>
								</ul>
								 
							</div>
							
							</div>
							
						</div>
						<div class="col-sm-3"></div>
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