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
<title> ${requestScope.model.username } －基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="pattern" value="${requestScope.pattern}" ></c:set>
<c:set var="ruleVertifyValue" value="${requestScope.ruleVertifyValue}" ></c:set>
<c:set var="notConfigUserrule" value="${requestScope.notConfigUserrule}" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span><a href="action/user/filter">浏览用户</a><span class="to"></span>${requestScope.model.username }</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">用户[<span class="red"><b>${requestScope.model.username }</b></span>]的详细信息如下所示</div>
		<div class="box">
			<h2><img src="common/images/personal-info.png" /> 用户详细</h2>
			<table class="data-display">
				<colgroup>
					<col width="16%" />
					<col width="84%" />
				</colgroup>
				<tr>
					<th class="blank">用户名</th>
					<td>${model.username }</td>
				</tr>
				<tr>
					<th class="blank">可发布规则模式</th>
					<c:choose>
						<c:when test="${ruleVertifyValue==false }">
						<td>
							<div id="pattern-container">
								<span id="patternValue">${pattern }</span><a href="javascript:void(0);" title="清除脏规则" class="clean-userrule">清除脏规则</a>
								<div id="clear-tip-container"></div>
							</div>
						</td>
						</c:when>
						<c:otherwise>
						<td>
							${pattern }							
						</td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr> 
					<th class="blank">注册时间</th>
					<td><fmt:formatDate value="${model.registertime }" type="both"/></td>
				</tr>
				<tr> 
					<th class="blank">上次登录时间</th>
					<td><fmt:formatDate value="${model.lastlogintime }" type="both"/></td>
				</tr>
			</table>		
			<input type="hidden" name="userid" id="userid" value="${model.id }" />	
			<input type="hidden" name="pattern" id="pattern" value="${pattern }" />	
			<div class="line btContainer common-long-bt-blank">
				<input type="button" value="返回" class="common-bt back-bt" />
			</div>
		</div>
	</div>		
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
<script language="javascript">
$(function(){
	$('.clean-userrule').click(function(){
		$.ajax({
			url : 'ajax/cleanUserrule.jsp',
			type: 'post',
			data : {
				userid : $('#userid').val(),
				pattern: $('#pattern').val()
			},
			success : function(res) {
				var ok=parseInt(res)==1;
				if(ok){
					$('#clear-tip-container').html('清除脏规则成功').addClass('ok').show();
					$('.clean-userrule').hide();
					$('#patternValue').html('尚未设置');
					$('#clear-tip-container').fadeOut(5000);
				}
				else{
					$('#clear-tip-container').html('清除脏规则失败').addClass('fail').show();
					$('#clear-tip-container').fadeOut(5000);
				}
			},
			error : function(){
				window.alert('系统暂时无法为您提供服务，请稍候重试！');
			}
		});
	});
});
</script>
</body>
</html>