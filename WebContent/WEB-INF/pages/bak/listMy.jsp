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
<title> 浏览备用配置－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="dataid" value="${requestScope.dataid }"></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>
<c:set var="location" value="${requestScope.location}" ></c:set>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/data/myData">我的配置</a><span class="to"></span>浏览备用配置</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword"><b>温馨提示</b>：以下展示的是您的全部备用配置数据</div>
		<c:if test="${ not empty tip}">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
				<c:choose>
					<c:when test="${fn:length(dataList)==0 }">
						<div class="nodata">无任何备用配置数据</div>
					</c:when>
					<c:otherwise>
					<form action="action/bak/batchDelete">
						<input type="hidden" name="location" value="myData" />
						<input type="hidden" name="dataid" value="${dataid }" />
						<div class="data-operator-bar">
							<a href="javascript:void(0);" class="selectAll" title="全选">全选</a>
							<a href="javascript:void(0);" class="selectNone" title="全不选">全不选</a>
							<a href="javascript:void(0);" class="selectReverse" title="反选">反选</a>
							<input type="submit" value="删除" class="common-bt" />
						</div>
						<table class="data-display">
							<colgroup>
								<col width="5%" />
								<col width="55%" />
								<col width="20%" />
								<col width="20%" />
							</colgroup>
							<tr>
								<th class="bleft btop relative">
									删?
								</th>
								<th class="btop relative">
									描述
								</th>
								<th class="btop relative">
									添加时间
								</th>
								<th class="bright btop relative">
									可选操作
								</th>
							</tr>
							<c:forEach var="model" items="${dataList}" varStatus="status">
								<c:choose>
									<c:when test="${status.index == dataListLength-1 }">
									<tr>
										<td class="bleft bbottom">
											<input type="checkbox" name="deleteId" value="${model.id }" class="common-checkbox"/>
										</td>
										<td class="bbottom">
											<a href="action/bak/showMy?id=${model.id }&dataid=${dataid}" title="查看详细备用配置">${model.description}</a>
										</td>
										<td class="bbottom"><fmt:formatDate value="${model.addtime }" type="both"/></td>
										<td class="bright bbottom">
											<a href="action/bak/showMy?id=${model.id }&dataid=${dataid}" class="detail">查看</a>
											<a href="action/bak/viewModify?id=${model.id }&location=myData" class="modify">修改</a>
										</td>
									</tr>
									</c:when>
									<c:otherwise>
									<tr>
										<td class="bleft">
											<input type="checkbox" name="deleteId" value="${model.id }" class="common-checkbox"/>
										</td>
										<td>
											<a href="action/bak/showMy?id=${model.id }&dataid=${dataid}" title="查看详细备用配置">${model.description}</a>
										</td>
										<td><fmt:formatDate value="${model.addtime }" type="both"/></td>
										<td class="bright">
											<a href="action/bak/showMy?id=${model.id }&dataid=${dataid}" class="detail">查看</a>
											<a href="action/bak/viewModify?id=${model.id }&location=myData" class="modify">修改</a>
										</td>
									</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</table>
						<div class="data-operator-bar top-border">
							<a href="javascript:void(0);" class="selectAll" title="全选">全选</a>
							<a href="javascript:void(0);" class="selectNone" title="全不选">全不选</a>
							<a href="javascript:void(0);" class="selectReverse" title="反选">反选</a>
							<input type="submit" value="删除" class="common-bt" />
						</div>
					</form>
					</c:otherwise>
				</c:choose>
			<div class="line btContainer">
				<input type="button" value="返回我的配置" class="common-bt" onclick="goUrl('action/data/myData?username=${username }');" />
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
</body>
</html>