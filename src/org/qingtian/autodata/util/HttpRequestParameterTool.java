package org.qingtian.autodata.util;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

/**
 * 请求获取UTF-8编码参数值的工具类
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:19:47
 */
public class HttpRequestParameterTool {
	
	protected static final String ENCODING = "UTF-8";

	/**
	 * 源串使用UTF-8编码
	 * 
	 * @param source
	 * @return
	 */
	protected static String encode(String source) {
		String destination = null;
		try {
			destination = new String(source.getBytes("iso-8859-1"), ENCODING);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			;// ignore
		}
		return destination;
	}

	/**
	 * 获取指定名称的参数值,没有则为""
	 * 
	 * @param req
	 * @param name
	 * @return
	 */
	protected static String param(HttpServletRequest req, String name) {
		String v = (String) req.getParameter(name);
		String value = v != null ? v.trim() : "";
		try {
			value = new String(value.getBytes("iso-8859-1"), ENCODING);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			;// ignore
		}
		return value;
	}

	/**
	 * 获取请求中指定名称参数值，不存在参数则设置默认值
	 * 
	 * @param req
	 * @param name
	 * @param defaultValue
	 * @return
	 */
	protected static String param(HttpServletRequest req, String name,
			String defaultValue) {
		String v = (String) req.getParameter(name);
		String value = v != null ? v.trim() : defaultValue;
		try {
			value = new String(value.getBytes("iso-8859-1"), ENCODING);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			;// ignore
		}
		return value;
	}

	protected static String[] params(HttpServletRequest req, String name) {
		String[] v = req.getParameterValues(name);
		return v == null ? new String[] {} : v;
	}

	protected static double param(HttpServletRequest req, String name,
			double defaultValue) {
		String value = param(req, name);
		double t = defaultValue;
		try {
			t = Double.parseDouble(value);
		} catch (NumberFormatException e) {
			;// ignore
		}
		return t;
	}

	protected static int param(HttpServletRequest req, String name, int defaultValue) {
		String value = param(req, name);
		return StringUtils.isNumeric(value) && value != null
				&& !"".equals(value) ? Integer.parseInt(value) : defaultValue;
	}
}
