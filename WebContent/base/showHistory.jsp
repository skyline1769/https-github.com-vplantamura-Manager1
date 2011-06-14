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
<div id="main-container-outter">
	<div id="main-container-inner">
		<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/history">推送历史</a><span class="to"></span>${requestScope.model.dataid }</div>
		<div class="noteword">订阅键[${model.dataid }]的推送历史记录详细如下所示</div>
		<div class="box">
			<h2><img src="common/images/history.png" /> 推送历史记录详细</h2>
			<table class="data-display">
				<colgroup>
					<col width="11%" />
					<col width="89%" />
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
<div id="menu-container-outter">
	<div id="menu-container-inner">
		<h2>系统概览</h2>
		<ul class="menulist">
			<li><a href="action/global/index"><span class="m-to-i"></span><img src="common/images/index.png" class="icon fixpos"/><span>主页</span></a></li>
			<li><a href="action/global/history" class="current"><span class="m-to-i"></span><img src="common/images/history.png" class="icon fixpos"/><span>推送历史</span></a></li>
			<li>
				<a href="action/global/chart"><span class="m-to-i"></span><img src="common/images/chart.png" class="icon fixpos"/><span>统计图表</span></a>
				<ul class="child-menu">
					<li><a href="action/global/showChart?type=柱状图&charttype=GLOBAL_BAR"><img src="common/images/zz.png" class="icon"/><span>柱状图</span></a>
					<li><a href="action/global/showChart?type=折线图&charttype=GLOBAL_LINE"><img src="common/images/zx.png" class="icon" /><span>折线图</span></a>
					<li><a href="action/global/showChart?type=饼图&charttype=GLOBAL_PIE"><img src="common/images/bx.png" class="icon"/><span>饼图</span></a>
				</ul>
			</li>
		</ul>
	</div>			
</div>
<div class="clear"></div>
</body>
</html>