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
<title> 高级管理－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="groupList" value="${requestScope.groupList }" ></c:set>
<c:set var="historyList" value="${requestScope.historyList }"></c:set>

<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>高级管理</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="box">
			<div id="go-fast-container">
				<h2>快速通道</h2>
				<ul class="panel">
					<li><a href="action/group/viewAdd" title="添加分组"><img src="common/images/fast-addgroup.png" alt="添加分组"/></a><p class="center bold">添加分组</p></li>
					<li><a href="action/rule/viewAdd" title="添加发布规则"><img src="common/images/fast-addrule.png" alt="添加发布规则"/></a><p class="center bold">添加发布规则</p></li>
					<div class="clear"></div>
				</ul>
				<div id="go-fast-search">
					<div class="search-bar">
						<form action="action/user/filter" method="get">
							<b><label for="username" class="w-1">用户名</label> </b><input type="text" name="username" id="username" value="${username }"  class="in-1"/>
							<input type="submit" value="查找用户" class="common-bt" />
						</form>
					</div>
					<div class="go-fast-search-bar"></div>
					<div class="search-bar">
						<form action="action/data/filter" method="get">
							<b><label for="dataid" class="w-1">订阅键</label> </b><input type="text" name="dataid" id="dataid" value="${dataid }"  class="in-1"/>
							<b><label for="groupname" class="w-1">分组名</label> </b>
							<select name="groupname">
								<option value="">==请选择分组==</option>
								<c:forEach var="group" items="${groupList}">
									<c:choose>
										<c:when test="${groupname==group.groupname }">
											<option value="${group.groupname }" selected="selected">${group.groupname }</option>
										</c:when>
										<c:otherwise>
											<option value="${group.groupname }">${group.groupname }</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<b><label for="content" class="w-1">配置内容</label> </b><input type="text" name="content" id="content" value="${content }"  class="in-1"/>
							<input type="submit" value="查找配置" class="common-bt" />
						</form>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div id="advance-chart-container">
				<h2>系统整体统计图表</h2>
				<div class="l">
					<div id="global_bar">
						<div class="display-chart">
							<img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_BAR&width=370&height=185';" class="chart-img"/>
						</div>
					</div>
				</div>
				<div class="r">
					<div id="global_line">
						<div class="display-chart">
							<img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_LINE&width=370&height=185';"" class="chart-img"/>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div id="data-info-container">
				<h2>最新发布</h2>
					<c:choose>
						<c:when test="${empty historyList }">
							<div class="nodata">无任何推送</div>
						</c:when>
						<c:otherwise>
						<table class="data-display" style="margin:0px;">
							<thead>
								<tr>
									<th class="bleft btop" style="padding-left:5px;">数据订阅键</th>
									<th class="btop">所属分组</th>
									<th class="btop">动作</th>
									<th class="btop">用户</th>
									<th class="bright btop">时间</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="history" items="${historyList }">
								<tr>
									<td class="bleft">${history.dataid}</td>
									<td>${history.groupname }</td>
									<td>${history.action}</td>
									<td>${history.username}</td>
									<td class="bright"><fmt:formatDate value="${history.addtime}" type="both"/></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</c:otherwise>
					</c:choose>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
</body>
</html>