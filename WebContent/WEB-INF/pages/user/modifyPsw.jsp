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
<title> 更换密码－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="username" value="${requestScope.username }"></c:set>
<c:set var="prepassword" value="${requestScope.prepassword }"></c:set>
<c:set var="newpassword" value="${requestScope.newpassword }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>更改密码</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">为了您的账号安全，我们建议您不要使用简单的数字作为密码！</div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<form action="action/user/modifyPsw" method="post">
				<div class="line">
					<label for="prepassword" class="common-label">原密码</label>
					<input type="password" name="prepassword" id="prepassword" class="in-1" value="${prepassword }" />
				</div>
				<div class="line">
					<label for="newpassword" class="common-label">新密码</label>
					<input type="password" name="newpassword" id="newpassword" class="in-1" value="${newpassword }" />
				</div>
				<div class="line">
					<label for="repassword" class="common-label">确认密码</label>
					<input type="password" name="repassword" id="repassword" class="in-1" />
				</div>
				<input type="hidden" name="username" value="${username }" />
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="更改密码" class="common-bt" />
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	/* 更改密码光标自动聚焦*/
	if ($('#prepassword').val() == '') {
		$('#prepassword').focus();
	} else if ($('#prepassword').val() != '' && $('#newpassword').val() == '') {
		$('#newpassword').focus();
	} else if ($('#prepassword').val() != '' && $('#newpassword').val() != ''
			&& $('#repassword').val() == '') {
		$('#repassword').focus();
	}
});
</script>
</body>
</html>