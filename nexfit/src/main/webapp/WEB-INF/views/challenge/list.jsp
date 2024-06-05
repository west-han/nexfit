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

.background-image {
    position: absolute;
    top: 30px;
    left: 0;
    width: 100%; 
    height: 45%; 
    z-index: -1; 
    object-fit: cover; 
    opacity: 0.7; 
}

.text-with-border {
    color: white; 
    text-shadow: 
        -1px -1px 0 black,  
        1px -1px 0 black,
        -1px 1px 0 black,
        1px 1px 0 black; 
}


</style>

 <c:if test="${sessionScope.member.userId == 'admin'}">
	<script type="text/javascript">
		$(function(){
			$('#chkAll').click(function(){
				$('input[name=nums]').prop('checked', $(this).is(':checked'));
			});
			
			$('#btnDeleteList').click(function(){
				let cnt = $('input[name=nums]:checked').length;
				if(cnt === 0) {
					alert('삭제할 게시물을 선택하세요');
					return;
				}
				
				if(confirm('게시글을 삭제하시 겠습니까 ? \n(진행중인 챌린지가 있는경우 삭제되지 않습니다.)')) {
					const f = document.listForm;
					f.action = '${pageContext.request.contextPath}/challenge/deletelist';
					f.submit();
				}
				   
			});
		});
	</script>
</c:if>

 <script type="text/javascript">
        // 마우스 클릭을 막는 함수
        function disableImageClick(event) {
            event.preventDefault();
        }

        // 페이지 로드 시 특정 이미지에 클릭 이벤트 리스너 추가
       $(window).on('load', function() {
    		$('#no-click-image').on('click', disableImageClick);
}		);
    </script>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>
		<main>
			<div class="container-xxl text-center">
			<div class="container mt-5">
			
			</div>
				<div class="row py-5"> <%-- 챌린지게시판로고 --%>
					<div class="col-11">
						<img src="/nexfit/resources/images/3.jpg" class="background-image">
						<a href="${pageContext.request.contextPath}/chboard/list"><img src="/nexfit/resources/images/challenge.png"></a> 
						<p><img id="no-click-image" src="/nexfit/resources/images/passion.png"></p>
					</div>
				</div>				
				
		<div class="row gx-2">
		
				<jsp:include page="/WEB-INF/views/challenge/ch_leftbar.jsp"></jsp:include> <%-- 왼쪽사이드바 --%>
				
						<div class="col-sm-7"> <%-- 메인공간 --%>
						<div class="body-title">
						<h2 style="font-family: 'nexon lv2 medium';" class="text-with-border"> 등록된 챌린지 </h2>
						</div>  
				<div class="body-main" style="font-family: nexon lv1;">
		<form name="listForm" method="post">
		        <div class="row board-list-header">
		        	<p> </p>
		        	<p> </p>
		            <div class="col-auto me-auto" style="font-family: 'nexon lv1 light';">${dataCount}개(${page}/${total_page} 페이지)</div>
		        </div>	
		       <c:if test="${sessionScope.member.userId == 'admin'}">
									<button type="button" class="btn btn-light" id="btnDeleteList" title="삭제" style="float: left;"><i class="bi bi-trash"></i></button>
									
						<button type="button" class="btn btn-light" style="float: right;" onclick="location.href='${pageContext.request.contextPath}/challenge/write';">글올리기</button>
								</c:if>			
				<table class="table table-hover board-list" >
					<thead class="table-light">
						<tr>
							<c:if test="${sessionScope.member.userId=='admin'}">
									<th class="chk" width="100px">
										<input type="checkbox" class="form-check-input" name="chkAll" id="chkAll">        
									</th>
								</c:if>
							<th class="challengeId" width="100px">번호</th>
							<th class="ch_subject">제목</th>
							<th class="fee" width="200px">참가비</th>
						</tr>
					</thead>
					
					<tbody style="font-family: 'nexon lv1 light';">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<c:if test="${sessionScope.member.userId=='admin'}">
										<td>
											<input type="checkbox" class="form-check-input" name="nums" value="${dto.challengeId}">
										</td>
								</c:if>
								<td>${dataCount - (page-1) * size - status.index}</td>
								<td class="left">
									<a href="${articleUrl}&challengeId=${dto.challengeId}" class="text-reset">${dto.ch_subject}</a>
								</td>
								<td>${dto.fee}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="hidden" name="page" value="${page}">
				
				
				
				
				</form>
				<div class="page-navigation" style="font-family: 'nexon lv2 medium';">
				<div class="col text-start">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/challenge/list';"><i class="bi bi-arrow-clockwise"></i></button>
					</div>
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					
					
				</div>

			</div>
						</div>
						<div class="col-sm-3"><%-- 우측공간 --%>
						
						</div>
					</div>
				
			</div>
			
		</main>
	</div>
	<div class="container">
	
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>