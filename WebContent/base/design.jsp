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
<title> 系统设计 </title>
</head>
<body>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>系统设计</div>
<div id="base-main-container-inner">
	<div id="system-design-container">
		<div id="system-design-container-inner">
			<h2><img src="common/images/design.png" /> 系统设计</h2>
			<div class="main-box">
				<h3>一、系统主体架构(图-1)</h3>
				<p class="center"><img src="common/images/system-design/design-1.jpg" alt="系统架构图-1" class="design-img"/></p>
				<p class="center">(图-1)</p>
				<h3>二、系统发布/订阅模型示例(图-2)</h3>
				<p class="center"><img src="common/images/system-design/pub-sub.jpg" alt="系统架构图-2" class="design-img"/></p>
				<p class="center">(图-2)</p>
				<h3>三、系统数据库设计示例(图-3)</h3>
				<p class="center"><img src="common/images/system-design/database.jpg" alt="系统架构图-3" class="design-img"/></p>
				<p class="center">(图-3)</p>
				<h3>三、系统订阅API设计示例(图-4)</h3>
				<h4 style="margin-left:40px;">1. 订阅API包结构图：</h4>
				<p class="left" style="margin-left:40px;">
					<img src="common/images/system-design/api-design.png" alt="系统架构图-4" class="design-img"/>
				</p>
				<h4 style="margin-left:40px;">2. 订阅API核心配置管理器接口：AutoDataManager继承与接口定义图：</h4>
				<p class="center">
					<img src="common/images/system-design/api-1.png" alt="系统架构图-4" class="design-img"/>
				</p>
				<h4 style="margin-left:40px;">3. 订阅API核心事件观察类：AutoDataWatchedEvent继承与类定义图：</h4>
				<p class="center">
					<img src="common/images/system-design/api-2.png" alt="系统架构图-4" class="design-img"/>
				</p>
				<h4 style="margin-left:40px;">4. 订阅API核心配置监听器接口：AutoDataListener继承与接口定义图：</h4>
				<p class="center">
					<img src="common/images/system-design/api-3.png" alt="系统架构图-4" class="design-img"/>
				</p>
				<p class="center">(图-4)</p>
			</div>
		</div>
	</div>
</div>
</body>
</html>