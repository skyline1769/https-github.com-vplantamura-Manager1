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
<title> ${requestScope.model.dataid } －基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="model" value="${requestScope.model}" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/history/filter">我的推送历史</a><span class="to"></span>${requestScope.model.dataid }</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">订阅键[${model.dataid }]的推送历史记录详细如下所示</div>
		<div class="box">
			<h2><img src="common/images/history.png" /> 我的推送历史记录详细</h2>
			<table class="data-display">
				<colgroup>
					<col width="16%" />
					<col width="84%" />
				</colgroup>
				<tr>
					<th class="blank">订阅键</th>
					<td>${model.dataid }</td>
				</tr>
				<tr>
					<th class="blank">所属分组</th>
					<td>${model.groupname }</td>
				</tr> 
				<tr>
					<th class="blank">内容</th>
					<td>${model.content }</td>
				</tr>
				<tr> 
					<th class="blank">动作</th>
					<td>${model.action }</td>
				</tr>
				<tr> 
					<th class="blank">操作用户</th>
					<td>${model.username }</td>
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
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
</body>
</html>