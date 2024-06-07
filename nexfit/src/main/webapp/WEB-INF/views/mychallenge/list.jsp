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

.item {cursor: pointer; }
.item img { display: block; width: 100%; height: 180px; border-radius: 5px; }
.item img:hover { scale: 101.7%; }
.item .item-title {
	font-size: 16px;
	font-weight: 500;
	padding: 10px 2px 0;
	
	width: auto;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>

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
								class="text-with-border">내가 참여한 챌린지</h2>
						</div>
						<div class="body-main" style="font-family: nexon lv1 light">
							<div class="row mb-2 list-header">
								<div class="col-auto me-auto">
									<p class="form-control-plaintext">
										${dataCount}개(${page}/${total_page} 페이지)</p>
								</div>
								<div class="col-auto">
									<button type="button" class="btn btn-light"
										onclick="location.href='${pageContext.request.contextPath}/chboard/list';">챌린지 참가하기!</button>
								</div>
							</div>
							<c:forEach var="dto" items="${list}" varStatus="status">
							
							<div class="accordion" id="accordionExample">
  									<div class="accordion-item">
    								<h2 class="accordion-header">
    									<button class="accordion-button" type="button" data-bs-toggle="collapse" 
  									 data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style="font-size: 14px; width: 100%;">
       								 	<table style="width: 100%;">
            							<tr>
                							<td style="text-align: left;">참여 챌린지 : ${dto.board_subject}</td>
                							<td style="text-align: right;">${dto.start_date} ~ ${dto.end_date}</td>
                							<td style="text-align: right;">${dto.appl_state}</td>
            							</tr>
        								</table>
    									</button>
									</h2>
    									<div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
      										<div class="accordion-body">
      											<p>챌린지 종류 :${dto.ch_subject}</p>
												<p>참여점수 : ${dto.appl_score}</p>
												<p>${dto.compl_date }</p>
												<p>진행도 : </p>
												<c:set var="progressWidth" value="${(dto.appl_score / dto.requiredAc) * 100}" />
												<fmt:formatNumber value="${progressWidth}" type="number" maxFractionDigits="1" var="formattedProgressWidth" />
												<div class="progress" role="progressbar" aria-label="Example with label" aria-valuenow="${dto.appl_score}" aria-valuemin="0" aria-valuemax="${dto.requiredAc}">
    											<div class="progress-bar" style="width: ${formattedProgressWidth}%">${formattedProgressWidth}%</div>
												</div>
												<button class="custom-btn btn-8 btnsuccess" type="button" title="포인트받기"
													style="font-family: nexon lv2 medium">
													<i></i><span style="font-family: 'nexon lv2 medium';" id="success">${dto.appl_state=='성공'?'포인트받기':'진행중'}</span>
												</button>
      										</div>
   							 			</div>
  									</div>
  							</div>
								
								<p></p>
							</c:forEach>

							<div class="page-navigation">${dataCount == 0 ? "참여한 챌린지가 없습니다." : paging }
							</div>

						</div>

					</div>
					<jsp:include page="/WEB-INF/views/challenge/ch_rightbar.jsp"></jsp:include>
				</div>

			</div>

		</main>
		<script type="text/javascript">
		
		function ajaxFun(url, method, formData, dataType) {
			const settings = {
					type: method, 
					data: formData,
					dataType:dataType,
					success:function(data) {
						fn(data);
					},
					beforeSend: function(jqXHR) {
						jqXHR.setRequestHeader('AJAX', true);
					},
					complete: function () {
					},
					error: function(jqXHR) {
						if(jqXHR.status === 403) {
							login();
							return false;
						} else if(jqXHR.status === 400) {
							alert('요청 처리가 실패 했습니다.');
							return false;
				    	}
				    	
						console.log(jqXHR.responseText);
					}
			};
			
			
			$.ajax(url, settings);
		}
		$(function(){
			$(".btnsuccess").click(function(){
				
				let url = "${pageContext.request.contextPath}/mychallenge/success";
				let num = "${dto.certifiedNum}";
				let applnum = "${dto.applNumber}";
				let appls = "${dto.appl_state}";
				// var query = {num:num, isNoLike:isNoLike};
				let query = "num=" + num  +"&applnum="+applnum +"&appls="+appls;

				const fn = function(data) {
					let state = data.state;
					if(state === "true") {
						let color = "black";
						if( isNoAcceptance ) {
							color = "blue";
						}
						$i.css("color", color);
						
						let acceptance = data.acceptance;
						$("#success").text(state=='성공'?'달성완료':'진행중');
					} else if(state === "liked") {
					}
				};
				ajaxFun(url, "post", query, "json");
			});
		});
		</script>
	</div>
	<div class="container"></div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>