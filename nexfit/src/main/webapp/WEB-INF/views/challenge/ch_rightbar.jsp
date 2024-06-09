<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
/* 200% 확대 시 메뉴 숨김 */
@media screen and (max-width: 1200px) {
    .menu-container {
        display: none;
    }
}
</style>

<div class="col-sm-2 mt-5">
	<div class="mt-5" style="padding-top: 100px;">
	<a href="${pageContext.request.contextPath}/chboard/list"><img src="/nexfit/resources/images/4.png" style="width: 120%"></a>
	</div>
</div>