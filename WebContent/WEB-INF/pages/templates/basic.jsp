<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
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
<title><decorator:title default="出错啦" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link rel="shortcut icon" type="image/ico" href="website.ico">
<script language="javascript" type="text/javascript"
	src="common/js/jquery-1.3.2.min.js"></script>
<script language="javascript" type="text/javascript"
	src="common/js/common.js"></script>
<script language="javascript" type="text/javascript"
	src="common/js/jqModal.js"></script>
<link rel="stylesheet" type="text/css" href="common/css/common.css">
<link rel="stylesheet" type="text/css" href="common/css/jqModal.css">
<script type="text/javascript">
$(function(){
	// 主页左侧导航菜单
	var operatorContainer = $('.m-title-operator-container');
	operatorContainer.mouseover(function() {
		$(this).css('backgroundColor', '#f3f3f3');
	});
	operatorContainer.mouseout(function() {
		$(this).css('backgroundColor', 'transparent');
	});
	// 收起/展开
	operatorContainer.toggle(function() {
		var next = $(this).parent().next();
		next.slideToggle(100);
		$(this).attr('title', '展开');
		$(this).children().removeClass('m-title-up');
		$(this).children().addClass('m-title-down');
	}, function() {
		var next = $(this).parent().next();
		next.slideToggle(100);
		$(this).attr('title', '收起');
		$(this).children().removeClass('m-title-down');
		$(this).children().addClass('m-title-up');
	});
	//全选，全不选，反选 
	$('.common-checkbox').click(function(){
		if($(this).attr('checked')){
			$(this).parent().parent().addClass('onselect');
		}
		else{
			$(this).parent().parent().removeClass('onselect');
		}
	});
	$('.selectAll').click(function(){
		$('.common-checkbox').attr('checked','checked');
		$('.common-checkbox').parent().parent().addClass('onselect');
	});
	$('.selectNone').click(function(){
		$('.common-checkbox').attr('checked','');
		$('.common-checkbox').parent().parent().removeClass('onselect');
	});
	$('.selectReverse').click(function(){
		$('.common-checkbox').each(function(){
			if($(this).attr("checked")){
				$(this).attr("checked",false);
				$(this).parent().parent().removeClass('onselect');
			}else{
				$(this).attr("checked",true);
				$(this).parent().parent().addClass('onselect');
			}
		});
	});
});
</script>
</head>
<body>
<div id="wrapoutter"><%@ include
	file="/WEB-INF/pages/include/header.jsp"%>
<div id="wrap">
<div id="wrapinner">
<div id="basic-container"><decorator:body /></div>
</div>
<%@ include file="/WEB-INF/pages/include/footer.jsp"%>
</div>
</div>
</body>
</html>