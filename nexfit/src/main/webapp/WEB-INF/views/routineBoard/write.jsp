<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
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

    f.action = "${pageContext.request.contextPath}/routine/${mode}";
    f.submit();
}
</script>
</head>
<body>
	<div class="container">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
		</header>
		
		<main>
		<div class="body-container">	
			<div class="body-title">
				<h3><i class="bi bi-app"></i> ROUTINE </h3>
			</div>
			
			<div class="body-main">
				<form name="boardForm" method="post">
					<table class="table write-form mt-5">
						<tr>
							<td class="bg-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">유 형</td>
							<td>
								<input type="radio" class="btn-check" name="options" id="option1"  value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option1">추천</label>
								
								<input type="radio" class="btn-check" name="options" id="option2"  value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option2">질문</label>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">운 동</td>
							<td>
								<select name="schType" class="form-select" style="width: 100px;">
									<option value="health">헬스</option>
									<option value="swimming">수영</option>
									<option value="climbing">클라이밍</option>
									<option value="volleyball">배구</option>
									<option value="kick">킥복싱</option>
								</select> 
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">운동경력</td>
							<td>
								<input type="radio" class="btn-check" name="options1" id="option3" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option3">~6개월</label>
								
								<input type="radio" class="btn-check" name="options1" id="option4" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option4">6개월~1년</label>
								
								<input type="radio" class="btn-check" name="options1" id="option5" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option5">1년~3년</label>
								
								<input type="radio" class="btn-check" name="options1" id="option6" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option6">3년~7년</label>
							
								<input type="radio" class="btn-check" name="options1" id="option7" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option7">7년~</label>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">요일</td>
							<td>
								<input type="checkbox" class="btn-check" id="btn-check1" autocomplete="off">
								<label class="btn btn-primary" for="btn-check1">일</label>
								
								<input type="checkbox" class="btn-check" id="btn-check2" autocomplete="off">
								<label class="btn btn-primary" for="btn-check2">월</label>
								
								<input type="checkbox" class="btn-check" id="btn-check3" autocomplete="off">
								<label class="btn btn-primary" for="btn-check3">화</label>
								
								<input type="checkbox" class="btn-check" id="btn-check4" autocomplete="off">
								<label class="btn btn-primary" for="btn-check4">수</label>
								
								<input type="checkbox" class="btn-check" id="btn-check5" autocomplete="off">
								<label class="btn btn-primary" for="btn-check5">목</label>
								
								<input type="checkbox" class="btn-check" id="btn-check6" autocomplete="off">
								<label class="btn btn-primary" for="btn-check6">금</label>
								
								<input type="checkbox" class="btn-check" id="btn-check7" autocomplete="off">
								<label class="btn btn-primary" for="btn-check7">토</label>
							</td>
						</tr>
	
						<tr>
							<td class="bg-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/bbs/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
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
		</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>