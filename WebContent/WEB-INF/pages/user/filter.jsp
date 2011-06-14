<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.qingtian.autodata.db.*"%>
<%@ page import="org.qingtian.autodata.mvc.action.*"%>
<%@ page import="org.qingtian.autodata.mvc.core.*"%>
<%@ page import="org.qingtian.autodata.mvc.domain.*"%>
<%@ page import="org.qingtian.autodata.mvc.filter.*"%>
<%@ page import="org.qingtian.autodata.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"></base> 
<title> 浏览用户－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<c:set var="countPerPage" value="${requestScope.countPerPage}"></c:set>
<c:set var="pager" value="${requestScope.pager}"></c:set>
<c:set var="maxPagerShowLength" value="${requestScope.maxPagerShowLength}"></c:set>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="username" value="${requestScope.username }"></c:set>
<c:set var="by" value="${requestScope.by }"></c:set>
<c:set var="order" value="${requestScope.order }"></c:set>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span>浏览用户</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword"><b>温馨提示</b>：您可以找到用户后给予其发布指定规则的权限</div>
		<c:if test="${not empty username || not empty tip}">
		<div class="result-tip">
			<c:if test="${not empty username }">
			当前查找关键字：
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">用户名</span>
					<span class="query-value">${username }<span class="query-item-close"><a href="action/user/filter?username=&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty tip }">
				小提示：<span class="tip-words">${tip }</span>
			</c:if>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
				<c:choose>
					<c:when test="${fn:length(dataList)==0 }">
						<div class="nodata">无任何用户</div>
					</c:when>
					<c:otherwise>
					<div id="quick-search">
					<form action="action/user/filter" method="get">
						<div class="line-1">
						<b><label for="username" class="w-1">用户名</label> </b><input type="text" name="username" id="username" value="${username }"  class="in-1"/>
						<input type="hidden" name="by" value="${by }" />
						<input type="hidden" name="order" value="${order }" />
						<input type="hidden" name="page" value="${page }" />
						<input type="hidden" name="countPerPage" value="${pager.countPerPage }" />
						<input type="submit" value="查找" class="common-bt" />
						</div>
					</form>
					</div>
					<form name="userForm" id="userForm" action="action/user/batchDelete" method="get">
						<input type="hidden" name="username" value="${username }" />
						<input type="hidden" name="by" value="${by }" />
						<input type="hidden" name="order" value="${order }" />
						<input type="hidden" name="page" value="${page }" />
						<input type="hidden" name="countPerPage" value="${pager.countPerPage }" />
						<div class="data-operator-bar">
							<a href="javascript:void(0);" class="selectAll" title="全选">全选</a>
							<a href="javascript:void(0);" class="selectNone" title="全不选">全不选</a>
							<a href="javascript:void(0);" class="selectReverse" title="反选">反选</a>
							<input type="button" value="设置规则" class="common-bt setRule-bt" />
							<input type="button" value="删除" class="common-bt delete-bt" />
						</div>
						<table class="data-display">
							<colgroup>
								<col width="5%" />
								<col width="60%" />
								<col width="35%" />
							</colgroup>
							<tr>
								<th class="bleft btop relative" style="font-weight:100;">
									&nbsp;
								</th>
								<th class="btop relative">
									<div class="order-title-container relative">
										<c:choose>
											<c:when test="${by=='username' && order=='desc' }">
												<a href="action/user/filter?username=${username }&by=username&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按用户名升序展示">用户名</a>
												<span class="order-by-dec pos-middle"></span>
											</c:when>
											<c:when test="${by=='username' && order=='asc' }">
												<a href="action/user/filter?username=${username }&by=username&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按用户名降序展示">用户名</a>
												<span class="order-by-asc pos-middle"></span>
											</c:when>
											<c:otherwise>
												<a href="action/user/filter?username=${username }&by=username&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按用户名${order=='asc' ? '升' : '降'}序展示">用户名</a>
											</c:otherwise>
										</c:choose>
									</div>
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
											<input type="checkbox" name="userIds" value="${model.id }" class="common-checkbox" />
										</td>
										<td class="bbottom">${model.username }</td>
										<td class="bright bbottom">
											<a href="action/user/show?id=${model.id }"  class="detail" title="查看详细信息">详细</a>
											<a href="action/user/resetPsw" class="resetPsw" title="密码重置" id="${model.username }" rel="action/user/resetPsw?id=${model.id }&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}">密码重置</a>
										</td>
									</tr>
									</c:when>
									<c:otherwise>
									<tr>
										<td class="bleft">
											<input type="checkbox" name="userIds" value="${model.id }" class="common-checkbox"  />
										</td>
										<td>${model.username }</td>
										<td class="bright">
											<a href="action/user/show?id=${model.id }" class="detail" title="查看详细信息">详细</a>
											<a href="action/user/resetPsw" class="resetPsw" title="密码重置" id="${model.username }" rel="action/user/resetPsw?id=${model.id }&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}">密码重置</a>
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
							<input type="button" value="设置规则" class="common-bt setRule-bt" />
							<input type="button" value="删除" class="common-bt delete-bt" />
						</div>
						<!-- 分页条 start -->
						<div id="pageBar">
						<div id="barL" class="l">
							<!-- 搜索式分页 -->
							<!-- 首页 -->
							<c:choose>
								<c:when test="${pager.currentPage > 1 }">
									<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=1&countPerPage=${pager.countPerPage}"
										class="page-slice first" title="首页">&lt;&lt;</a>
								</c:when>
								<c:otherwise>
									<span class="page-slice-disabled first">&lt;&lt;</span>
								</c:otherwise>
							</c:choose> 
							<!-- 上一页 -->
							<c:choose>
								<c:when test="${pager.currentPage > 1 }">
									<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${pager.currentPage - 1 }&countPerPage=${pager.countPerPage}"
										class="page-slice prevent" title="上一页">&lt;</a>
								</c:when>
								<c:otherwise>
									<span class="page-slice-disabled prevent">&lt;</span>
								</c:otherwise>
							</c:choose> 
							<c:choose>
								<c:when test="${pager.totalPage == 1}">
									<span class="page-slice-disabled">${1 }</span>
								</c:when>
								<c:when
									test="${(pager.totalPage > maxPagerShowLength) && (pager.currentPage + maxPagerShowLength-1 <= pager.totalPage) && pager.currentPage <= maxPagerShowLength}">
									<c:forEach var="p" begin="1"
										end="${maxPagerShowLength }" step="1">
										<c:choose>
											<c:when test="${p==pager.currentPage }">
												<span class="currentPage">${p }</span>
											</c:when>
											<c:otherwise>
												<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
													class="page-slice" title="第${p }页">${p }</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:when
									test="${(pager.totalPage > maxPagerShowLength) && (pager.currentPage + maxPagerShowLength-1 <= pager.totalPage)}">
									<c:forEach var="p" begin="${pager.currentPage}"
										end="${pager.currentPage + maxPagerShowLength-1}" step="1">
										<c:choose>
											<c:when test="${p==pager.currentPage }">
												<span class="currentPage">${p }</span>
											</c:when>
											<c:otherwise>
												<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
													class="page-slice" title="第${p }页">${p }</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:when
									test="${(pager.totalPage > maxPagerShowLength) && (pager.currentPage + maxPagerShowLength-1 > pager.totalPage)}">
									<c:forEach var="p" begin="${pager.totalPage-maxPagerShowLength + 1}"
										end="${ pager.totalPage}" step="1">
										<c:choose>
											<c:when test="${p==pager.currentPage }">
												<span class="currentPage">${p }</span>
											</c:when>
											<c:otherwise>
												<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
													class="page-slice" title="第${p }页">${p }</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="p" begin="1" end="${pager.totalPage }" step="1">
										<c:choose>
											<c:when test="${p==pager.currentPage }">
												<span class="currentPage">${p }</span>
											</c:when>
											<c:otherwise>
												<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
													class="page-slice" title="第${p }页">${p }</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose> 
							<!-- 下一页 -->
							<c:choose>
								<c:when test="${pager.currentPage < pager.totalPage }">
									<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${pager.currentPage + 1}&countPerPage=${pager.countPerPage}"
									 class="page-slice next" title="下一页">&gt;</a>
								</c:when>
								<c:otherwise>
									<span class="page-slice-disabled next">&gt;</span>
								</c:otherwise>
							</c:choose>
							<!-- 尾页 -->
							<c:choose>
								<c:when test="${pager.currentPage < pager.totalPage }">
									<a href="action/user/filter?username=${username }&by=${by }&order=${order }&page=${pager.totalPage}&countPerPage=${pager.countPerPage}"
									 class="page-slice last" title="尾页">&gt;&gt;</a>
								</c:when>
								<c:otherwise>
									<span class="page-slice-disabled last">&gt;&gt;</span>
								</c:otherwise>
							</c:choose>
						</div>
						<div id="barR" class="r">
							${pager.currentPage }/${pager.totalPage }页，共${pager.totalCount}条
						</div>
						<div style="clear: both;"></div>
						</div>
						<!-- 分页 end -->
						</form>
					</c:otherwise>
				</c:choose>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
