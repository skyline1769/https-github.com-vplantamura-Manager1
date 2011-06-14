package org.qingtian.autodata.util;

import java.util.Calendar;

/**
 * 日期操作工具类
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:22:58
 */
public class CalendarTool {
	private static final Calendar today = Calendar.getInstance();

	/**
	 * 今天是几号
	 * 
	 * @return
	 */
	public static int getCurrentDate() {
		return today.get(Calendar.DATE);
	}

	/**
	 * 今天是几月，范围0－11
	 * 
	 * @return
	 */
	public static int getCurrentMonth() {
		return today.get(Calendar.MONTH);
	}

	/**
	 * 今天是几几年
	 * 
	 * @return
	 */
	public static int getCurrentYear() {
		return today.get(Calendar.YEAR);
	}

	public static void main(String[] args) {
		System.out.println("今天日子是：" + CalendarTool.getCurrentDate());
		System.out.println("今天月份是：" + CalendarTool.getCurrentMonth());
		System.out.println("今天年份是：" + CalendarTool.getCurrentYear());
	}
}
