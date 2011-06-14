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
<title> 首页－基于JAVA的分布式企业配置管理系统</title>
</head>
<c:set var="serverClusterSize" value="${requestScope.serverClusterSize }"></c:set>
<c:set var="pushDataTotal" value="${requestScope.pushDataTotal }"></c:set>
<c:set var="registerUserCount" value="${requestScope.registerUserCount }"></c:set>
<c:set var="registerUserCountOfToday" value="${requestScope.registerUserCountOfToday }"></c:set>
<c:set var="averagePushDataPerUser" value="${requestScope.averagePushDataPerUser }"></c:set>
<c:set var="topPushDataByModel" value="${requestScope.topPushDataByModel }"></c:set>
<c:set var="historyList" value="${requestScope.historyList }"></c:set>
<body>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div id="chart-container">
			<h2>统计图表</h2>
			<div class="l">
				<div id="global_bar">
					<div class="display-chart">
						<a href="action/global/showChart?type=柱状图&charttype=GLOBAL_BAR" title="柱状图模式浏览"><img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_BAR&width=370&height=185';" class="chart-img"/></a>
					</div>
				</div>
			</div>
			<div class="r">
				<div id="global_line">
					<div class="display-chart">
						<a href="action/global/showChart?type=折线图&charttype=GLOBAL_LINE" title="折线图模式浏览"><img src="common/images/loading.gif" onload="javascript:this.src='chart?charttype=GLOBAL_LINE&width=370&height=185';"" class="chart-img"/></a>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div id="stat-container">
			<div class="l">
				<h2>系统状态</h2>
				<div class="stat-content">
					<div class="stat-content-inner">
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/server-total.png" class="fixImg"/> WEB集群：</span><span class="stat-value"><b>${serverClusterSize }</b>台web服务器<a href="action/zookeeper/viewCluster" title="查看详细" class="server-view">查看详细</a></span></div>
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/fz.png" class="fixImg"/> 推送峰值率：</span><span class="stat-value"><b>${topPushDataByModel.count }</b>条/天 <a href="javascript:void(0);" class="viewTopPushDetail" title="查看详细">查看详细</a></span></div>
						<div class="topPushData-container">
							<div>发生时间为：${topPushDataByModel.year }年${topPushDataByModel.month }月${topPushDataByModel.day }日 ${topPushDataByModel.hour }时${topPushDataByModel.minute }分${topPushDataByModel.second }秒</div>
						</div>
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/data-total.png" class="fixImg"/> 推送数据总量：</span><span class="stat-value"><b>${pushDataTotal }</b>条</span></div>
					</div>
				</div>
			</div>
			<div class="r">
				<h2>用户统计</h2>
				<div class="stat-content">
					<div class="stat-content-inner">
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/user-total.png" class="fixImg"/> 注册用户总量：</span><span class="stat-value"><b>${registerUserCount }</b>位</span></div>
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/average-push.png" class="fixImg"/> 平均推送数据：</span><span class="stat-value"><b><fmt:formatNumber value="${averagePushDataPerUser }" pattern="#0.00" ></fmt:formatNumber></b>条/位</span></div>
						<div class="stat-row"><span class="stat-description-word"><img src="common/images/personal-info.png" class="fixImg"/> 今日注册用户数：</span><span class="stat-value"><b>${registerUserCountOfToday }</b>位</span></div>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div id="history-container">
			<h2>近期推送一览</h2>
			<c:choose>
				<c:when test="${empty historyList }">
					<div class="nodata">无任何推送</div>
				</c:when>
				<c:otherwise>
				<table class="display-table" style="margin:0px;">
					<thead>
						<tr>
							<th>数据订阅键</th>
							<th>所属分组</th>
							<th>动作</th>
							<th>用户</th>
							<th>时间</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="history" items="${historyList }">
						<tr>
							<td>${history.dataid}</td>
							<td>${history.groupname }</td>
							<td>${history.action}</td>
							<td>${history.username }</td>
							<td><fmt:formatDate value="${history.addtime}" type="both"/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</c:otherwise>
			</c:choose>
		</div>					
	</div>		
</div>
<div id="menu-container-outter">
	<div id="menu-container-inner">
		<h2>系统概览</h2>
		<ul class="menulist">
			<li><a href="action/global/index" class="current"><span class="m-to-i"></span><img src="common/images/index.png" class="icon fixpos"/><span>主页</span></a></li>
			<li><a href="action/global/history"><span class="m-to-i"></span><img src="common/images/history.png" class="icon fixpos"/><span>推送历史</span></a></li>
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
<script language="javascript">
$(function(){
	$('.chart-img').hover(function(){
		$(this).addClass('chart-img-on');
	},function(){
		$(this).removeClass('chart-img-on');
	});
	$('.viewTopPushDetail').toggle(function(){
		$(this).html('关闭');
		$(this).attr('title','关闭');
		$('.topPushData-container').slideDown('fast');
	},function(){
		$(this).html('查看详细');
		$(this).attr('title','查看详细');
		$('.topPushData-container').slideUp('fast');
	});
});
</script>
</body>
</html>