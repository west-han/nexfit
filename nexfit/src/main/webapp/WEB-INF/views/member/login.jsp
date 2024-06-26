﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

<style type="text/css">
.body-container {
	max-width: 800px;
}


.flip-text {
       display: inline-block;
       animation: flip 2s infinite;
       color: #333;
   }
   
@keyframes flip {
            0% {
                transform: rotateY(0deg);
            }
            50% {
                transform: rotateY(180deg);
            }
            100% {
                transform: rotateY(360deg);
            }
        }
</style>

<script type="text/javascript">
	function sendLogin() {
		const f = document.loginForm;
		let str;

		str = f.userId.value;
		if (!str) {
			f.userId.focus();
			return;
		}

		str = f.userPwd.value;
		if (!str) {
			f.userPwd.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/member/login";
		f.submit();
	}
</script>
</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>

		<main class="mt-5">
			<div class="container">
				<div class="row">
					<div class="col-md-6 offset-md-3">
						<div class="border mt-5 p-4" style="font-family: nexon lv1 light;">
							<form name="loginForm" action="" method="post" class="row g-3">
								<h3 class="text-center" style="font-family: nexon lv1 light; font-weight: bold;">
									<i class="bi bi-lock flip-text"></i> 회원 로그인
								</h3>
								<div class="col-12">
									<label class="mb-1">아이디</label> <input type="text"
										name="userId" class="form-control" placeholder="아이디">
								</div>
								<div class="col-12">
									<label class="mb-1">패스워드</label> <input type="password"
										name="userPwd" class="form-control" autocomplete="off"
										placeholder="패스워드">
								</div>
								<div class="col-12">
									<div class="form-check">
										<input class="form-check-input" type="checkbox"
											id="rememberMe"> <label class="form-check-label"
											for="rememberMe"> 아이디 저장</label>
									</div>
								</div>
								<div class="col-12">
									<button type="button" class="btn btn-dark float-end"
										onclick="sendLogin();">
										&nbsp;Login&nbsp;<i class="bi bi-check2"></i>
									</button>
								</div>
							</form>
							<hr class="mt-4">
							<div class="col-12">
								<p class="text-center mb-0"> 
									<a href="${pageContext.request.contextPath}/member/member" class="text-decoration-none">가입해주세요...😢</a>
								</p>
							</div>
						</div>

						<div class="d-grid">
							<p class="form-control-plaintext text-center text-primary">${message}</p>
						</div>

					</div>
				</div>

			</div>
		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />

</html>