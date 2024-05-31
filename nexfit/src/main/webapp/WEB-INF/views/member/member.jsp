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
function memberOk() {
	const f = document.memberForm;
	let str;

	str = f.userId.value;
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(str) ) { 
		alert("아이디를 다시 입력 하세요. ");
		f.userId.focus();
		return;
	}
	
	let mode = "${mode}";
	if (mode === "member" && f.userIdValid.value === "false") {
		str = "아이디 중복 검사가 실행되지 않았습니다.";
		$("#userId").closest(".userId-box").find(".help-block").html(str);
		f.userId.focus();
		return;
	}
	
	str = f.userPwd.value;
	if( !/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str) ) { 
		alert("패스워드를 다시 입력 하세요. ");
		f.userPwd.focus();
		return;
	}

	if( str !== f.userPwd2.value ) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwd.focus();
        return;
	}
	
    str = f.userName.value;
    if( !/^[가-힣]{2,5}$/.test(str) ) {
        alert("이름을 다시 입력하세요. ");
        f.userName.focus();
        return;
    }

    str = f.birth.value;
    if( !str ) {
        alert("생년월일를 입력하세요. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
    if( !str ) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
    if( !/^\d{3,4}$/.test(str) ) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
    if( !/^\d{4}$/.test(str) ) {
    	alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value.trim();
    if( !str ) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }

   	f.action = "${pageContext.request.contextPath}/member/${mode}";
    f.submit();
}

function changeEmail() {
    const f = document.memberForm;
	    
    let str = f.selectEmail.value;
    if(str !== "direct") {
        f.email2.value = str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value = "";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	// 아이디 중복 검사
	let userId = $("#userId").val();
	if( !/^[a-z][a-z0-9_]{4,9}$/i.test(userId) ) {
		let str = "아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#userId").focus();
		$("#userId").closest(".userId-box").find(".help-block").html(str);
		return;
	}
	
	let url = "${pageContext.request.contextPath}/member/userIdCheck";
	let query = "userId=" + userId;
	
	$.ajax({
		type:"post",
		url:url,
		data:query,
		dataType:"json",
		success:function(data) {
			let passed = data.passed;
			
			if (passed === "true") {
				let s = "<span style='color:blue; font-weight:700;'>" + userId + "</span> 아이디는 사용가능합니다.";
				$(".userId-box").find(".help-block").html(s);
				$("#userIdValid").val("true");
			} else {
				let s = "<span style='color:red; font-weight:700;'>" + userId + "</span> 아이디는 사용할 수 없습니다.";
				$(".userId-box").find(".help-block").html(s);
				$("#userIdValid").val("false");
			}
		},
		error:function(e) {
			console.log(e.responseText);
		}
	})

}

window.addEventListener('load', () => {
	const el = document.querySelector('form input[name=birth]');
	el.addEventListener('keydown', e => e.preventDefault());
});
</script>
</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>

		
						
	<main>
	<div class="container">
		<div class="body-container" style="padding: 80px;">
			<div class="body-title">
				<h3><i class="bi bi-person-square"></i> 회원가입</h3>
			</div>
			
			<div class="body-main">
			
				<form name="memberForm" method="post">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userId">아이디</label>
						<div class="col-sm-10 userId-box">
							<div class="row">
								<div class="col-5 pe-1">
									<input type="text" name="userId" id="userId" class="form-control" value="${dto.userId}"${mode=="update" ? "readonly ":""}
											placeholder="아이디">
								</div>
							<div class="col-3 ps-1">
									<c:if test="${mode=='member'}">
										<button type="button" class="btn btn-light" style="width:140px;" onclick="userIdCheck();">아이디중복검사</button>
									</c:if>
								</div>
							</div>
							<c:if test="${mode=='member'}">
								<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
							</c:if>
						</div>
					</div>
					
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="userPwd">패스워드</label>
						<div class="col-sm-10">
				            <input type="password" name="userPwd" id="userPwd" class="form-control" autocomplete="off" placeholder="패스워드">
				            <small class="form-control-plaintext">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</small>
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userPwd2">패스워드 확인</label>
				        <div class="col-sm-10">
				            <input type="password" name="userPwd2" id="userPwd2" class="form-control" autocomplete="off" placeholder="패스워드 확인">
				            <small class="form-control-plaintext">패스워드를 한번 더 입력해주세요.</small>
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="userName">이름</label>
				        <div class="col-sm-10">
				            <input type="text" name="userName" id="userName" class="form-control" value="${dto.userName}" 
				            		${mode=="update" ? "readonly ":""}
				            		placeholder="이름">
				        </div>
				    </div>
				     <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="birth">생년월일</label>
				        <div class="col-sm-10">
				            <input type="date" name="birth" id="birth" class="form-control" value="${dto.birth}" placeholder="생년월일">
				            <small class="form-control-plaintext">생년월일은 2000-01-01 형식으로 입력 합니다.</small>
				        </div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="selectEmail">이메일</label>
				        <div class="col-sm-10 row">
							<div class="col-3 pe-0">
								<select name="selectEmail" id="selectEmail" class="form-select" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com" ${dto.email2=="naver.com" ? "selected" : ""}>네이버 메일</option>
									<option value="gmail.com" ${dto.email2=="gmail.com" ? "selected" : ""}>지 메일</option>
									<option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected" : ""}>한 메일</option>
									<option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected" : ""}>핫 메일</option>
									<option value="direct">직접입력</option>
								</select>
							</div>
							
							<div class="col input-group">
								<input type="text" name="email1" class="form-control" maxlength="30" value="${dto.email1}" >
							    <span class="input-group-text p-1" style="border: none; background: none;">@</span>
								<input type="text" name="email2" class="form-control" maxlength="30" value="${dto.email2}" readonly>
							</div>		
		
				        </div>
				    </div>
				    
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="tel1">전화번호</label>
				        <div class="col-sm-10 row">
							<div class="col-sm-3 pe-2">
								<input type="text" name="tel1" id="tel1" class="form-control" value="${dto.tel1}" maxlength="3">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 px-1">
								<input type="text" name="tel2" id="tel2" class="form-control" value="${dto.tel2}" maxlength="4">
							</div>
							<div class="col-sm-1 px-1" style="width: 2%;">
								<p class="form-control-plaintext text-center">-</p>
							</div>
							<div class="col-sm-3 ps-1">
								<input type="text" name="tel3" id="tel3" class="form-control" value="${dto.tel3}" maxlength="4">
							</div>
				        </div>
				    </div>
				
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="zip">우편번호</label>
				        <div class="col-sm-5">
				       		<div class="input-group">
				           		<input type="text" name="zip" id="zip" class="form-control" placeholder="우편번호" value="${dto.zip}" readonly>
			           			<button class="btn btn-light" type="button" style="margin-left: 3px;" onclick="daumPostcode();">우편번호 검색</button>
				           	</div>
						</div>
				    </div>
			
				    <div class="row mb-3">
				        <label class="col-sm-2 col-form-label" for="addr1">주소</label>
				        <div class="col-sm-10">
				       		<div>
				           		<input type="text" name="addr1" id="addr1" class="form-control" placeholder="기본 주소" value="${dto.addr1}" readonly>
				           	</div>
				       		<div style="margin-top: 5px;">
				       			<input type="text" name="addr2" id="addr2" class="form-control" placeholder="상세 주소" value="${dto.addr2}">
							</div>
						</div>
				    </div>
			
					<c:if test="${mode == 'member' }">
					    <div class="row mb-3">
					        <label class="col-sm-2 col-form-label" for="agree">약관 동의</label>
							<div class="col-sm-8" style="padding-top: 5px;">
								<input type="checkbox" id="agree" name="agree"
									class="form-check-input"
									checked
									style="margin-left: 0;"
									onchange="form.sendButton.disabled = !checked">
								<label class="form-check-label">
									<a href="#" class="text-decoration-none">이용약관</a>에 동의합니다.
								</label>
							</div>
					    </div>
					 </c:if>
				     
				    <div class="row mb-3">
				        <div class="text-center">
				            <button type="button" name="sendButton" class="btn btn-primary" onclick="memberOk();"> ${mode=="member"?"회원가입":"정보수정"} <i class="bi bi-check2"></i></button>
				            <button type="button" class="btn btn-danger" onclick="location.href='${pageContext.request.contextPath}/';"> ${mode=="member"?"가입취소":"수정취소"} <i class="bi bi-x"></i></button>
							<input type="hidden" name="userIdValid" id="userIdValid" value="false">
				        </div>
				    </div>
				
				    <div class="row">
						<p class="form-control-plaintext text-center">${message}</p>
				    </div>
				</form>
			</div>
		</div>
	</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
	    function daumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                var fullAddr = ''; 
	                var extraAddr = ''; 
	
	                if (data.userSelectedType === 'R') { 
	                    fullAddr = data.roadAddress;
	
	                } else { 
	                    fullAddr = data.jibunAddress;
	                }
	
	                if(data.userSelectedType === 'R'){
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                document.getElementById('zip').value = data.zonecode; 
	                document.getElementById('addr1').value = fullAddr;
	
	                document.getElementById('addr2').focus();
	            }
	        }).open();
	    }
	</script>
</main>
						
					</div>
				
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>