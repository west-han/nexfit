﻿<%@ page contentType="text/html; charset=UTF-8" %>
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


.heart {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 10em;
            color: red;
            opacity: 0;
            pointer-events: none;
            animation: none;
        }
        


@keyframes blink {
      0% {opacity: 0; transform: scale(1) rotateY(0deg);}
      50% {opacity: 0.8; transform: scale(1) rotateY(400deg) translateY(-25px);} 
      100% {opacity: 0; transform: scale(0) rotateY(800deg);}
   }
   
@keyframes break {
            0% {opacity: 0; transform: scale(1);}
            50% {opacity: 0.8; transform: scale(1) translateY(50px) rotate(-20deg);}
            100% {opacity: 0; transform: scale(1) translateY(50px) rotate(-20deg);}
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
			    let url = "${pageContext.request.contextPath}/board/delete?" + query;
		    	location.href = url;
		    }
		}
	</script>
</c:if>

	
<script>
		
		 let isLiked = false;

	     function toggleLike() {
	         isLiked = !isLiked;
	         showHeart(isLiked);
	         const likeButton = document.getElementById('likeButton');
	         likeButton.style.color = isLiked ? '#FF73B8' : 'black';
	         // Update the like count here if necessary
	     }

	     function showHeart(isLike) {
	         const heart = document.getElementById(isLike ? 'heart' : 'brokenHeart');
	         heart.style.animation = isLike ? 'blink 1.5s forwards' : 'break 1.5s forwards';

	         setTimeout(() => {
	             heart.style.animation = 'none';
	         }, 1500);
	     }
		 
</script>

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
					<img src="/nexfit/resources/images/exercisebg.PNG" class="background-image" style="width:1300px; height:200px; opacity: 0.3;">
					<img src="/nexfit/resources/images/freelounge.png" class="overlay-image" style="width:550px; height:110px;"><br>
					<img src="/nexfit/resources/images/sci.png" class="overlay-image2" style="width:330px; height:25px;">
				</div>
				</div>
				
					<div class="row gx-2" style="font-family: 'nexon lv1 light'; font-weight: 600;">
						<jsp:include page="/WEB-INF/views/board/list_leftbar.jsp"></jsp:include>
						<div class="col-sm-7 mt-3"> <!-- mt-n : margin-top -->
						<main>
							<div class="container">
								<div class="body-container">	
									<div class="body-title">
										<h3 style="font-family: 'nexon lv2 medium';"> 자유 게시판 </h3>
									</div>
									
									<div class="body-main">
										
										<table class="table table-style">
											<thead>
												<tr>
													<td colspan="2" align="center" style="background: black; color: white; font-family: 'nexon lv2 medium';"> 
														<h6><span style="color: orange;">[${dto.categoryName}]&nbsp; </span> ${dto.subject}</h6> 
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
													<td colspan="2">
														<c:forEach var="vo" items="${listFile}" varStatus="status">
															<p class="border text-secondary mb-1 p-2">
																<i class="bi bi-folder2-open"></i>
																<a href="${pageContext.request.contextPath}/board/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
															</p>
														</c:forEach>
													</td>
												</tr>				
												
												<tr>
													<td colspan="2" class="text-center p-3" style="position: relative;">
														<button type="button" class="btn btn-outline-secondary btnSendBoardLike" title="좋아요" style="color: ${isUserLike?'#FF73B8':'black'}" onclick="toggleLike()"><i class="far">🖤&nbsp;&nbsp;<span id="boardLikeCount">${dto.boardLikeCount}</span></i></button>
														<div class="heart" id="heart" style="margin-left: -100px; margin-top: -100px;">❤️</div>
														<div class="heart" id="brokenHeart" style="margin-left: -100px; margin-top: -100px;">💔</div>
													</td>
												</tr>
												
												<tr>
													<td colspan="2" style="text-align: left">
														이전글 :
														<c:if test="${not empty prevDto}">
															<a href="${pageContext.request.contextPath}/board/article?${query}&num=${prevDto.num}">${prevDto.subject}</a>
														</c:if>
													</td>
												</tr>
												<tr>
													<td colspan="2" style="text-align: left">
														다음글 :
														<c:if test="${not empty nextDto}">
															<a href="${pageContext.request.contextPath}/board/article?${query}&num=${nextDto.num}">${nextDto.subject}</a>
														</c:if>
													</td>
												</tr>
												<tr>
													<td width="50%" style="text-align: left;">
														<c:choose>
															<c:when test="${sessionScope.member.userId==dto.userId}">
																<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/board/update?num=${dto.num}&page=${page}';">수정</button>
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
														<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/board/list?${query}';">리스트</button>
													</td>
												</tr>
											</tbody>
										</table>
										
										
										<div class="reply">
											<form name="replyForm" method="post">
												
												<table class="table table-borderless table-style reply-form">
													<tr>
														<td>
															<textarea class='form-control' name="content" placeholder="댓글 이쁘게 써라."></textarea>
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

// 게시글 공감 여부
$(function() {
	$('.btnSendBoardLike').hover(function() {
        const floatHeart = $('<i class="far float-heart" style="margin-left: -51px;">🖤</i>');
       
        $(this).parent().append(floatHeart);
        
        setTimeout(function() {
            floatHeart.remove();
        }, 1000);
    });
	
	$('.btnSendBoardLike').click(function(){
		const $i = $(this).find("i");
		let isNoLike = $i.css("color") === "rgb(0, 0, 0)";
		let msg = isNoLike ? '게시글에 공감하시겠습니까 ?' : '게시글 공감을 취소하시겠습니까 ?';
		
		if (! confirm(msg)) {
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/board/insertBoardLike';
		let num = '${dto.num}';
		let query = "num=" + num + "&isNoLike=" + isNoLike;
		
		const fn = function(data) {
			let state = data.state;
			if (state === 'true') {
				let color = 'black';
				if (isNoLike) {
					color = '#FF73B8';
				}
				$i.css("color", color);
				
				let count = data.boardLikeCount;
				$('#boardLikeCount').text(count);
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
		
	});
});

// 리스트
$(function() {
	listPage(1);
});

function listPage(page) {
	let url = "${pageContext.request.contextPath}/board/listReply";
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
		
		let url = "${pageContext.request.contextPath}/board/insertReply";
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
		
		let url = "${pageContext.request.contextPath}/board/deleteReply";
		let query = "replyNum=" + replyNum;
		
		const fn = function(data) {
			listPage(page);
		}
		
		ajaxFun(url, "post", query, "json", fn);
		
	})
})


//댓글별 답글 리스트
function listReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/board/listReplyAnswer";
	let query = "answer=" + answer;
	let selector = "#listReplyAnswer" + answer;
	
	const fn = function(data) {
		$(selector).html(data);
	}
	
	ajaxFun(url, "get", query, "text", fn);
	
}


//댓글별 답글 개수
function countReplyAnswer(answer) {
	let url = "${pageContext.request.contextPath}/board/countReplyAnswer";
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
		
		let url = "${pageContext.request.contextPath}/board/insertReply";
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
		
		let url = "${pageContext.request.contextPath}/board/deleteReply";
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