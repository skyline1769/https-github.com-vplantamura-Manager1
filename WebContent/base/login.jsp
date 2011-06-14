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
<title> 登录－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>登录</div>
<div id="base-main-container-inner">
	<div class="outter-border">
		<div id="login-container">
			<h2>用户登录</h2>
			<div id="login-container-inner">
			<c:if test="${not empty tip }">
			<div id="tip-container">小提示：<span class="tip-words">${tip }</span></div>
			</c:if>
			<form action="action/user/login" method="post">
				<div class="line">
					<label for="username" class="common-label">用户名</label>
					<input type="text" name="username" id="username" value="${model.username }" class="in-1" />
				</div>
				<div class="line">
					<label for="password" class="common-label">密码</label>
					<input type="password" name="password" id="password" value="${model.password }" class="in-1" />
				</div>
				<div class="line">
					<label for="code" class="common-label">验证码</label>
					<input type="text" name="code" id="code" value="" class="in-1" />
					<span id="codeImg-container"></span>
				</div>
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="登录" class="common-bt" />
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* 登录光标自动聚焦 */
	if ($('#username').val() == '') {
		$('#username').focus();
	} else if ($('#username').val() != '' && $('#password').val() == '') {
		$('#password').focus();
	} else if ($('#username').val() != '' && $('#password').val() != ''
			&& $('#code').val() == '') {
		$('#code').focus();
		if($('#codeImg-container').html()==''){
			var html="<img src=\"code\" onclick=\"document.getElementById('codeImg').src='code?d='+(new Date()).toUTCString();document.getElementById('code').focus();\" id=\"codeImg\"  title=\"看不清楚，换一个？\"/>";
			$('#codeImg-container').html(html);
		}
	} 
	/*验证码延迟加载 */
	$('#code').focus(function(){
		if($('#codeImg-container').html()==''){
			var html="<img src=\"code\" onclick=\"document.getElementById('codeImg').src='code?d='+(new Date()).toUTCString();document.getElementById('code').focus();\" id=\"codeImg\"  title=\"看不清楚，换一个？\"/>";
			$('#codeImg-container').html(html);
		}
	});
});
</script>
</body>
</html>