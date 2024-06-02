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

.image-container {
    position: relative;
    width: 1300px; 
    height: 200px; 
}


.background-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.overlay-image {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}


.overlay-image2 {
    position: absolute;
    top: 80%; 
    left: 50%;
    transform: translate(-50%, -50%);
}

</style>
	<script>
	function filterCategory(category) {
        const urlParams = new URLSearchParams(window.location.search);
        if (category === '전체') {
            urlParams.delete('category');
        } else {
            urlParams.set('category', category);
        }
        window.location.href = window.location.pathname + '?' + urlParams.toString();
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
			<div class="row py-5 mt-5">
				<div class="col image-container">
					<img src="/nexfit/resources/images/exercisebg.PNG" class="background-image" style="width:1300px; height:200px; opacity: 0.3;">
					<img src="/nexfit/resources/images/freelounge.png" class="overlay-image" style="width:450px; height:90px;"><br>
					<img src="/nexfit/resources/images/sci.png" class="overlay-image2" style="width:300px; height:20px;">
				</div>
				
				
			</div>
						
	<div class="row gx-2">
		<div class="col-sm-3 mt-5" style="font-family: 'nexon lv1 light'; font-weight: 600;">
			<h3>CATEGORY</h3>
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" onclick="filterCategory('전체')" ${category == '전체' ? 'checked' : ''} checked>
			  <label class="btn btn-outline-dark" for="btnradio1">전체</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" onclick="filterCategory('잡담')" ${category == '잡담' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio2">잡담</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" onclick="filterCategory('건강')" ${category == '건강' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio3">건강</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" onclick="filterCategory('축구')" ${category == '축구' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio4">축구</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" onclick="filterCategory('야구')" ${category == '야구' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio5">야구</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio6" onclick="filterCategory('농구')" ${category == '농구' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio6">농구</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio7" onclick="filterCategory('배구')" ${category == '배구' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio7">배구</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio8" onclick="filterCategory('기타종목')" ${category == '기타종목' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio8">기타종목</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio9" onclick="filterCategory('동물')" ${category == '동물' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio9">동물</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio10" onclick="filterCategory('식단')" ${category == '식단' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio10">식단</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio11" onclick="filterCategory('게임')" ${category == '게임' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio11">게임</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio12" onclick="filterCategory('영화')" ${category == '영화' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio12">영화</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio13" onclick="filterCategory('문학')" ${category == '문학' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio13">문학</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio14" onclick="filterCategory('유머')" ${category == '유머' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio14">유머</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio15" onclick="filterCategory('연애')" ${category == '연애' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio15">연애</label>
			</div>
			
			<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio16" onclick="filterCategory('여행')" ${category == '여행' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio16">여행</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio17" onclick="filterCategory('음악')" ${category == '음악' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio17">음악</label>
			
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio18" onclick="filterCategory('취업')" ${category == '취업' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio18">취업</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio19" onclick="filterCategory('재테크')" ${category == '재테크' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio19">재테크</label>
			  
			  <input type="radio" class="btn-check" name="btnradio" id="btnradio20" onclick="filterCategory('IT')" ${category == 'IT' ? 'checked' : ''}>
			  <label class="btn btn-outline-dark" for="btnradio20">IT</label>
			</div>
	</div>
	
	
	<div class="col-sm-6">
		<main>
			<div class="container" style="font-family: 'nexon lv2 medium';">
				<div class="body-container">	
					<div class="body-title">
						<h3 style="font-family: 'nexon lv2 medium';">자유 게시판</h3>
					</div>
					
				
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            
				        </div>
				        
				        <form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/board/list" method="post" > 
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
								<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 350px;">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
							</div>
						</form>
						 
						<div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/write';" style="float: right;">글쓰기</button></div>
				     	
				     	<div class="table-style">		
						<table class="table table-hover board-list">
							<thead>
								<tr>
									<th class="num">번호</th>
									<th class="categoryName">제목</th>
									<th class="name">작성자</th>
									<th class="date">작성일</th>
									<th class="hit">조회수</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr> 
										<td>${dataCount - (page-1) * size - status.index}</td>
										<td class="left">
									
											<a href="${articleUrl}&num=${dto.num}" class="text-reset">
											<span style="float: left"><span style="color: orange;">[${dto.categoryName}]</span> ${dto.subject} 	<span style="color: #23A41A; font-weight: bold;">&nbsp; 🗨 ${dto.replyCount}</span>
											<span style="color: #FF73B8; font-weight: bold;">♥ ${dto.boardLikeCount}</span>
											</span>
											</a>
										
										</td>
										<td>${dto.nickname}</td>
										<td>${dto.reg_date}</td>
										<td>${dto.hitCount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						
						<div class="page-navigation">
							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
						</div> 
						<div class="row board-list-footer">
							<div class="col">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/list';" style="float: left;"><i class="bi bi-arrow-clockwise"></i></button>
							</div>
							
						</div>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-3">여기에는 우측 공간에 들어갈 거 작성</div>
				
		</div>
	
			</div>
		</main>
	</div>
	<div class="row py-5">
										
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>