<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.form-control::placeholder {
    color: #BDBDBD;
    font-weight: bold;
}

.body-container {
	max-width: 800px;
}

.table-style {
	border: 1px solid #ddd;
    border-radius: 8px;
    padding: 16px;
    margin: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    background-color: #fff;
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

@keyframes heart {
	0% {transform: translateY(0px) scale(1); opacity: 1;}
	100% {transform: translateY(-25px) scale(1.4); opacity: 0;}
}

.float-heart {
    position: absolute;
    font-size: 1.5em;
    color: #FF73B8;
    animation: heart 1s ease-in-out forwards;
}

.table-article img {max-width: 100%;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">
<!-- 클라이언트에 자바스크립트 소스를 보이지 않도록 하기 위한 장치 -->
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
	<script type="text/javascript">
		function deleteBoard() {
		    if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			    let query = "num=${dto.num}&${query}";
			    let url = "${pageContext.request.contextPath}/qnaboard/delete?" + query;
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
				<div class="row py-5 mt-5">
					<div class="col image-container">
					<img src="/nexfit/resources/images/qnapeople.png" class="background-image" style="width:1300px; height:200px; opacity: 0.3;">
					<img src="/nexfit/resources/images/qnalounge.png" class="overlay-image" style="width:550px; height:110px;"><br>
					<img src="/nexfit/resources/images/aae.png" class="overlay-image2" style="width:300px; height:20px;"> 
				</div>
				</div>
				
					<div class="row gx-2" style="font-family: 'nexon lv1 light'; font-weight: 600;">
						<jsp:include page="/WEB-INF/views/qnaboard/list_leftbar.jsp"></jsp:include>
						<div class="col-sm-7 mt-3"> <!-- mt-n : margin-top -->
						<main>
							<div class="container">
								<div class="body-container">	
									<div class="body-title">
										<h3 style="font-family: 'nexon lv2 medium';"> 질의 게시판 </h3>
									</div>
									
									<div class="body-main">
										
										<table class="table table-style">
											<thead>
												
												
												<tr>
													<td colspan="2" align="center" style="background: #1266FF; color: white; font-family: 'nexon lv2 medium';"> 
														<h5>Q. ${dto.subject}</h5>
													</td>
												</tr>
											</thead>
											
											<tbody>
												<tr>
													<td width="50%" style="text-align: left">
														이름 : ${dto.nickname}
													</td>
													<td align="right">
														${dto.reg_date} | 조회 ${dto.hitCount}
													</td>
												</tr>
												
												<tr>
													<td colspan="2" valign="top" height="200" style="border-bottom: none;" align="left">
														${dto.content}
													</td>
												</tr>
												
												<tr>
													<td colspan="2" style="text-align: left">
														이전글 :
														<c:if test="${not empty prevDto}">
															<a href="${pageContext.request.contextPath}/qnaboard/article?${query}&num=${prevDto.num}">${prevDto.subject}</a>
														</c:if>
													</td>
												</tr>
												<tr>
													<td colspan="2" style="text-align: left">
														다음글 :
														<c:if test="${not empty nextDto}">
															<a href="${pageContext.request.contextPath}/qnaboard/article?${query}&num=${nextDto.num}">${nextDto.subject}</a>
														</c:if>
													</td>
												</tr>
												<tr>
													<td width="50%" style="text-align: left;">
														<c:choose>
															<c:when test="${sessionScope.member.userId==dto.userId}">
																<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/qnaboard/update?num=${dto.num}&page=${page}';">수정</button>
															</c:when>
															<c:otherwise>
																<button type="button" class="btn btn-outline-dark" disabled>수정</button>
															</c:otherwise>
														</c:choose>
												    	
														<c:choose>
												    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
												    			<button type="button" class="btn btn-outline-dark" onclick="deleteBoard();">삭제</button>
												    		</c:when>
												    		<c:otherwise>
												    			<button type="button" class="btn btn-outline-dark" disabled>삭제</button>
												    		</c:otherwise>
												    	</c:choose>
													</td>
													<td class="text-end">
														<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/qnaboard/list?${query}';">리스트</button>
													</td>
												</tr>
											</tbody>
										</table>
										
										
										<div class="reply">
											<form name="replyForm" method="post">
												
												<table class="table table-borderless table-style reply-form">
													<tr>
														<td>
															<textarea class='form-control' name="content" placeholder="답변 이쁘게 해라."></textarea>
														</td>
													</tr>
													<tr>
													   <td align='right'>
													        <button type='button' class='btn btn-outline-dark btnSendReply'>댓글 등록</button>
													    </td>
													 </tr>
												</table>
											</form>
											
											<div id="listReply"></div>
										</div>
										
									</div>
								</div>
							</div>
						</main>
						
						</div>
						
					</div>

			</div>
		</main>
		
		
	</div>
	
<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, formData, dataType, fn, file = false) {
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
	
	if(file) {
		settings.processData = false;  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		settings.contentType = false;  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
	}
	
	$.ajax(url, settings);
}



// 리스트
$(function() {
	listPage(1);
});

function listPage(page) {
	let url = "${pageContext.request.contextPath}/qnaboard/listReply";
	let query = "num=${dto.num}&pageNo=" + page;
	let selector = "#listReply";
	
	const fn = function(data) {
		$(selector).html(data);
	}
	
	// AJAX - Text(html)
	ajaxFun(url, 'get', query, 'text', fn);
}

//댓글 등록
$(function() {
	$(".btnSendReply").click(function() {
		let num = "${dto.num}";
		const $tb = $(this).closest("table");
		let content = $tb.find("textarea").val().trim();
		
		if (! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		let url = "${pageContext.request.contextPath}/qnaboard/insertReply";
		let query = "num=" + num + "&content=" + content + "&answer=0";
		
		const fn = function(data) {
			$tb.find("textarea").val("");
			let state = data.state;
			if (state === "true") {
				listPage(1);
			} else {
				alert("댓글 등록에 실패했습니다.");
			}
		}
		
		ajaxFun(url, "post", query, "json", fn);
			
	})
})


//댓글 삭제
$(function() {
	$(".reply").on("click", ".deleteReply", function() {
		if (! confirm("댓글을 삭제하시겠습니까 ? ")) {
			return false;
		}
		
		let replyNum = $(this).attr("data-replyNum");
		let page = $(this).attr("data-pageNo");
		
		let url = "${pageContext.request.contextPath}/qnaboard/deleteReply";
		let query = "replyNum=" + replyNum;
		
		const fn = function(data) {
			listPage(page);
		}
		
		ajaxFun(url, "post", query, "json", fn);
		
	})
})


//댓글별 답글 리스트
function listReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/qnaboard/listReplyAnswer";
	let query = "answer=" + answer;
	let selector = "#listReplyAnswer" + answer;
	
	const fn = function(data) {
		$(selector).html(data);
	}
	
	ajaxFun(url, "get", query, "text", fn);
	
}


//댓글별 답글 개수
function countReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/qnaboard/countReplyAnswer";
	let query = "answer=" + answer;
	
	const fn = function(data) {
		let count = data.count;
		let selector = "#answerCount" + answer;
		$(selector).html(count);
	}
	
	ajaxFun(url, "post", query, "json", fn);
	
}


// 댓글별 답글 버튼
$(function() {
	$(".reply").on("click", ".btnReplyAnswerLayout", function() {
		const $trReplyAnswer = $(this).closest("tr").next();
		
		let isVisible = $trReplyAnswer.is(":visible");
		let replyNum = $(this).attr("data-replyNum");
		
		if (isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
			
			// 답글 리스트
			listReplyAnswer(replyNum);
			
			// 답글 개수
			countReplyAnswer(replyNum);
		}
		
	})
})


//댓글별 답글 등록
$(function() {
	$(".reply").on("click", ".btnSendReplyAnswer", function() {
		let num = "${dto.num}";
		let replyNum = $(this).attr("data-replyNum");
		const $td = $(this).closest("td");
		
		let content = $td.find("textarea").val().trim();
		if (! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		let url = "${pageContext.request.contextPath}/qnaboard/insertReply";
		let query = "num="+num+"&content="+content+"&answer="+replyNum;
		
		const fn = function(data) {
			$td.find("textarea").val("");
			
			let state = data.state;
			if (state === "true") {
				listReplyAnswer(replyNum);
				countReplyAnswer(replyNum);
			}
		}
		
		ajaxFun(url, "post", query, "json", fn);
		
	})
})


//댓글별 답글 삭제
$(function() {
	$(".reply").on("click", ".deleteReplyAnswer", function() {
		if (! confirm("답글을 삭제하시겠습니까 ? ")) {
			return false;
		}
		
		let replyNum = $(this).attr("data-replyNum");
		let answer = $(this).attr("data-answer");
		
		let url = "${pageContext.request.contextPath}/qnaboard/deleteReply";
		let query = "replyNum=" + replyNum;
		
		const fn = function(data) {
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		}
		
		ajaxFun(url, "post", query, "json", fn);
		
	})
})




</script>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>