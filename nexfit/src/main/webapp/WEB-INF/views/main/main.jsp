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
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
*, *::after, *::before {
	margin: 0;
	padding: 0;
}



</style>

</head>
<body>
	<div class="container-fluid p-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>
			

			<nav>
				<div style="max-height:800px;">
					<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
  						<div class="carousel-inner">
    						<div class="carousel-item active">
      							<img src="resources/images/gym1.jpg" class="d-block w-100" style="max-height:580px;">
   							 </div>
   							 <div class="carousel-item">
						      <img src="resources/images/gym2.jpg" class="d-block w-100" style="max-height: 580px;">
						    </div>
						    <div class="carousel-item">
						      <img src="resources/images/gym3.jpg" class="d-block w-100" style="max-height: 580px;">
						    </div>
						    <div class="carousel-item">
						      <img src="resources/images/gym4.jpg" class="d-block w-100" style="max-height:580px;">
						    </div>
						    <div class="carousel-item">
						      <img src="resources/images/gym5.jpg" class="d-block w-100" style="max-height: 580px;">
						    </div>
  						</div>
  						
					  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="visually-hidden">Next</span>
					  </button>
					</div>
					
				</div>
			</nav>
			<main>
			<div class="banner">
			
			<marquee direction="left"><span style='font-size: 100px;color:white; background: black;' >NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT</span></marquee>
        

    </div>
    	<div class="middle">
				<div class="body-container">	
					<div class="rec">
						<video class="player" src="resources/images/content.mp4" autoplay muted="muted" loop="loop" width="1000px;" height="600px;"></video>
					
					</div> 
					<div class="spti">
						
						<p>운동 MBTI 테스트</p>
						<p>당신의 운동 타입은 ? </p>
						<img src="resources/images/spti.png">
						<div class="sptibtn">
							<button class="btn" style="font-family: nexon lv2 medium;">테스트 하러 가기 !</button>
						</div>
					</div>
				</div>
		</div>
				<div class="boardcontent">
				<div class="main-contents1">
					<div class="con1">
						<span>
							<img src="resources/images/fire.png" style="width: 20px; height: 20px;">
							실시간 인기글
						</span>
					</div>
					<div>
					</div>
					<div>
					</div>
				</div>
				<div class="main-contents2">
					<div>
					</div>
					<div>
					</div>
					<div>
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
</html>