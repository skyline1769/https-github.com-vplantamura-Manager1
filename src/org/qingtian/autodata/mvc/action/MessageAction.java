package org.qingtian.autodata.mvc.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.domain.Message;

public class MessageAction extends ActionAdapter {

	@Result(success = "/base/question.jsp", fail = "/base/question.jsp")
	@Override
	public String add(HttpServletRequest req, HttpServletResponse resp) {
		String type = param(req, "type");
		String title = param(req, "title");
		String content = param(req, "content");
		String reportuser = param(req, "reportuser");
		Message model = new Message();
		model.setType(type);
		model.setTitle(title);
		model.setContent(content);
		model.setReportuser(reportuser);
		model.setAddtime(new Timestamp(new Date().getTime()));
		setAttr(req, MODEL, model);
		if (StringUtils.isBlank(type)) {
			setAttr(req, TIP_NAME_KEY, "请选择反馈类型");
			return FAIL;
		}
		if (StringUtils.isBlank(title)) {
			setAttr(req, TIP_NAME_KEY, "请输入标题");
			return FAIL;
		}
		if (StringUtils.isBlank(content)) {
			setAttr(req, TIP_NAME_KEY, "请输入反馈内容");
			return FAIL;
		}
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "谢谢您给予反馈，我们将以为您提供更优质的服务而努力奋斗！");
			model.setTitle("");
			model.setContent("");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "系统繁忙，请稍候重试!");
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/message/filter.jsp", fail = "/WEB-INF/pages/message/filter.jsp")
	@Override
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String type = param(req, "type", "");
		String title = param(req, "title", "");
		String content = param(req, "content", "");
		String reportuser = param(req, "reportuser", "");
		// 默认排序
		String by = param(req, "by", "addtime");
		String order = param(req, "order", "desc");
		Message model = new Message();
		model.setType(type);
		model.setTitle(title);
		model.setContent(content);
		model.setReportuser(reportuser);
		// 合成查询字串
		if (StringUtils.isNotBlank(type)) {
			filter.append(" where ");
			filter.append(" type ='" + type + "'");
		}

		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(title)) {
			filter.append(" and ");
			filter.append(" title like '%" + title + "%'");
		} else if (StringUtils.isBlank(type) && StringUtils.isNotBlank(title)) {
			filter.append(" where ");
			filter.append(" title like '%" + title + "%'");
		}

		if ((StringUtils.isNotBlank(type) || StringUtils.isNotBlank(title))
				&& StringUtils.isNotBlank(content)) {
			filter.append(" and ");
			filter.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(type) && StringUtils.isBlank(title)
				&& StringUtils.isNotBlank(content)) {
			filter.append(" where ");
			filter.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(type) || StringUtils.isNotBlank(title) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(reportuser)) {
			filter.append(" and ");
			filter.append(" reportuser like '%" + reportuser + "%'");
		} else if (StringUtils.isBlank(type) && StringUtils.isBlank(title)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(reportuser)) {
			filter.append(" where ");
			filter.append(" reportuser like '%" + reportuser + "%'");
		}
		filter.append(" order by ");
		filter.append(by);
		filter.append(" ");
		filter.append(order);
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
		setAttr(req, TYPE, type);
		setAttr(req, TITLE, title);
		setAttr(req, CONTENT, content);
		setAttr(req, REPORTUSER, reportuser);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/message/show.jsp")
	@Override
	public String show(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		Message model = new Message();
		model.setId(id);
		model = model.get(id);
		setAttr(req, MODEL, model);
		return SUCCESS;
	}

}
