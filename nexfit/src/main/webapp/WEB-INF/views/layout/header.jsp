<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<style>
@keyframes color {
	0% {color: red; transform: translateX(-2px);}
	25% {color: yellow; transform: translateX(2px);}
	50% {color: green; transform: translateX(-2px);}
	75% {color: blue; transform: translateX(2px);}
	100% {color: purple; transform: translateX(-2px);}
}

.color-text {
	animation: color 3s infinite;
}

</style>

	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background: #272727; font-family: 'nexon lv2 medium';" >
		<div class="container">
			<a href="${pageContext.request.contextPath}/"> 
                      
                           <img src="/nexfit/resources/images/NEXFIT.png" style="width:220px; height:50px;">
                       
                      </a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span> 
			</button>
				
			<div class="collapse navbar-collapse" id="navbarSupportedContent"> 
				<ul class="navbar-nav mx-auto flex-nowrap">   
					<li class="nav-item dropdown font-title">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							SPORTS
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/sports/routine/list">ROUTINE</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/sports/types/list">TYPES</a></li>
						</ul>
					</li>

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							PLAYGROUND
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/board/list">FREE LOUNGE</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/qnaboard/list">Q&amp;A LOUNGE</a></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/withme/list">WITH ME</a></li>
						</ul>
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							CHALLENGE
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/chboard/list">진행중인 챌린지</a></li>
							<li><a class="dropdown-item" href="#">종료된 챌린지</a></li>
							<li><a class="dropdown-item" href="#">인증 게시판</a></li>
							<c:if test="${sessionScope.member.userName=='admin'}">
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/challenge/list">챌린지관리 게시판</a></li>
							</c:if>
						</ul>
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							OH! ROCK!
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/sports/spti/main">SPTI</a></li>
							<li><a class="dropdown-item" href="#">WORLD CUP</a></li>
							<li><a class="dropdown-item color-text" href="#">SPORTS ROULETTE</a></li>
						</ul>
					</li>
					
				</ul>
				<div class="col-1">
					<div class="d-flex justify-content-end">
						<c:if test="${empty sessionScope.member}">
							<div class="p-2">
								<a href="javascript:dialogLogin();" title="로그인"><i class="bi bi-lock" style="color: white;"></i></a>
							</div>
							<div class="p-2">
								<a href="${pageContext.request.contextPath}/member/member" title="회원가입"><i class="bi bi-person-plus" style="color: white;"></i></a>
							</div>
						</c:if>
						<c:if test="${not empty sessionScope.member}">
							<div class="p-2">
								<a href="${pageContext.request.contextPath}/mypage/mypage" title="마이페이지"><i class="bi bi-person-circle" style="color: white;"></i></a> 
							</div>
							<div class="p-2">
								<a href="${pageContext.request.contextPath}/member/logout" title="로그아웃"><i class="bi bi-unlock" style="color: white;"></i></a>
							</div>
						</c:if>
						<c:if test="${sessionScope.member.userId == 'admin'}">
							<div class="p-2">
								<a href="#" title="관리자"><i class="bi bi-gear" style="color: white;"></i></a>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</nav>

	
	<!-- Login Modal -->
	<script type="text/javascript">
		function dialogLogin() {
		    $("form[name=modelLoginForm] input[name=userId]").val("");
		    $("form[name=modelLoginForm] input[name=userPwd]").val("");
		    
			$("#loginModal").modal("show");	
			
		    $("form[name=modelLoginForm] input[name=userId]").focus();
		}
	
		function sendModelLogin() {
		    var f = document.modelLoginForm;
			var str;
			
			str = f.userId.value;
		    if(!str) {
		        f.userId.focus();
		        return;
		    }
		
		    str = f.userPwd.value;
		    if(!str) {
		        f.userPwd.focus();
		        return;
		    }
		
		    f.action = "${pageContext.request.contextPath}/member/login";
		    f.submit();
		}
	</script>
	<div class="modal fade" id="loginModal" tabindex="-1"
			data-bs-backdrop="static" data-bs-keyboard="false" 
			aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header" style="font-family: nexon lv2 medium;">
					<h5 class="modal-title" id="loginViewerModalLabel">Login</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" style="font-family: nexon lv1 light;">
	                <div class="p-3">
	                    <form name="modelLoginForm" action="" method="post" class="row g-3">
	                    	<div class="mt-0">
	                    		 <p class="form-control-plaintext">계정으로 로그인 하세요</p>
	                    	</div>
	                        <div class="mt-0">
	                            <input type="text" name="userId" class="form-control" placeholder="아이디">
	                        </div>
	                        <div>
	                            <input type="password" name="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
	                        </div>
	                        <div>
	                            <button type="button" class="btn btn-dark w-100" onclick="sendModelLogin();">Login</button>
	                        </div>
	                    </form>
	                    <hr class="mt-3">
	                    <div>
	                        <p class="form-control-plaintext mb-0">
	                        	아직 회원이 아니세요 ?
	                        	<a href="${pageContext.request.contextPath}/member/member" class="text-decoration-none">회원가입</a>
	                        </p>
	                    </div>
	                </div>
				</div>
			</div>
		</div>
	</div>	