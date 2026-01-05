<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${sessionScope.error != null}">
	<article class="alert alert-danger alert-dismissible fade show d-flex align-items-center"
			role="alert"
			aria-live="assertive">
		${sessionScope.success}
	</article>
	<c:remove var="error" scope="session"/>
</c:if>

<c:if test="${sessionScope.success != null}">
	<article class="alert alert-success alert-dismissible fade show d-flex align-items-center"
			role="status"
			aria-live="polite">
		${sessionScope.success}
	</article>
	<c:remove var="success" scope="session"/>
</c:if>