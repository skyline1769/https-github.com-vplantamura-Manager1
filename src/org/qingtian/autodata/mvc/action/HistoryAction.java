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
import org.qingtian.autodata.mvc.domain.Group;
import org.qingtian.autodata.mvc.domain.History;

public class HistoryAction extends ActionAdapter {
	
	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/history/myHistory.jsp")
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		HttpSession session=req.getSession();
		String []sessionUser=((String)session.getAttribute(LOGIN_USER_KEY)).split("&");
		String loginUser=sessionUser[1];
		String username = param(req, "username", loginUser);
		// 默认排序
		String by = param(req, "by", "addtime");
		String order = param(req, "order", "desc");
		History model = new History();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setAction(action);
		model.setUsername(username);
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			filter.append(" where ");
			filter.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			filter.append(" and ");
			filter.append(" groupname = '" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			filter.append(" where ");
			filter.append(" groupname = '" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			filter.append(" and ");
			filter.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			filter.append(" where ");
			filter.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(action)) {
			filter.append(" and ");
			filter.append(" action = '" + action + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(action)) {
			filter.append(" where ");
			filter.append(" action = '" + action + "'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname)
				|| StringUtils.isNotBlank(content) || StringUtils
				.isNotBlank(action)) && StringUtils.isNotBlank(username)) {
			filter.append(" and ");
			filter.append(" username like '%" + username + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isBlank(action)
				&& StringUtils.isNotBlank(username)) {
			filter.append(" where ");
			filter.append(" username like '%" + username + "%'");
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
		List<History> list = (List<History>) model.filterByPage(
				filter.toString(), p, pager.getCountPerPage());

		//分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();
		
		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, ACTION, action);
		setAttr(req, USERNAME, username);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		return SUCCESS;
	}

	@Result(success = "/base/showHistory.jsp")
	@Override
	public String show(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		History model = new History();
		model.setId(id);
		model = model.get(id);
		setAttr(req, MODEL, model);
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/history/viewHistory.jsp")
	public String view(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		History model = new History();
		model.setId(id);
		model = model.get(id);
		setAttr(req, MODEL, model);
		return SUCCESS;
	}
	
	
}
