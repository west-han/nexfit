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

.table-style {
	border: 1px solid #ddd;
    border-radius: 20px;
    padding: 30px;
    margin: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    background-color: #fff;
}


.pointBubble {
    position: relative;
    background: #E8FFFF;
    border-radius: 25px;
    padding: 10px;
    width: 500px;
    height: 100px;
    margin-top: 10px;
    color: black;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    display: flex;
    align-items: center;
    justify-content: flex-start;
}

.pointBubble:after {
    content: '';
    position: absolute;
    top: -20px;
    left: 50px;
    border-width: 0 20px 20px;
    border-style: solid;
    border-color: transparent transparent #E8FFFF;
    display: block;
    width: 0;
    
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
						<img src="/nexfit/resources/images/myaccount.png" style="width: 450px; height: 60px; float: left;">
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
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/mypage/update">계정관리</a></div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/mypage/community">커뮤니티 활동</a></div>
				    </div>
				  </li>
				  
			</ol>
						
						</div>
						<div class="col-sm-6" style="margin-left:50px; font-family: nexon lv2 medium">
							<div class="table-style" style="width: 600px; height: 330px;"> 
								<div style="display: flex;">
								<div style="border-radius: 50px; float: left">
									<img src="/nexfit/resources/images/muscle.PNG" style="width: 90px; height: 90px; border-radius: 50px; float: left;">
								</div>
								<ul style="list-style: none; float: left;">
									<li><h4 style="text-align: left; font-family: nexon lv1 light;">${sessionScope.member.nickname}</h4></li>
									
									<li><i class="bi bi-file-earmark-text"> 작성수 <span style="color: #5CD1E5">${count}</span></i> &nbsp;&nbsp;  
										<i class="bi bi-chat-right-text"> 댓글수 <span style="color: #5CD1E5">${rpl_count}</span></i>
									</li>
									<li><span style="float: left"> 현재 포인트 : <span style="color: #980000;">${currentPoint}</span> </span></li>
							
								</ul>
								</div>
								<br>
								<div class="pointBubble">
									<div style="text-align: left; font-family: nexon Lv1 light; font-weight: bold;">${a.bio}</div>
								</div>
								<br>
								<br>
								<span style="float: left">NEXFIT 가입 날짜 : <span style="color: #7F7EFF;">${sessionScope.member.reg_date}</span></span>
								
							</div>
							
							</div>
							
						</div>
						<div class="col-sm-3">
						
						</div>
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