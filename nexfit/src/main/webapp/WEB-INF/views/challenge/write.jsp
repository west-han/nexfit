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
    const f = document.newChellengeForm;
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
    
    str = f.fee.value.trim();
    if(!str) {
        alert("참가비를 입력하세요. ");
        f.content.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/chellenge/${mode}";
    f.submit();
}
</script>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>
		<div class="container">
		</div>
		<main>
		<div class="container">
		<div class="body-container m-auto" >	
			<div class="body-title">
				<h3><i class="bi bi-clipboard"></i> NEW 챌린지 등록 </h3>
			</div>
			
			<div class="body-main">
				<form name="newChellengeForm" method="post" enctype="multipart/form-data">
					<table class="table write-form mt-5">
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지명</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.ch_subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="bg-light col-sm-2" scope="row">작성자명</td>
	 						<td>
								<p class="form-control-plaintext">${sessionScope.member.userName}</p>
							</td>
						</tr>
	
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지 소개 및 <br>규 &nbsp;&nbsp;칙</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.ch_content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2">참&nbsp;가&nbsp;비</td>
							<td>
								<input type="text" name="fee" class="form-control" value="${dto.fee}" style="width: 200px;">
							</td>
						</tr>
						
					</table>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/chellenge/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								<c:if test="${mode == 'update'}">
									<input type="hidden" name="chellengeId" value="${dto.chellengeId}">
									<input type="hidden" name="size" value="${size}">
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
	
	<div class="container">
	
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>