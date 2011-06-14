package org.qingtian.autodata.mvc.action;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.domain.Loginrecord;
import org.qingtian.autodata.mvc.domain.Rule;
import org.qingtian.autodata.mvc.domain.User;
import org.qingtian.autodata.mvc.domain.UserRule;

public class UserAction extends ActionAdapter {

	@Result(success = "/WEB-INF/pages/jump.jsp", fail = "/base/login.jsp")
	public String login(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = param(req, "username");
		String password = param(req, "password");
		String code = param(req, "code");
		String identifyCode = (String) req.getSession().getAttribute("code");
		User model = new User();
		model.setUsername(username);
		model.setPassword(password);
		setAttr(req, MODEL, model);
		if (StringUtils.isBlank(username)) {
			setAttr(req, TIP_NAME_KEY, "请输入用户名");
			return FAIL;
		}
		if (StringUtils.isBlank(password)) {
			setAttr(req, TIP_NAME_KEY, "请输入密码");
			return FAIL;
		}
		if (StringUtils.isBlank(code)) {
			setAttr(req, TIP_NAME_KEY, "请输入验证码");
			return FAIL;
		}
		if (!StringUtils.equals(code, identifyCode)) {
			setAttr(req, TIP_NAME_KEY, "验证码输入有误");
			return FAIL;
		}
		// 登录业务
		if (model.login()) {
			setAttr(req, TIP_NAME_KEY, "登录成功");
			HttpSession sessoin = req.getSession();
			setAttr(sessoin, LOGIN_USER_KEY,
					model.getId() + "&" + model.getUsername());
			// 上次登录时间
			model.setLastlogintime(new Timestamp(new Date().getTime()));
			model.save();
			// 添加一条登录记录
			Loginrecord lr = new Loginrecord();
			lr.setUsername(username);
			lr.setLogintime(new Timestamp(new Date().getTime()));
			lr.save();
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "用户名或者密码有误");
			return FAIL;
		}
	}

	@Result(success = "/base/login.jsp")
	public String logout(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		rmAttr(session, LOGIN_USER_KEY);
		setAttr(req, TIP_NAME_KEY, "成功注销");
		return SUCCESS;
	}

	@Result(success = "/base/login.jsp", fail = "/base/register.jsp")
	public String register(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = param(req, "username");
		String password = param(req, "password");
		String repassword = param(req, "repassword");
		String code = param(req, "code");
		String identifyCode = (String) req.getSession().getAttribute("code");
		User model = new User();
		model.setUsername(username);
		model.setPassword(password);
		model.setRegistertime(new Timestamp(new Date().getTime()));
		model.setLastlogintime(new Timestamp(new Date().getTime()));
		setAttr(req, MODEL, model);
		setAttr(req, REPASSWORD, repassword);
		if (StringUtils.isBlank(username)) {
			setAttr(req, TIP_NAME_KEY, "请输入用户名");
			return FAIL;
		}
		if (StringUtils.isBlank(password)) {
			setAttr(req, TIP_NAME_KEY, "请输入密码");
			return FAIL;
		}
		if (!StringUtils.equals(password, repassword)) {
			setAttr(req, TIP_NAME_KEY, "密码与确认密码不一致");
			setAttr(req, REPASSWORD, "");
			return FAIL;
		}
		if (StringUtils.isBlank(code)) {
			setAttr(req, TIP_NAME_KEY, "请输入验证码");
			return FAIL;
		}
		if (!StringUtils.equals(code, identifyCode)) {
			setAttr(req, TIP_NAME_KEY, "验证码输入有误");
			return FAIL;
		}
		if (model.isExist(username)) {
			setAttr(req, TIP_NAME_KEY, "您输入的用户名已被注册");
			model.setUsername("");
			model.setPassword("");
			setAttr(req, REPASSWORD, "");
			setAttr(req, MODEL, model);
			return FAIL;
		}
		// 注册业务
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "恭喜您注册成功，立即登录进行体验吧!");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "系统繁忙，请稍候...");
			return FAIL;
		}
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/user/show.jsp")
	@Override
	public String show(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		User model = new User();
		model.setId(id);
		model = model.get(id);
		setAttr(req, MODEL, model);
		// 用户规则
		StringBuilder filter = new StringBuilder();
		filter.append(" where userid=" + id + "");
		UserRule userrule = new UserRule();
		List<UserRule> list = (List<UserRule>) userrule.filter(filter
				.toString());
		UserRule newUserrule = list.size() > 0 ? list.get(0) : userrule;
		Rule rule=new Rule();
		boolean ruleExist=rule.isExist(newUserrule.getPattern());
		String pattern = list.size() > 0 ? list.get(0).getPattern()
				: NOT_CONFIG_USERRULE;
		setAttr(req, PATTERN, pattern);
		setAttr(req, NOT_CONFIG_USERRULE_KEY, NOT_CONFIG_USERRULE);
		setAttr(req, RULE_VERTIFY_VALUE, pattern.equals(NOT_CONFIG_USERRULE) ? true : ruleExist);
		
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/user/filter.jsp", fail = "/WEB-INF/pages/user/filter.jsp")
	public String resetPsw(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		User model = new User();
		model.setId(id);
		model = model.get(id);
		model.setPassword(INIT_PASSWORD);
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "用户[" + model.getUsername()
					+ "]密码已被重置为[" + INIT_PASSWORD + "]");
			this.filter(req, resp);
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "对不起，为用户[" + model.getUsername()
					+ "]重置密码失败，请稍候再试!");
			this.filter(req, resp);
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/user/modifyPsw.jsp")
	public String viewModifyPsw(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session=req.getSession();
		String []sessionUser=((String)session.getAttribute(LOGIN_USER_KEY)).split("&");
		String loginUser=sessionUser[1];
		String username = param(req, "username", loginUser);
		setAttr(req, USERNAME, username);
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/user/modifyPsw.jsp", fail = "/WEB-INF/pages/user/modifyPsw.jsp")
	public String modifyPsw(HttpServletRequest req, HttpServletResponse resp) {
		String username = param(req, "username");
		String prepassword = param(req, "prepassword");
		String newpassword = param(req, "newpassword");
		String repassword = param(req, "repassword");
		setAttr(req, USERNAME, username);
		setAttr(req, PREPASSWORD, prepassword);
		setAttr(req, NEWPASSWORD, newpassword);
		setAttr(req, REPASSWORD, repassword);
		if (StringUtils.isBlank(prepassword)) {
			setAttr(req, TIP_NAME_KEY, "请输入原密码");
			return FAIL;
		}
		if (StringUtils.isBlank(newpassword)) {
			setAttr(req, TIP_NAME_KEY, "请输入新密码");
			return FAIL;
		}
		if (!StringUtils.equals(newpassword, repassword)) {
			setAttr(req, TIP_NAME_KEY, "新密码与确认密码输入不一致");
			setAttr(req, NEWPASSWORD, "");
			setAttr(req, REPASSWORD, "");
			return FAIL;
		}
		User model = new User();
		// 验证用户原密码正确性
		if (!model.isRightPrepassword(username, prepassword)) {
			setAttr(req, TIP_NAME_KEY, "原密码输入错误");
			setAttr(req, PREPASSWORD, "");
			setAttr(req, NEWPASSWORD, "");
			setAttr(req, REPASSWORD, "");
			return FAIL;
		}
		// 更改密码
		if (model.updatePassword(username, newpassword)) {
			setAttr(req, TIP_NAME_KEY, "新密码更改成功");
			setAttr(req, PREPASSWORD, "");
			setAttr(req, NEWPASSWORD, "");
			setAttr(req, REPASSWORD, "");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "新密码更改失败");
			setAttr(req, PREPASSWORD, "");
			setAttr(req, NEWPASSWORD, "");
			setAttr(req, REPASSWORD, "");
			return FAIL;
		}

	}

	@Result(success = "/WEB-INF/pages/user/filter.jsp", fail = "/WEB-INF/pages/user/filter.jsp")
	@Override
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String username = param(req, "username", "");
		// 默认排序
		String by = param(req, "by", "username");
		String order = param(req, "order", "desc");
		User model = new User();
		model.setUsername(username);
		if (StringUtils.isNotBlank(username)) {
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
		@SuppressWarnings("unchecked")
		List<User> list = (List<User>) model.filterByPage(filter.toString(), p,
				pager.getCountPerPage());
		// 过滤管理员
		List<User> listFilter = new ArrayList<User>();
		String sessionUser = ((String) req.getSession().getAttribute(
				LOGIN_USER_KEY)).split("&")[1];
		for (User u : list) {
			if (!u.getUsername().equals("admin")) {
				listFilter.add(u);
			}
		}
		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		if (sessionUser.equals("admin")) {
			setAttr(req, DATA_LIST, list);
		} else {
			setAttr(req, DATA_LIST, listFilter);
		}
		// 查询值
		setAttr(req, USERNAME, username);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		// 批量删除传来的消息
		String tip = (String) getAttr(req, TIP_NAME_KEY);
		setAttr(req, TIP_NAME_KEY, tip);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/user/filter.jsp", fail = "/WEB-INF/pages/user/filter.jsp")
	public String batchDelete(HttpServletRequest req, HttpServletResponse resp) {
		String[] deleteId = params(req, "userIds");
		System.out.println("deleteId's length:" + deleteId.length);
		if (deleteId.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要删除的用户");
			this.filter(req, resp);
			return FAIL;
		}
		String[] filterDeleteId = new String[deleteId.length];
		String sessionUserId = ((String) req.getSession().getAttribute(
				LOGIN_USER_KEY)).split("&")[0];
		for (int i = 0; i < deleteId.length; i++) {
			if (!deleteId[i].equals(sessionUserId)) {
				filterDeleteId[i] = deleteId[i];
			}
		}
		// Hi~选择删除对象后才会到达此处
		// 业务
		User model = new User();
		int[] results = model.batchDelete(filterDeleteId);
		log.debug("batchDelete results[0]: " + results[0]);
		if (results.length > 0 && results[0] > 0) {
			setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个用户");
		}
		this.filter(req, resp);
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/user/viewSetRule.jsp", fail = "/WEB-INF/pages/user/filter.jsp")
	public String viewSetRule(HttpServletRequest req, HttpServletResponse resp) {
		String[] ids = StringUtils.isBlank((String) getAttr(req, USER_IDS)) ? params(
				req, "userIds")
				: (((String) getAttr(req, USER_IDS)).split(","));
		StringBuilder userIds = new StringBuilder();
		for (int i = 0; i < ids.length; i++) {
			System.out.println("id:" + ids[i]);
			if (i != ids.length - 1)
				userIds.append(ids[i] + ',');
			else
				userIds.append(ids[i]);
		}
		if (ids.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要设置规则的用户");
			this.filter(req, resp);
			return FAIL;
		}
		// 规则列表
		Rule rule = new Rule();
		List<Rule> ruleList = (List<Rule>) rule.listAll();
		// 根据id获取用户列表
		List<User> userList = new ArrayList<User>();
		for (String s : ids) {
			User user = new User();
			Integer id = Integer.valueOf(s);
			user = (User) user.get(id);
			userList.add(user);
		}
		setAttr(req, RULE_LIST, ruleList);
		setAttr(req, USER_LIST, userList);
		setAttr(req, USER_IDS, userIds.toString());
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/user/filter.jsp", fail = "/WEB-INF/pages/user/viewSetRule.jsp")
	public String setRule(HttpServletRequest req, HttpServletResponse resp) {
		String[] usernames = params(req, "usernames");
		StringBuilder usernameStr = new StringBuilder();
		for (int i = 0; i < usernames.length; i++) {
			if (i == usernames.length - 1)
				usernameStr.append(usernames[i]);
			else
				usernameStr.append(usernames[i] + ",");
		}
		String pattern = param(req, "pattern");
		// 操作不完整时返回到输入必须
		String ids = param(req, "userIds");
		setAttr(req, USER_IDS, ids);
		String[] userIds = ids.split(",");
		if (StringUtils.isBlank(pattern)) {
			setAttr(req, TIP_NAME_KEY, "请选择规则模式");
			this.viewSetRule(req, resp);
			return FAIL;
		}
		// 用户规则的保存
		int totalRequire = usernames.length;
		int realSave = 0;
		for (String u : userIds) {
			UserRule model = new UserRule();
			Integer userid = Integer.valueOf(u);
			// 存在即加载数据
			model.isExist(userid);
			model.setUserid(userid);
			model.setPattern(pattern);
			if (model.save() > 0)
				realSave += 1;
		}
		if (totalRequire == realSave) {
			setAttr(req, TIP_NAME_KEY, "为[" + usernameStr.toString() + "]设置规则["
					+ pattern + "]成功");
			this.filter(req, resp);
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "设置规则部分失败");
			this.viewSetRule(req, resp);
			return FAIL;
		}
	}
}
