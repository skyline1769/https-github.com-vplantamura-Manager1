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
<title> 我的推送历史－基于JAVA的分布式企业配置管理系统</title>
</head>
<body>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="sessionUsername" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="sessionUserid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<c:set var="countPerPage" value="${requestScope.countPerPage}"></c:set>
<c:set var="pager" value="${requestScope.pager}"></c:set>
<c:set var="maxPagerShowLength" value="${requestScope.maxPagerShowLength}"></c:set>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="dataid" value="${requestScope.dataid }"></c:set>
<c:set var="groupname" value="${requestScope.groupname }"></c:set>
<c:set var="content" value="${requestScope.content }"></c:set>
<c:set var="action" value="${requestScope.action }"></c:set>
<c:set var="username" value="${sessionUsername }"></c:set>
<c:set var="by" value="${requestScope.by }"></c:set>
<c:set var="order" value="${requestScope.order }"></c:set>
<c:set var="actions" value="发布,修改,删除,切换" ></c:set>
<c:set var="groupList" value="${requestScope.groupList }" ></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>我的推送历史</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">
			<p>以下是系统从运行开始以来的所有推送记录，如果你发布了数据却发现订阅端未收到最新数据可以通过浏览推送历史来了解数据的情况！</p>
		</div>
		<c:if test="${not empty dataid || not empty groupname || not empty content || not empty action  || not empty tip}">
		<div class="result-tip">
			当前查找关键字：
			<c:if test="${not empty dataid }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">订阅键</span>
					<span class="query-value">${dataid }<span class="query-item-close"><a href="action/history/filter?dataid=&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action }&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty groupname }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">分组名</span>
					<span class="query-value">${groupname }<span class="query-item-close"><a href="action/history/filter?dataid=${dataid }&groupname=&content=${content }&addtime=${addtime }&action=${action }&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty content }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">配置内容</span>
					<span class="query-value">${content }<span class="query-item-close"><a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=&addtime=${addtime }&action=${action }&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
				</span>
			</p>
			</c:if>
			<c:if test="${not empty action }">
			<p class="search-item">
				<span class="query-key-container">
					<span class="query-key-name">动作</span>
					<span class="query-value">${action }<span class="query-item-close"><a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=&addtime=${addtime }&action=&username=${username }&by=${by }&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" title="删除这个查找条件">关闭</a></span></span>
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
				<c:choose>
					<c:when test="${fn:length(dataList)==0 }">
						<div class="nodata">无任何推送历史</div>
					</c:when>
					<c:otherwise> 
					<div id="quick-search">
					<form action="action/history/filter" method="get">
						<div class="line-1">
						<b><label for="dataid" class="w-1">订阅键</label> </b><input type="text" name="dataid" id="dataid" value="${dataid }"  class="in-1" style="width:455px;"/>
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
						</div>
						<div class="line-1">
						<b><label for="content" class="w-1">配置内容</label> </b><input type="text" name="content" id="content" value="${content }" class="in-1" style="width:455px;"/>
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
						<input type="hidden" name="username" value="${username }" />
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
										<c:when test="${by=='dataid' && order=='desc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=dataid&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按订阅键升序展示">订阅键</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='dataid' && order=='asc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=dataid&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按订阅键降序展示">订阅键</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=dataid&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按订阅键${order=='asc' ? '升' : '降'}序展示">订阅键</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
							<th class="btop relative">
								<div class="order-title-container relative">
									<c:choose>
										<c:when test="${by=='groupname' && order=='desc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=groupname&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按分组名升序展示">分组名</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='groupname' && order=='asc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=groupname&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按分组名降序展示">分组名</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=groupname&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按分组名${order=='asc' ? '升' : '降'}序展示">分组名</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
							<th class="bright btop relative">
								<div class="order-title-container relative">
									<c:choose>
										<c:when test="${by=='addtime' && order=='desc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=addtime&order=asc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间升序展示">提交时间</a>
											<span class="order-by-dec pos-middle"></span>
										</c:when>
										<c:when test="${by=='addtime' && order=='asc' }">
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=addtime&order=desc&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间降序展示">提交时间</a>
											<span class="order-by-asc pos-middle"></span>
										</c:when>
										<c:otherwise>
											<a href="action/history/filter?dataid=${dataid }&groupname=${groupname }&content=${content }&addtime=${addtime }&action=${action}&username=${username }&by=addtime&order=${order }&page=${pager.currentPage}&countPerPage=${pager.countPerPage}" class="order-operator" title="点击按提交时间${order=='asc' ? '升' : '降'}序展示">提交时间</a>
										</c:otherwise>
									</c:choose>
								</div>
							</th>
						</tr>
						<c:forEach var="model" items="${dataList}" varStatus="status">
							<c:choose>
								<c:when test="${status.index == dataListLength-1 }">
								<tr>
									<td class="bleft bbottom"><a href="action/history/view?id=${model.id }" title="查看详细">${model.dataid }</a></td>
									<td class="bbottom">${model.groupname }</td>
									<td class="bright bbottom"><fmt:formatDate value="${model.addtime }" type="both"/></td>
								</tr>
								</c:when>
								<c:otherwise>
								<tr>
									<td class="bleft"><a href="action/history/view?id=${model.id}">${model.dataid }</a></td>
									<td>${model.groupname }</td>
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
								<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=1&countPerPage=${pager.countPerPage}"
									class="page-slice first" title="首页">&lt;&lt;</a>
							</c:when>
							<c:otherwise>
								<span class="page-slice-disabled first">&lt;&lt;</span>
							</c:otherwise>
						</c:choose> 
						<!-- 上一页 -->
						<c:choose>
							<c:when test="${pager.currentPage > 1 }">
								<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${pager.currentPage - 1 }&countPerPage=${pager.countPerPage}"
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
											<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
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
											<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${p }&countPerPage=${pager.countPerPage}"
												class="page-slice" title="第${p }页">${p }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:otherwise>
						</c:choose> 
						<!-- 下一页 -->
						<c:choose>
							<c:when test="${pager.currentPage < pager.totalPage }">
								<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${pager.currentPage + 1}&countPerPage=${pager.countPerPage}"
								 class="page-slice next" title="下一页">&gt;</a>
							</c:when>
							<c:otherwise>
								<span class="page-slice-disabled next">&gt;</span>
							</c:otherwise>
						</c:choose>
						<!-- 尾页 -->
						<c:choose>
							<c:when test="${pager.currentPage < pager.totalPage }">
								<a href="action/history/filter?dataid=${dataid}&groupname=${groupname}&content=${content}&addtime=${addtime }&action=${action}&username=${username }&by=${by }&order=${order }&page=${pager.totalPage}&countPerPage=${pager.countPerPage}"
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
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
<script type="text/javascript">
$(function(){
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