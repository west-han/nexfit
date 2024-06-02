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

<c:if test="${sessionScope.member.userId=='admin'}">
	<script type="text/javascript">
		function deleteBoard() {
		    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			    let query = "challengeId=${dto.challengeId}&${query}";
			    let url = "${pageContext.request.contextPath}/challenge/delete?" + query;
		    	location.href = url;
		    }
		}
	</script>
</c:if>





</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>

		<main>
			<div class="container-xxl text-center">
				<div class="row py-5"> <%-- 챌린지게시판로고 --%>
					<div class="col-11">
						<a href="#"><img src="/nexfit/resources/images/challenge.png"></a> 
						<p><img id="no-click-image" src="/nexfit/resources/images/passion.png"></p>
					</div>
				</div>
				
				
		<div class="row gx-2">
				<jsp:include page="/WEB-INF/views/challenge/ch_leftbar.jsp"></jsp:include> <%-- 왼쪽사이드바 --%>
				
						<div class="col-sm-7"> <%-- 메인공간 --%>
						<div class="body-title">
						<h3> 등록된 챌린지 </h3>
						</div>  
	<div class="body-main" style="font-family: nexon lv2;">
		<div class="body-main">
				
				<table class="table border border-4">
					<thead>
						<tr>
							<td colspan="2" align="center">
								챌린지 번호 : ${dto.challengeId}
							</td>
						</tr>
					</thead>
					
					<tbody>
						<tr>
							<td class=" border border-4" width="50%">
								챌린지 명 : ${dto.ch_subject}
							</td>
						</tr>
						
						<tr>
							<td class=" border border-4" colspan="2" valign="top" height="200" style="border-bottom: none;">
								${dto.ch_content}
							</td>
						</tr>
						<tr>
							<td width="50%">
								참가비 : ${dto.fee}
							</td>
						</tr>
					</tbody>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td width="50%">
							<c:choose>
								<c:when test="${sessionScope.member.userId=='admin'}">
									<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/challenge/update?challengeId=${dto.challengeId}&page=${page}';">수정</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-light" disabled>수정</button>
								</c:otherwise>
							</c:choose>
					    	
							<c:choose>
					    		<c:when test="${sessionScope.member.userId=='admin'}">
					    			<button type="button" class="btn btn-light" onclick="deleteBoard();">삭제</button>
					    		</c:when>
					    		<c:otherwise>
					    			<button type="button" class="btn btn-light" disabled>삭제</button>
					    		</c:otherwise>
					    	</c:choose>
						</td>
					</tr>
				</table>
				
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