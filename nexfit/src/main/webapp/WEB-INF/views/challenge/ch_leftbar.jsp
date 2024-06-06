<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>




<div class="col-sm-2 mt-5" style="font-family: 'nexon lv2 medium'; ">
<div class="container">
			<ol class="list-group list-group" style="width:190px; position: fixed;">
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto ">
				      <div class="fw-bold" ><a href="${pageContext.request.contextPath}/chboard/list">진행중인 챌린지</a></div>
				    </div>
				    <span class="badge text-bg-primary rounded-pill">${procount}</span>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold">종료된 챌린지</div>
				    </div>
				    <span class="badge text-bg-primary rounded-pill">${endcount}</span>
				  </li>
				  <li class="list-group-item d-flex justify-content-between align-items-start">
				    <div class="ms-2 me-auto">
				      <div class="fw-bold"><a href="${pageContext.request.contextPath}/certiboard/list">인증 게시판</a></div>
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