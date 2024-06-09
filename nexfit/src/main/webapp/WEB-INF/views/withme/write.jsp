<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp" />

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
	padding: 16px;
	margin: 20px 0;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
}
</style>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board2.css"
	type="text/css">

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
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }

    let pos = marker.getPosition();
    f.action = "${pageContext.request.contextPath}/withme/${mode}";

    $('#coordinate-x').val(pos.La);
    $('#coordinate-y').val(pos.Ma);
    
    return true;
}



</script>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>

		<main>
			<div class="container-xxl text-center">
				<div class="row py-5"></div>

				<div class="row gx-2">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<main>
							<div class="container">
								<div class="body-container"
									style="font-family: 'nexon lv2 medium';">
									<div class="body-title">
										<h3 style="font-family: 'nexon lv2 medium';">WORKOUT TOGETHER !</h3>
									</div>

									<div class="body-main">
										<form name="boardForm" method="post">
											<table class="table write-form mt-5 table-style">
												<tr>
													<td class="bg-light col-sm-2" scope="row">제 목</td>
													<td><input type="text" name="subject"
														class="form-control" value="${dto.subject}"></td>
												</tr>


												<tr>
													<td class="bg-light col-sm-2" scope="row">내 용</td>
													<td><textarea name="content" id="ir1"
															class="form-control">${dto.content}</textarea></td>
												</tr>
												<tr>
													<td class="bg-light col-sm-2" scope="row">위 치</td>
													<td colspan="2" valign="top" height="300"
														style="border-bottom: none;" align="center">
														<div id="map" class="w-100 h-100"></div> <input
														id="coordinate-x" type="hidden" name="coordinate-x">
														<input id="coordinate-y" type="hidden" name="coordinate-y">
													</td>
												</tr>
											</table>

											<table class="table table-borderless table-style">
												<tr>
													<td class="text-center">
														<button type="button" class="btn btn-dark"
															onclick="submitContents(this.form);">${mode=='update'?'수정완료':'등록하기'}&nbsp;<i
																class="bi bi-check2"></i>
														</button>
														<button type="reset" class="btn btn-light">다시입력</button>
														<button type="button" class="btn btn-light"
															onclick="location.href='${pageContext.request.contextPath}/withme/list';">${mode=='update'?'수정취소':'등록취소'}&nbsp;<i
																class="bi bi-x"></i>
														</button> <c:if test="${mode=='update'}">
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
			</div>
		</main>
		
		
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/se2/js/service/HuskyEZCreator.js"
			charset="utf-8"></script>
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
	<div style="height: 100px;"></div>
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services"></script>
	<script type="text/javascript">
	const mode = '${mode}';
	var marker;
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng(37.56825, 126.8973), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	var imgSrc = '${pageContext.request.contextPath}/resources/images/map_marker.png',
		imgSize = new kakao.maps.Size(64, 64),
		imgOption = {offset: new kakao.maps.Point(27, 69)};
	
	var markerImage = new kakao.maps.MarkerImage(imgSrc, imgSize, imgOption);
	
	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var coords;
	
	if (mode === 'write') {
		var lat = 37.56825;
		var lng = 126.8973;
		//주소로 좌표를 검색합니다
		geocoder.addressSearch('${address}', function(result, status) {
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {
				lat = result[0].y;
				lng = result[0].x;
			}

			coords = new kakao.maps.LatLng(lat, lng);
			
			// 결과값으로 받은 위치를 마커로 표시합니다
			marker = new kakao.maps.Marker({
			    map: map,
			    position: coords,
			    draggable: true,
			    image: markerImage
			});
			
			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content: '<div style="width:150px;text-align:center;padding:6px 0;">만날 장소</div>'
			});
			
			// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			map.setCenter(coords);
			
			// 마커 지도에 표시
			marker.setMap(map);
		});
	} else {
		var lat = ${empty dto.y || dto.y == 0 ? 37.56825 : dto.y};
		var lng = ${empty dto.x || dto.x == 0 ? 126.8973 : dto.x};
		coords = new kakao.maps.LatLng(lat, lng);
		
		// 결과값으로 받은 위치를 마커로 표시합니다
		marker = new kakao.maps.Marker({
		    map: map,
		    position: coords,
		    draggable: true,
		    image: markerImage
		});
		
		// 인포윈도우로 장소에 대한 설명을 표시합니다
		var infowindow = new kakao.maps.InfoWindow({
		    content: '<div style="width:150px;text-align:center;padding:6px 0;">만날 장소</div>'
		});
		
		// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		map.setCenter(coords);
		
		// 마커 지도에 표시
		marker.setMap(map);
	}
</script>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>