<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-container {
	max-width: 800px;
}

.table-style {
	border: 1px solid #ddd;
    border-radius: 5px;
    padding: 16px;
    margin: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    background-color: #fff;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board2.css" type="text/css">

<script type="text/javascript">
function check() {
    const f = document.boardForm;
    let str;

    str = f.subject.value.trim();
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return false;
    }

    str = f.content.value.trim();
    if(! str || str === "<p><br></p>") {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }

    f.action = "${pageContext.request.contextPath}/board/${mode}";
    return true;
}


function filterCategory(category) {
    const urlParams = new URLSearchParams(window.location.search);
    if (categoryName === '전체') {
        urlParams.delete('category');
    } else {
        urlParams.set('category', category);
    }
    window.location.href = window.location.pathname + '?' + urlParams.toString();
}


</script>

<c:if test="${mode=='update'}">
	<script type="text/javascript">
		function deleteFile(fileNum) {
			if(! confirm('파일을 삭제하시겠습니까 ? ')) {
				return;
			}
			
			let q = 'num=${dto.num}&page=${page}&size=${size}&fileNum=' + fileNum;
			location.href = '${pageContext.request.contextPath}/notice/deleteFile?' + q;
		}	
	</script>
</c:if>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
		</header>

							<main>
								<div class="container-xxl text-center">
									<div class="row py-5">
										
									</div>
									
		<c:forEach var="i" begin="0" end="0">
			<div class="row gx-2">
				<div class="col-sm-2"></div>
				<div class="col-sm-7">
					<main>
						<div class="container">
							<div class="body-container" style="font-family: 'nexon lv2 medium';">	
								<div class="body-title">
									<h3 style="font-family: 'nexon lv2 medium';">자유 게시판 </h3>
								</div>
								
								<div class="body-main">
									<form name="boardForm" method="post" enctype="multipart/form-data">
										<table class="table write-form mt-5 table-style">
											<tr>
												<td class="bg-light col-sm-2" scope="row">카테고리
													<td>
													<select name="categoryId" class="form-select" style="width: 100px;" onchange="filterCategory(this.value)" required>
														<option value="1" ${categoryId=="1"?"selected":""}>IT</option>
														<option value="2" ${categoryId=="2"?"selected":""}>잡담</option>
														<option value="3" ${categoryId=="3"?"selected":""}>건강</option>
														<option value="4" ${categoryId=="4"?"selected":""}>축구</option>
														<option value="5" ${categoryId=="5"?"selected":""}>야구</option>
														<option value="6" ${categoryId=="6"?"selected":""}>농구</option>
														<option value="7" ${categoryId=="7"?"selected":""}>배구</option>
														<option value="8" ${categoryId=="8"?"selected":""}>기타종목</option>
														<option value="9" ${categoryId=="9"?"selected":""}>동물</option>
														<option value="10" ${categoryId=="10"?"selected":""}>식단</option>
														<option value="11" ${categoryId=="11"?"selected":""}>게임</option>
														<option value="12" ${categoryId=="12"?"selected":""}>영화</option>
														<option value="13" ${categoryId=="13"?"selected":""}>문학</option>
														<option value="14" ${categoryId=="14"?"selected":""}>유머</option>
														<option value="15" ${categoryId=="15"?"selected":""}>연애</option>
														<option value="16" ${categoryId=="16"?"selected":""}>여행</option>
														<option value="17" ${categoryId=="17"?"selected":""}>음악</option>
														<option value="18" ${categoryId=="18"?"selected":""}>취업</option>
														<option value="19" ${categoryId=="19"?"selected":""}>재테크</option>
													</select> 
													</td>
												</tr>
											<tr>
												<td class="bg-light col-sm-2" scope="row">제 목</td>
												<td>
													<input type="text" name="subject" class="form-control" value="${dto.subject}">
												</td>
											</tr>
						        
						
											<tr>
												<td class="bg-light col-sm-2" scope="row">내 용</td>
												<td>
													<textarea name="content" id="ir1" class="form-control">${dto.content}</textarea>
												</td>
											</tr>
											
											<tr>
												<td class="bg-light col-sm-2">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
												<td> 
													<input type="file" name="selectFile" multiple class="form-control">
												</td>
											</tr>
											
											<c:if test="${mode=='update'}">
												<c:forEach var="vo" items="${listFile}">
													<tr>
														<td class="bg-light col-sm-2">첨부된파일</td>
														<td>
															<p class="form-control-plaintext">
																<a href="javascript:deleteFile(${vo.fileNum})"><i class="bi bi-trash"></i></a>
																${vo.originalFilename}
															</p>
														</td>
													</tr>
												</c:forEach>
											</c:if>
										</table>
										 
										<table class="table table-borderless table-style">
						 					<tr>
												<td class="text-center">
													<button type="button" class="btn btn-dark" onclick="submitContents(this.form);">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i class="bi bi-check2"></i></button>
													<button type="reset" class="btn btn-light">다시입력</button>
													<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i class="bi bi-x"></i></button>
													<c:if test="${mode=='update'}">
														<input type="hidden" name="num" value="${dto.num}">
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
						
					</div>
				</c:forEach>
			</div>
		</main>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
			<script type="text/javascript">
			var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
			    oAppRef: oEditors,
			    elPlaceHolder: "ir1",
			    sSkinURI: "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",
			    fCreator: "createSEditor2"
			});
			
			function submitContents(elClickedObj) {
			     oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
			     try {
			        if(! check()) {
			            return;
			        }
			
			        elClickedObj.submit();
			    } catch(e) {
			    }
			}
			
			function setDefaultFont() {
			    var sDefaultFont = '돋움';
			    var nFontSize = 12;
			    oEditors.getById["ir1"].setDefaultFont(sDefaultFont, nFontSize);
			}
			</script>
	</div>
	<div class="row py-5">
										
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>