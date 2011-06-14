package org.qingtian.autodata.mvc.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.mvc.core.Configuration;

/**
 * 用户授权过滤器
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:36:39
 */
public class AuthorityFilter implements Filter {

	private static final Log log = LogFactory.getLog(AuthorityFilter.class);

	/** 不验证状态的Action名称 */
	private List<String> exclude = new ArrayList<String>();

	@Override
	public void init(FilterConfig config) throws ServletException {
		exclude = Arrays.asList(StringUtils.split(
				config.getInitParameter("exclude"), ','));
		log.info(" init, exclude uri : " + exclude);
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpreq = (HttpServletRequest) req;
		String loginUserSeri = (String) (httpreq.getSession())
				.getAttribute(Configuration.LOGIN_USER_KEY);
		String uri = getUri(httpreq);
		if (Configuration.URI_IS_WRONG.equals(uri)) {
			log.error("Application URI need start with ["
					+ httpreq.getContextPath() + "] ");
			return;
		}
		boolean isInclude = false;
		for (String action : exclude) {
			if (action.equals(uri)) {
				isInclude = true;
				break;
			}
		}
		// 存在用户会话或者属于放行的URI
		if (loginUserSeri != null || isInclude) {
			log.debug("green light: " + uri);
			chain.doFilter(req, resp);
		} else {
			RequestDispatcher dispatcher = httpreq
					.getRequestDispatcher(Configuration.LOGIN_PAGE_LOCATION);
			httpreq.setAttribute(Configuration.TIP_NAME_KEY, "原会话已过期,请重新登录");
			log.debug(" never login ,intercepted ：" + uri);
			dispatcher.forward(req, resp);
			return;
		}
	}

	@Override
	public void destroy() {
		log.debug("destroy...");
	}

	private String getUri(HttpServletRequest req) {
		String uri = req.getRequestURI();
		if (uri.indexOf(req.getContextPath()) < 0) {
			return Configuration.URI_IS_WRONG;
		}
		int index1 = uri.indexOf("/", 2);
		if (index1 > 0) {
			uri = uri.substring(index1);
		}
		return uri;
	}
}
