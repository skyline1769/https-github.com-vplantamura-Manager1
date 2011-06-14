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
		<h2 class="current index">我的主页</h2>
		<h2 class="personal-info">个人中心<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/user/viewModifyPsw"><span><img src="common/images/m-psw.png" class="icon"/>更改密码</span></a></li>
			<li><a href="action/loginrecord/view?type=日"><span><img src="common/images/lr-1.png" class="icon"/>登录记录</span></a></li>
			<li><a href="action/userrule/myRule"><span><img src="common/images/pr-1.png" class="icon"/>我的发布规则</span></a></li>
			<li><a href="action/history/filter"><span><img src="common/images/history-icon.png" class="icon"/>我的推送历史</span></a></li>
			<li><a href="action/global/myChart"><span><img src="common/images/chart-icon.png" class="icon"/>我的统计图表</span></a></li>
		</ul>
		<h2 class="config-data">配置数据<span class="m-title-operator-container" title="收起"><span class="m-title-operator m-title-up"></span></span></h2>
		<ul class="sub-nav-list">
			<li><a href="action/zookeeper/viewAdd"><span><img src="common/images/data-add.png" class="icon"/>我要发布</span></a></li>
			<li><a href="action/data/myData"><span><img src="common/images/my-data.png" class="icon"/>我的配置</span></a></li>
		</ul>
	</div>			
</div>