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
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function sendOk() {
    const f = document.boardForm;
	let str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/qnaboard/${mode}";
    f.submit();
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
									<div class="row py-5">
										
									</div>
									
		<c:forEach var="i" begin="0" end="0">
			<div class="row gx-2">
				<div class="col-sm-2"></div>
				<div class="col-sm-7">
					<main>
						<div class="container">
							<div class="body-container" style="font-family: 'nexon lv2 medium';">	
								<div class="body-title">
									<h3 style="font-family: 'nexon lv2 medium';">질의 게시판 </h3>
								</div>
								
								<div class="body-main">
									<form name="boardForm" method="post">
										<table class="table write-form mt-5 table-style">
											<tr>
												<td class="bg-light col-sm-2" scope="row">제 목</td>
												<td>
													<input type="text" name="subject" class="form-control" value="${dto.subject}">
												</td>
											</tr>
						        
						
											<tr>
												<td class="bg-light col-sm-2" scope="row">내 용</td>
												<td>
													<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
												</td>
											</tr>
										</table>
										 
										<table class="table table-borderless table-style">
						 					<tr>
												<td class="text-center">
													<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
													<button type="reset" class="btn btn-light">다시입력</button>
													<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/qnaboard/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
													<c:if test="${mode=='update'}">
														<input type="hidden" name="num" value="${dto.num}">
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
						
					</div>
				</c:forEach>
			</div>
		</main>
	</div>
	<div class="row py-5">
										
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>