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
<title> 服务器集群一览 </title>
</head>
<body>
<c:set var="serverClusterList" value="${requestScope.serverClusterList }"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>服务器集群一览</div>
<div id="base-main-container-inner">
	<div id="serverCluster-container">
		<div id="serverCluster-container-inner">
			<h2><img src="common/images/server-view-icon.png"/> 服务器集群一览</h2>
			<div class="noteword">以下服务器节点情况是系统动态读取生成，展示了当前整个WEB服务器的集群详情（包括IP地址及服务端口）</div>
			<div class="main-box">
				<c:choose>
					<c:when test="${empty serverClusterList }">
						<div class="nodata">服务器集群暂不可用</div>
					</c:when>
					<c:otherwise>
					<div class="serverCluster-container">
						<div class="zookeeper-container">
							<div class="zookeeper-inner">
								<img src="common/images/server-border-bottom.png" />
								<div class="server-info-container">
									<p class="server-serial">ZOOKEEPER</p>
								</div>
							</div>
						</div>
						<div class="webserver-container">
							<c:forEach var="server" items="${serverClusterList }" varStatus="status">
								<c:set var="parts" value="${fn:split(server,':')}"></c:set>
								<div class="webserver-item">
								<img src="common/images/server-line-1.png" />
								<div class="server-info-container">
									<p class="server-serial">WEB-SERVER-${status.index+1 }</p>
									<p>IP：${parts[0] }</p>
									<p>端口：${parts[1] }</p>
								</div>
								</div>
							</c:forEach>
						</div>
					</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
</body>
</html>