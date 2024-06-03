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
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function check() {
    const f = document.boardForm;
	let str;
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return false;
    }

    str = f.content.value.trim();
    if(! str || str === "<p><br></p>") {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/routine/${mode}";
    return true;
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
								<input type="radio" class="btn-check" name="postType" id="option1"  value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option1">추천</label>
								
								<input type="radio" class="btn-check" name="postType" id="option2"  value="2" autocomplete="off">
								<label class="btn btn-secondary" for="option2">질문</label>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">운 동</td>
							<td>
								<select name="sports" class="form-select" style="width: 100px;">
									<option value="1">헬스</option>
									<option value="2">수영</option>
									<option value="3">클라이밍</option>
									<option value="4">배구</option>
									<option value="5">킥복싱</option>
									<option value="6">기타</option>
								</select> 
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">운동경력</td>
							<td>
								<input type="radio" class="btn-check" name="career" id="option3" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option3">~6개월</label>
								
								<input type="radio" class="btn-check" name="career" id="option4" value="2" autocomplete="off">
								<label class="btn btn-secondary" for="option4">6개월~1년</label>
								
								<input type="radio" class="btn-check" name="career" id="option5" value="3" autocomplete="off">
								<label class="btn btn-secondary" for="option5">1년~3년</label>
								
								<input type="radio" class="btn-check" name="career" id="option6" value="4" autocomplete="off">
								<label class="btn btn-secondary" for="option6">3년~7년</label>
							
								<input type="radio" class="btn-check" name="career" id="option7" value="5" autocomplete="off">
								<label class="btn btn-secondary" for="option7">7년~</label>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">주n일</td>
							<td>
								<input type="radio" class="btn-check" name="week" id="option8" value="1" autocomplete="off">
								<label class="btn btn-secondary" for="option8">주1회</label>
								
								<input type="radio" class="btn-check" name="week" id="option9" value="2" autocomplete="off">
								<label class="btn btn-secondary" for="option9">주2회</label>
								
								<input type="radio" class="btn-check" name="week" id="option10" value="3" autocomplete="off">
								<label class="btn btn-secondary" for="option10">주3회</label>
								
								<input type="radio" class="btn-check" name="week" id="option11" value="4" autocomplete="off">
								<label class="btn btn-secondary" for="option11">주4회</label>
							
								<input type="radio" class="btn-check" name="week" id="option12" value="5" autocomplete="off">
								<label class="btn btn-secondary" for="option12">주5회</label>
								
								<input type="radio" class="btn-check" name="week" id="option13" value="6" autocomplete="off">
								<label class="btn btn-secondary" for="option13">주6회</label>
								
								<input type="radio" class="btn-check" name="week" id="option14" value="7" autocomplete="off">
								<label class="btn btn-secondary" for="option14">주7회</label>
							</td>
						</tr>
						
						
						<!--
						<tr>
							<td class="bg-light col-sm-2" scope="row">요일</td>
							<td>
								<input type="checkbox" class="week" name="week" id="btn-check1" value="1" autocomplete="off">
								<label class="btn btn-primary" for="btn-check1">주1회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check2" value="2" autocomplete="off">
								<label class="btn btn-primary" for="btn-check2">주2회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check3" value="3" autocomplete="off">
								<label class="btn btn-primary" for="btn-check3">주3회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check4" value="4" autocomplete="off">
								<label class="btn btn-primary" for="btn-check4">주4회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check5" value="5" autocomplete="off">
								<label class="btn btn-primary" for="btn-check5">주5회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check6" value="6" autocomplete="off">
								<label class="btn btn-primary" for="btn-check6">주6회</label>
								
								<input type="checkbox" class="week" name="week" id="btn-check7" value="7" autocomplete="off">
								<label class="btn btn-primary" for="btn-check7">주7회</label>
							</td>
						</tr>
						-->
						
						<tr>
							<td class="bg-light col-sm-2"  scope="row">내 용</td>
							<td>
								<textarea name="content" id="ir1" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="submitContents(this.form);">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/routine/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});

function submitContents(elClickedObj) {
	 oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	 try {
		if(! check()) {
			return;
		}

		elClickedObj.submit();
	} catch(e) {
	}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 12;
	oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>