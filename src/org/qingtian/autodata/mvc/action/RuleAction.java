package org.qingtian.autodata.mvc.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.domain.Rule;
import org.qingtian.autodata.mvc.domain.UserRule;
import org.qingtian.autodata.util.CharFilterTool;

public class RuleAction extends ActionAdapter {

	private static final Log log = LogFactory.getLog(RuleAction.class);

	@Result(success = "/WEB-INF/pages/rule/viewAdd.jsp")
	@Override
	public String viewAdd(HttpServletRequest req, HttpServletResponse resp) {
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/rule/viewAdd.jsp", fail = "/WEB-INF/pages/rule/viewAdd.jsp")
	@Override
	public String add(HttpServletRequest req, HttpServletResponse resp) {
		String pattern = param(req, "pattern");

		Rule model = new Rule();
		model.setPattern(pattern);
		setAttr(req, MODEL, model);
		if (StringUtils.isBlank(pattern)) {
			setAttr(req, TIP_NAME_KEY, "请输入模式");
			return FAIL;
		}
		// check char
		if (CharFilterTool.hasBackRegex(pattern)) {
			setAttr(req, TIP_NAME_KEY,
					"您输入的模式不能包含如下字符:" + CharFilterTool.getBackRegexChars());
			model.setPattern("");
			return FAIL;
		}
		// 业务
		if (model.isExist(pattern)) {
			setAttr(req, TIP_NAME_KEY, "对不起，模式[" + pattern + "]已被使用,请换个模式后重试!");
			model.setPattern("");
			return FAIL;
		}
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "恭喜您，成功添加新模式: [" + pattern + "]");
			model.setPattern("");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "系统故障，请稍候重试");
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/rule/filter.jsp")
	@Override
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String pattern = param(req, "pattern", "");
		// 默认排序
		String by = param(req, "by", "pattern");
		String order = param(req, "order", "desc");
		Rule model = new Rule();
		model.setPattern(pattern);
		if (StringUtils.isNotBlank(pattern)) {
			filter.append(" where ");
			filter.append(" pattern like '%" + pattern + "%'");
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
		List<Rule> list = (List<Rule>) model.filterByPage(filter.toString(), p,
				pager.getCountPerPage());

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req, PATTERN, pattern);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		// 批量删除传来的消息
		String tip = (String) getAttr(req, TIP_NAME_KEY);
		setAttr(req, TIP_NAME_KEY, tip);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/rule/filter.jsp", fail = "/WEB-INF/pages/rule/filter.jsp")
	public String batchDelete(HttpServletRequest req, HttpServletResponse resp) {
		String[] deleteId = params(req, "deleteId");
		System.out.println("deleteId's length:" + deleteId.length);
		if (deleteId.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要删除的模式");
			this.filter(req, resp);
			return FAIL;
		}
		// Hi~选择删除对象后才会到达此处
		Rule model = new Rule();
		// 删除相关联的用户发布规则关系定义
		List<UserRule> deleteUserRule = new ArrayList<UserRule>();
		for (String ruleId : deleteId) {
			model = model.get(Long.parseLong(ruleId));
			UserRule userrule = new UserRule();
			List<UserRule> list = (List<UserRule>) userrule
					.filter(" where pattern='" + model.getPattern() + "'");
			deleteUserRule.addAll(list);
		}
		int require = deleteUserRule.size();
		int deleteCount = 0;
		for (UserRule userrule : deleteUserRule) {
			if (userrule.delete())
				deleteCount += 1;
		}
		// 删除规则
		int[] results = model.batchDelete(deleteId);
		log.debug("batchDelete results[0]: " + results[0]);
		if (results.length > 0 && results[0] > 0) {
			if (require == deleteCount)
				setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个模式, 成功关联删除"
						+ deleteCount + "个用户与规则对应关系");
			else
				setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个模式, 成功关联删除"
						+ deleteCount + "个用户与规则对应关系," + (require - deleteCount)
						+ "个用户与规则对应关系删除失败，请手动清除");
		}
		this.filter(req, resp);
		return SUCCESS;
	}
}
