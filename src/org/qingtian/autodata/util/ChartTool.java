package org.qingtian.autodata.util;

import java.awt.Font;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.qingtian.autodata.mvc.domain.History;
import org.qingtian.autodata.mvc.domain.useful.AdvanceHistory;

/**
 * 图表工具类。提供生成柱状图、折线图、饼图的工具方法
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:20:33
 */
public class ChartTool extends HttpRequestParameterTool {
	private static final StandardChartTheme standardChartTheme = new StandardChartTheme(
			"CN");

	static {
		// 设置标题字体
		standardChartTheme.setExtraLargeFont(new Font("微软雅黑", Font.PLAIN, 14));
		// 设置图例的字体
		standardChartTheme.setRegularFont(new Font("微软雅黑", Font.PLAIN, 12));
		// 设置轴向的字体
		standardChartTheme.setLargeFont(new Font("微软雅黑", Font.PLAIN, 12));

		// 应用主题样式
		ChartFactory.setChartTheme(standardChartTheme);
	}

	public static JFreeChart getGlobalBarChart(HttpServletRequest req) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		// 构建过滤条件
		StringBuilder where = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			where.append(" where ");
			where.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			where.append(" and ");
			where.append(" groupname = '" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			where.append(" where ");
			where.append(" groupname = '" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			where.append(" and ");
			where.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			where.append(" where ");
			where.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(action)) {
			where.append(" and ");
			where.append(" action = '" + action + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(action)) {
			where.append(" where ");
			where.append(" action = '" + action + "'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname)
				|| StringUtils.isNotBlank(content) || StringUtils
				.isNotBlank(action)) && StringUtils.isNotBlank(username)) {
			where.append(" and ");
			where.append(" username like '%" + username + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content) && StringUtils.isBlank(action)
				&& StringUtils.isNotBlank(username)) {
			where.append(" where ");
			where.append(" username like '%" + username + "%'");
		}

		String groupby = param(req, "groupby", " day(addtime) ");
		History model = new History();
		List<AdvanceHistory> dataList = (List<AdvanceHistory>) model
				.getAdvance(where.toString(), groupby);
		for (AdvanceHistory ah : dataList) {
			dataset.addValue(ah.getCount(), "推送量", getChartXValue(ah,groupby));
		}
		JFreeChart chart = ChartFactory.createBarChart("日推送趋势柱状图", getChartXLabel(groupby), "推送量",
				dataset, PlotOrientation.VERTICAL, true, true, true);
		return chart;
	}

	public static JFreeChart getGlobalLineChart(HttpServletRequest req) {
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		// 构建过滤条件
		StringBuilder where = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			where.append(" where ");
			where.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			where.append(" and ");
			where.append(" groupname = '" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			where.append(" where ");
			where.append(" groupname = '" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			where.append(" and ");
			where.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			where.append(" where ");
			where.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(action)) {
			where.append(" and ");
			where.append(" action = '" + action + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(action)) {
			where.append(" where ");
			where.append(" action = '" + action + "'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname)
				|| StringUtils.isNotBlank(content) || StringUtils
				.isNotBlank(action)) && StringUtils.isNotBlank(username)) {
			where.append(" and ");
			where.append(" username like '%" + username + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content) && StringUtils.isBlank(action)
				&& StringUtils.isNotBlank(username)) {
			where.append(" where ");
			where.append(" username like '%" + username + "%'");
		}

		String groupby = param(req, "groupby", " day(addtime) ");
		History model = new History();
		List<AdvanceHistory> dataList = (List<AdvanceHistory>) model
				.getAdvance(where.toString(), groupby);
		for (AdvanceHistory ah : dataList) {
			dataset.addValue(ah.getCount(), "推送量", getChartXValue(ah,groupby));
		}
		JFreeChart chart = ChartFactory.createLineChart("日推送趋势折线图", getChartXLabel(groupby), "推送量",
				dataset, PlotOrientation.VERTICAL, true, true, true);
		return chart;
	}

	public static JFreeChart getGlobalPieChart(HttpServletRequest req) {
		DefaultPieDataset dataset = new DefaultPieDataset();
		// 构建过滤条件
		StringBuilder where = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String action = param(req, "action", "");
		String username = param(req, "username", "");
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			where.append(" where ");
			where.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			where.append(" and ");
			where.append(" groupname = '" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			where.append(" where ");
			where.append(" groupname = '" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			where.append(" and ");
			where.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			where.append(" where ");
			where.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(action)) {
			where.append(" and ");
			where.append(" action = '" + action + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(action)) {
			where.append(" where ");
			where.append(" action = '" + action + "'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname)
				|| StringUtils.isNotBlank(content) || StringUtils
				.isNotBlank(action)) && StringUtils.isNotBlank(username)) {
			where.append(" and ");
			where.append(" username like '%" + username + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content) && StringUtils.isBlank(action)
				&& StringUtils.isNotBlank(username)) {
			where.append(" where ");
			where.append(" username like '%" + username + "%'");
		}

		String groupby = param(req, "groupby", " day(addtime) ");
		History model = new History();
		List<AdvanceHistory> dataList = (List<AdvanceHistory>) model
				.getAdvance(where.toString(), groupby);
		for (AdvanceHistory ah : dataList) {
			dataset.setValue(getChartXValue(ah,groupby)+"("+ah.getCount()+"条)", ah.getCount());
		}
		JFreeChart chart = ChartFactory.createPieChart("日推送饼图", dataset, true,
				false, false);
		return chart;
	}

	/**
	 * 通过分组规则来决定图表的X值标签
	 * 
	 * @param groupby
	 * @return
	 */
	private static String getChartXLabel(String groupby){
		String chartXLabel=DAY_VALUE;
		if(groupby.equals(DAY_KEY)){
			chartXLabel=DAY_VALUE;
		}
		else if(groupby.equals(MONTH_KEY)){
			chartXLabel=MONTH_VALUE;
		}
		else if(groupby.equals(YEAR_KEY)){
			chartXLabel=YEAR_VALUE;
		}
		else if(groupby.equals(DATAID_KEY)){
			chartXLabel=DATAID_VALUE;
		}
		else if(groupby.equals(GROUPNAME_KEY)){
			chartXLabel=GROUPNAME_VALUE;
		}
		else if(groupby.equals(CONTENT_KEY)){
			chartXLabel=CONTENT_VALUE;
		}
		else if(groupby.equals(ACTION_KEY)){
			chartXLabel=ACTION_VALUE;
		}
		else if(groupby.equals(USERNAME_KEY)){
			chartXLabel=USERNAME_VALUE;
		}
		return chartXLabel;
	}

	private static String getChartXValue(AdvanceHistory ah,String groupby){
		String chartXValue=ah.getMonth()+"月"+ah.getDay()+"日";
		if(groupby.equals(DAY_KEY)){
			chartXValue=ah.getMonth()+"月"+ah.getDay()+"日";
		}
		else if(groupby.equals(MONTH_KEY)){
			chartXValue=ah.getMonth()+"月";
		}
		else if(groupby.equals(YEAR_KEY)){
			chartXValue=ah.getYear()+"年";
		}
		else if(groupby.equals(DATAID_KEY)){
			chartXValue=ah.getHistory().getDataid();
		}
		else if(groupby.equals(GROUPNAME_KEY)){
			chartXValue=ah.getHistory().getGroupname();
		}
		else if(groupby.equals(CONTENT_KEY)){
			chartXValue=ah.getHistory().getContent();
		}
		else if(groupby.equals(ACTION_KEY)){
			chartXValue=ah.getHistory().getAction();
		}
		else if(groupby.equals(USERNAME_KEY)){
			chartXValue=ah.getHistory().getUsername();
		}
		return chartXValue;
	}
	// sql groupby 分组键值
	private static final String DAY_KEY = "day(addtime)";
	private static final String MONTH_KEY = "month(addtime)";
	private static final String YEAR_KEY = "year(addtime)";
	private static final String DATAID_KEY = "dataid";
	private static final String GROUPNAME_KEY = "groupname";
	private static final String CONTENT_KEY = "content";
	private static final String ACTION_KEY = "action";
	private static final String USERNAME_KEY = "username";

	private static final String DAY_VALUE = "天";
	private static final String MONTH_VALUE = "月";
	private static final String YEAR_VALUE = "年";
	private static final String DATAID_VALUE= "订阅键";
	private static final String GROUPNAME_VALUE = "分组";
	private static final String CONTENT_VALUE = "内容";
	private static final String ACTION_VALUE = "动作";
	private static final String USERNAME_VALUE = "用户";
}
