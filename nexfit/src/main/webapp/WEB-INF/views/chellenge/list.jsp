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
				
				if(confirm('게시글을 삭제하시 겠습니까 ? ')) {
					const f = document.listForm;
					f.action = '${pageContext.request.contextPath}/chellenge/deletelist';
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
        window.onload = function() {
            var image = document.getElementById('no-click-image');
            image.addEventListener('click', disableImageClick);
        };
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
						<a href="#"><img src="/nexfit/resources/images/chellenge.png"></a> 
						<p><img id="no-click-image" src="/nexfit/resources/images/passion.png"></p>
					</div>
				</div>
				
				
		<div class="row gx-2">
		
				<jsp:include page="/WEB-INF/views/chellenge/ch_leftbar.jsp"></jsp:include> <%-- 왼쪽사이드바 --%>
				
						<div class="col-sm-7"> <%-- 메인공간 --%>
						<div class="body-title">
						<h3> 등록된 챌린지 </h3>
						</div>  
				<div class="body-main" style="font-family: nexon lv1;">
		<form name="listForm" method="post">
		        <div class="row board-list-header">
		            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
		            <div class="col-auto">&nbsp;</div>
		        </div>	
		       <c:if test="${sessionScope.member.userId == 'admin'}">
									<button type="button" class="btn btn-light" id="btnDeleteList" title="삭제" style="float: right;"><i class="bi bi-trash"></i></button>
								</c:if>			
				<table class="table table-hover board-list" >
					<thead class="table-light">
						<tr>
							<c:if test="${sessionScope.member.userId=='admin'}">
									<th class="chk" width="100px">
										<input type="checkbox" class="form-check-input" name="chkAll" id="chkAll">        
									</th>
								</c:if>
							<th class="chellengeId" width="100px">번호</th>
							<th class="ch_subject">제목</th>
							<th class="fee" width="200px">참가비</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<c:if test="${sessionScope.member.userId=='admin'}">
										<td>
											<input type="checkbox" class="form-check-input" name="nums" value="${dto.chellengeId}">
										</td>
								</c:if>
								<td>${dataCount - (page-1) * size - status.index}</td>
								<td class="left">
									<a href="${articleUrl}&chellengeId=${dto.chellengeId}" class="text-reset">${dto.ch_subject}</a>
								</td>
								<td>${dto.fee}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="hidden" name="page" value="${page}">
				
				
				
				
				</form>
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
				</div>

				<div class="row board-list-footer">
					<div class="col text-start">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/chellenge/list';"><i class="bi bi-arrow-clockwise"></i></button>
					</div>
					<div class="col-7 text-center">
						<form class="row" name="searchForm" action="${pageContext.request.contextPath}/bbs/list" method="post">
							<div class="col-auto p-1">
								<select name="schType" class="form-select">
									<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
									<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
									<option value="content" ${schType=="content"?"selected":""}>내용</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="kwd" value="${kwd}" class="form-control">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
							</div>
						</form>
					</div>
					<div class="col text-end">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/chellenge/write';">글올리기</button>
					</div>
				</div>

			</div>
						</div>
						<div class="col-sm-2"><%-- 우측공간 --%>
						
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