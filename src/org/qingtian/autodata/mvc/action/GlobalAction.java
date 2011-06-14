package org.qingtian.autodata.mvc.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooKeeper;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.mvc.domain.Group;
import org.qingtian.autodata.mvc.domain.History;
import org.qingtian.autodata.mvc.domain.Loginrecord;
import org.qingtian.autodata.mvc.domain.User;
import org.qingtian.autodata.mvc.domain.UserRule;
import org.qingtian.autodata.mvc.domain.useful.AdvanceHistory;
import org.qingtian.autodata.util.CalendarTool;

public class GlobalAction extends ActionAdapter {

	private static final Log log = LogFactory.getLog(GlobalAction.class);

	@Result(success = "/base/index.jsp")
	public String index(HttpServletRequest req, HttpServletResponse resp) {
		// 集群大小
		try {
			ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
			List<String> serverClusterList = (List<String>) zk.getChildren(
					SERVER_CLUSTER_NODE, new AutoDataWatcher(zk));
			setAttr(req, SERVER_CLUSTER_SIZE, (serverClusterList == null ? 0
					: serverClusterList.size()));
		} catch (NullPointerException e) {
			e.printStackTrace();
			return FAIL;
		} catch (KeeperException e) {
			e.printStackTrace();
			return FAIL;
		} catch (InterruptedException e) {
			e.printStackTrace();
			return FAIL;
		}

		// 用户数据统计
		User user = new User();
		// 注册用户总量
		int registerUserCount = user.totalCount();
		setAttr(req, REGISTER_USER_COUNT, registerUserCount);
		// 今日注册
		int dateOfToday = CalendarTool.getCurrentDate();
		int monthOfToday = CalendarTool.getCurrentMonth() + 1;
		int yearOfToday = CalendarTool.getCurrentYear();
		StringBuilder sql = new StringBuilder(
				" where (select year(registertime))=");
		sql.append(yearOfToday);
		sql.append(" and (select month(registertime))=");
		sql.append(monthOfToday);
		sql.append(" and (select day(registertime))=");
		sql.append(dateOfToday);
		int registerUserCountOfToday = user.totalCount(sql.toString());
		log.debug("registerUserCount in " + yearOfToday + "-" + monthOfToday
				+ "-" + dateOfToday + ": " + registerUserCountOfToday);
		setAttr(req, REGISTER_USER_COUNT_OF_TODAY, registerUserCountOfToday);
		// 推送历史
		History history = new History();
		// 前台显示一页数据
		StringBuilder filter = new StringBuilder();
		filter.append(" order by addtime desc");
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = 5;
		int currentPage = p;
		int totalCount = history.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 读取部分数据
		@SuppressWarnings("unchecked")
		List<History> historyList = (List<History>) history.filterByPage(
				filter.toString(), p, pager.getCountPerPage());
		setAttr(req, HISTORY_LIST, historyList);
		// 总推送量
		int pushDataTotal = history.totalCount();
		setAttr(req, PUSH_DATA_TOTAL, pushDataTotal);
		// 平均推送量/用户
		setAttr(req, AVERAGE_PUSHDATA_PER_USER, (double) pushDataTotal
				/ registerUserCount);
		// 最高峰值 条数/天
		List<AdvanceHistory> topList = (List<AdvanceHistory>) history
				.getAdvance("", "day(addtime)", "count(*) desc");
		setAttr(req, TOP_PUSHDATA_BY_MODEL, topList.size() > 0 ? topList.get(0)
				: new AdvanceHistory());
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/base/history.jsp")
	public String history(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
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
				&& StringUtils.isBlank(content) && StringUtils.isBlank(action)
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

		// 分组名列表
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

	@SuppressWarnings("unchecked")
	@Result(success = "/base/chart.jsp")
	public String chart(HttpServletRequest req, HttpServletResponse resp) {
		// 构建过滤条件
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
		// 默认分组
		String groupby = param(req, "groupby", "day(addtime)");
		History model = new History();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setAction(action);
		model.setUsername(username);

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, ACTION, action);
		setAttr(req, USERNAME, username);

		setAttr(req, GROUPBY, groupby);
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/base/showChart.jsp")
	public String showChart(HttpServletRequest req, HttpServletResponse resp) {
		String type = param(req, "type", "柱状图");
		String charttype = param(req, "charttype", "GLOBAL_BAR");
		// 构建过滤条件
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
		// 默认分组
		String groupby = param(req, "groupby", "day(addtime)");
		History model = new History();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setAction(action);
		model.setUsername(username);

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, ACTION, action);
		setAttr(req, USERNAME, username);

		setAttr(req, TYPE, type);
		setAttr(req, CHART_TYPE, charttype);
		setAttr(req, GROUPBY, groupby);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/global/myChart.jsp")
	public String myChart(HttpServletRequest req, HttpServletResponse resp) {
		// 构建过滤条件
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");

		String groupby = param(req, "groupby", "day(addtime)");

		History model = new History();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setAction(action);
		model.setUsername(username);

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, ACTION, action);
		setAttr(req, USERNAME, username);

		setAttr(req, GROUPBY, groupby);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/global/home.jsp")
	public String home(HttpServletRequest req, HttpServletResponse resp) {
		// 登录情况
		Loginrecord loginrecord = new Loginrecord();
		HttpSession session = req.getSession();
		String[] sessionUser = ((String) session.getAttribute(LOGIN_USER_KEY))
				.split("&");
		String loginUserId = sessionUser[0];
		String loginUser = sessionUser[1];
		List<Loginrecord> lrs = (List<Loginrecord>) loginrecord.filterByPage(
				" where username='" + loginUser + "' order by logintime desc",
				DEFAULT_CURRENT_PAGE, DEFAULT_COUNT_PER_PAGE);
		loginrecord = lrs.size() > 1 ? lrs.get(1) : lrs.get(0);
		// 推送历史
		History history = new History();
		// 前台显示一页数据
		StringBuilder filter = new StringBuilder();
		filter.append(" where username='" + loginUser
				+ "' order by addtime desc");
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = 5;
		int currentPage = p;
		int totalCount = history.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 读取部分数据
		List<History> historyList = (List<History>) history.filterByPage(
				filter.toString(), p, pager.getCountPerPage());
		// 当前用户发布规则
		UserRule userrule = new UserRule();
		List<UserRule> list = (List<UserRule>) userrule.filter(" where userid="
				+ loginUserId);
		setAttr(req, MY_RULE, list.size() > 0 ? list.get(0).getPattern()
				: userrule.getPattern());
		// 总推送量
		int pushDataTotal = history.totalCount(filter.toString());
		setAttr(req, PUSH_DATA_TOTAL, pushDataTotal);

		setAttr(req, HISTORY_LIST, historyList);
		setAttr(req, LOGIN_RECORD_KEY, loginrecord);
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/global/advance.jsp")
	public String advance(HttpServletRequest req, HttpServletResponse resp) {
		// 推送历史
		History history = new History();
		// 前台显示一页数据
		StringBuilder filter = new StringBuilder();
		filter.append(" order by addtime desc");
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = 5;
		int currentPage = p;
		int totalCount = history.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 读取部分数据
		List<History> historyList = (List<History>) history.filterByPage(
				filter.toString(), p, pager.getCountPerPage());

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, HISTORY_LIST, historyList);
		return SUCCESS;
	}

}
