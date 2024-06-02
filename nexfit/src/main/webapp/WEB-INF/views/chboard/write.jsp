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
	
    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }
    
    var selectElement = document.getElementById('challengeSelect');
    var selectedValue = selectElement.value.trim();
    
    if (selectedValue === "none") {
        alert("챌린지를 선택하세요!");
        selectElement.focus();
        return;
    }
    
    str = f.start_date.value.trim();
    if(!str) {
        alert("시작일을 선택하세요 ");
        f.content.focus();
        return;
    }
    
    str = f.end_date.value.trim();
    if(!str) {
        alert("기간을 선택하세요 ");
        f.content.focus();
        return;
    }
    
    
    str = f.content.value.trim();
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }
    

    let mode = "${mode}";
    if( (mode === "write") && (!f.selectFile.value) ) {
        alert("이미지 파일을 추가 하세요. ");
        f.selectFile.focus();
        return;
    }
    
    f.action = "${pageContext.request.contextPath}/chboard/${mode}";
    f.submit();
}

$(function() {
	let img = "${dto.imageFilename}";
	if( img ) { // 수정인 경우
		img = "${pageContext.request.contextPath}/uploads/photo/" + img;
		$(".write-form .img-viewer").empty();
		$(".write-form .img-viewer").css("background-image", "url("+img+")");
	}
	
	$(".write-form .img-viewer").click(function(){
		$("form[name=photoForm] input[name=selectFile]").trigger("click"); 
	});
	
	$("form[name=photoForm] input[name=selectFile]").change(function(){
		let file=this.files[0];
		if(! file) {
			$(".write-form .img-viewer").empty();
			if( img ) {
				img = "${pageContext.request.contextPath}/uploads/photo/" + img;
				$(".write-form .img-viewer").css("background-image", "url("+img+")");
			} else {
				img = "${pageContext.request.contextPath}/resources/images/add_photo.png";
				$(".write-form .img-viewer").css("background-image", "url("+img+")");
			}
			return false;
		}
		
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		let reader = new FileReader();
		reader.onload = function(e) {
			$(".write-form .img-viewer").empty();
			$(".write-form .img-viewer").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});
});


document.addEventListener('DOMContentLoaded', function() {
   
    var startDateInput = document.getElementById('start_date');
   
    var today = new Date().toISOString().split('T')[0];
   
    startDateInput.min = today;
});
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
				<h3><i class="bi bi-clipboard"></i> NEW 챌린지게시글 등록 </h3>
			</div>
			
			<div class="body-main">
				<form name="photoForm" method="post" enctype="multipart/form-data">
					<table class="table write-form mt-5">
						<tr>
							<td class="bg-light col-sm-2" scope="row">제 목</td>
							<td>
								<input type="text" name="subject" class="form-control" value="${dto.subject}">
							</td>
						</tr>
	        
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지 선택</td>
	 						<td>
								<select name="challengeId" id="challengeSelect" class="form-select" aria-label="Default select example">
								  <option selected value="none">챌린지를 선택하세요!</option>
								  <c:forEach var="dto" items="${list}" varStatus="status">
								  	<option  value="${dto.challengeId}" data-content="${dto.ch_content}" data-fee="${dto.fee}" data-challengeId="${dto.challengeId}">${dto.ch_subject}</option>
								  </c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">날짜 선택</td>
							<td>
								시작일 :
								<input type="date" name="start_date" id="start_date" class="form-control date-input" placeholder="시작날짜" value="${dto.start_date}">
								종료일 :
                				<input type="date" name="end_date" id="end_date" class="form-control date-input" placeholder="종료날짜" value="${dto.end_date}" readonly>
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">기간 선택</td>
							<td>
								<button type="button" class="btn btn-secondary" data-days="14">14일</button>
								<button type="button" class="btn btn-secondary" data-days="30">30일</button>
								<button type="button" class="btn btn-secondary" data-days="90">90일</button>
							</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">챌린지 소개</td>
							 <td>
                				  <textarea name="ch_content" id="ch_content" class="form-control" readonly style="height: 200px"></textarea>
            				</td>
						</tr>
						<tr>
							<td class="bg-light col-sm-2" scope="row">내 용</td>
							<td>
								<textarea name="content" id="content" class="form-control">${dto.content}</textarea>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">참가비</td>
							<td>
								<input name="fee" id="fee" class="form-control w-25" readonly>
							</td>
						</tr>
						
						<tr>
							<td class="bg-light col-sm-2" scope="row">이미지</td>
							<td>
								<div class="img-viewer"></div>
								<input type="file" name="selectFile" accept="image/*" class="form-control" style="display: none;">
							</td>
						</tr>
						
					</table>
					
	 	 <script>
	 	 function updateContent() {
	         var select = document.getElementById('challengeSelect');
	         var selectedOption = select.options[select.selectedIndex];
	         var content = selectedOption.getAttribute('data-content');
	         var fee = selectedOption.getAttribute('data-fee');
	         var challengeId = selectedOption.getAttribute('data-challengeId');
	         document.getElementById('ch_content').value = content;
	         document.getElementById('fee').value=fee;
	         document.getElementById('challengeId').value=challengeId;
	     }
		//챌린지 선택시 이벤트 추가 
	     document.getElementById('challengeSelect').addEventListener('change', updateContent);
			
        function setEndDate(days) {
            var startDateInput = document.getElementById('start_date');
            var endDateInput = document.getElementById('end_date');
            var startDate = new Date(startDateInput.value);

            if (!isNaN(startDate.getTime())) { 
                startDate.setDate(startDate.getDate() + days); 
                var endDate = startDate.toISOString().split('T')[0]; 
                endDateInput.value = endDate;
            }
        }

        function clearSelection() {
            document.querySelectorAll('.btn.btn-secondary').forEach(button => {
                button.classList.remove('selected');
            });
        }

        document.querySelectorAll('.btn.btn-secondary').forEach(button => {
            button.addEventListener('click', function() {
                clearSelection();
                this.classList.add('selected');
                var days = parseInt(this.getAttribute('data-days'));
                setEndDate(days);
            });
        });
       
    </script>
					
					<table class="table table-borderless">
	 					<tr>
							<td class="text-center">
								<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
								<button type="reset" class="btn btn-light">다시입력</button>
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/chboard/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
								
								<c:if test="${mode == 'update'}">
									<input type="hidden" name="num" value="${dto.boardnum}">
									<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
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