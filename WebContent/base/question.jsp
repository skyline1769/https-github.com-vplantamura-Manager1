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
<title> 提交BUG与意见 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<c:set var="types" value="系统BUG,改进意见"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>提交BUG与意见</div>
<div id="base-main-container-inner">
	<div id="advise-container">
		<div id="advise-container-inner">
			<h2><img src="common/images/bug.png" /> 提交BUG与意见</h2>
			<div class="noteword">如果您在使用过程中发现BUG，或对系统有个人意见，都真诚希望您能花点时间填写以下表单反馈给我们!您的反馈与支持是我们前进的动力,非常感谢!</div>
			<c:if test="${not empty tip }">
			<div class="result-tip">
				小提示：<span class="tip-words">${tip }</span>
				<a href="javascript:void(0);" class="result-tip-close">关闭</a>
			</div>
			</c:if>
			<div class="main-box">
				<form action="action/message/add" method="post">
					<div class="line">
						<label for="type" class="question-label">请选择反馈类型</label>
						<select name="type" id="type">
							<option value="">==请选择==</option>
							<c:forEach var="type" items="${types }">
								<c:choose>
									<c:when test="${type==model.type }">
										<option value="${type }" selected="selected">${type }</option>
									</c:when>
									<c:otherwise>
										<option value="${type }">${type }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
					<div class="line">
						<label for="title" class="question-label">标题</label>
						<input type="text" name="title" id="title" class="in-1 in-long-title" value="${model.title }" />
					</div>
					<div class="line">
						<label for="content" class="question-label label-content">反馈内容</label>
						<textarea name="content" id="content" class="common-textarea">${model.content }</textarea>
					</div>
					<input type="hidden" name="reportuser" value="${not empty loginUser ? username : '游客' }" />
					<div class="line btContainer question-bt-blank">
						<input type="submit" value="反馈" class="common-bt" />
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script language="javascript">
$(function(){
	if($('#type').val()==''){
		$('#type').focus();
	}
	else if($('#type').val()!='' && $('#title').val()==''){
		$('#title').focus();
	}
	else if($('#title').val()!='' && $('#content').val()==''){
		$('#content').focus();
	}
});
</script>
</body>
</html>