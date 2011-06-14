<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"></base> 
<title> 我的发布规则－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<c:set var="countPerPage" value="${requestScope.countPerPage}"></c:set>
<c:set var="pager" value="${requestScope.pager}"></c:set>
<c:set var="maxPagerShowLength" value="${requestScope.maxPagerShowLength}"></c:set>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>

<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>

<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>我的发布规则</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword"><b>温馨提示</b>：用户只能发布与分配的规则模式相匹配的配置数据（目前设计的规则支持正则模式!）</div>
		<div class="box">
			<div class="line">
				<label class="common-label">用户</label>
				<span id="usernames-container">
					<span class="username-container"><b><img src="common/images/user-item.png" />${username }</b></span>
				</span>
			</div>
			<div class="line">
				<label class="common-label">发布规则</label>
				<span id="usernames-container">
					<span class="username-container"><b><img src="common/images/rule-icon.png" />
					<c:choose>
						<c:when test="${not empty model.pattern }">
						${model.pattern }
						</c:when>
						<c:otherwise>
						无
						</c:otherwise>
					</c:choose>
					</b></span>
				</span>
			</div>
			<div class="line btContainer common-bt-blank">
					<input type="button" value="返回" class="common-bt back-bt" />
				</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
</body>
</html>