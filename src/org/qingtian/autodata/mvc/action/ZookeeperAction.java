package org.qingtian.autodata.mvc.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.zookeeper.CreateMode;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooDefs.Ids;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.config.HistoryActionEnum;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.mvc.domain.Bak;
import org.qingtian.autodata.mvc.domain.Data;
import org.qingtian.autodata.mvc.domain.Group;
import org.qingtian.autodata.mvc.domain.History;
import org.qingtian.autodata.mvc.domain.UserRule;
import org.qingtian.autodata.util.PatternTool;

public class ZookeeperAction extends ActionAdapter {

	private static final Log log = LogFactory.getLog(ZookeeperAction.class);

	@Result(success = "/base/viewCluster.jsp", fail = "/base/viewCluster.jsp")
	public String viewCluster(HttpServletRequest req, HttpServletResponse resp) {
		try {
			ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
			List<String> serverClusterList = (List<String>) zk.getChildren(
					SERVER_CLUSTER_NODE, new AutoDataWatcher(zk));
			setAttr(req, SERVER_CLUSTER_LIST, serverClusterList);
			log.debug("WEB集群大小 ："
					+ (serverClusterList == null ? 0 : serverClusterList.size()));
		} catch (NullPointerException e) {
			e.printStackTrace();
			return FAIL;
		} catch (KeeperException e) {
			e.printStackTrace();
			return FAIL;
		} catch (InterruptedException e) {
			e.printStackTrace();
			return FAIL;
		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/data/viewAdd.jsp")
	@Override
	public String viewAdd(HttpServletRequest req, HttpServletResponse resp) {
		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();
		setAttr(req, GROUP_NAME_LIST, groupList);
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/data/viewAdd.jsp", fail = "/WEB-INF/pages/data/viewAdd.jsp")
	@Override
	public String add(HttpServletRequest req, HttpServletResponse resp) {
		String dataid = param(req, "dataid");
		String groupname = param(req, "groupname");
		String content = param(req, "content");
		String username = param(req, "username");
		Data model = new Data();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setUsername(username);
		setAttr(req, MODEL, model);
		HttpSession session = req.getSession();
		String loginUser = ((String) session.getAttribute(LOGIN_USER_KEY))
				.split("&")[1];
		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();
		setAttr(req, GROUP_NAME_LIST, groupList);

		if (StringUtils.isBlank(dataid)) {
			setAttr(req, TIP_NAME_KEY, "请输入配置的订阅键名");
			return FAIL;
		}
		if (StringUtils.isBlank(groupname)) {
			setAttr(req, TIP_NAME_KEY, "请选择分组名");
			return FAIL;
		}
		if (StringUtils.isBlank(content)) {
			setAttr(req, TIP_NAME_KEY, "请输入配置内容");
			return FAIL;
		}
		// 检查用户发布规则
		UserRule userrule = new UserRule();
		Integer userid = Integer.valueOf(((String) req.getSession()
				.getAttribute(LOGIN_USER_KEY)).split("&")[0]);
		boolean canPublish = userrule.isExist(userid);
		if (!canPublish) {
			setAttr(req, TIP_NAME_KEY,
					"亲爱的用户，您的账号还未被管理员指定发布规则或者您的发布键值超出了您的发布规则允许范围，请立即向管理员申请！");
			return FAIL;
		} else {
			// 模式检查
			String userPattern = userrule.getPattern();
			if (!PatternTool.match(userPattern, dataid)) {
				setAttr(req, TIP_NAME_KEY, "亲爱的用户，您暂时还不能发布[" + dataid
						+ "]配置的数据，您目前的发布规则为[" + userPattern
						+ "]，如需发布请向管理员提出更改发布规则的申请！");
				return FAIL;
			}
		}
		// 存在配置
		if (model.isExist(dataid, groupname)) {
			if (!loginUser.equals(model.getUsername())) {
				setAttr(req, TIP_NAME_KEY, "对不起，您无权修改他人发布的配置数据!");
				return FAIL;
			} else {
				if (content.equals(model.getContent())) {
					setAttr(req, TIP_NAME_KEY, "配置数据没有任何更改！");
					return FAIL;
				} else {
					model.setContent(content);
				}
			}
		}
		// 保存一条记录到历史
		History history = new History();
		history.setDataid(dataid);
		history.setGroupname(groupname);
		history.setContent(content);
		history.setUsername(username);
		// 创建或者修改zookeeper数据节点
		ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
		try {
			String groupNode = "/" + groupname;
			Stat groupExist = zk.exists(groupNode, new AutoDataWatcher(zk));
			if (groupExist == null) {
				setAttr(req, TIP_NAME_KEY, "发布失败，分组已被管理员删除！");
				return FAIL;
			} else {
				log.debug("已存在分组节点" + groupNode + ",不能创建...");
			}
			String dataNode = groupNode + "/" + dataid;
			Stat dataExist = zk.exists(dataNode, new AutoDataWatcher(zk));
			if (dataExist == null) {
				log.debug("创建数据节点:" + dataNode);
				history.setAction(HistoryActionEnum.PUBLISH.toString());
				zk.create(dataNode, content.getBytes(), Ids.OPEN_ACL_UNSAFE,
						CreateMode.PERSISTENT);
			} else {
				log.debug("已存在数据节点" + dataNode + ",开始修改数据内容...");
				history.setAction(HistoryActionEnum.MODIFY.toString());
				zk.setData(dataNode, content.getBytes(), -1);
			}
		} catch (KeeperException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// 添加配置，历史操作到库
		history.setAddtime(new Timestamp(new Date().getTime()));
		model.setAddtime(new Timestamp(new Date().getTime()));
		if (model.save() > 0 && history.save() > 0) {
			// 保存一条备用配置，用于切换回最初设置
			Bak bak = new Bak();
			bak.setDataid(Integer.valueOf(Long.valueOf(model.getId()).toString()));
			bak.setContent(content);
			bak.setAddtime(new Timestamp(new Date().getTime()));
			if (history.getAction() == HistoryActionEnum.PUBLISH.toString()){
				bak.setDescription("键"+dataid+"的最初配置");
				setAttr(req, TIP_NAME_KEY, "恭喜您，配置数据发布成功！");
			}
			else if (history.getAction() == HistoryActionEnum.MODIFY.toString()){
				bak.setDescription("键"+dataid+"的配置");
				setAttr(req, TIP_NAME_KEY, "恭喜您，配置数据修改成功！");
			}
			//执行保存备用配置－每次发布和修改配置都将生成一条备用配置
			bak.save();

			model.setDataid("");
			model.setGroupname(groupname);
			model.setContent("");

			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "对不起，服务暂时无法访问，请稍候重试！");
			return FAIL;
		}
	}

}
