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
<title> 用户反馈<c:if test="${not empty requestScope.type}">－${requestScope.type }</c:if>－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<c:set var="countPerPage" value="${requestScope.countPerPage}"></c:set>
<c:set var="pager" value="${requestScope.pager}"></c:set>
<c:set var="maxPagerShowLength" value="${requestScope.maxPagerShowLength}"></c:set>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="type" value="${requestScope.type }"></c:set>
<c:set var="title" value="${requestScope.title }"></c:set>
<c:set var="content" value="${requestScope.content }"></c:set>
<c:set var="reportuser" value="${requestScope.reportuser }"></c:set>
<c:set var="addtime" value="${requestScope.addtime }"></c:set>
<c:set var="by" value="${requestScope.by }"></c:set>
<c:set var="order" value="${requestScope.order }"></c:set>
<c:set var="model" value="${requestScope.model}" ></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>
<c:set var="types" value="系统BUG,改进意见"></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span><a href="action/global/advance">高级管理</a><span class="to"></span><c:choose><c:when test="${not empty requestScope.type }"><a href="action/message/filter">用户反馈</a><span class="to"></span>${requestScope.type }</c:when><c:otherwise>用户反馈</c:otherwise></c:choose>
</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">
			<p>用户反馈的系统BUG需要尽快处理，提出的意见和建议要有针对性的总结提炼，用户体验永远是第一位！</p>
		</div>
		<c:if test="${not empty type || not empty title || not empty content || not empty reportuser }">
		<div class="result-tip">
			当前查找关键字：
			<c:if test="${not empty type }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">反馈类型</span>
					<span class="query-value">${type }<span class="query-item-close"><a href="action/message/filter?type=&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty title }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">标题</span>
					<span class="query-value">${title }<span class="query-item-close"><a href="action/message/filter?type=${type }&title=&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty content }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">内容</span>
					<span class="query-value">${content }<span class="query-item-close"><a href="action/message/filter?type=${type }&title=${title }&content=&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty reportuser }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">反馈人</span>
					<span class="query-value">${reportuser }<span class="query-item-close"><a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div class="box">
				<c:choose>
					<c:when test="${fn:length(dataList)==0 }">
						<div class="nodata">无任何用户反馈</div>
					</c:when>
					<c:otherwise>
					<div id="quick-search">
					<form action="action/message/filter" method="get">
						<div class="line-1">
						<b><label for="type" class="w-1">请选择反馈类型</label> </b>
						<select name="type" id="type">
							<option value="">==请选择==</option>
							<c:forEach var="type" items="${types }">
								<c:choose>
									<c:when test="${type==model.type }">
										<option value="${type }" selected="selected">${type }</option>
									</c:when>
									<c:otherwise>
										<option value="${type }">${type }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<b><label for="title" class="w-1">标题</label> </b><input type="text" name="title" id="title" value="${title }"  class="in-1" style="width:510px;"/>
						</div>
						<div class="line-1">
						<b><label for="content" class="w-1">内容</label> </b><input type="text" name="content" id="content" value="${content }"  class="in-1" style="width:425px;"/>
						<b><label for="reportuser" class="w-1">反馈人</label> </b><input type="text" name="reportuser" id="reportuser" value="${reportuser }"  class="in-1"/>
						<input type="hidden" name="by" value="${by }" />
						<input type="hidden" name="order" value="${order }" />
						<input type="hidden" name="page" value="${page }" />
						<input type="hidden" name="countPerPage" value="${pager.countPerPage }" />
						<input type="submit" value="查找" class="common-bt" />
						</div>
					</form>
					</div>
					<table class="data-display">
						<colgroup>
							<col width="60%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tr>
							<th class="bleft btop relative">
								<div class="order-title-container relative">
									<c:choose>
										<c:when test="${by=='title' && order=='desc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=title&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按标题升序展示">标题</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='title' && order=='asc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=title&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按标题降序展示">标题</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=title&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按标题${order=='asc' ? '升' : '降'}序展示">标题</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
							<th class="btop relative">
								<div class="order-title-container relative">
									<c:choose>
										<c:when test="${by=='reportuser' && order=='desc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=reportuser&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按反馈人升序展示">反馈人</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='reportuser' && order=='asc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=reportuser&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按反馈人降序展示">反馈人</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=reportuser&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按反馈人${order=='asc' ? '升' : '降'}序展示">反馈人</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
							<th class="bright btop relative">
								<div class="order-title-container relative">
									<c:choose>
										<c:when test="${by=='addtime' && order=='desc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=addtime&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间升序展示">提交时间</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='addtime' && order=='asc' }">
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=addtime&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间降序展示">提交时间</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=addtime&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间${order=='asc' ? '升' : '降'}序展示">提交时间</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
						</tr>
						<c:forEach var="model" items="${dataList}" varStatus="status">
							<c:choose>
								<c:when test="${status.index == dataListLength-1 }">
								<tr>
									<td class="bleft bbottom"><a href="action/message/show?id=${model.id }">${model.title }</a></td>
									<td class="bbottom">${model.reportuser }</td>
									<td class="bright bbottom"><fmt:formatDate value="${model.addtime }" type="both"/></td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td class="bleft"><a href="action/message/show?id=${model.id}">${model.title }</a></td>
									<td>${model.reportuser }</td>
									<td class="bright"><fmt:formatDate value="${model.addtime }" type="both"/></td>
								</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</table>
					<!-- 分页条 start -->
					<div id="pageBar">
					<div id="barL" class="l">
						<!-- 搜索式分页 -->
						<!-- 首页 -->
						<c:choose>
							<c:when test="${pager.currentPage > 1 }">
								<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=1&countPerPage=${pager.countPerPage}"
									class="page-slice first" title="首页">&lt;&lt;</a>
							</c:when>
							<c:otherwise>
								<span class="page-slice-disabled first">&lt;&lt;</span>
							</c:otherwise>
						</c:choose> 
						<!-- 上一页 -->
						<c:choose>
							<c:when test="${pager.currentPage > 1 }">
								<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage - 1 }&countPerPage=${pager.countPerPage}"
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
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
												class="page-slice" title="第${p }页">${p }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose> 
						<!-- 下一页 -->
						<c:choose>
							<c:when test="${pager.currentPage < pager.totalPage }">
								<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.currentPage + 1}&countPerPage=${pager.countPerPage}"
								 class="page-slice next" title="下一页">&gt;</a>
							</c:when>
							<c:otherwise>
								<span class="page-slice-disabled next">&gt;</span>
							</c:otherwise>
						</c:choose>
						<!-- 尾页 -->
						<c:choose>
							<c:when test="${pager.currentPage < pager.totalPage }">
								<a href="action/message/filter?type=${type }&title=${title }&content=${content }&reportuser=${reportuser }&addtime=${addtime }&by=${by }&order=${order }&page=${pager.totalPage}&countPerPage=${pager.countPerPage}"
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
					</c:otherwise>
				</c:choose>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/advanceMenu.jsp" %>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
	if($('#type').val()==''){
		$('#type').focus();
	}
	else if($('#type').val()!='' && $('#title').val()==''){
		$('#title').focus();
	}
	else if($('#type').val()!='' && $('#title').val()!=''&& $('#content').val()==''){
		$('#content').focus();
	}
	else if($('#type').val()!='' && $('#title').val()!=''&& $('#content').val()!=''&& $('#reportuser').val()==''){
		$('#reportuser').focus();
	}
});
</script>
</body>
</html>