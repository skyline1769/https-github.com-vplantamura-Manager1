<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.qingtian.autodata.db.*"%>
<%@ page import="org.qingtian.autodata.mvc.action.*"%>
<%@ page import="org.qingtian.autodata.mvc.core.*"%>
<%@ page import="org.qingtian.autodata.mvc.domain.*"%>
<%@ page import="org.qingtian.autodata.mvc.filter.*"%>
<%@ page import="org.qingtian.autodata.util.*"%>
<%@ page import="org.apache.commons.lang.*"%>
<%
	StringBuilder filter = new StringBuilder();
	String username = request.getParameter("username");
	String t = new String(request.getParameter("type").getBytes(
			"iso-8859-1"), "utf-8");
	String type = (t == null) ? ("日" ) : t;
	Loginrecord model = new Loginrecord();
	model.setUsername(username);
	// 合成查询字串
	if (StringUtils.isNotBlank(username)) {
		filter.append(" where ");
		filter.append(" username ='" + username + "'");
	}

	if (StringUtils.isNotBlank(username)
			&& StringUtils.isNotBlank(type)) {
		filter.append(" and ");
	} else if (StringUtils.isBlank(username)
			&& StringUtils.isNotBlank(type)) {
		filter.append(" where ");
	}

	int currentDate = CalendarTool.getCurrentDate();
	int currentMonth = CalendarTool.getCurrentMonth() + 1;
	int currentYear = CalendarTool.getCurrentYear();

	//类型
	if (StringUtils.equals(type, "日")) {
		filter.append(" (select year(logintime))=");
		filter.append(currentYear);
		filter.append(" and (select month(logintime))= ");
		filter.append(currentMonth);
		filter.append(" and (select day(logintime))=");
		filter.append(currentDate);
	} else if (StringUtils.equals(type, "月")) {
		filter.append(" (select year(logintime))=");
		filter.append(currentYear);
		filter.append(" and (select month(logintime))= ");
		filter.append(currentMonth);
	} else if (StringUtils.equals(type, "年")) {
		filter.append(" (select year(logintime))=");
		filter.append(currentYear);
	}

	filter.append(" order by logintime desc");
	// 前台分页
	int p = Configuration.DEFAULT_CURRENT_PAGE;
	int countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
	try {
		p = request.getParameter("page") == null ? Configuration.DEFAULT_CURRENT_PAGE
				: Integer.parseInt(request.getParameter("page"));
		if (p < 1)
			p = Configuration.DEFAULT_CURRENT_PAGE;
	} catch (NumberFormatException e) {
		p = Configuration.DEFAULT_CURRENT_PAGE;
	}
	try {
		countPerPage = request.getParameter("countPerPage") == null ? Configuration.DEFAULT_COUNT_PER_PAGE
				: Integer
						.parseInt(request.getParameter("countPerPage"));
	} catch (NumberFormatException e) {
		countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
	}
	int currentPage = p;
	System.out.println("sql:" + filter.toString());
	int totalCount = model.totalCount(filter.toString());
	Pager pager = new Pager(currentPage, countPerPage, totalCount);
	// 针对可能的原访问页数大于实际总页数，此处重置下
	if (currentPage > pager.getTotalPage())
		currentPage = p = pager.getTotalPage();
	// 读取部分数据
	@SuppressWarnings("unchecked")
	List<Loginrecord> list = (List<Loginrecord>) model.filterByPage(
			filter.toString(), p, pager.getCountPerPage());
	StringBuilder result = new StringBuilder();
	result.append("{'data':'");
	for (Loginrecord lr : list) {
		result.append("<li>您于：");
		result.append(new SimpleDateFormat("yyyy年M月d日  ahh时mm分ss秒, ")
				.format(lr.getLogintime()));
		result.append("登录系统一次</li>");
	}
	result.append("','page':");
	result.append(p + ",'hasNext':");
	result.append(pager.getHasNext());
	result.append("}");
	out.println(result.toString());
	out.flush();
%>
