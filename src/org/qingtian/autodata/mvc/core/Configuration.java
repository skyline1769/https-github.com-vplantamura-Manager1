package org.qingtian.autodata.mvc.core;

/**
 * 基础配置接口，定义一些基本键和常量值
 * 
 * @author qingtian
 * 
 *         2011-2-23 下午08:08:34
 */
public interface Configuration {
	
	String ZOOKEEPER_KEY="zookeeper";
	String SERVER_CLUSTER_KEY = "serverCluster";
	
	String SERVER_CLUSTER_NODE = "/serverCluster";
	String SERVER_CLUSTER_LIST="serverClusterList";
	String SERVER_CLUSTER_SIZE="serverClusterSize";
	String GOTO_PAGE = "gotoPage";
	
	String ERROR_404_PAGE_LOCATION="/error/404.jsp";
	String ERROR_500_PAGE_LOCATION="/error/500.jsp";
	String LOGIN_PAGE_LOCATION="/base/login.jsp";
	
	/** actionservlet拦截到访问路径不是以项目路径根开头的返回值  */
	String URI_IS_WRONG="URI_IS_WRONG";
	
	String INNER_PREFIX = "/WEB-INF/pages/";
	
	/** 页面响应中EL键  */
	String LOGIN_USER_KEY="loginUser";
	String TIP_NAME_KEY="tip";
	String MODEL="model";
	String DATA_LIST="dataList";
	
	int DEFAULT_CURRENT_PAGE=1;									/** 分页时默认当前页码 =1 */
	int DEFAULT_COUNT_PER_PAGE=10;								/** 分页时默认分页大小 =10 */
	int DEFAULT_MAX_PAGERSHOW_LENGTH=10;						/** 分页时左右分页区间大小 */
	String PAGER_KEY="pager";									/** 分页时分页键 */
	String MAX_PAGERSHOW_LENGTH_KEY="maxPagerShowLength";		/** 分页时左右分页区间键 */
	String CURRENT_PAGE_KEY="currentPage";						/** 分页时当前页键 */
	String CURRENT_COUNT_PER_PAGE_KEY="countPerPage";			/** 分页时当前分页大小键 */
	
	/** 首页页面响应EL键  */
	String REGISTER_USER_COUNT="registerUserCount";
	String REGISTER_USER_COUNT_OF_TODAY="registerUserCountOfToday";
	String HISTORY_LIST="historyList";
	String PUSH_DATA_TOTAL="pushDataTotal";
	String AVERAGE_PUSHDATA_PER_USER="averagePushDataPerUser";
	String TOP_PUSHDATA_BY_MODEL="topPushDataByModel";
	
	/** 注册页面 */
	String REPASSWORD="repassword";
	
	/** 更改密码 */
	String USERNAME="username";
	String PREPASSWORD="prepassword";
	String NEWPASSWORD="newpassword";
	
	/** 登录记录 */
	String TYPE="type";
	
	/** BUG与意见 */
	String TITLE="title";
	String CONTENT="content";
	String REPORTUSER="reportuser";
	String BY="by";
	String ORDER="order";
	
	/** 分组 */
	String GROUPNAME="groupname";
	
	/** 配置 */
	String GROUP_NAME_LIST="groupList";
	
	/** 规则 */
	String PATTERN="pattern";
	String NOT_CONFIG_USERRULE_KEY="notConfigUserrule";
	String NOT_CONFIG_USERRULE="尚未设置";
	String RULE_VERTIFY_VALUE="ruleVertifyValue";
	
	/** 用户  */
	String USER_IDS="userIds";
	String RULE_LIST="ruleList";
	String USER_LIST="userList";
	String INIT_PASSWORD="123456";
	
	/** 配置数据 */
	String DATAID="dataid";
	String LOCATION="location";
	String DATA="data";
	
	/** 历史 */
	String ACTION="action";
	
	/** 图表 */
	String CHART_TYPE="charttype";
	String GROUPBY="groupby";
	
	/** 我的主页 */
	String LOGIN_RECORD_KEY="loginrecord";
	String MY_RULE="myRule";
}
