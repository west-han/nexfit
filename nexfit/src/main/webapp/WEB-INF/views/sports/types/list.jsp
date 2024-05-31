<%@ page contentType="text/html; charset=UTF-8"%>
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
</style>

</head>

<body>
	<div class="container-fluid px-0">
		<header>
			<jsp:include page="/WEB-INF/views/layout/header.jsp" />
		</header>

		<main class="mt-5">
			<div class="container-xxl text-center">
				<div class="row py-5">
					<div class="col">
						<h1 class="fs-1 text-start">운동 목록</h1>
					</div>
				</div>

				<div class="row gx-2">
					<div class="col">
						<form class="row justify-content-center pb-5" name="searchForm"
							action="${pageContext.request.contextPath}/sports/type/list"
							method="post">
							<div class="col-auto p-0 pb">
								<input type="text" name="keyword" value="${keyword}"
									class="form-control" style="width: 500px;">
							</div>
							<div class="col-auto p-0">
								<button type="button" class="btn btn-light"
									onclick="searchList()" style="">
									<i class="bi bi-search"></i>
								</button>
							</div>
							<c:if test="${sessionScope.member.userId == 'admin'}">
								<div class="row text-end">
									<div class="col">
										<a class="btn btn-primary"
											href="${pageContext.request.contextPath}/sports/types/write"
											role="button">추가</a>
									</div>
								</div>
							</c:if>
						</form>
					</div>

					<div class="btn-group-lg" role="group" aria-label="Basic radio toggle button group" id="btnsTypeSelect">
						<input type="radio" class="btn-check" name="btnBodyPart" id="all" value="all" autocomplete="off" checked>
						<label class="btn btn-outline-primary" for="all">전체</label>

						<c:forEach var="entry" items="${map}" varStatus="status">
							<input type="radio" class="btn-check" name="btnBodyPart" id="${entry.key}" value="${entry.key}" autocomplete="off">
							<label class="btn btn-outline-primary" for="${entry.key}">${entry.value}</label>
						</c:forEach> 
					</div>
					
					<c:forEach var="dto" items="${list}" varStatus="status">
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#sportsDetailModal" data-param="${dto.num}">
							${dto.name}
						</button>
					</c:forEach>
					
					<div class="modal fade" id="sportsDetailModal" tabindex="-1">
  						<div class="modal-dialog">
    						<div class="modal-content">
      							<div class="modal-header">
        							<h5 class="modal-title">Modal title</h5>
        							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    							</div>

								<div class="modal-body">
									<div class="container-fluid">
								    	<div class="row">
								      		<div class="col-md-4">.col-md-4</div>
								      		<div class="col-md-4 ms-auto">.col-md-4 .ms-auto</div>
								    	</div>
								    <div class="row">
										<div class="col-md-3 ms-auto">.col-md-3 .ms-auto</div>
										<div class="col-md-2 ms-auto">.col-md-2 .ms-auto</div>
									</div>
									<div class="row">
										<div class="col-md-6 ms-auto">.col-md-6 .ms-auto</div>
								    </div>
									<div class="row">
										<div class="col-sm-9">
								        	Level 1: .col-sm-9
								        	<div class="row">
												<div class="col-8 col-sm-6">
								            		Level 2: .col-8 .col-sm-6
								          		</div>
												<div class="col-4 col-sm-6">
													Level 2: .col-4 .col-sm-6
												</div>
											</div>
										</div>
								    </div>
								  </div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save changes</button>
								</div>
							</div>
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

<script type="text/javascript">
$(function() {
	$("#btnsTypeSelect").on("click", ".btn-check", function() {
		
	});
});

</script>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp" />
</body>
</html>