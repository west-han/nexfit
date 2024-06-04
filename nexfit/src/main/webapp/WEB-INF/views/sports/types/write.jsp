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
        f.name.focus();
        return;
    }

    str = f.bodyPart.value.trim();
    if(!str) {
        alert("운동 부위를 선택하세요. ");
        f.bodyPart.focus();
        return;
    }
    str = f.description.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.description.focus();
        return;
    }

    var mode = "${mode}";
    console.log($('form-control-plaintext > span').html);
    if( mode == 'write' && !f.selectFile.value ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/sports/types/" + mode;
	f.submit();
}

</script>
<c:if test="${mode == 'update'}">
<script type="text/javascript">
function deleteFile(num) {
	if (! confirm('파일을 삭제하시겠습니까 ? ')) {
		return;
	}
	
	let q = 'num=' + num;
	location.href = '${pageContext.request.contextPath}/sports/types/deleteFile?' + q;
}
</script>
</c:if>
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
										<input type="text" name="name" class="form-control" value="${dto.name}">
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2" scope="row">운동 부위</td>
									<td>
										<select name="bodyPart" class="form-select" style="width: 100px;">
											<c:forEach var="entry" items="${map}" varStatus="status">
												<option value="${entry.key}" ${mode == 'update' && dto.bodyPart == entry.key ? 'selected' : ''}>${entry.value}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2" scope="row">설명</td>
									<td>
										<textarea name="description" id="description" class="form-control">${dto.description}</textarea>
									</td>
								</tr>
								
								<tr>
									<td class="bg-light col-sm-2">이미지</td>
									<td> 
										<input type="file" name="selectFile" multiple class="form-control">
									</td>
								</tr>
								
								<c:if test="${mode=='update'}">
									<tr>
										<td class="bg-light col-sm-2" scope="row">등록이미지</td>
										<td>
											<p class="form-control-plaintext">
												<a href="javascript:deleteFile(${dto.num})"><i class="bi bi-trash"></i></a>
												<span>${dto.filename}</span>
											</p>
										</td>
									</tr>
								</c:if>
							</table>
							
							<table class="table table-borderless">
			 					<tr>
									<td class="text-center">
										<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
										<button type="reset" class="btn btn-light">다시입력</button>
										<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/sports/types/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
										<c:if test="${mode=='update'}">
											<input type="hidden" name="num" value="${dto.num}">
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