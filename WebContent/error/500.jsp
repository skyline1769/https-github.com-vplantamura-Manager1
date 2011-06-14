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
<title> 500 </title>
</head>
<body>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>服务器内部出错</div>
<div id="base-main-container-inner">
	<div id="error-page-container">
		<div id="error-page-container-inner">
			<h2>服务器内部出错，工程师正在努力解决中！</h2>
			<p></p>
		</div>
	</div>
</div>
</body>
</html>