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

<style type="text/css">
.body-container {
	max-width: 800px;
}
</style>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>

		<main class="mt-5">
			<div class="container-xxl text-center">
				<div class="row py-5">
					<div class="col">
						<h1 class="fs-1 text-start">운동 목록</h1>
					</div>
				</div>

				<div class="row gx-2 pb-4">
					<div class="col">
						<form class="row justify-content-center" name="searchForm"
							action="${pageContext.request.contextPath}/sports/type/list"
							method="post">
							<div class="col-auto p-0 pb">
								<input type="text" name="keyword" value="${keyword}"
									class="form-control" style="width: 500px;">
							</div>
							<div class="col-auto p-0">
								<button type="button" class="btn btn-light"
									onclick="searchList()" style="">
									<i class="bi bi-search"></i>
								</button>
							</div>
							<c:if test="${sessionScope.member.userId == 'admin'}">
								<div class="row text-end">
									<div class="col">
										<a class="btn btn-primary"
											href="${pageContext.request.contextPath}/sports/types/write"
											role="button">추가</a>
									</div>
								</div>
							</c:if>
						</form>
					</div>
				</div>
				<div class="row pb-4">
					<div class="btn-group-lg" role="group"
						aria-label="Basic radio toggle button group" id="btnsTypeSelect">
						<input type="radio" class="btn-check" name="btnBodyPart" id="all"
							value="all" autocomplete="off"
							${bodyPart == 'all' ? 'checked' : ''}> <label
							class="btn btn-outline-primary" for="all">전체</label>

						<c:forEach var="entry" items="${map}" varStatus="status">
							<input type="radio" class="btn-check" name="btnBodyPart"
								id="${entry.key}" value="${entry.key}" autocomplete="off"
								${bodyPart == entry.key ? 'checked' : ''}>
							<label class="btn btn-outline-primary" for="${entry.key}">${entry.value}</label>
						</c:forEach>
					</div>
				</div>

				<div class="list-content row justify-content-start gx-2"
					data-pageNo="0" data-totalPage="0">
					
					<div class="sentinel" data-loading="false"></div>
				</div>
			</div>

			<!-- 모달창 -->
			<div class="modal fade" id="sportsDetailModal" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Modal title</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>

						<div class="modal-body">
							<div class="container-fluid">
								<div class="modal-image">
									<img alt="" src="">
								</div>

								<div class="modal-content"></div>
							</div>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>

<script type="text/javascript">
function login() {
	location.href = "${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	const sentinelNode = document.querySelector('.sentinel');
	
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR) {
			sentinelNode.setAttribute('data-loading', 'true');
			
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

$(function() {
	$("#btnsTypeSelect").on("click", ".btn-check", function() {
		let bodyPart = $(this).val().trim();
		
		let url = "${pageContext.request.contextPath}/sports/types/list?bodyPart=" + bodyPart + "&pageNo=" + 1;
		
		location.href = url;
	});

	$(".list-content").on("mouseover", ".card-body", () => $(this).find(".card-img-overlay").show());
	$(".list-content").on("mouseout", ".card-body", () => $(this).find(".card-img-overlay").hide());
	
	$(".list-content").on("click", ".card-body", () => $(this).find(".btnModal").click());
	
	$("#sportsDetailModal").on("show.bs.modal", event => {
		const btnClicked = $(event.relatedTarget)[0];
		const num = btnClicked.getAttribute("data-num");
		
		let url = "${pageContext.request.contextPath}/sports/types/detail"
		let query = 'num=' + num;
		
		const fn = data => {
			const pathname = '${pageContext.request.contextPath}/uploads/sports/types/' + data.filename;
			const name = data.name;
			const content = data.description;
			console.log(name, content);
			
			$("#sportsDetailModal").find('.modal-body').html('<div> <h1>' + name + '</h1> <p>' + content + '</p>');
		};
		
		ajaxFun(url, 'get', query, 'json', fn);
	});
});

const sentinelNode = $('.sentinel')[0];
const listNode = document.querySelector(".list-content");

function loadContent(bodyPart, page) {
	let url = "${pageContext.request.contextPath}/sports/types/listAjax";
	let query = "bodyPart=" + bodyPart + "&pageNo=" + page;
	
	const fn = data => addNewContent(data);
	
	ajaxFun(url, "get", query, "json", fn);
}

function addNewContent(data) {
	let dataCount = data.dataCount;
	let pageNo = data.pageNo;
	let totalPage = data.totalPage;
	
	listNode.setAttribute('data-pageNo', pageNo);
	listNode.setAttribute('data-totalPage', totalPage);
	
	sentinelNode.style.display = "none";
	
	if (parseInt(dataCount) === 0) {
		listNode.innerHTML = "";
		return;
	}
	
	let htmlText;
	
	for (let item of data.list) {
		let num = item.num;
		let name = item.name;
		let filename = item.filename;
		let content = item.description;
		let deletePermit = item.permit;
		let bodyPart = item.bodyPart;
		let filenum = item.filenum;

		htmlText = '<div class="col-xl-3 col-lg-4 col-sm-6 col-xs-12 pb-3 d-flex justify-content-center">';
		htmlText += '	<div class="card w-100 p-2">';
		htmlText += '		<div class="card-body">';
		htmlText += '			<img src="${pageContext.request.contextPath}/uploads/sports/types/' + filename + '" class="card-img-top" alt="' + name + '...">';
		htmlText += '			<div class="card-img-overlay" style="display: none;">';
		htmlText += '				<h5 class="card-title">' + name + '</h5>';
		htmlText += '			</div>';
		htmlText += '		</div>';
		htmlText += '	</div>';
		htmlText += '	<input type="button" class="btnModal" style="display: none;"';
		htmlText += '		data-bs-toggle="modal" data-bs-target="#sportsDetailModal"';
		htmlText += '		data-num="' + num + '">';
		htmlText += '</div>';

		listNode.insertAdjacentHTML("beforeend", htmlText);
	}
	
	if (pageNo < totalPage) {
		sentinelNode.setAttribute("data-loading", "false");
		sentinelNode.style.display = "block";
		
		io.observe(sentinelNode);
	}
}

const ioCallback = (entries, io) => {
	entries.forEach((entry) => {
		if(entry.isIntersecting) { // 관찰자가 화면에 보이면
			// 현재 페이지가 로딩중이면 빠져 나감
			let loading = sentinelNode.getAttribute('data-loading');
			if(loading !== 'false') {
				return;
			}
			
			// 기존 관찰하던 요소는 더이상 관찰하지 않음
			io.unobserve(entry.target);
			
			let pageNo = parseInt(listNode.getAttribute('data-pageNo'));
			let total_page = parseInt(listNode.getAttribute('data-totalPage'));
			let bodyPart = document.querySelector("input[name=btnBodyPart]:checked").value;
			
			if(pageNo === 0 || pageNo < total_page) {
				pageNo++;
				loadContent(bodyPart, pageNo);
			}
		}
	});
};

const io = new IntersectionObserver(ioCallback);
io.observe(sentinelNode);

</script>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>