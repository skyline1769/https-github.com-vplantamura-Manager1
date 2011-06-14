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
<title> 登录记录－基于JAVA的分布式企业配置管理系统 </title>
</head>
<body>
<c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
<c:set var="countPerPage" value="${requestScope.countPerPage}"></c:set>
<c:set var="pager" value="${requestScope.pager}"></c:set>
<c:set var="maxPagerShowLength" value="${requestScope.maxPagerShowLength}"></c:set>
<c:set var="dataList" value="${requestScope.dataList }" ></c:set>
<c:set var="dataListLength" value="${fn:length(requestScope.dataList) }" ></c:set>
<c:set var="tip" value="${requestScope.tip }"></c:set>
<c:set var="username" value="${requestScope.username }" ></c:set>
<c:set var="type" value="${requestScope.type }" ></c:set>
<c:set var="allType" value="日,月,年" ></c:set>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span><a href="action/global/home">我的主页</a><span class="to"></span>登录记录</div>
<div id="main-container-outter">
	<div id="main-container-inner">
		<div class="noteword">您可以通过浏览您账号的登录记录了解账号是否有不正常的使用，如果发现我们强烈建议您立即<a href="action/user/viewModifyPsw?username=${username }" title="更改密码"><img src="common/images/m-psw.png" class="icon"/>更改密码</a></div>
		<c:if test="${not empty tip }">
		<div class="result-tip">
			小提示：<span class="tip-words">${tip }</span>
			<a href="javascript:void(0);" class="result-tip-close">关闭</a>
		</div>
		</c:if>
		<div id="view-nav-container">
			<c:forEach var="currenttype" items="${allType }">
				<c:choose>
					<c:when test="${currenttype==type }">
						<span class="current"><span>本${currenttype }</span></span>
					</c:when>
					<c:otherwise>
						<a href="action/loginrecord/view?username=${username }&type=${currenttype}"><span>本${currenttype }</span></a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div id="view-more-container">
			<c:choose>
				<c:when test="${not empty dataList }">
					<ul id="loginrecord-container">
					<c:forEach var="model" items="${dataList }">
						<li>您于：<fmt:formatDate value="${model.logintime }" type="both" dateStyle="long" timeStyle="long"/>, 登录系统一次</li>
					</c:forEach>
					</ul>
					<c:if test="${pager.currentPage < pager.totalPage }">
					<div id="view-more-outter">
						<div id="more-record-wait">
							<img src="common/images/loading.gif" />
						</div>
						<div id="view-more-button-container">
							<input type="hidden" name="username" id="username" value="${username }" />
							<input type="hidden" name="type" id="type" value="${type }" />
							<input type="hidden" name="page" id="page" value="${pager.currentPage+1}" />
							<a href="javascript:void(0);" class="loadMore-bt" title="查看更多">查看更多</a>
						</div>
					</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="nodata">暂 无 数 据</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/pages/include/menu.jsp" %>
<div class="clear"></div>
<script language="javascript">
$(function(){
	$('#loginrecord-container li').hover(function(){
		$(this).addClass('on');
	},function(){
		$(this).removeClass('on');
	});
	//加载更多
	$('.loadMore-bt').click(function(){
		$('#more-record-wait').show();
		$('#view-more-button-container').hide();
		$.ajax({
			url : 'ajax/loadMoreLoginRecord.jsp',
			type: 'post',
			data : {
				username : $('#username').val(),
				type: $('#type').val(),
				page: $('#page').val()
			},
			success : function(res) {
				
				var obj=eval('('+res+')');
				//页码递增
				$('#page').val(parseInt($('#page').val())+1);
				//追加内容
				$('#loginrecord-container').html($('#loginrecord-container').html()+obj.data);
				//注册事件
				$('#loginrecord-container li').hover(function(){
					$(this).addClass('on');
				},function(){
					$(this).removeClass('on');
				});
				
				if(obj.hasNext!=0)
					$('#view-more-button-container').show();
				$('#more-record-wait').hide();
			},
			error : function() {
				window.alert('系统暂时无法为您提供服务，请稍候重试！');	
				$('#view-more-button-container').show();
				$('#more-record-wait').hide();
			}
		});
	});
});
</script>
</body>
</html>