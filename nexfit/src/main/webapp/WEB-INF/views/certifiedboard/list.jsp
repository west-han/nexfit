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
<style type="text/css">
.body-container {
	max-width: 800px;
}

.background-image {
    position: absolute;
    top: 30px;
    left: 0;
    width: 100%; 
    height: 45%; 
    z-index: -1; 
    object-fit: cover; 
    opacity: 0.7; 
}

.text-with-border {
    color: white; 
    text-shadow: 
        -1px -1px 0 black,  
        1px -1px 0 black,
        -1px 1px 0 black,
        1px 1px 0 black; 
}

</style>

 <script type="text/javascript">
        // 마우스 클릭을 막음
        function disableImageClick(event) {
            event.preventDefault();
        }

      $(window).on('load', function() {
    		$('#no-click-image').on('click', disableImageClick);
		});
      
      function searchList() {
    		const f = document.searchForm;
    		f.submit();
    	}
     
    </script>
   <script>
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    
    if (message) {
        alert(message);
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
			<div class="container mt-5">
			
			</div>
				<div class="row py-5"> <%-- 챌린지게시판로고 --%>
					<div class="col-11">
						<img src="/nexfit/resources/images/3.jpg" class="background-image">
						<a href="${pageContext.request.contextPath}/chboard/list"><img src="/nexfit/resources/images/challenge.png"></a> 
						<p><img id="no-click-image" src="/nexfit/resources/images/passion.png"></p>
					</div>
				</div>
				
				
		<div class="row gx-2">
		
				<jsp:include page="/WEB-INF/views/challenge/ch_leftbar.jsp"></jsp:include> <%-- 왼쪽사이드바 --%>
				
			<div class="col-sm-7"> <%-- 메인공간 --%>
				<div class="body-title">
					<h2 style="font-family: 'nexon lv2 medium';" class="text-with-border"> 인증게시판 </h2>
			</div>
			<div class="body-main">
		        <div class="row mb-2 list-header">
		            <div class="col-auto me-auto">
		            	<p class="form-control-plaintext">
		            		${dataCount}개(${page}/${total_page} 페이지)
		            	</p>
		            </div>
		            <div class="col-auto">
						<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/certiboard/write';">사진올리기</button>
					</div>
		        </div>				
				
				 <div class="row row-cols-4 px-1 py-1 g-2">
				 	<c:forEach var="dto" items="${list}" varStatus="status">
				 		<div>
				 			<div class="col border rounded p-1 item"
				 				onclick="location.href='${articleUrl}&num=${dto.certifiedNum}';">
				 				<img src="${pageContext.request.contextPath}/uploads/photo/${dto.imageFilename}">
				 				<p class="item-title">${dto.subject}</p>
				 				<p>${dto.nickname}</p>
				 			</div>
				 		</div>
				 	</c:forEach>
				 </div>
				
				<div class="page-navigation">
					${dataCount == 0 ? "등록된 게시물이 없습니다." : paging }
				</div>

			</div>
						
		</div>
						<div class="col-sm-2"><%-- 우측공간 --%>
						
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