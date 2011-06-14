package org.qingtian.autodata.mvc.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.qingtian.autodata.mvc.core.AbstractService;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.util.ChartTool;

/**
 * 图表生成处理器，提供通过参数配置图表数据并展示三类图表的功能
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:37:12
 */
@SuppressWarnings("serial")
public class ChartServlet extends AbstractService implements Configuration {

	private static final Log log = LogFactory.getLog(ChartServlet.class);

	private static final String ENCODING = "UTF-8";

	private static final int DEFAULT_WIDTH = 777;
	private static final int DEFAULT_HEIGHT = 390;

	private int initWidth = DEFAULT_WIDTH;
	private int initHeight = DEFAULT_HEIGHT;

	@Override
	public void init() throws ServletException {
		super.init();
		try {
			initWidth = Integer.parseInt(getInitParameter("width"));
		} catch (NumberFormatException e) {

		}
		try {
			initHeight = Integer.parseInt(getInitParameter("height"));
		} catch (NumberFormatException e) {

		}
		log.info("Init ChartServlet, Params -> initWidth : " + initWidth
				+ ",initHeight : " + initHeight);
	}

	@Override
	public void destroy() {
		super.destroy();
		log.debug("destroy ChartServlet");
	}

	/**
	 * 图表数据输出到响应
	 * 
	 * (non-Javadoc)
	 * 
	 * @see org.qingtian.autodata.mvc.core.AbstractService#process(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, boolean)
	 */
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp,
			boolean isPost) throws ServletException, IOException {
		String type = param(req, "charttype");
		int width = param(req, "width", initWidth);
		int height = param(req, "height", initHeight);
		ChartType chartType = ChartType.valueOf(type);
		JFreeChart chart = null;
		if (chartType == ChartType.GLOBAL_BAR) {
			chart = ChartTool.getGlobalBarChart(req);
		} else if (chartType == ChartType.GLOBAL_LINE) {
			chart = ChartTool.getGlobalLineChart(req);
		} else if (chartType == ChartType.GLOBAL_PIE) {
			chart = ChartTool.getGlobalPieChart(req);
		}
		// 设置图表属性
		chart.setBackgroundImageAlpha(0.0f);
		try {
			ChartUtilities.writeChartAsJPEG(resp.getOutputStream(), chart,
					width, height, null);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected boolean _process(HttpServletRequest req,
			HttpServletResponse resp, boolean isPost) throws ServletException,
			IOException, InstantiationException, IllegalAccessException {
		return true;
	}

	/**
	 * 图表展示类型，有柱状图、折线图、饼图三类
	 * 
	 * @author qingtian
	 * 
	 *         2011-5-8 下午07:29:54
	 */
	private enum ChartType {
		GLOBAL_BAR("gb"), GLOBAL_LINE("gl"), GLOBAL_PIE("gp");

		private final String type;

		ChartType(String type) {
			this.type = type;
		}

		@Override
		public String toString() {
			return type;
		}

	}

	/**
	 * 获取指定名称的参数值,没有则为""
	 * 
	 * @param req
	 * @param name
	 * @return
	 */
	private String param(HttpServletRequest req, String name) {
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

	private int param(HttpServletRequest req, String name, int defaultValue) {
		String value = param(req, name);
		return StringUtils.isNumeric(value) && value != null
				&& !"".equals(value) ? Integer.parseInt(value) : defaultValue;
	}
}
