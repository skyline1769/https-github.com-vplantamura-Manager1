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
<title> ${requestScope.type }－基于JAVA的分布式企业配置管理系统</title>
</head>
<body>
<c:set var="type" value="${requestScope.type }"></c:set>
<c:set var="charttype" value="${requestScope.charttype }"></c:set>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="dataid" value="${requestScope.dataid }"></c:set>
<c:set var="groupname" value="${requestScope.groupname }"></c:set>
<c:set var="content" value="${requestScope.content }"></c:set>
<c:set var="action" value="${requestScope.action }"></c:set>
<c:set var="username" value="${requestScope.username }"></c:set>
<c:set var="actions" value="发布,修改,删除,切换" ></c:set>
<c:set var="groupbys" value="day(addtime),month(addtime),year(addtime),dataid,groupname,content,action,username"></c:set>
<c:set var="groupbyLabelList" value="日,月,年,键,分组,内容,动作,用户" ></c:set>
<c:set var="groupbyLabels" value="${fn:split(groupbyLabelList,',') }" ></c:set>
<c:set var="groupby" value="${requestScope.groupby }"></c:set>
<c:set var="groupList" value="${requestScope.groupList }" ></c:set>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/chart">统计图表</a><span class="to"></span>${requestScope.type }</div>
		<div class="noteword">
			<p>以下是系统运行数据的[ <span class="red"><b>${type }</b></span> ]形式展示，使您更直观的了解系统运行情况！</p>
		</div>
		<div id="view-mode">
			<div class="l">
				<img src="common/images/view-mode.png" class="fixImg"/> <b>查看模式</b>
				<c:forEach var="gb" items="${groupbys }" varStatus="status">
					<c:if test="${status.index==3 }">
						<span class="model-item">
					</c:if>
					<c:choose>
						<c:when test="${groupby==gb }">
							<span class="current">${groupbyLabels[status.index] }</span>
						</c:when>
						<c:otherwise>
							<a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=${dataid }&groupname=${groupname }&content=${content }&action=${action }&username=${username }&groupby=${gb}" title="按${groupbyLabels[status.index] }查看">${groupbyLabels[status.index] }</a>
						</c:otherwise>
					</c:choose>
					<c:if test="${status.index==(fn:length(groupbys)-1) }">
						</span>
					</c:if>
				</c:forEach>
			</div>
			<div class="r">
				您当前选择的浏览模式为: 按[<b><c:forEach var="gb" items="${groupbys }" varStatus="status"><c:choose><c:when test="${groupby==gb }">${groupbyLabels[status.index] }</c:when></c:choose></c:forEach></b>]查看
			</div>
			<div class="clear"></div>
		</div>
		<c:if test="${not empty dataid || not empty groupname || not empty content || not empty action || not empty username || not empty tip}">
		<div class="result-tip">
			当前查找关键字：
			<c:if test="${not empty dataid }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">订阅键</span>
					<span class="query-value">${dataid }<span class="query-item-close"><a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action }&username=${username }&groupby=${groupby }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty groupname }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">分组名</span>
					<span class="query-value">${groupname }<span class="query-item-close"><a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=${dataid }&groupname=&content=${content }&addtime=${addtime }&action=${action }&username=${username }&groupby=${groupby }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty content }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">配置内容</span>
					<span class="query-value">${content }<span class="query-item-close"><a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=${dataid }&groupname=${groupname }&content=&addtime=${addtime }&action=${action }&username=${username }&groupby=${groupby }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty action }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">动作</span>
					<span class="query-value">${action }<span class="query-item-close"><a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=${dataid }&groupname=${groupname }&content=&addtime=${addtime }&action=&username=${username }&groupby=${groupby }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty username }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">操作用户</span>
					<span class="query-value">${username }<span class="query-item-close"><a href="action/global/showChart?type=${type }&charttype=${charttype }&dataid=${dataid }&groupname=${groupname }&content=&addtime=${addtime }&action=${action }&username=&groupby=${groupby }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty tip }">
			<p>
				小提示：<span class="tip-words">${tip }</span>
			</p>
			</c:if>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
			<div id="quick-search">
			<form action="action/global/showChart" method="get">
				<div class="line-1">
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
				<b><label for="content" class="w-1">配置内容</label> </b><input type="text" name="content" id="content" value="${content }" class="in-1" style="width:310px;"/>
				</div>
				<div class="line-1">
				<b><label for="action" class="w-1">动作</label> </b>
				<select name="action">
					<option value="">==请选择动作==</option>
					<c:forEach var="act" items="${actions}">
						<c:choose>
							<c:when test="${action==act }">
								<option value="${act }" selected="selected">${act }</option>
							</c:when>
							<c:otherwise>
								<option value="${act }">${act }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<b><label for="username" class="w-1">操作用户</label> </b><input type="text" name="username" id="username" value="${username }"  class="in-1" style="width:350px;"/>
				<input type="hidden" name="type" value="${type }" />
				<input type="hidden" name="groupby" value="${groupby }" />
				<input type="hidden" name="charttype" value="${charttype }" />
				<input type="submit" value="查找" class="common-bt" />
				</div>
			</form>
			</div>
			<div class="display-chart-container">
				<div class="display-chart">
					<img src="common/images/loading.gif" onload="javascript:this.src='chart?type=${type }&charttype=${charttype}&dataid=${dataid }&groupname=${groupname }&content=${content }&action=${action }&username=${username }&groupby=${groupby }';" class="chart-img"/>
				</div>
			</div>
		</div>
	</div>		
