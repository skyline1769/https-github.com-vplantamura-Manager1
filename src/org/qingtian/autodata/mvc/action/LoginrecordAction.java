package org.qingtian.autodata.mvc.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.domain.Loginrecord;
import org.qingtian.autodata.mvc.domain.Message;
import org.qingtian.autodata.util.CalendarTool;

public class LoginrecordAction extends ActionAdapter {

	
	@Result(success="/WEB-INF/pages/loginrecord/view.jsp")
	public String view(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		HttpSession session=req.getSession();
		String []sessionUser=((String)session.getAttribute(LOGIN_USER_KEY)).split("&");
		String loginUser=sessionUser[1];
		//默认为当前用户
		String username = param(req, "username",loginUser );
		String type = param(req, "type", "日");
		Loginrecord model = new Loginrecord();
		model.setUsername(username);
		// 合成查询字串
		if (StringUtils.isNotBlank(username)) {
			filter.append(" where ");
			filter.append(" username ='" + username + "'");
		}
		
		if(StringUtils.isNotBlank(username) && StringUtils.isNotBlank(type)){
			filter.append(" and ");
		}
		else if(StringUtils.isBlank(username) && StringUtils.isNotBlank(type)){
			filter.append(" where ");
		}
		
		int currentDate=CalendarTool.getCurrentDate();
		int currentMonth=CalendarTool.getCurrentMonth()+1;
		int currentYear=CalendarTool.getCurrentYear();
		
		//类型
		if(StringUtils.equals(type, "日")){
			filter.append(" (select year(logintime))=");
			filter.append(currentYear);
			filter.append(" and (select month(logintime))= ");
			filter.append(currentMonth);
			filter.append(" and (select day(logintime))=");
			filter.append(currentDate);
		}
		else if(StringUtils.equals(type, "月")){
			filter.append(" (select year(logintime))=");
			filter.append(currentYear);
			filter.append(" and (select month(logintime))= ");
			filter.append(currentMonth);
		}
		else if(StringUtils.equals(type, "年")){
			filter.append(" (select year(logintime))=");
			filter.append(currentYear);
		}
		
		filter.append(" order by logintime desc");
		// 前台分页
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		try {
			p = param(req, "page", Configuration.DEFAULT_CURRENT_PAGE);
			if (p < 1)
				p = Configuration.DEFAULT_CURRENT_PAGE;
		} catch (NumberFormatException e) {
			p = Configuration.DEFAULT_CURRENT_PAGE;
		}
		try {
			countPerPage = param(req, "countPerPage",
					Configuration.DEFAULT_COUNT_PER_PAGE);
		} catch (NumberFormatException e) {
			countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		}
		int currentPage = p;
		int totalCount = model.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 针对可能的原访问页数大于实际总页数，此处重置下
		if (currentPage > pager.getTotalPage())
			currentPage = p = pager.getTotalPage();
		// 读取部分数据
		@SuppressWarnings("unchecked")
		List<Loginrecord> list = (List<Loginrecord>) model.filterByPage(
				filter.toString(), p, pager.getCountPerPage());

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req,USERNAME,username);
		setAttr(req,TYPE,type);
		
		return SUCCESS;
	}

	@Result(success="/ajax/loadMoreLoginRecord.jsp")
	@Override
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String username = param(req, "username", "");
		Loginrecord model = new Loginrecord();
		model.setUsername(username);
		// 合成查询字串
		if (StringUtils.isNotBlank(username)) {
			filter.append(" where ");
			filter.append(" username ='" + username + "'");
		}
		filter.append(" order by logintime desc");
		// 前台分页
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		try {
			p = param(req, "page", Configuration.DEFAULT_CURRENT_PAGE);
			if (p < 1)
				p = Configuration.DEFAULT_CURRENT_PAGE;
		} catch (NumberFormatException e) {
			p = Configuration.DEFAULT_CURRENT_PAGE;
		}
		try {
			countPerPage = param(req, "countPerPage",
					Configuration.DEFAULT_COUNT_PER_PAGE);
		} catch (NumberFormatException e) {
			countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		}
		int currentPage = p;
		int totalCount = model.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 针对可能的原访问页数大于实际总页数，此处重置下
		if (currentPage > pager.getTotalPage())
			currentPage = p = pager.getTotalPage();
		// 读取部分数据
		@SuppressWarnings("unchecked")
		List<Message> list = (List<Message>) model.filterByPage(
				filter.toString(), p, pager.getCountPerPage());

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req,USERNAME,username);
		
		return SUCCESS;
	}
	
	
}
