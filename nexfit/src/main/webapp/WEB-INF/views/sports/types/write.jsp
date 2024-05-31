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

<script type="text/javascript">
function sendOk() {
    const f = document.sportsTypeForm;
	let str;
	
    str = f.name.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

    str = f.bodyPart.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }
    str = f.description.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

    var mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/sports/types/write";
    f.submit();
}

</script>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>

		<main class="pb-5">
			<div class="row justify-content-center">
				<div class="col-6">
					<div class="body-title pt-5">
						<h3><i class="bi bi-app"></i> ROUTINE </h3>
					</div>
					
					<div class="body-main">
						<form name="sportsTypeForm" method="post" enctype="multipart/form-data">
							<table class="table write-form mt-5">
								<tr>
									<td class="bg-light col-sm-2" scope="row">운동 이름</td>
									<td>
										<input type="text" name="name" class="form-control" value="${dto.subject}">
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2" scope="row">운동 부위</td>
									<td>
										<select name="bodyPart" class="form-select" style="width: 100px;">
											<option value="chest">가슴</option>
											<option value="back">등</option>
											<option value="lowerBody">하체</option>
											<option value="shoulders">어깨</option>
											<option value="triceps">삼두</option>
											<option value="biceps">이두</option>
											<option value="core">코어</option>
											<option value="forearm">전완근</option>
											<option value="aerobic">유산소</option>
											<option value="sports">스포츠</option>
										</select> 
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2" scope="row">설명</td>
									<td>
										<textarea name="description" id="content" class="form-control">${dto.content}</textarea>
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2" scope="row">이미지</td>
									<td>
										<input type="file" name="selectFile" accept="image/*" multiple="multiple" class="form-control">
									</td>
								</tr>
							</table>
							
							<table class="table table-borderless">
			 					<tr>
									<td class="text-center">
										<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
										<button type="reset" class="btn btn-light">다시입력</button>
										<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sports/types/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
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
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>