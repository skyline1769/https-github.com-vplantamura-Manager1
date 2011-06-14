package org.qingtian.autodata.mvc.action;

import java.util.ArrayList;
import java.util.List;

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
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.mvc.domain.Group;

public class GroupAction extends ActionAdapter {

	private static final Log log = LogFactory.getLog(GroupAction.class);

	@Result(success = "/WEB-INF/pages/group/viewAdd.jsp")
	@Override
	public String viewAdd(HttpServletRequest req, HttpServletResponse resp) {
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/group/viewAdd.jsp", fail = "/WEB-INF/pages/group/viewAdd.jsp")
	@Override
	public String add(HttpServletRequest req, HttpServletResponse resp) {
		String groupname = param(req, "groupname");
		groupname = groupname.toUpperCase();
		Group model = new Group();
		model.setGroupname(groupname);
		setAttr(req, MODEL, model);
		if (StringUtils.isBlank(groupname)) {
			setAttr(req, TIP_NAME_KEY, "请输入分组名");
			return FAIL;
		}
		// 屏蔽原始节点名[zookeeper][serverCluster]
		if (StringUtils.equals(groupname, ZOOKEEPER_KEY.toUpperCase())
				|| StringUtils.equals(groupname,
						SERVER_CLUSTER_KEY.toUpperCase())) {
			setAttr(req, TIP_NAME_KEY, "对不起，不能创建内置分组名");
			model.setGroupname("");
			return FAIL;
		}
		// 业务
		if (model.isExist(groupname)) {
			setAttr(req, TIP_NAME_KEY, "对不起，分组名[" + groupname
					+ "]已被使用,请换个分组名后重试!");
			model.setGroupname("");
			return FAIL;
		}
		// 添加组服务zookeeper节点
		ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
		Stat groupExist;
		try {
			String groupNode = "/" + groupname;
			groupExist = zk.exists(groupNode, new AutoDataWatcher(zk));
			if (groupExist == null) {
				log.debug("创建分组节点:" + groupNode);
				zk.create(groupNode, new byte[] {}, Ids.OPEN_ACL_UNSAFE,
						CreateMode.PERSISTENT);
			} else {
				log.debug("已存在分组节点" + groupNode + ",不能创建...");
			}
		} catch (KeeperException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// 保存到数据库
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "恭喜您，成功添加新分组: [" + groupname + "]");
			model.setGroupname("");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "系统故障，请稍候重试");
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/group/filter.jsp")
	@Override
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String groupname = param(req, "groupname", "");
		// 默认排序
		String by = param(req, "by", "groupname");
		String order = param(req, "order", "desc");
		Group model = new Group();
		model.setGroupname(groupname);
		if (StringUtils.isNotBlank(groupname)) {
			filter.append(" where ");
			filter.append(" groupname like '%" + groupname + "%'");
		}
		filter.append(" order by ");
		filter.append(by);
		filter.append(" ");
		filter.append(order);
		// 前台分页
		int p = Configuration.DEFAULT_CURRENT_PAGE;
		int countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		try {
			p = param(req, "page", Configuration.DEFAULT_CURRENT_PAGE);
			if (p < 1)
				p = Configuration.DEFAULT_CURRENT_PAGE;
		} catch (NumberFormatException e) {
			p = Configuration.DEFAULT_CURRENT_PAGE;
		}
		try {
			countPerPage = param(req, "countPerPage",
					Configuration.DEFAULT_COUNT_PER_PAGE);
		} catch (NumberFormatException e) {
			countPerPage = Configuration.DEFAULT_COUNT_PER_PAGE;
		}
		int currentPage = p;
		int totalCount = model.totalCount(filter.toString());
		Pager pager = new Pager(currentPage, countPerPage, totalCount);
		// 针对可能的原访问页数大于实际总页数，此处重置下
		if (currentPage > pager.getTotalPage())
			currentPage = p = pager.getTotalPage();
		// 读取部分数据
		@SuppressWarnings("unchecked")
		List<Group> list = (List<Group>) model.filterByPage(filter.toString(),
				p, pager.getCountPerPage());

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		// 批量删除传来的消息
		String tip = (String) getAttr(req, TIP_NAME_KEY);
		setAttr(req, TIP_NAME_KEY, tip);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/group/filter.jsp", fail = "/WEB-INF/pages/group/filter.jsp")
	public String batchDelete(HttpServletRequest req, HttpServletResponse resp) {
		String[] deleteId = params(req, "deleteId");
		System.out.println("deleteId's length:" + deleteId.length);
		if (deleteId.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要删除的分组");
			this.filter(req, resp);
			return FAIL;
		}
		// Hi~选择删除对象后才会到达此处
		// 业务
		Group model = new Group();
		// 删除分组服务节点
		List<Long> ids = new ArrayList<Long>();
		for (String s : deleteId) {
			ids.add(new Long(s));
		}
		List<Group> groupList = (List<Group>) model.batchGet(ids);
		ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
		for (Group group : groupList) {
			Stat groupExist;
			try {
				String groupNode = "/" + group.getGroupname();
				groupExist = zk.exists(groupNode, new AutoDataWatcher(zk));
				if (groupExist != null) {
					log.debug("删除分组节点:" + groupNode);
					zk.delete(groupNode, -1);
				}
			} catch (KeeperException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		// 删除数据库分组
		int[] results = model.batchDelete(deleteId);
		log.debug("batchDelete results[0]: " + results[0]);
		if (results.length > 0 && results[0] > 0) {
			setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个分组名");
		}
		this.filter(req, resp);
		return SUCCESS;
	}

}
