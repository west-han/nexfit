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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/button2.css">
<style type="text/css">
.body-container {
	max-width: 800px;
}

.textarea-no-border {
	border: none;
	resize: none; /* 리사이징 비활성화 */
	width: 100%; /* 너비 조정 가능 */
	height: 200px; /* 높이 조정 가능 */
	padding: 8px; /* 내부 여백 */
	font-size: 16px; /* 폰트 크기 */
	line-height: 1.6; /* 줄 간격 */
	font-family: Arial, sans-serif; /* 폰트 패밀리 */
}

.write-form .img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image:
		url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	position: relative;
	z-index: 9999;
	background-repeat: no-repeat;
	background-size: cover;
}

.date-input {
	display: inline-block;
	width: auto;
	margin-right: 10px;
}

.selected {
	background-color: #E0115F;
	color: white;
}
</style>

<script type="text/javascript">
	function sendOk() {
		const f = document.photoForm;
		let str;

		str = f.subject.value.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.subject.focus();
			return;
		}

		var selectElement = document.getElementById('challengeSelect');
		var selectedValue = selectElement.value.trim();

		if (selectedValue === "none") {
			alert("참가한 챌린지를 선택하세요!");
			selectElement.focus();
			return;
		}

		str = f.content.value.trim();
		if (!str) {
			alert("내용을 입력하세요. ");
			f.content.focus();
			return;
		}

		let mode = "${mode}";
		if ((mode === "write") && (!f.selectFile.value)) {
			alert("이미지 파일을 추가 하세요. ");
			f.selectFile.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/certiboard/${mode}";
		f.submit();
	}

	$(function() {
		let img = "${dto.imageFilename}";
		if (img) { // 수정인 경우
			img = "${pageContext.request.contextPath}/uploads/photo/" + img;
			$(".write-form .img-viewer").empty();
			$(".write-form .img-viewer").css("background-image",
					"url(" + img + ")");
		}

		$(".write-form .img-viewer").click(function() {
			$("form[name=photoForm] input[name=selectFile]").trigger("click");
		});

		$("form[name=photoForm] input[name=selectFile]")
				.change(
						function() {
							let file = this.files[0];
							if (!file) {
								$(".write-form .img-viewer").empty();
								if (img) {
									img = "${pageContext.request.contextPath}/uploads/photo/"
											+ img;
									$(".write-form .img-viewer").css(
											"background-image",
											"url(" + img + ")");
								} else {
									img = "${pageContext.request.contextPath}/resources/images/add_photo.png";
									$(".write-form .img-viewer").css(
											"background-image",
											"url(" + img + ")");
								}
								return false;
							}

							if (!file.type.match("image.*")) {
								this.focus();
								return false;
							}

							let reader = new FileReader();
							reader.onload = function(e) {
								$(".write-form .img-viewer").empty();
								$(".write-form .img-viewer").css(
										"background-image",
										"url(" + e.target.result + ")");
							}
							reader.readAsDataURL(file);
						});
	});
</script>



</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>
		<div class="container"></div>
		<main>
			<div class="container">
				<div class="body-container m-auto">
					<div class="body-title">
						<h3>
							<i class="bi bi-clipboard"></i> 인증 게시글 등록
						</h3>
					</div>

					<div class="body-main" style="font-family: 'nexon lv2 medium';">
						<form name="photoForm" method="post" enctype="multipart/form-data">
							<table class="table write-form mt-5">
								<tr>
									<td class="bg-light col-sm-2" scope="row">제 목</td>
									<td><input type="text" name="subject" class="form-control"
										value="${dto.subject}"></td>
								</tr>

								<tr>
									<td class="bg-light col-sm-2" scope="row">작성자명</td>
									<td>
										<p class="form-control-plaintext">${sessionScope.member.nickname}</p>
									</td>
								</tr>
								<tr>
									<td class="bg-light col-sm-2" scope="row">참가한 챌린지 선택</td>
									<td><select name="applnum" id="challengeSelect"
										class="form-select" aria-label="Default select example">
											<option selected value="none">챌린지를 선택하세요!</option>
											<c:forEach var="app" items="${list}" varStatus="status">
												<option ${mode=='update'?'selected':'' }
													value="${app.boardNumber}"
													data-ch_content="${app.ch_content}"
													data-content="${app.content}">${app.subject}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td class="bg-light col-sm-2" scope="row">챌린지 정보</td>
									<td>
										<p class="d-inline-flex gap-1">
											<button class="btn btn-primary" type="button"
												onclick="toggleCollapse('collapseExample', 'ch_content')">
												챌린지 소개</button>
											<button class="btn btn-primary" type="button"
												onclick="toggleCollapse('collapseExample2', 'content')">
												게시판 내용</button>
										</p>

										<div class="collapse" id="collapseExample">
											<div class="card card-body">
												<textarea class="textarea-no-border" id="ch_content"
													placeholder="선택된 챌린지가 없습니다"></textarea>
											</div>
										</div>

										<div class="collapse" id="collapseExample2">
											<div class="card card-body">
												<textarea class="textarea-no-border" id="content"
													placeholder="선택된 챌린지가 없습니다"></textarea>
											</div>
										</div> <script>
											function toggleCollapse(collapseId,
													textareaId) {
												$('.collapse').collapse('hide');
												$('#' + collapseId).collapse(
														'show');
											}
										</script>

									</td>
								</tr>
								<tr>
									<td class="bg-light col-sm-2" scope="row">내 용</td>
									<td><textarea name="content" id="content"
											class="form-control">${dto.content}</textarea></td>
								</tr>

								<tr>
									<td class="bg-light col-sm-2" scope="row">이미지</td>
									<td>
										<div class="img-viewer"></div> <input type="file"
										name="selectFile" accept="image/*" class="form-control"
										style="display: none;">
									</td>
								</tr>

							</table>
							<script>
								function updateContent() {
									var selectedOption = $('#challengeSelect option:selected');
									var ch_content = selectedOption
											.data('ch_content');
									var content = selectedOption
											.data('content');
									var applnum = selectedOption
											.data('applnum');
									$('#content').val(content);
									$('#ch_content').val(ch_content);
									$('#applnum').val(applnum);
								}
								$('#challengeSelect').on('change',
										updateContent);
							</script>
							<table class="table table-borderless">
								<tr>
									<td class="text-center">
										<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i
												class="bi bi-check2"></i>
										</button>
										<button type="reset" class="btn btn-light">다시입력</button>
										<button type="button" class="btn btn-light"
											onclick="location.href='${pageContext.request.contextPath}/certiboard/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
												class="bi bi-x"></i>
										</button> <c:if test="${mode == 'update'}">
											<input type="hidden" name="num" value="${dto.certifiedNum}">
											<input type="hidden" name="imageFilename"
												value="${dto.imageFilename}">
											<input type="hidden" name="page" value="${page}">
										</c:if>

									</td>
								</tr>
							</table>
						</form>
					</div>
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