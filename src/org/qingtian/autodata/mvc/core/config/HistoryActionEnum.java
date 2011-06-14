package org.qingtian.autodata.mvc.core.config;

/**
 * 配置操作动作枚举，包括发布、修改、删除、切换四种
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:41:31
 */
public enum HistoryActionEnum {
	PUBLISH("发布"), MODIFY("修改"), DELETE("删除"), SWITCH("切换");

	private final String action;

	HistoryActionEnum(String action) {
		this.action = action;
	}

	public String toString() {
		return action;
	}
}
