<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

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
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>
		<main>
			<div class="container-xxl text-center">
				<div class="row py-5 mt-5">
					<div class="col image-container">
						<img src="/nexfit/resources/images/withmeback.png"
							class="background-image"
							style="width: 1300px; height: 200px; opacity: 0.3;"> <img
							src="/nexfit/resources/images/withme.png" class="overlay-image"
							style="width: 550px; height: 110px;"><br> <img
							src="/nexfit/resources/images/ppp.png" class="overlay-image2"
							style="width: 300px; height: 20px;">
					</div>
				</div>

				<div class="row gx-2">

					<jsp:include page="/WEB-INF/views/withme/list_leftbar.jsp"></jsp:include>

					<div class="col-sm-8">
						<div class="container" style="font-family: 'nexon lv2 medium';">
							<div class="body-container">
								<div class="body-title">
									<h3 style="font-family: 'nexon lv2 medium';">WORKOUT
										TOGETHER !</h3>
								</div>

								<div class="body-main">
									<div class="row board-list-header">
										<div class="col-auto me-auto">${dataCount}개(${page}/${total_page}
											페이지)</div>
									</div>

									<form class="row mx-auto" name="searchForm"
										action="${pageContext.request.contextPath}/withme/list"
										method="post">
										<div class="col-auto p-1">
											<select name="schType" class="form-select">
												<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
												<option value="nickname"
													${schType=="nickname"?"selected":""}>작성자</option>
												<option value="reg_date"
													${schType=="reg_date"?"selected":""}>등록일</option>
												<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
												<option value="content" ${schType=="content"?"selected":""}>내용</option>
											</select>
										</div>
										<div class="col-auto p-1">
											<input type="text" name="kwd" value="${kwd}"
												class="form-control" style="width: 450px;">
										</div>
										<div class="col-auto p-1">
											<button type="button" class="btn btn-light"
												onclick="searchList()" style="">
												<i class="bi bi-search"></i>
											</button>
										</div>
									</form>

									<div class="col-auto">
										&nbsp;
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/withme/write';"
											style="float: right;">글쓰기</button>
									</div>

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
														<td class="left"><a
															href="${articleUrl}&num=${dto.num}" class="text-reset">
																<span style="float: left"></span> ${dto.subject} <span
																style="color: #23A41A; font-weight: bold;"> </span>
														</a></td>
														<td><span style="color: #23A41A; font-weight: bold;">🗨
																${dto.replyCount}</span></td>
														<td>${dto.nickname}</td>
														<td>${dto.reg_date}</td>
														<td>${dto.hitCount}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>

									<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
									</div>
									<div class="row board-list-footer"></div>

								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-2"></div>
				</div>
			</div>
		</main>
	</div>
	<div style="height: 100px;"></div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>