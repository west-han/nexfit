<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>



	<nav class="navbar navbar-expand-lg navbar-light fixed-top" style="background: #272727; font-family: 'nexon lv2 medium';" >
		<div class="container">
			<a href="${pageContext.request.contextPath}/"> 
                      
                           <img src="/nexfit/resources/images/NEXFIT.png" style="width:220px; height:50px;">
                       
                      </a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span> 
			</button>
				
			<div class="collapse navbar-collapse" id="navbarSupportedContent"> 
				<ul class="navbar-nav mx-auto flex-nowrap">   
			

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							SPORTS
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">프로그래밍</a></li>
							<li><a class="dropdown-item" href="#">데이터베이스</a></li>
							<li><a class="dropdown-item" href="#">웹프로그래밍</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">IT  질문과 답변</a></li>
						</ul>
					</li>

					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							PLAYGROUND
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/board/list">FREE LOUNGE</a></li>
							<li><a class="dropdown-item" href="#">Q&A LOUNGE</a></li>
							<li><a class="dropdown-item" href="#">WITH ME</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">자료실</a></li>
						</ul>
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							CHALLENGE
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">진행중인 챌린지</a></li>
							<li><a class="dropdown-item" href="#">종료된 챌린지</a></li>
							<li><a class="dropdown-item" href="#">인증게시판</a></li>
							
							<c:if test="${sessionScope.member.userName=='admin'}">
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="${pageContext.request.contextPath}/chellenge/list">챌린지관리 게시판</a></li>
							</c:if>
						</ul>
					</li>
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle px-5" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="color: white;">
							NEWS
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">일정관리</a></li>
							<li><a class="dropdown-item" href="#">사진첩</a></li>
							<li><a class="dropdown-item" href="#">쪽지함</a></li>
							<li><a class="dropdown-item" href="#">가계부</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">정보수정</a></li>
						</ul>
					</li>
					
				</ul>
			</div>
			
			<div class="col">
					<div class="d-flex justify-content-end">
						<c:if test="${empty sessionScope.member}">
							<div class="p-2">
								<a href="javascript:dialogLogin();" title="로그인"><i class="bi bi-lock" style="color: white;"></i></a>
							</div>
							<div class="p-2">
								<a href="${pageContext.request.contextPath}/" title="회원가입"><i class="bi bi-person-plus" style="color: white;"></i></a>
							</div>	
						</c:if>
						<c:if test="${not empty sessionScope.member}">
							<div class="p-2">
								<a href="#" title="알림"><i class="bi bi-bell" style="color: white;"></i></a> 
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
				<div class="modal-header">
					<h5 class="modal-title" id="loginViewerModalLabel">Login</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
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
	                            <div class="form-check">
	                                <input class="form-check-input" type="checkbox" id="rememberMeModel">
	                                <label class="form-check-label" for="rememberMeModel"> 아이디 저장</label>
	                            </div>
	                        </div>
	                        <div>
	                            <button type="button" class="btn btn-primary w-100" onclick="sendModelLogin();">Login</button>
	                        </div>
	                        <div>
	                    		 <p class="form-control-plaintext text-center">
	                    		 	<a href="#" class="text-decoration-none me-2">패스워드를 잊으셨나요 ?</a>
	                    		 </p>
	                    	</div>
	                    </form>
	                    <hr class="mt-3">
	                    <div>
	                        <p class="form-control-plaintext mb-0">
	                        	아직 회원이 아니세요 ?
	                        	<a href="${pageContext.request.contextPath}" class="text-decoration-none">회원가입</a>
	                        </p>
	                    </div>
	                </div>
	        
				</div>
			</div>
		</div>
	</div>	