<!-- 密码重置确定弹窗 -->
<div id="resetPswDialog" class="common-dialog-container">
	<div class="outter-border" style="margin:0px auto;border-color:#6f6f6f;">
		<div class="inner-container">
			<div class="dialogTitle">
				<b>密码重置</b>
				<a href="javascript:void(0);" class="jqmClose" title="关闭">关闭</a>
			</div>
			<div class="dialogCt">
				<div class="dialog-icon-container">
					<div class="icon-outter">
						<img src="common/images/resetPsw-icon.png" alt="重置密码"/>
					</div>
				</div>
				<div class="dialog-body-container">
					<p><b>您确认重置[<span id="targetUser"></span>]的登录密码嘛？</b></p>
					<div class="dialog-seperate-line"></div>
					<p>点击"重置密码"后，该用户登录密码将自动重置为<%=Configuration.INIT_PASSWORD %></p>
				</div>
				<div class="clear"></div>
			</div>
			<div class="dialogBottom">
				<input type="button" class="common-bt" id="resetPsw-bt" value="重置密码"/>
				<input type="button" class="common-cancel-bt jqmClose" value="取消"/>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	if($('#username').val()==''){
		$('#username').focus();
	}
	$('.delete-bt').click(function(){
		$('#userForm').attr('action','action/user/batchDelete');
		$('#userForm').submit();
	});
	$('.setRule-bt').click(function(){
		$('#userForm').attr('action','action/user/viewSetRule');
		$('#userForm').submit();
	});
	
	$('.resetPsw').click(function(){
		$('#targetUser').html($(this).attr('id'));
		var targeturl=$(this).attr('rel');
		$('#resetPsw-bt').click(function(){
			goUrl(targeturl);
		});
	});
	//初始化密码重置确认弹窗
	$('#resetPswDialog').jqm({
		trigger:'.resetPsw'
	});
});
</script>
</body>
</html>