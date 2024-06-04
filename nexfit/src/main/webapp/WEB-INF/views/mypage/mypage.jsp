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
				<div class="row py-5 " style="margin-top: 100px;">
					<div class="col">
						<h1 class="fs-1 text-start" style="font-family: nexon lv2 medium; font-size: 24px; letter-spacing: 10px;">
							내정보
						</h1>
					</div>
				</div>
				
					<div class="row gx-2">
						<div class="col-sm-2 mt-5" style="font-family: nexon lv2 medium; ">
			<ol class="list-group list-group" style="width:250px;height: 100px; position: fixed;">
				  <li class="list-group-item d-flex justify-content-between align-items-start" style="background: aqua;">
				    <div class="ms-2 me-auto ">
				      <div class="fw-bold" style="color: white;">프로필</div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/mypage/account">계정관리</a></div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/mypage/community">커뮤니티 활동</a></div>
				    </div>
				  </li>
				  
			</ol>
						
						</div>
						<div class="col-sm-6" style="margin-left:50px;">
							<div style=" border: 1px solid #dedede; width: 800px; height: 500px; border-radius: 20px; padding: 30px;">
								<div style="display: flex;">
								<div style="border: 1px solid red; width: 100px; height: 100px ;border-radius: 50px; float: left"></div>
								<ul style="list-style: none; float: left;">
									<li>${sessionScope.member.nickname}</li>
									<li>한 줄 소개를 입력하세요</li>
								</ul>
								</div>
								<div class="pointAbount" style="border: 1px solid blue; width: 250px; height:100px; margin-top: 10px; ">
								
								</div>
								<div style="float: left;">
								<div class="signedup">
								<p>NEXFIT 가입 날짜 : ${sessionScope.member.reg_date}</p>
								</div> 
								
								<div class="wrote">
								<p>작성수 <i class="bi bi-file-earmark-text"></i>${count}
								댓글수 <i class="bi bi-chat-right-text"></i>${rpl_count}개</p>
								</div>
								</div>
							</div>
							
							</div>
							
						</div>
						<div class="col-sm-3"></div>
					</div>
			</main>
			<div style="width: 100%; height: 200px;"></div>
			</div>
		
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>