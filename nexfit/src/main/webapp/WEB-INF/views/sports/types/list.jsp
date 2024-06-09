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

.card-img-overlay {
	background-color: rgba( 255, 255, 255, 0.5 );
	display: none;
}

h5.card-title {
	font-family: nexon lv2 medium;
	font-size: 2rem;
	width: 100%;
}
</style>

</head>

<body>
	<div class="container-fluid px-0"  style="font-family: nexon lv2 medium;">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>

		<main>
			<div class="container-xxl text-center">
				<div class="row py-5">
					<div class="col">
						<img src="/nexfit/resources/images/sportstype.png" style="width:550px; height:110px; margin-top: 76px;"><br>
						<img src="/nexfit/resources/images/thc.png" class="overlay-image2" style="width:330px; height:25px;">
					</div>
				</div>

				<div class="row gx-2 pb-4">
					<div class="col">
						<form class="row justify-content-center" name="searchForm"
							action="${pageContext.request.contextPath}/sports/type/list"
							method="post">
							<div class="col-auto p-0 pb">
								<input type="text" id="keyword" name="keyword"
									class="form-control" style="width: 500px;">
							</div>
							<c:if test="${sessionScope.member.userId == 'admin'}">
								<div class="row text-end">
									<div class="col">
										<a class="btn btn-dark"
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
							class="btn btn-outline-dark" for="all">전체</label>

						<c:forEach var="entry" items="${map}" varStatus="status">
							<input type="radio" class="btn-check" name="btnBodyPart"
								id="${entry.key}" value="${entry.key}" autocomplete="off"
								${bodyPart == entry.key ? 'checked' : ''}>
							<label class="btn btn-outline-dark" for="${entry.key}">${entry.value}</label>
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
							<button type="button" class="btn-close btn-dark" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>

						<div class="modal-body">
							<div class="container-fluid">
								<div class="modal-image container-fluid pb-4">
									<img alt="" src="">
								</div>

								<div class="modal-content" style="border: none;"></div>
							</div>
						</div>

						<!-- 관리자면 푸터 표시, 수정/삭제 -->
						<c:if test="${sessionScope.member.userId == 'admin'}">
							<div class="modal-footer">
								<button type="button" class="btn btn-dark">수정</button>
								<button type="button" class="btn btn-dark">삭제</button>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</main>
	</div>
	
	<div style="height: 100px;"></div>

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

	$(".list-content").on("mouseover", ".card", function() { $(this).find(".card-img-overlay").show(); });
	$(".list-content").on("mouseout", ".card", function() { $(this).find(".card-img-overlay").hide(); });
	
	$(".list-content").on("click", ".card-body", event => event.target.closest('.card').querySelector(".btnModal").click() );
	
	$("#sportsDetailModal").on("shown.bs.modal", event => {
		const btnClicked = $(event.relatedTarget)[0];
		const num = btnClicked.getAttribute("data-num");
		
		let url = "${pageContext.request.contextPath}/sports/types/detail";
		let query = 'num=' + num;
		
		const fn = data => {
			const pathname = '${pageContext.request.contextPath}/uploads/sports/types/' + data.filename;
			const name = data.name;
			const content = data.description;
			const num = data.num;
			
			$("#sportsDetailModal").find(".modal-header > .modal-title").html(name);
			
			$("#sportsDetailModal").find('.modal-body .modal-image').html('<img src="' + pathname + '" class="w-100">');
			
			$("#sportsDetailModal").find(".modal-body .modal-content").html(content);
			
			$("#sportsDetailModal").find(".modal-footer").children().eq(0).click(event => {
				location.href = '${pageContext.request.contextPath}/sports/types/update?num=' + num;
			});
			
			$("#sportsDetailModal").find(".modal-footer").children().eq(1).click(event => {
				if (! confirm('삭제하시겠습니까?')) {
					return;
				}
				
				location.href = '${pageContext.request.contextPath}/sports/types/delete?num=' + num;
			});
			
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
		const num = item.num;
		const name = item.name;
		const filename = item.filename;
		const content = item.description;
		const deconstePermit = item.permit;
		const bodyPart = item.bodyPart;
		const filenum = item.filenum;

		htmlText = '<div class="col-xl-3 col-lg-4 col-sm-6 col-xs-12 pb-3 d-flex justify-content-center col-sport">';
		htmlText += '	<div class="card w-100 p-0 mb-2" style="min-height: 250px; max-height: 300px;" data-name="' + name + '">';
		htmlText += '		<div class="card-body p-0 h-100 w-100">';
		htmlText += '			<img src="${pageContext.request.contextPath}/uploads/sports/types/' + filename + '" class="card-img-top w-100 h-100" alt="' + name + '...">';
		htmlText += '			<div class="card-img-overlay">';
		htmlText += '				<div class="w-100 h-100 position-relative"><h5 class="card-title position-absolute top-50 start-50 translate-middle">' + name + '</h5></div>';
		htmlText += '			</div>';
		htmlText += '		</div>';
		htmlText += '		<input type="button" class="btnModal" style="display: none;"';
		htmlText += '			data-bs-toggle="modal" data-bs-target="#sportsDetailModal"';
		htmlText += '			data-num="' + num + '">';
		htmlText += '	</div>';
		htmlText += '</div>';

		sentinelNode.insertAdjacentHTML("beforebegin", htmlText);
	}

	if (pageNo <= totalPage) {
		sentinelNode.setAttribute("data-loading", "false");
		sentinelNode.style.display = "block";
		io.observe(sentinelNode);
	}
}

const ioCallback = (entries, io) => {
	entries.forEach((entry) => {
		if(entry.isIntersecting) {
			let loading = sentinelNode.getAttribute('data-loading');
			if(loading !== 'false') {
				return;
			}
			
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

$(function() {
	$("#keyword").keyup(function(event) {
        let keyword = $(this).val();
        $("div.col-sport").hide();
        $("div.col-sport").removeClass('d-flex');
        
        if (! keyword.trim()) {
	        $(".col-sport").show();
	        $(".col-sport").addClass('d-flex');
	        return;
        }
        
        let found = $(".card h5.card-title:contains(" + keyword + ")")

        $(found).closest(".col-sport").show();
        $(found).closest(".col-sport").addClass('d-flex');
	});
});

</script>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>