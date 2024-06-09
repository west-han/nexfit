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
    border-radius: 5px;
    padding: 16px;
    margin: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    background-color: #fff;
}

.btn-light:hover {
	background: black; 
	color: white;
}

/* 타원형 컨테이너 스타일 */
        .ellipse-container {
            display: flex; /* 자식 요소를 한 줄로 배치 */
            align-items: center; /* 수직 가운데 정렬 */
            justify-content: center; /* 가로 중앙 정렬 */
            padding: 5px 15px; /* 내부 여백 추가 */
            border-radius: 50px; /* 타원형으로 만들기 위한 경계 반경 */
            background-color: #f1f5f9; /* 배경색 설정 */
            border: 0px; /* 테두리 설정 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
            gap: 10px; /* 요소 사이 간격 */
            width: fit-content; /* 컨텐츠에 맞춰 너비 자동 조정 */
        }

        /* sports와 postType 텍스트 스타일 */
        .ellipse-text {
            font-size: 13px; /* 텍스트 크기 */
            color: #333; /* 텍스트 색상 */
        }
        
        /* 부모 컨테이너 스타일 */
.flex-container {
    display: flex; /* Flexbox 활성화 */
    gap: 10px; /* 타원형 요소 사이의 간격 */
    align-items: center; /* 수직 가운데 정렬 */
    margin-top: 10px;
    margin-left:10px;
    margin-bottom: 10px;
}

.block {
	display: block;
}

.text-sm {
	font-size:15px;
	line-height: 0.9rem;
	color: rgba(0, 0, 0, 0.5);
	
}

.line-clamp-2 {
	overflow: hidden;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
}

.content-with-images img {
	display: none;
}

.flex-container-inline {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-left: 20px;
}

.hit-count, .reply-count {
	display: flex;
    align-items: center;
    gap: 5px;
    color: rgba(0, 0, 0, 1);
    font-size: 14px;
}

.reg-date {
	display: flex;
    align-items: center;
    gap: 5px;
	color: rgba(0, 0, 0, 0.6);
	font-size:13px;
}

/* Flex 컨테이너의 기본 스타일 */
.items-center {
    display: flex;
    justify-content: space-between; /* 자식 요소들을 양 끝으로 정렬 */
    align-items: center;
    gap: 10px;
    margin-bottom: 5px;
}

/* 왼쪽 요소들의 컨테이너 스타일 */
.flex-container-inline {
    display: flex;
    align-items: center;
    gap: 10px; /* 요소 사이의 간격 */
}

/* nickname 컨테이너의 스타일 */
.nickname-container {
    margin-left: auto; /* 오른쪽 끝으로 정렬 */
    text-align: right; /* 텍스트를 오른쪽으로 정렬 */
    margin-right: 10px;
    color: rgba(0, 0, 0, 1);
}


</style>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>
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
								<img src="/nexfit/resources/images/ROUTINE.png" style="width:550px; height:110px; margin-top: 76px;"><br>
								<img src="/nexfit/resources/images/thc.png" class="overlay-image2" style="width:330px; height:25px;">
							</div>
						</div>
						
<c:forEach var="i" begin="0" end="0">
	<div class="row gx-2">
	<div class="col-sm-2"></div>
	<div class="col-sm-7">
		<main>
			<div class="container" style="font-family: 'nexon lv2 medium';">
				<div class="body-container">	
					<div class="body-title">
						<h3 style="font-family: 'nexon lv2 medium';">ROUTINE</h3>
					</div>
					
					<div class="row board-list-header">
				        <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				    </div>
					
					<form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/sports/routine/list" method="post" >
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
								<option value="nickname" ${schType=="nickname"?"selected":""}>작성자</option>
								<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
								<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
								<option value="content" ${schType=="content"?"selected":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 450px;">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
						</div>
					</form>
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto"></div>
				            <div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sports/routine/write';">글쓰기</button></div>
				        </div> 
				     	
				     	<div class="row px-1 py-1 g-2">	
								<c:forEach var="dto" items="${list}" varStatus="status">
									<div>
										<div style="background-color: #ffffff; border-radius: 13px;" class="col p-1 item">
											<div class="flex-container">
												<div class="ellipse-container">
													<div class="ellipse-text">
													<c:choose>
														<c:when test="${dto.sports == 1}">헬스</c:when>
														<c:when test="${dto.sports == 2}">수영</c:when>
														<c:when test="${dto.sports == 3}">클라이밍</c:when>
														<c:when test="${dto.sports == 4}">배구</c:when>
														<c:when test="${dto.sports == 5}">킥복싱</c:when>
														<c:when test="${dto.sports == 6}">기타</c:when>
													</c:choose>
													</div>
												</div> 
													<div class="ellipse-container">
														<div class="ellipse-text" style="color: ${dto.postType == 1? '#FF6B6B' : '#1E40AF'}">${dto.postType == 1? "추천" : "질문"}</div> 
													</div>
											</div>
											<a href="${articleUrl}&num=${dto.num}" class="break-all block">
												<span style="font-size: 25px;">										
													${dto.subject}
												</span>	
												<span class="my-2 mb-4 line-clamp-2 text-sm">
													<span class="content-with-images">
														${dto.content}
													</span>
												</span>		
											</a>
											<div class="items-center text-sm sm:flex sm:justify-between">
												<div class="flex items-center gap-4">
													<div class="flex-container-inline">
														<div class="hit-count">
															<i class="fa-solid fa-user-group"></i>
															${dto.hitCount}
														</div>
														<div class="reply-count">
															<i class="fa-solid fa-comment"></i>
															${dto.replyCount}
														</div>
														<div class="reg-date">
															${dto.reg_date}
														</div>
													</div>
												</div>
														<div class="nickname-container">
															<i style="color: ${dto.postType == 1? '#FF6B6B' : '#1E40AF'}" class="fa-solid fa-dumbbell"></i>
															${dto.nickname}													
														</div>
											</div>
											
									
										</div>
									</div>
								</c:forEach>
						</div>
						
						<div class="page-navigation">
							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
						</div>
						<br>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-3"></div>
				
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