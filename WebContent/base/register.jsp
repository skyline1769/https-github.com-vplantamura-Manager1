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
<title> 注册－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<c:set var="repassword" value="${requestScope.repassword }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>注册</div>
<div id="base-main-container-inner">
	<div class="outter-border">
		<div id="register-container">
			<h2>新用户注册</h2>
			<div id="register-container-inner">
			<c:if test="${not empty tip }">
			<div id="tip-container">小提示：<span class="tip-words">${tip }</span></div>
			</c:if>
			<form action="action/user/register" method="post">
				<div class="line">
					<label for="username" class="common-label">用户名</label>
					<input type="text" name="username" id="username" value="${model.username }" class="in-1" />
				<a href="javascript:void(0);" id="checkUsername" class="test-formal" title="检测用户名是否已被他人注册?">检测</a>
				</div>
				<div class="line">
					<label for="password" class="common-label">密码</label>
					<input type="password" name="password" id="password" value="${model.password }" class="in-1"  />
				</div>
				<div class="line">
					<label for="repassword" class="common-label">确认密码</label>
					<input type="password" name="repassword" id="repassword" value="${repassword }" class="in-1"  />
				</div>
				<div class="line">
					<label for="code" class="common-label">验证码</label>
					<input type="text" name="code" id="code" value="" class="in-1" />
					<span id="codeImg-container"></span>
				</div>
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="注册" class="common-bt"/>
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* 注册光标自动聚焦 */
	if ($('#username').val() == '') {
		$('#username').focus();
	} else if ($('#username').val() != '' && $('#password').val() == '') {
		$('#password').focus();
	} else if ($('#username').val() != '' && $('#password').val() != ''
			&& $('#repassword').val() == '') {
		$('#repassword').focus();
	} else if ($('#username').val() != '' && $('#password').val() != ''
			&& $('#repassword').val() != '' && $('#code').val() == '') {
		$('#code').focus();
		if($('#codeImg-container').html()==''){
			var html="<img src=\"code\" onclick=\"document.getElementById('codeImg').src='code?d='+(new Date()).toUTCString();document.getElementById('code').focus();\" id=\"codeImg\"  title=\"看不清楚，换一个？\"/>";
			$('#codeImg-container').html(html);
		}
	}
	/* 检测用户名存在性的动作 */
	$('#checkUsername').click(function() {
		if ($('#username').val() == '') {
			$('#username').focus();
		} else {
			$.ajax({
				url : 'ajax/checkUsername.jsp',
				type : 'post',
				data : {
					username : $('#username').val()
				},
				success : function(res) {
					if (parseInt(res) ==1 ) {
						$('#checkUsername').removeClass('test-formal');
						$('#checkUsername').removeClass('test-fail');
						$('#checkUsername').addClass('test-ok');
						$('#password').focus();
					} else {
						$('#checkUsername').removeClass('test-formal');
						$('#checkUsername').removeClass('test-ok');
						$('#checkUsername').addClass('test-fail');
						$('#username').select();
					}
				},
				error : function() {
					window.alert('系统暂时无法为您提供服务，请稍候重试！');	
				}
			});
		}
	});
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