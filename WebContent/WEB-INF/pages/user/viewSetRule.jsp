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
<title> 设置规则－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="pattern" value="${requestScope.pattern }"></c:set>
<c:set var="ruleList" value="${requestScope.ruleList }"></c:set>
<c:set var="userList" value="${requestScope.userList }"></c:set>
<c:set var="userIds" value="${requestScope.userIds }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span><a href="action/user/filter">浏览用户</a><span class="to"></span>设置规则</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">为了保障系统的安全性，系统针对每位用户设置专用的数据订阅键规则</div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<form action="action/user/setRule" method="get">
				<div class="line">
					<label for="usernames" class="common-label">用户</label>
					<span id="usernames-container">
					<c:forEach var="user" items="${userList }" varStatus="status">
						<span class="username-container"><b><img src="common/images/user-item.png" />${user.username }</b></span>
						<input type="checkbox" name="usernames" class="common-checkbox" value="${user.username }" checked="checked" style="display:none;" />
					</c:forEach>
					</span>
				</div>
				<div class="line">
					<label for="pattern" class="common-label">规则模式</label>
					<select name="pattern" id="pattern">
						<option value="">==请选择==</option>
						<c:forEach var="rule" items="${ruleList }">
							<c:choose>
								<c:when test="${pattern==rule.pattern }">
									<option value="${rule.pattern }" selected="selected">${rule.pattern }</option>
								</c:when>
								<c:otherwise>
									<option value="${rule.pattern }">${rule.pattern }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
				<input type="hidden" name="userIds" value="${userIds }" />
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="设置规则" class="common-bt" />
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
</body>
</html>