package org.qingtian.autodata.mvc.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;
import org.qingtian.autodata.db.Pager;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.Configuration;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.config.HistoryActionEnum;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.mvc.domain.Bak;
import org.qingtian.autodata.mvc.domain.Data;
import org.qingtian.autodata.mvc.domain.Group;
import org.qingtian.autodata.mvc.domain.History;

public class DataAction extends ActionAdapter {

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/data/myData.jsp")
	public String myData(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		HttpSession session=req.getSession();
		String []sessionUser=((String)session.getAttribute(LOGIN_USER_KEY)).split("&");
		String loginUser=sessionUser[1];
		//默认为当前用户
		String username = param(req, "username",loginUser );
		// 默认排序
		String by = param(req, "by", "addtime");
		String order = param(req, "order", "desc");
		Data model = new Data();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setUsername(username);
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			filter.append(" where ");
			filter.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			filter.append(" and ");
			filter.append(" groupname ='" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			filter.append(" where ");
			filter.append(" groupname  ='" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			filter.append(" and ");
			filter.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			filter.append(" where ");
			filter.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(username)) {
			filter.append(" and ");
			filter.append(" username ='" + username + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(username)) {
			filter.append(" where ");
			filter.append(" username = '" + username + "'");
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
		List<Data> list = (List<Data>) model.filterByPage(filter.toString(), p,
				pager.getCountPerPage());

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/data/filter.jsp")
	public String filter(HttpServletRequest req, HttpServletResponse resp) {
		StringBuilder filter = new StringBuilder();
		String dataid = param(req, "dataid", "");
		String groupname = param(req, "groupname", "");
		String content = param(req, "content", "");
		String username = param(req, "username", "");
		// 默认排序
		String by = param(req, "by", "addtime");
		String order = param(req, "order", "desc");
		Data model = new Data();
		model.setDataid(dataid);
		model.setGroupname(groupname);
		model.setContent(content);
		model.setUsername(username);
		// 合成查询字串
		if (StringUtils.isNotBlank(dataid)) {
			filter.append(" where ");
			filter.append(" dataid like '%" + dataid + "%'");
		}

		if (StringUtils.isNotBlank(dataid) && StringUtils.isNotBlank(groupname)) {
			filter.append(" and ");
			filter.append(" groupname ='" + groupname + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isNotBlank(groupname)) {
			filter.append(" where ");
			filter.append(" groupname  ='" + groupname + "'");
		}

		if ((StringUtils.isNotBlank(dataid) || StringUtils
				.isNotBlank(groupname)) && StringUtils.isNotBlank(content)) {
			filter.append(" and ");
			filter.append(" content like '%" + content + "%'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isNotBlank(content)) {
			filter.append(" where ");
			filter.append(" content like '%" + content + "%'");
		}

		if ((StringUtils.isNotBlank(dataid)
				|| StringUtils.isNotBlank(groupname) || StringUtils
				.isNotBlank(content)) && StringUtils.isNotBlank(username)) {
			filter.append(" and ");
			filter.append(" username ='" + username + "'");
		} else if (StringUtils.isBlank(dataid)
				&& StringUtils.isBlank(groupname)
				&& StringUtils.isBlank(content)
				&& StringUtils.isNotBlank(username)) {
			filter.append(" where ");
			filter.append(" username = '" + username + "'");
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
		List<Data> list = (List<Data>) model.filterByPage(filter.toString(), p,
				pager.getCountPerPage());

		// 分组名列表
		Group group = new Group();
		List<Group> groupList = (List<Group>) group.listAll();

		setAttr(req, CURRENT_PAGE_KEY, currentPage);
		setAttr(req, CURRENT_COUNT_PER_PAGE_KEY, countPerPage);
		setAttr(req, PAGER_KEY, pager);
		setAttr(req, MAX_PAGERSHOW_LENGTH_KEY, DEFAULT_MAX_PAGERSHOW_LENGTH);
		setAttr(req, DATA_LIST, list);
		// 查询值
		setAttr(req, GROUP_NAME_LIST, groupList);
		setAttr(req, DATAID, dataid);
		setAttr(req, GROUPNAME, groupname);
		setAttr(req, CONTENT, content);
		setAttr(req, BY, by);
		setAttr(req, ORDER, order);

		setAttr(req, MODEL, model);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/data/filter.jsp", fail = "/WEB-INF/pages/data/myData.jsp")
	public String batchDelete(HttpServletRequest req, HttpServletResponse resp) {
		String location = param(req, "location");
		boolean isAdmin = location.equals("filter") ? true : false;
		String[] deleteId = params(req, "deleteId");
		System.out.println("deleteId's length:" + deleteId.length);
		if (deleteId.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要删除的配置数据");
			if (isAdmin){
				this.filter(req, resp);
				return SUCCESS;
			}
			else{
				this.myData(req, resp);
				return FAIL;
			}
		}
		// 业务
		Data model = new Data();
		// 删除分组服务节点
		List<Long> ids = new ArrayList<Long>();
		for (String s : deleteId) {
			ids.add(new Long(s));
		}
		List<Data> dataList = (List<Data>) model.batchGet(ids);
		ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
		
		List<Bak> bakListDeleted=new ArrayList<Bak>();
		for (Data data : dataList) {
			History history = new History();
			history.setDataid(data.getDataid());
			history.setGroupname(data.getGroupname());
			history.setContent(data.getContent());
			history.setUsername(data.getUsername());
			history.setAction(HistoryActionEnum.DELETE.toString());
			Stat dataExist;
			try {
				String dataNode = "/" + data.getGroupname() + "/"
						+ data.getDataid();
				dataExist = zk.exists(dataNode, new AutoDataWatcher(zk));
				if (dataExist != null) {
					log.debug("删除配置数据节点:" + dataNode);
					zk.delete(dataNode, -1);
				}
			} catch (KeeperException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			// 保存操作历史
			history.setAddtime(new Timestamp(new Date().getTime()));
			history.save();
			// 删除自动配置关联数据
			Bak bak=new Bak();
			List<Bak> bakList=(List<Bak>)bak.filter("where dataid="+data.getId());
			bakListDeleted.addAll(bakList);
		}
		//删除自动配置
		int requireBak=bakListDeleted.size();
		int deleteBakCount=0;
		for(Bak bak : bakListDeleted){
			if(bak.delete())
				deleteBakCount+=1;
		}
		// 删除数据库分组
		int[] results = model.batchDelete(deleteId);
		log.debug("batchDelete results[0]: " + results[0]);
		
		if (results.length > 0 && results[0] > 0) {
			if(requireBak==deleteBakCount)
				setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个配置数据,关联删除"+deleteBakCount+"个备用配置数据");
			else
				setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个配置数据,关联删除"+deleteBakCount+"个备用配置数据,还存在"+(requireBak-deleteBakCount)+"条备用配置脏数据");
		}
		
		if (isAdmin){
			this.filter(req, resp);
			return SUCCESS;
		}
		else{
			this.myData(req, resp);
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/data/show.jsp")
	@Override
	public String show(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		String location=param(req,"location");
		Data model = new Data();
		model.setId(id);
		model = model.get(id);
		setAttr(req, MODEL, model);
		setAttr(req,LOCATION,location);
		return SUCCESS;
	}
}
