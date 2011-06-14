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
<title> 我的主页－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="loginrecord" value="${requestScope.loginrecord }" ></c:set>
<c:set var="historyList" value="${requestScope.historyList }"></c:set>
<c:set var="myRule" value="${requestScope.myRule }"></c:set>
<c:set var="pushDataTotal" value="${requestScope.pushDataTotal }"></c:set>

<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1]}"></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>

<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>我的主页</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="box">
			<div id="go-fast-container">
				<h2>快速通道</h2>
				<ul class="panel">
					<li><a href="action/user/viewModifyPsw" title="更改密码"><img src="common/images/fast-modifypsw.png" alt="更改密码"/></a><p class="center bold">更改密码</p></li>
					<li><a href="action/zookeeper/viewAdd" title="发布配置"><img src="common/images/fast-pushdata.png" alt="发布配置"/></a><p class="center bold">发布配置</p></li>
					<li><a href="action/history/filter" title="查看推送历史"><img src="common/images/fast-viewhistory.png" alt="查看推送历史"/></a><p class="center bold">查看推送历史</p></li>
					<li><a href="action/global/myChart" title="统计图表"><img src="common/images/fast-chart.png" alt="统计图表"/></a><p class="center bold">统计图表</p></li>
					<div class="clear"></div>
				</ul>
			</div>
			<div id="my-info-container">
				<h2>我的个人信息</h2>
				<div class="panel">
					您好，<img src="common/images/user-item.png"> <span class="red bold">${username }</span>  
					您上次登录系统于：<fmt:formatDate value="${loginrecord.logintime}" type="both"/> 
					<img src="common/images/lr-1.png" class="icon"/><a href="action/loginrecord/view?type=日" title="查看详细登录记录 ">查看详细登录记录 </a>  
					如发现登录异常，请立即 <a href="action/user/viewModifyPsw" title="更改密码"> <img src="common/images/m-psw.png" class="icon"/>更改密码</a>
				</div>
			</div>
			<div id="home-chart-container">
				<h2>我的统计图表</h2>
				<div class="l">
					<div id="global_bar">
						<div class="display-chart">
							<img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_BAR&width=370&height=185&username=${username }';" class="chart-img"/>
						</div>
					</div>
				</div>
				<div class="r">
					<div id="global_line">
						<div class="display-chart">
							<img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_LINE&width=370&height=185&username=${username }';"" class="chart-img"/>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<div id="data-info-container">
				<h2>我的发布规则与配置</h2>
				<div class="panel">
					<p>您的发布规则为：<b class="red">
					<c:choose>
						<c:when test="${not empty myRule }">
						${myRule }
						</c:when>
						<c:otherwise>
						无
						</c:otherwise>
					</c:choose></b> ，截止到目前您已经发布了共[ <b class="red">${pushDataTotal }</b> ]条配置, <img src="common/images/my-data.png" class="icon"/><a href="action/data/myData">查看我的所有配置</a></p>
				</div>
				<h2>我的最新发布配置</h2>
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
									<th class="bright btop">时间</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="history" items="${historyList }">
								<tr>
									<td class="bleft">${history.dataid}</td>
									<td>${history.groupname }</td>
									<td>${history.action}</td>
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
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
</body>
</html>