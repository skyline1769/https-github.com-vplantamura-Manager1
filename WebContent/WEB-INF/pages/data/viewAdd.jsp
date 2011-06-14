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
<title> 发布数据－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="model" value="${requestScope.model }"></c:set>
<c:set var="groupList" value="${requestScope.groupList }"></c:set>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>发布数据</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">
			<p>请认真填写以下表单，以保证发布的数据能被应用订阅端订阅到~谢谢您的配合!</p>
			<p>[<span class="red">特别提醒：对于您已经发布过的键，您如果再次发布将<b>替换</b>原键发布的内容，也就是说原内容将丢失！</span>]</p>
			<p>如果您既想对同样的键发布内容，又不想下次再次输入上次的内容。这时我们强烈建议您使用"添加备用配置"功能，详情可阅读<a href="base/help.jsp?#question-6" title="如何添加备用配置？"><img src="common/images/help.png" class="icon fixImg"/>帮助</a>]</p>
		</div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<form action="action/zookeeper/add" method="post">
				<div class="line">
					<label for="dataid" class="common-label">订阅键名</label>
					<input type="text" name="dataid" id="dataid" class="in-1" value="${model.dataid }" /> <img src="common/images/rule-icon.png"> 
					<span id="myRule-container"><a href="javascript:void(0);" id="viewRule" title="查看我的发布规则">查看我的发布规则</a></span>
					<input type="hidden" name="userid" id="userid" value="${userid }" />
				</div>
				<div class="line">
					<label for="groupname" class="common-label">分组名</label>
					<select name="groupname" id="groupname">
						<option value="">==请选择==</option>
						<c:forEach var="group" items="${groupList }">
							<c:choose>
								<c:when test="${group.groupname==model.groupname }">
									<option value="${group.groupname }" selected="selected">${group.groupname }</option>
								</c:when>
								<c:otherwise>
									<option value="${group.groupname }">${group.groupname }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
				<div class="line">
					<label for="content" class="common-label label-content">配置内容</label>
					<textarea name="content" id="content" class="common-textarea">${model.content }</textarea>
				</div>
				<input type="hidden" name="username" value="${fn:split(sessionScope.loginUser,'&')[1] }" />
				<div class="line btContainer common-bt-blank">
					<input type="submit" value="发布" class="common-bt" />
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	/* 光标自动聚焦*/
	if ($('#dataid').val() == '') {
		$('#dataid').focus();
	} 
	else if ($('#dataid').val() != '' && $('#groupname').val() == '') {
		$('#groupname').focus();
	} 
	else if ($('#dataid').val() != '' && $('#groupname').val() != ''&& $('#content').val() == '') {
		$('#content').focus();
	} 
	else{
		$('#dataid').focus();
	}
	
	//查看发布规则
	$('#viewRule').click(function() {
		$('#myRule-container').html('<img src="common/images/loading.gif" width="16" height="16" />');
		$.ajax({
				url : 'ajax/viewMyRule.jsp',
				type : 'post',
				data : {
					userid : $('#userid').val()
				},
				success : function(res) {
					$('#myRule-container').html(res);	
				},
				error: function(){
					$('#myRule-container').html('系统繁忙请稍候重试');
				}
		});
	});
});
</script>
</body>
</html>