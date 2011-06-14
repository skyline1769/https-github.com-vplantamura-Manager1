<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"></base> 
<title> 404 </title>
</head>
<body>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>请求的网页找不到</div>
<div id="base-main-container-inner">
	<div id="error-page-container">
		<div id="error-page-container-inner">
			<h2>对不起~您请求的网页未找到</h2>
			<p>请通过 <a href="base/question.jsp" class="bug">提交BUG与意见</a> 链接上报错误和提出您的宝贵建议,谢谢！</p>
		</div>
	</div>
</div>
</body>
</html>