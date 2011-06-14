<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:choose>
	<c:when test="${username=='admin' }">
	<%@ include file="/WEB-INF/pages/include/adminMenu.jsp" %>
	</c:when>
	<c:otherwise>
	<%@ include file="/WEB-INF/pages/include/personalMenu.jsp" %>
	</c:otherwise>
</c:choose>
