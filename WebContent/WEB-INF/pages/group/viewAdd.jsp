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
<title> 添加分组－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span>添加分组</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">
			<p>"<b>分组</b>"是为隔离应用在不同环境下配置而提出的概念( 如测试环境可以定义分组名为"TEST",线上环境可以定义分组名为"ONLINE"！)</p>
			<p class="red">温馨提醒：为了让分组名更加醒目，因此系统会将分组名自动转换为全大写形式!</p>
		</div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<form action="action/group/add" method="post">
				<div class="line">
					<label for="groupname" class="common-label">分组名</label>
					<input type="text" name="groupname" id="groupname" class="in-1" value="${model.groupname }" />
				</div>
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="添加分组" class="common-bt" />
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	/* 光标自动聚焦*/
	if ($('#groupname').val() == '') {
		$('#groupname').focus();
	} 
});
</script>
</body>
</html>