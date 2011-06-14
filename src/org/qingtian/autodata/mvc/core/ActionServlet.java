package org.qingtian.autodata.mvc.core;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooDefs.Ids;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.util.PropertiesTool;

/**
 * 中心控制器
 * 
 * @author qingtian
 * 
 *         2011-2-23 下午09:18:30
 */
@SuppressWarnings("serial")
public class ActionServlet extends AbstractService implements Configuration {

	private static final Log log = LogFactory.getLog(ActionServlet.class);

	/** Action类所在包 */
	private List<String> action_packages = null;
	/** action及method缓存 */
	private final static HashMap<String, Object> actions = new HashMap<String, Object>();
	private final static HashMap<String, Object> methods = new HashMap<String, Object>();

	private static ZooKeeper zk = null;

	/**
	 * 初始化，设置Action类所在包及加载启动便可用的Action类
	 * 
	 * (non-Javadoc)
	 * 
	 * @throws InterruptedException
	 * @throws KeeperException
	 * 
	 * @see org.qingtian.cash.core.AbstractService#init()
	 */
	@Override
	public void init() throws ServletException {
		super.init();
		String packages = this.getInitParameter("packages");
		log.info("Param -> packages：" + packages);
		action_packages = Arrays.asList(StringUtils.split(packages, ','));
		String initial_actions = this.getInitParameter("initial_actions");
		log.info("Param -> initial_actions：" + initial_actions);
		if (initial_actions != null) {
			// 应用启动即需初始化action
			for (String action : StringUtils.split(initial_actions, ',')) {
				try {
					log.info("Direct init action -> " + action);
					loadAction(action);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		try {
			this.initZookeeper();
		} catch (KeeperException e) {
			e.printStackTrace();
			System.exit(-1);
		} catch (InterruptedException e) {
			e.printStackTrace();
			System.exit(-1);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(-1);
		}
	}

	/**
	 * 销毁Servlet，清理缓存
	 * 
	 * (non-Javadoc)
	 * 
	 * @see org.qingtian.cash.core.AbstractService#destroy()
	 */
	@Override
	public void destroy() {
		super.destroy();
		for (Object action : actions.values()) {
			try {
				Method dm = action.getClass().getMethod("destroy");
				if (dm != null) {
					dm.invoke(action);
					log.info(getClass().getName() + " destroy(): "
							+ action.getClass().getSimpleName());
				}
			} catch (NoSuchMethodException e) {
				log.warn(e.getCause());
			} catch (Exception e) {
				log.warn(e.getCause());
			}
		}
		try {
			this.destoryZookeeper();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void initZookeeper() throws KeeperException, InterruptedException,
			IOException {
		log.debug("initZookeeper()");
		Properties zookeeper = PropertiesTool
				.loadProperties("zookeeper.properties");
		String ip = (String) zookeeper.get("zookeeper.ip");
		Integer port = new Integer((String) zookeeper.get("zookeeper.port"));
		Integer timeout = new Integer(
				(String) zookeeper.get("zookeeper.timeout"));
		log.info("Zookeeper Properties -> zookeeper.ip: " + ip
				+ ", zookeeper.port: " + port + ", zookeeper.timeout: "
				+ timeout);
		zk = new ZooKeeper(ip + ":" + port, timeout, new AutoDataWatcher(zk));
		// 创建自身服务节点到Zookeeper服务中
		this.createServerNodeForZookeeper();
		this.getServletContext().setAttribute(ZOOKEEPER_KEY, zk);
	}

	public void destoryZookeeper() throws InterruptedException {
		log.debug("destoryZookeeper()");
		zk.close();
	}

	/**
	 * <b>中心控制器(控制请求与响应的流程)</b><br />
	 * 控制器得到控制权后便交由业务逻辑类处理，最后取回控制权完成页面响应
	 * 
	 * (non-Javadoc)
	 * 
	 * @see org.qingtian.cash.core.AbstractService#process(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, boolean)
	 */
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp,
			boolean isPost) throws ServletException, IOException {
		try {
			if (_process(req, resp, isPost)) {
				String defaultGotoPage = super.getWebroot(req)
						+ Configuration.ERROR_404_PAGE_LOCATION;
				this.beforeResponeProcess(req, resp, defaultGotoPage);
			} else {
				String defaultGotoPage = super.getWebroot(req)
						+ Configuration.ERROR_500_PAGE_LOCATION;
				this.beforeResponeProcess(req, resp, defaultGotoPage);
			}
		} catch (InstantiationException e) {
			e.printStackTrace();
			log.warn(e.getCause());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
			log.warn(e.getCause());
		}
	}

	/**
	 * <b>Action类完成业务逻辑处理</b><br />
	 * 第一步：获取请求URI，原始URI格式为: /应用名/action/业务逻辑Action类名/方法名<br />
	 * 第二步：转换URI格式为:/action/业务逻辑Action类名/方法名<br />
	 * 第三步：URI有效性校正，格式截取，分别得到Action类名，方法名<br />
	 * 第四步：通过反射加载Action实例<br />
	 * 第五步：通过反射调用 业务逻辑类的方法，并且方法参数必须带HttpServletRequest req, HttpServletResponse
	 * resp<br />
	 * <br />
	 * <b>期间未捕获到任何异常便表示业务逻辑处理成功完成，反之则失败</b>
	 * 
	 * @see org.qingtian.cash.core.AbstractService#_process(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, boolean)
	 */
	protected boolean _process(HttpServletRequest req,
			HttpServletResponse resp, boolean isPost) throws ServletException,
			IOException, InstantiationException, IllegalAccessException {
		String uri = getCorrentedUri(req);
		if (Configuration.URI_IS_WRONG.equals(uri)) {
			log.error("Application URI need start with ["
					+ super.getWebroot(req) + "] ");
			return false;
		}
		// URI: /action/Test/t1 --> /action + /Xxxxx(业务逻辑类名[无论大小写最后都转为小写]) +
		// /xxxxx(方法名)
		String[] parts = StringUtils.split(uri, '/');
		if (parts.length < 2) {
			log.error("After Application URI was splited by '/' must be 2 params or more");
			return false;
		}
		// 加载action类 parts[1]=业务逻辑类名(大小写无妨)
		Object action = this.loadAction(parts[1]);
		if (action == null) {
			log.error(StringUtils.capitalize(parts[1]) + "Action is not found");
			return false;
		}
		// parts[2]=业务方法名
		String action_method_name = (parts.length > 2) ? parts[2] : "index";
		log.debug("Invoke method : " + action_method_name);
		Method m_action = this.getActionMethod(action, action_method_name);
		if (m_action == null) {
			log.error("[Class : " + parts[1] + ", Method: "
					+ action_method_name
					+ "] is null, go to write it hurriedly");
			return false;
		}
		// 调用业务方法处理
		try {
			String returnValue = (String) m_action.invoke(action, req, resp);
			// 通过注解获取响应页面
			if (m_action.isAnnotationPresent(Result.class)) {
				Annotation annotation = m_action.getAnnotation(Result.class);
				Result result = (Result) annotation;
				// 根据返回值进行视图转发
				if (StringUtils.equals("success", returnValue)
						&& StringUtils.isNotBlank(result.success())) {
					req.setAttribute(Configuration.GOTO_PAGE, result.success());
				} else if (StringUtils.equals("fail", returnValue)
						&& StringUtils.isNotBlank(result.fail())) {
					req.setAttribute(Configuration.GOTO_PAGE, result.fail());
				}
			} else {
				log.error("未对Action方法作任何响应结果页面的位置声明");
				return true;// 未定义Result而已不代表业务逻辑处理不成功
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			log.warn(e.getCause());
			return false;
		} catch (InvocationTargetException e) {
			e.printStackTrace();
			log.warn(e.getCause());
			return false;
		}
		return true;
	}

	/**
	 * <b>获取除根路径外的URI串</b>(如：前(/qtCash/action/Test/t1) ----> 后(/action/Test/t1))<br />
	 * 如果原始URI不是以"/项目跟路径访问" 访问，则会直接返回 Configuration.URI_IS_WRONG<br />
	 * 
	 * @see org.qingtian.autodata.mvc.core.Configuration#URI_IS_WRONG
	 * @param req
	 * @return
	 */
	private String getCorrentedUri(HttpServletRequest req) {
		String uri = req.getRequestURI();
		if (uri.indexOf(super.getWebroot(req)) < 0) {
			return Configuration.URI_IS_WRONG;
		}
		int index1 = uri.indexOf("/", 2);
		if (index1 > 0) {
			uri = uri.substring(index1);
		}
		return uri;
	}

	/**
	 * 根据action_name来加载action，action_name规则为去Action后缀<br />
	 * action位置为：初始包名+"."+名字(首字母大写其他小写)+Action
	 * 
	 * @param action_name
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private Object loadAction(String action_name)
			throws InstantiationException, IllegalAccessException {
		Object action = actions.get(action_name);
		if (action == null) {
			for (String pkg : action_packages) {
				String cls = pkg + "." + StringUtils.capitalize(action_name)
						+ "Action";
				action = loadActionByFullName(action_name, cls);
				if (action != null) {
					log.info("First visit, init Action: " + action_name);
					break;
				}
			}
		} else {
			log.info("Direct hit : " + action_name + "Action");
		}
		return action;
	}

	/**
	 * 通过反射实例化Action对象，并调用init()
	 * 
	 * @param action_name
	 * @param cls
	 * @return
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	private Object loadActionByFullName(String action_name, String cls)
			throws IllegalAccessException, InstantiationException {
		Object action = null;
		try {
			action = Class.forName(cls).newInstance();
			// Action类初始化init 方法调用
			try {
				Method action_init_method = action.getClass().getMethod("init",
						ServletContext.class);
				action_init_method.invoke(action, getServletContext());
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
				log.warn(e.getCause());
			} catch (InvocationTargetException exc) {
				exc.printStackTrace();
				log.warn(exc.getCause());
			}
			if (!actions.containsKey(action_name)) {
				synchronized (actions) {
					actions.put(action_name, action);
				}
			}
		} catch (ClassNotFoundException excp) {
			excp.printStackTrace();
			log.warn(excp.getCause());
		}
		return action;
	}

	/**
	 * 获取名为method的方法
	 * 
	 * @param action
	 * @param method
	 * @return
	 */
	private Method getActionMethod(Object action, String method) {
		String key = action.getClass().getSimpleName() + "." + method;
		Method m = (Method) methods.get(key);
		if (m != null)
			return m;
		for (Method m1 : action.getClass().getMethods()) {
			if (m1.getModifiers() == Modifier.PUBLIC
					&& m1.getName().equals(method)) {
				synchronized (methods) {
					methods.put(key, m1);
				}
				return m1;
			}
		}
		return null;
	}

	/**
	 * 响应前：解析视图位置并选择响应方式（重定向/转发）
	 * 
	 * @param req
	 * @param resp
	 * @param defaultGotoPage
	 * @throws ServletException
	 * @throws IOException
	 */
	private void beforeResponeProcess(HttpServletRequest req,
			HttpServletResponse resp, String defaultGotoPage)
			throws ServletException, IOException {
		String gotoPage = ((String) req.getAttribute(GOTO_PAGE)) == null ? defaultGotoPage
				: (String) req.getAttribute(GOTO_PAGE);
		boolean isRedirect = ((String) req.getAttribute(GOTO_PAGE)) == null ? true
				: false;
		log.info(" process ok! target viewer: [" + gotoPage
				+ "] error redirect? (" + isRedirect + ")");
		if (isRedirect) {
			super.redirect(req, resp, gotoPage);
		} else
			super.forward(req, resp, gotoPage);
	}

	private void createServerNodeForZookeeper() throws KeeperException,
			InterruptedException {
		log.debug("createServerNodeForZookeeper()");
		/*
		 * Properties localserver = PropertiesTool
		 * .loadProperties("localserver.properties"); String ip = (String)
		 * localserver.get("localserver.ip"); Integer port = new
		 * Integer((String) localserver.get("localserver.port"));
		 */
		String ip = (String) this.getServletContext().getInitParameter(
				"localserver.ip");
		Integer port = Integer.valueOf((String) this.getServletContext()
				.getInitParameter("localserver.port"));
		log.info("Localserver context param -> localserver.ip: " + ip
				+ ", localserver.port: " + port);
		// 检测父节点
		Stat isRootExist = zk.exists(SERVER_CLUSTER_NODE, new AutoDataWatcher(
				zk));
		if (isRootExist == null) {
			log.debug("创建服务器集群中的可用服务父节点:" + SERVER_CLUSTER_NODE);
			zk.create(SERVER_CLUSTER_NODE, new byte[] {}, Ids.OPEN_ACL_UNSAFE,
					CreateMode.PERSISTENT);
		} else {
			log.debug("已存在父节点" + SERVER_CLUSTER_NODE + ",不能创建...");
		}
		// 开始创建自身节点
		String selfNode = SERVER_CLUSTER_NODE + ("/" + ip + ":" + port);
		byte[] selfData = (ip + ":" + port).getBytes();
		Stat selfExist = zk.exists(selfNode, new AutoDataWatcher(zk));
		if (selfExist == null) {
			log.debug("创建服务节点" + selfNode);
			zk.create(selfNode, selfData, Ids.OPEN_ACL_UNSAFE,
					CreateMode.EPHEMERAL);
		} else {
			log.debug("已存在" + selfNode + "服务节点,无法创建...");
		}

	}

}
