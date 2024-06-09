<%@page import="java.util.List"%>
<%@page import="com.nexfit.domain.BoardDTO"%>
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
			
			<marquee direction="left"><span style='font-size: 100px;color:white; background: black;' >NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT  NEXFIT</span></marquee>
        
 
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
							<button class="btn" style="font-family: nexon lv2 medium;" onclick="location.href='${pageContext.request.contextPath}/sports/spti/main'">테스트 하러 가기 !</button>
						</div>
					</div>
				</div>
		</div>
				<div class="boardcontent">
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        HOT NOW
					        <a href="${pageContext.request.contextPath}/board/list" class="more-link">MORE</a>
					    </p>
					    <div class="hot-now-content">
					        <c:forEach var="post" items="${topLikedPosts}">
					            <div class="post-item">
					                <a href="${pageContext.request.contextPath}/board/article?num=${post.num}" class="post-title">${post.subject}</a>
					                <span class="post-date">${post.reg_date }</span>
					            </div>
					        </c:forEach>
					    </div>
					</div>
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        FREE LOUNGE
					        <a href="${pageContext.request.contextPath}/board/list" class="more-link">MORE</a>
					    </p>
					    <div class="hot-now-content">
					        <c:forEach var="post" items="${recentFreePosts}">
                    <li>
                       <a href="${pageContext.request.contextPath}/board/article?num=${post.num}" class="post-title">${post.subject}</a>
                        <span>${post.reg_date}</span>
                    </li>
                </c:forEach>
					    </div>
					</div>
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        ROUTINE
					        <a href="${pageContext.request.contextPath}/sports/routine/list" class="more-link">MORE</a>
					    </p>
					    <div class="routine">
					        <c:forEach var="post" items="${recentPosts}">
                    <li>
                       <a href="${pageContext.request.contextPath}/board/article?num=${post.num}" class="post-title">${post.subject}</a>
                        <span>${post.reg_date}</span>
                    </li>
                </c:forEach>
					    </div>
					</div>
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        Q&A LOUNGE
					        <a href="${pageContext.request.contextPath}/qnaboard/list" class="more-link">MORE</a>
					    </p>
					    <div class="hot-now-content">
					        <c:forEach var="post" items="${recentQnaPosts}">
                    <li>
                        <a href="<c:url value='/qnaboard/article'/>?num=${post.num}">${post.subject}</a>
                        <span>${post.reg_date}</span>
                    </li>
                </c:forEach>
					    </div>
					</div>
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        WITH ME
					        <a href="${pageContext.request.contextPath}/withme/list" class="more-link">MORE</a>
					    </p>
					    <div class="hot-now-content">
					        <c:forEach var="post" items="${recentWithPosts}">
			                    <li>
			                       <a href="${pageContext.request.contextPath}/withme/article?num=${post.num}" class="post-title">${post.subject}</a>
			                        <span>${post.reg_date}</span>
			                    </li>
			                </c:forEach>
					    </div>
					</div>
					<div class="con1">
					    <p class="content-title">
					        <img src="resources/images/fire.png" style="width: 20px; height: 20px;">
					        CHALLENGE
					        <a href="${pageContext.request.contextPath}/chboard/list" class="more-link">MORE</a>
					    </p>
					    <div class="hot-now-content">
					        <c:forEach var="post" items="${recentChallengePosts}">
			                    <li>
			                       <a href="${pageContext.request.contextPath}/chboard/article?num=${post.boardNumber}" class="post-title">${post.subject}</a>
			                        <span>${post.reg_date}</span>
			                    </li>
			                </c:forEach>
					    </div>
					</div>
					
				</div>
			</main>
	</div>
	<div style="width: 100%; height: 200px;"></div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/> 
</html>
