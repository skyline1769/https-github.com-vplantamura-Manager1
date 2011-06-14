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
<title> ${requestScope.model.title } －基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="types" value="系统BUG,改进意见"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span>${requestScope.model.title }</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">用户反馈的系统BUG需要尽快处理，提出的意见和建议要有针对性的总结提炼，用户体验永远是第一位！</div>
		<div class="box">
			<h2><img src="common/images/bug.png" /> 用户BUG提交与意见</h2>
			<table class="data-display">
				<colgroup>
					<col width="11%" />
					<col width="89%" />
				</colgroup>
				<tr>
					<th class="blank">反馈类型</th>
					<td><a href="action/message/filter?type=${model.type}" title="查找更多同类反馈">${model.type }</a></td>
				</tr>
				<tr>
					<th class="blank">标题</th>
					<td>${model.title }</td>
				</tr> 
				<tr>
					<th class="blank">内容</th>
					<td>${model.content }</td>
				</tr>
				<tr> 
					<th class="blank">反馈人</th>
					<td>${model.reportuser }</td>
				</tr>
				<tr> 
					<th class="blank">提交时间</th>
					<td><fmt:formatDate value="${model.addtime }" type="both"/></td>
				</tr>
			</table>			
			<div class="line btContainer common-long-bt-blank">
				<input type="button" value="返回" class="common-bt back-bt" />
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
</body>
</html>