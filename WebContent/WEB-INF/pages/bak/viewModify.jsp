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
<title> 修改备用配置－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<c:set var="location" value="${requestScope.location}" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><c:choose><c:when test="${location=='advance' }"><a href="action/global/advance">高级管理</a><span class="to"></span><a href="action/data/filter">浏览配置</a><span class="to"></span></c:when><c:otherwise><a href="action/data/myData">我的配置</a><span class="to"></span></c:otherwise></c:choose>修改备用配置</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">
			<p>您可以修改备用配置的内容和描述信息！</p>
		</div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<form action="action/bak/modify" method="post">
				<div class="line">
					<label for="content" class="common-label label-content">配置内容</label>
					<textarea name="content" id="content" class="common-textarea">${model.content }</textarea>
				</div>
				<div class="line">
					<label for="description" class="common-label label-content">简介描述</label>
					<textarea name="description" id="description" class="common-textarea">${model.description }</textarea>
				</div>
				<input type="hidden" name="id" value="${model.id}" />
				<input type="hidden" name="location" value="${location}" />
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="完成修改" class="common-bt" />
					<c:set var="backurl" value="action/data/myData"></c:set>
					<c:if test="${location=='advance' }">
						<c:set var="backurl" value="action/data/filter"></c:set>
					</c:if>
					<input type="button" value="返回浏览配置" class="common-bt" onclick="goUrl('${backurl}');" />
				</div>
			</form>
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${location=='advance' }">
	<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
	</c:when>
	<c:otherwise>
	<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
	</c:otherwise>
</c:choose>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	/* 光标自动聚焦*/
	if ($('#content').val() == '') {
		$('#content').focus();
	} 
	else if ($('#content').val() != '' && $('#description').val() == '') {
		$('#description').focus();
	} 
	else{
		$('#content').select();
	}
});
</script>
</body>
</html>