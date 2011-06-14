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
<title> 查看备用配置 －基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="data" value="${requestScope.data}" ></c:set>
<c:set var="dataid" value="${requestScope.dataid}" ></c:set>
<c:set var="location" value="${requestScope.location}" ></c:set>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span><a href="action/data/filter">浏览配置</a><span class="to"></span>查看备用配置 </div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">订阅键[${data.dataid }]的备用配置详细如下所示</div>
		<c:if test="${ not empty tip}">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<h2><img src="common/images/config-data.png" /> 我的备用配置详细</h2>
			<table class="data-display">
				<colgroup>
					<col width="21%" />
					<col width="79%" />
				</colgroup>
				<tr>
					<th class="blank">订阅键</th>
					<td>${data.dataid }</td>
				</tr>
				<tr>
					<th class="blank">所属分组</th>
					<td>${data.groupname }</td>
				</tr> 
				<tr> 
					<th class="blank">当前内容</th>
					<td>${data.content }</td>
				</tr>
				<tr> 
					<th class="blank">操作用户</th>
					<td>${data.username }</td>
				</tr>
				<tr>
					<td colspan="2" style="padding:5px;text-align:center;background-color:#F1F1F1;font-weight:bold;">以下为备用配置条目详细</td>
				</tr>
				<tr>
					<th class="blank">内容</th>
					<td>${model.content }</td>
				</tr>
				<tr>
					<th class="blank">简介描述</th>
					<td>${model.description }</td>
				</tr>
				<tr> 
					<th class="blank">提交时间</th>
					<td><fmt:formatDate value="${model.addtime }" type="both"/></td>
				</tr>
			</table>			
			<div class="line btContainer common-long-bt-blank">
				<input type="button" value="返回浏览配置" class="common-bt" onclick="goUrl('action/data/filter')" />
				<input type="button" value="设置为默认配置" class="common-bt setDataConfig"  />
			</div>
		</div>
	</div>		
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
<!-- 设置为默认配置-确定弹窗 -->
<div id="setDataConfigDialog" class="common-dialog-container">
	<div class="outter-border" style="margin:0px auto;border-color:#6f6f6f;">
		<div class="inner-container">
			<div class="dialogTitle">
				<b>设置默认配置</b>
				<a href="javascript:void(0);" class="jqmClose" title="关闭">关闭</a>
			</div>
			<div class="dialogCt">
				<div class="dialog-icon-container">
					<div class="icon-outter">
						<img src="common/images/resetPsw-icon.png" alt="设置默认配置"/>
					</div>
				</div>
				<div class="dialog-body-container">
					<p><b>您确认修改订阅键[${data.dataid }]的内容嘛？</b></p>
					<div class="dialog-seperate-line"></div>
					<p>您发布的订阅键[${data.dataid }]的内容将作如下变更：</p>
					<p>从目前的[<b>${data.content}</b>] -> 修改为新值[<b>${model.content }</b>]</p>
				</div>
				<div class="clear"></div>
			</div>
			<div class="dialogBottom">
				<input type="button" class="common-bt" id="setDataConfig-bt" onclick="goUrl('action/bak/setDataConfig?id=${model.id }&did=${data.id}&dataid=${data.dataid}&groupname=${data.groupname }&content=${model.content}&username=${data.username }&location=advance');" value="确认并设置为默认配置"/>
				<input type="button" class="common-cancel-bt jqmClose" value="取消"/>
			</div>
		</div>
	</div>
</div>
<script language="javascript">
$(function(){
	//设置为默认配置确认弹窗
	$('#setDataConfigDialog').jqm({
		trigger:'.setDataConfig'
	});
});
</script>
</body>
</html>