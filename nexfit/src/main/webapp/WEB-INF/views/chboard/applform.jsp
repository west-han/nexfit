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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/button.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/button2.css">
<style type="text/css">
.body-container {
	max-width: 800px;
}

.write-form .img-viewer {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	border-radius: 45px;
	background-image: url("${pageContext.request.contextPath}/resources/images/add_photo.png");
	position: relative;
	z-index: 9999;
	background-repeat : no-repeat;
	background-size : cover;
}

  .date-input {
      display: inline-block;
      width: auto; 
      margin-right: 10px; 
        }
        
   .selected {
       background-color: #E0115F;
       color: white;
        }
</style>

<script type="text/javascript">
function sendOk() {
    const f = document.photoForm;
	let str;
	
    
    str = f.coment.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.coment.focus();
        return;
    }
    
    var count =f.count.value.trim();
    if(parseInt(count) > 0) {
        alert("이미 신청한 챌린지 입니다.");
        f.action = "${pageContext.request.contextPath}/chboard/list";
        return;
    }
    
    
    
    
    f.action = "${pageContext.request.contextPath}/chboard/applform";
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
		<div class="container py-5">
		<div class="body-container m-auto " >	
			<div class="body-title py-5">
				<h3><i class="bi bi-clipboard"></i> 챌린지 신청서 </h3>
			</div>
			
			<div class="body-main" style="font-family: nexon lv1 light">
				<form name="photoForm" method="post" enctype="multipart/form-data">
					<table class="table write-form mt-5">
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">게시물 제목</td>
	 						<td>
								<input class="form-control w-30" value="${dto.subject}" readonly>
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지명</td>
	 						<td>
								<input class="form-control w-30" value="${dto.ch_subject}" readonly>
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지 기간</td>
							<td>
								시작일 :
								<input type="date" name="start_date" id="start_date" class="form-control date-input" placeholder="시작날짜" value="${dto.start_date}">
								종료일 :
                				<input type="date" name="end_date" id="end_date" class="form-control date-input" placeholder="종료날짜" value="${dto.end_date}" readonly>
                				
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">한줄각오</td>
							<td>
								<input type="text" name="coment" class="form-control">
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">참가비</td>
							<td>
								<input name="fee" id="fee" class="form-control w-25" readonly value="${dto.fee}">
							</td>
						</tr>
						
	
					</table>
					<input type="hidden" name="boardnum" value="${dto.boardNumber}">
	 
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="button button--nuka" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="button button--nuka">다시입력</button>
								<button type="button" class="button button--nuka" onclick="location.href='${pageContext.request.contextPath}/chboard/article?page=${page}&num=${num}';">신청취소&nbsp;<i class="bi bi-x"></i></button>
								
								
									<input type="hidden" name="num" value="${dto.boardNumber}">
									<input type="hidden" name="count" value="${count}">
						
			
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