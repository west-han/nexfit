<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/spti1.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/spti2.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/spti-qna.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/spti-animation.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/spti-result.css" type="text/css">

</head>
<body>
	<div class="container">
		<section id="main" class="mx-auto my-5 py-5 px-3">
			<h3 class="pt-5">운동 MBTI 테스트</h3>
			<div class="col-lg-6 col-md-8 col-sm-10 mx-auto" >
				<img src="/nexfit/resources/images/ROUTINE.png" alt="mainImage" class="img-fluid">			
			</div>
				<p>
				내 운동 유형은? <br>
				아래 시작하기 버튼을 눌러 시작해 주십시오
				</p>
			<button type="button" class="btn btn-outline-danger mt-3" onclick="js:begin()">시작하기</button>
		</section>
		
		<section id="qna">
			<div class="status mx-auto mt-5">
				<div class="statusBar">
				</div>
			</div>
			<div class="qBox my-5 py-3 mx-auto">
			
			</div>
			
			<div class="answerBox">
			
			</div>
		
		</section>
		
		<section id="result" class="mx-auto my-5 py-5 px-3">
			<h3 class="pt-5">당신의 결과는?!</h3>
			<div class="resultname">
				
			</div>
			
			<div id="resultImg" class="my-3 col-lg-6 col-md-8 col-sm-10 mx-auto" >
					
			</div>
			<div class="resultDesc">
				
			</div>
			<button type="button" class="gohome mt-3 py-2 px-3" onclick="refreshPage()">다시하기</button>
		</section>
		<script src="/nexfit/resources/js/data.js" type="text/javascript"></script>
		<script src="/nexfit/resources/js/start.js" type="text/javascript"></script>
		<script type="text/javascript">
			function refreshPage() {
				location.reload();
			}
		</script>
	</div>
	
</body>
</html>