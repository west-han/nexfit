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


.background-container2 {
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
}


@keyframes rotateEmoji {
    0% {
        transform: rotateY(0deg);
    }
    50% {
        transform: rotateY(90deg);
    }
    100% {
        transform: rotateY(180deg);
    }
}

.emoji-rotate {
    animation: rotateEmoji 2s forwards;
} 

</style>

<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}


document.addEventListener('DOMContentLoaded', function() {
    const emoji = document.getElementById('emoji');
    const emojiText = document.getElementById('emoji-text');
    const emojiStates = ['🤔', '🤗', '🧐', '🤬']; // 이모지 상태 배열
    const emojiMessages = ['효과적인 운동 방법을 찾고 계신가요?', '다양한 운동 경험을 나눠보세요!', '운동 관련 질문과 답변을 자유롭게 할 수 있는 게시판입니다.', '질문자 및 답변자에 대한 비난 및 비방은 삼가해주시길 바랍니다.']; // 이모지에 대응하는 메시지 배열
    let currentIndex = 0;

    function rotateEmoji() {
        emoji.classList.add('emoji-rotate');

        setTimeout(() => {
            currentIndex = (currentIndex + 1) % emojiStates.length;
            emoji.innerHTML = emojiStates[currentIndex];
            emojiText.innerHTML = emojiMessages[currentIndex];
        }, 1000);

        setTimeout(() => {
            emoji.classList.remove('emoji-rotate');
        }, 2000);
    }

    emoji.addEventListener('click', rotateEmoji);

    // 5초마다 자동으로 이모지를 변경
    setInterval(rotateEmoji, 5000);
});


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
					<img src="/nexfit/resources/images/qnapeople.png" class="background-image" style="width:1300px; height:200px; opacity: 0.3;">
					<img src="/nexfit/resources/images/qnalounge.png" class="overlay-image" style="width:550px; height:110px;"><br>
					<img src="/nexfit/resources/images/aae.png" class="overlay-image2" style="width:300px; height:20px;"> 
				</div>
				
				
			</div>
						
	<div class="row gx-2">
		
	<jsp:include page="/WEB-INF/views/board/list_leftbar.jsp"></jsp:include>
	
	<div class="col-sm-7"> 
		<main>
			<div class="container" style="font-family: 'nexon lv2 medium';">
				<div class="body-container">	
					<div class="body-title">
						<h3 style="font-family: 'nexon lv2 medium';">질의 게시판</h3>
					</div>
					
				
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            
				        </div>
				        
				        <form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/qnaboard/list" method="post" > 
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
						 
						<div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/qnaboard/write';" style="float: right;">질문하기</button></div>
				     	
				     	<div class="table-style">		
						<table class="table table-hover board-list">
							<thead>
								<tr>
									<th class="num">번호</th>
									<th class="categoryName">제목</th>
									<th></th>
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
											<span style="float: left"><span style="color: blue;">Q.</span> ${dto.subject} <span style="color: #23A41A; font-weight: bold;"> 
											</span>
											</span>
											</a>
										
										</td>
										<td>
										<span style="color: #23A41A; font-weight: bold;">&nbsp;&nbsp; <span style="color: red; text-align: right;">A.</span> ${dto.replyCount}개</span>
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
							
						</div>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-2 mt-5">
			<div class="background-container2">
				<br>
				<div id="emoji" style="font-size: 40px;">🤔</div>
				<br>
				<div id="emoji-text" style="color: #C1B438; font-family: 'nexon lv2 medium'; font-size: 16px;">효과적인 운동 방법을 찾고 계신가요?</div>
				<br>
			</div>
		</div>
			
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