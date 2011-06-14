<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<div id="slider-container-outter">
	<div id="slider-container-inner">
		<h2 class="index"><a href="action/global/home" title="返回我的主页">我的主页</a></h2>
		<h2 class="current advance">高级管理</h2>
		<h2 class="user-center">用户中心<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/user/filter"><span><img src="common/images/user-brower.png" class="icon"/>浏览用户</span></a></li>
		</ul>
		<h2 class="config-data">配置中心<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/data/filter"><span><img src="common/images/my-data.png" class="icon"/>浏览配置</span></a></li>
		</ul>
		<h2 class="group">分组<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/group/viewAdd"><span><img src="common/images/group-add.png" class="icon"/>添加分组</span></a></li>
			<li><a href="action/group/filter"><span><img src="common/images/group-info.png" class="icon"/>分组信息</span></a></li>
		</ul>
		<h2 class="rule">规则<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/rule/viewAdd"><span><img src="common/images/rule-add.png" class="icon"/>添加规则</span></a></li>
			<li><a href="action/rule/filter"><span><img src="common/images/rule-info.png" class="icon"/>规则信息</span></a></li>
		</ul>
		<h2 class="user-reflect">用户反馈<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/message/filter?type=系统BUG"><span><img src="common/images/bug-1.png" class="icon"/>系统BUG</span></a></li>
			<li><a href="action/message/filter?type=改进意见"><span><img src="common/images/advise-1.png" class="icon"/>改进意见</span></a></li>
		</ul>
	</div>			
</div>