</div>
<div id="menu-container-outter">
	<div id="menu-container-inner">
		<h2>系统概览</h2>
		<ul class="menulist">
			<li><a href="action/global/index"><span class="m-to-i"></span><img src="common/images/index.png" class="icon fixpos"/><span>主页</span></a></li>
			<li><a href="action/global/history"><span class="m-to-i"></span><img src="common/images/history.png" class="icon fixpos"/><span>推送历史</span></a></li>
			<li>
				<a href="action/global/chart"><span class="m-to-i"></span><img src="common/images/chart.png" class="icon fixpos"/><span>统计图表</span></a>
				<ul class="child-menu">
					<c:choose>
						<c:when test="${type=='柱状图' }">
							<li class="current"><a href="action/global/showChart?type=柱状图&charttype=GLOBAL_BAR"><img src="common/images/zz.png" class="icon"/><span>柱状图</span></a>
						</c:when>
						<c:otherwise>
							<li><a href="action/global/showChart?type=柱状图&charttype=GLOBAL_BAR"><img src="common/images/zz.png" class="icon"/><span>柱状图</span></a>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${type=='折线图' }">
							<li class="current"><a href="action/global/showChart?type=折线图&charttype=GLOBAL_LINE"><img src="common/images/zx.png" class="icon"/><span>折线图</span></a>
						</c:when>
						<c:otherwise>
							<li><a href="action/global/showChart?type=折线图&charttype=GLOBAL_LINE"><img src="common/images/zx.png" class="icon"/><span>折线图</span></a>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${type=='饼图' }">
							<li class="current"><a href="action/global/showChart?type=饼图&charttype=GLOBAL_PIE"><img src="common/images/bx.png" class="icon"/><span>饼图</span></a>
						</c:when>
						<c:otherwise>
							<li><a href="action/global/showChart?type=饼图&charttype=GLOBAL_PIE"><img src="common/images/bx.png" class="icon"/><span>饼图</span></a>
						</c:otherwise>
					</c:choose>
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
	//光标聚焦
	if($('#dataid').val()==''){
		$('#dataid').focus();
	}
	else if($('#dataid').val()!='' && $('#groupname').val()==''){
		$('#groupname').focus();
	}
	else if($('#dataid').val()!='' && $('#groupname').val()!='' && $('#content').val()==''){
		$('#content').focus();
	}
	else if($('#dataid').val()!='' && $('#groupname').val()!='' && $('#content').val()!=''&& $('#action').val()==''){
		$('#action').focus();
	}
	else if($('#dataid').val()!='' && $('#groupname').val()!='' && $('#content').val()!=''&& $('#action').val()!=''&& $('#username').val()==''){
		$('#username').focus();
	}
});
</script>
</body>
</html>