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

<c:if test="${sessionScope.member.userId == 'admin'}">
	<script type="text/javascript">
		$(function() {
			$('#chkAll').click(function() {
				$('input[name=nums]').prop('checked', $(this).is(':checked'));
			});

			$('#btnDeleteList')
					.click(
							function() {
								let cnt = $('input[name=nums]:checked').length;
								if (cnt === 0) {
									alert('삭제할 게시물을 선택하세요');
									return;
								}

								if (confirm('게시글을 삭제하시 겠습니까 ? ')) {
									const f = document.listForm;
									f.action = '${pageContext.request.contextPath}/challenge/deletelist';
									f.submit();
								}

							});
		});

		function goToArticle(url, num) {
			const link = `${url}&num=${num}`;
			window.location.href = link;
		}
	</script>
</c:if>

<script type="text/javascript">
	// 마우스 클릭을 막음
	function disableImageClick(event) {
		event.preventDefault();
	}

	$(window).on('load', function() {
		$('#no-click-image').on('click', disableImageClick);
	});

	function searchList() {
		const f = document.searchForm;
		f.submit();
	}
</script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var today = new Date();
		today.setHours(0, 0, 0, 0);

		var dateData = [];
		<c:forEach var="dto" items="${list}" varStatus="status">
			dateData.push({
				startDate: "${dto.start_date}",
				endDate: "${dto.end_date}",
				elementId: "date-message-${status.index}"
			});
		</c:forEach>

		dateData.forEach(function(item) {
			var dbStartDateStr = item.startDate;
			var dbStartDate = new Date(dbStartDateStr);
			dbStartDate.setHours(0, 0, 0, 0); 

			var dbEndDateStr = item.endDate;
			var dbEndDate = new Date(dbEndDateStr);
			dbEndDate.setHours(0, 0, 0, 0); 

			var dateMessageElement = document.getElementById(item.elementId);

			if (dbEndDate < today) {
				dateMessageElement.textContent = '종료됨';
			} else if (dbStartDate > today) {
				dateMessageElement.textContent = '준비중';
			} else {
				dateMessageElement.textContent = '진행중';
			}
		});
	});
</script>

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
								class="text-with-border">진행중인 챌린지</h2>
						</div>
						<div class="body-main" style="font-family: 'nexon lv1 medium';">
							<form class="row mx-auto d-flex justify-content-center"
								name="searchForm"
								action="${pageContext.request.contextPath}/chboard/list"
								method="post" style="display: inline-block; text-align: center;">
								<div class="row align-items-center">
									<div class="col-auto">
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/chboard/list';">
											<i class="bi bi-arrow-clockwise"></i>
										</button>
									</div>
									<div class="col-auto">
										<select name="schType" class="form-select">
											<option value="all" ${schType=="all"?"selected":""}>전체검색</option>
											<option value="ch_subject"
												${schType=="ch_subject"?"selected":""}>챌린지제목</option>
											<option value="reg_date"
												${schType=="ch_content"?"selected":""}>챌린지내용</option>
											<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
											<option value="content"
												${schType=="content"||schType=="ch_content"?"selected":""}>내용</option>
										</select>
									</div>
									<div class="col-auto">
										<input type="text" name="kwd" value="${kwd}"
											class="form-control" style="width: 250px;">
									</div>
									<div class="col-auto">
										<button type="button" class="btn btn-light"
											onclick="searchList()">
											<i class="bi bi-search"></i>
										</button>
									</div>
									<div class="col-auto">
										<button type="button" style="font-family: 'nexon lv1 light';"
											class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/chboard/write';">글올리기</button>
									</div>
								</div>
								<input type="hidden" name="page" value="${page}">
							</form>



							<div class="row board-list-header">
								<div class="col-auto me-auto"
									style="font-family: 'nexon lv1 light';">${dataCount}개(${page}/${total_page}
									페이지)</div>
								<div class="col-auto">&nbsp;</div>

							</div>
							<p>&nbsp;</p>



							<div class="row">
								<c:forEach var="dto" items="${list}" varStatus="status">
									<div class="col-md-6 mb-4">
										<div class="card" style="background-color: #fff">
											<img
												src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}"
												class="card-img-top img-fluid" style="height: 250px;">
											<div class="card-body">
												<h5 class="card-title"
													style="font-family: 'nexon lv2 medium';">${dto.subject}</h5>
												<p class="card-text" style="font-family: 'nexon lv1 light';">${dto.ch_subject}</p>
												<p class="card-text" style="font-family: 'nexon lv1 light'; margin: 0">${dto.start_date}
													~ ${dto.end_date}</p>
												<button class="custom-btn btn-7"
													style="font-family: nexon lv2 medium"
													onclick="location.href='${articleUrl}&num=${dto.boardNumber}';">
													<span style="font-family: 'nexon lv2 medium';">Go Challenge</span>
													<p style="font-family: 'nexon lv2 medium';" id="date-message-${status.index}"></p>
												</button>
												<p></p>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>




							<div class="page-navigation">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
							</div>

							<div class="row board-list-footer">

								<div class="col-7 text-center"></div>

							</div>

						</div>

					</div>
					
						<%-- 우측공간 --%>

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