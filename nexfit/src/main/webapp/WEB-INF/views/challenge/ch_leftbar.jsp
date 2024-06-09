<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<style>
/* 200% 확대 시 메뉴 숨김 */
@media screen and (max-width: 1200px) {
    .menu-container {
        display: none;
    }
}
</style>

<div class="col-sm-2 mt-5 " style="font-family: 'nexon lv2 medium'; ">
<div class="mt-5">
<div class="container menu-container">
			<ol class="list-group list-group" style="width:190px; position: fixed;">
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto ">
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/chboard/list">챌린지 리스트</a></div>
				    </div>
				    <span class="badge text-bg-primary rounded-pill">진행중-${procount}</span>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/certiboard/list">인증 게시판</a></div>
				    </div>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/mychallenge/list">참여한 챌린지</a></div>
				    </div>
				  </li>
				  <c:if test="${sessionScope.member.userName=='admin'}">
				  	 <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/challenge/list">챌린지관리 게시판</a></div>
				    </div>
				  </li>
				  </c:if>
			</ol>
			</div>
			</div>
		</div>