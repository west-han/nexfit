<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/button.css">
<style type="text/css">
.body-container {
	max-width: 800px;
}

.font {
	font-family: 'nexon lv1 light';
}

.box {
	margin-bottom: 2rem;
	background: #FFF;
}

.box .image.fit {
	margin: 0;
	border-radius: 0;
}

.box .image.fit img {
	border-radius: 0;
}

.box header h2 {
	margin-bottom: 2rem;
}

.box header p {
	text-transform: uppercase;
	font-size: .75rem;
	font-weight: 300;
	margin: 0 0 .25rem 0;
	padding: 0 0 .75rem 0;
	letter-spacing: .25rem;
}

.box .content {
	padding: 3rem;
}

.box>:last-child, .box>:last-child>:last-child, .box>:last-child>:last-child>:last-child
	{
	margin-bottom: 0;
}

.box.alt {
	border: 0;
	border-radius: 0;
	padding: 0;
}

@media screen and (max-width: 736px) {
	.box .content {
		padding: 2rem;
	}
}

.box {
	border-color: rgba(144, 144, 144, 0.25);
}

.content hr {
	width: 50%;
	margin: 0 auto;
	margin-bottom: 10px;
}

.max-h {
	max-height: 400px;
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
	text-shadow: -1px -1px 0 black, 1px -1px 0 black, -1px 1px 0 black, 1px
		1px 0 black;
}
</style>

<c:if
	test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	<script type="text/javascript">
		function deleteBoard() {
		    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
		    	let query = "num=${dto.certifiedNum}&page=${page}";
			    let url = "${pageContext.request.contextPath}/certiboard/delete?" + query;
		    	location.href = url;
		    }
		}
	</script>
</c:if>





</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>
		<main>
			<div class="container-xxl text-center">
				<div class="container mt-5"></div>
				<div class="row py-5">
					<%-- 챌린지게시판로고 --%>
					<div class="col-11">
						<img src="/nexfit/resources/images/3.jpg" class="background-image">
						<a href="${pageContext.request.contextPath}/chboard/list"><img
							src="/nexfit/resources/images/challenge.png"></a>
						<p>
							<img id="no-click-image"
								src="/nexfit/resources/images/passion.png">
						</p>
					</div>
				</div>

				<div class="row gx-2">
					<jsp:include page="/WEB-INF/views/challenge/ch_leftbar.jsp"></jsp:include>
					<%-- 왼쪽사이드바 --%>

					<div class="col-sm-7">
						<%-- 메인공간 --%>
						<div class="body-title">
							<h2 style="font-family: 'nexon lv2 medium';"
								class="text-with-border">챌린지 인증</h2>
						</div>
						<div class="body-main">
							<div class="body-main" style="font-family: nexon lv1 light">

								<table class="table">
									<thead>
										<tr>
											<td colspan="2" align="center"><h4>${dto.subject}</h4></td>
										</tr>
									</thead>

									<tbody>
										<tr>
											<td align="left" style="padding-left: 20px;">이름 : ${dto.nickname}</td>
											<td align="right" width="210px">${dto.reg_date}</td>
										</tr>

										<tr>
											<td colspan="2" style="border-bottom: none;"><img
												src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}"
												class="img-fluid img-thumbnail w-100 h-auto"></td>
										</tr>

										<tr>
											<td colspan="2">${dto.content}</td>
										</tr>

									</tbody>
								</table>

								<table class="table table-borderless">
									<tr>
										<td width="50%"><c:choose>
												<c:when test="${sessionScope.member.userId==dto.userId}">
													<button type="button" class="btn btn-light"
														onclick="location.href='${pageContext.request.contextPath}/certiboard/update?num=${dto.certifiedNum}&page=${page}';">수정</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-light" disabled>수정</button>
												</c:otherwise>
											</c:choose> <c:choose>
												<c:when
													test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
													<button type="button" class="btn btn-light"
														onclick="deleteBoard();">삭제</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-light" disabled>삭제</button>
												</c:otherwise>
											</c:choose></td>
										<td class="text-end">
											<button type="button" class="btn btn-light"
												onclick="location.href='${pageContext.request.contextPath}/certiboard/list?page=${page}';">리스트</button>
										</td>
									</tr>
								</table>

							</div>

						</div>
					</div>
					<jsp:include page="/WEB-INF/views/challenge/ch_rightbar.jsp"></jsp:include>
				</div>

			</div>

		</main>
	</div>
	<div class="container"></div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>