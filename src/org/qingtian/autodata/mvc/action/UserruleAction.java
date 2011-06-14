package org.qingtian.autodata.mvc.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.domain.UserRule;

public class UserruleAction extends ActionAdapter {

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/rule/myRule.jsp")
	public String myRule(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		HttpSession session=req.getSession();
		String []sessionUser=((String)session.getAttribute(LOGIN_USER_KEY)).split("&");
		String loginUserId=sessionUser[0];
		String userid = param(req, "userid",loginUserId);
		if (StringUtils.isNotBlank(userid)) {
			filter.append(" where userid=" + userid + "");
		}
		UserRule model = new UserRule();
		List<UserRule> list = (List<UserRule>) model.filter(filter.toString());
		setAttr(req, MODEL, list.size() > 0 ? list.get(0) : model);
		return SUCCESS;
	}
	
}
