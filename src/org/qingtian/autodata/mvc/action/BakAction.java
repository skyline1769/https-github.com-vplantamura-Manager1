package org.qingtian.autodata.mvc.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooKeeper;
import org.apache.zookeeper.data.Stat;
import org.qingtian.autodata.mvc.core.ActionAdapter;
import org.qingtian.autodata.mvc.core.annotation.Result;
import org.qingtian.autodata.mvc.core.config.HistoryActionEnum;
import org.qingtian.autodata.mvc.core.zookeeper.AutoDataWatcher;
import org.qingtian.autodata.mvc.domain.Bak;
import org.qingtian.autodata.mvc.domain.Data;
import org.qingtian.autodata.mvc.domain.History;

public class BakAction extends ActionAdapter {

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/bak/list.jsp")
	@Override
	public String list(HttpServletRequest req, HttpServletResponse resp) {
		Integer dataid = Integer.valueOf(param(req, "dataid", 0));
		String location = param(req, "location");

		Bak model = new Bak();
		StringBuilder filter = new StringBuilder();
		filter.append(" where dataid=");
		filter.append(dataid);
		List<Bak> list = (List<Bak>) model.filter(filter.toString());

		setAttr(req, LOCATION, location);
		setAttr(req, DATAID, dataid);
		setAttr(req, DATA_LIST, list);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	@Result(success = "/WEB-INF/pages/bak/listMy.jsp")
	public String listMy(HttpServletRequest req, HttpServletResponse resp) {
		Integer dataid = Integer.valueOf(param(req, "dataid", 0));
		String location = param(req, "location");

		Bak model = new Bak();
		StringBuilder filter = new StringBuilder();
		filter.append(" where dataid=");
		filter.append(dataid);
		List<Bak> list = (List<Bak>) model.filter(filter.toString());

		setAttr(req, DATAID, dataid);
		setAttr(req, DATA_LIST, list);
		setAttr(req, LOCATION, location);
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/bak/show.jsp")
	@Override
	public String show(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		// 标识面板组成
		String location = param(req, "location");
		String dataid = param(req, "dataid");

		Bak model = new Bak();
		model.setId(id);
		model = model.get(id);
		Data data = new Data();
		data.setId(model.getDataid());
		data = data.get(model.getDataid());
		setAttr(req, MODEL, model);
		setAttr(req, DATA, data);
		setAttr(req, LOCATION, location);
		setAttr(req, DATAID, dataid);

		setAttr(req, TIP_NAME_KEY, getAttr(req, TIP_NAME_KEY));

		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/bak/showMy.jsp")
	public String showMy(HttpServletRequest req, HttpServletResponse resp) {
		long id = Long.parseLong(param(req, "id"));
		// 标识面板组成
		String location = param(req, "location");
		String dataid = param(req, "dataid");

		Bak model = new Bak();
		model.setId(id);
		model = model.get(id);
		Data data = new Data();
		data.setId(model.getDataid());
		data = data.get(model.getDataid());
		setAttr(req, MODEL, model);
		setAttr(req, DATA, data);
		setAttr(req, LOCATION, location);
		setAttr(req, DATAID, dataid);

		setAttr(req, TIP_NAME_KEY, getAttr(req, TIP_NAME_KEY));

		return SUCCESS;
	}
	@Result(success = "/WEB-INF/pages/bak/viewAdd.jsp")
	@Override
	public String viewAdd(HttpServletRequest req, HttpServletResponse resp) {
		Integer dataid = Integer.valueOf(param(req, "dataid", 0));
		String location = param(req, "location");

		Bak model = new Bak();
		model.setDataid(dataid);
		setAttr(req, MODEL, model);
		setAttr(req, LOCATION, location);
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/bak/viewAdd.jsp", fail = "/WEB-INF/pages/bak/viewAdd.jsp")
	@Override
	public String add(HttpServletRequest req, HttpServletResponse resp) {
		Integer dataid = Integer.valueOf(param(req, "dataid", 0));
		String content = param(req, "content");
		String description = param(req, "description");
		String location = param(req, "location");
		Bak model = new Bak();
		model.setDataid(dataid);
		model.setContent(content);
		model.setDescription(description);
		setAttr(req, MODEL, model);
		setAttr(req, LOCATION, location);
		if (dataid == 0) {
			setAttr(req, TIP_NAME_KEY, "配置ID不正确，请重试!");
			return FAIL;
		}
		if (StringUtils.isBlank(content)) {
			setAttr(req, TIP_NAME_KEY, "请输入备用配置内容");
			return FAIL;
		}
		if (StringUtils.isBlank(description)) {
			setAttr(req, TIP_NAME_KEY, "请输入备用配置简介描述");
			return FAIL;
		}
		if (model.isExist(dataid, content)) {
			setAttr(req, TIP_NAME_KEY, "对不起，已存在的订阅键与内容对应值，请不要重复添加！");
			return FAIL;
		}
		model.setAddtime(new Timestamp(new Date().getTime()));
		if (model.save() > 0) {
			setAttr(req, TIP_NAME_KEY, "恭喜您，备用配置添加成功！");
			model.setContent("");
			model.setDescription("");
			return SUCCESS;
		} else {
			setAttr(req, TIP_NAME_KEY, "对不起，系统暂时无法访问，请稍候重试!");
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/bak/list.jsp", fail = "/WEB-INF/pages/bak/listMy.jsp")
	public String batchDelete(HttpServletRequest req, HttpServletResponse resp) {
		String location = param(req, "location");
		boolean isAdmin = location.equals("advance") ? true : false;
		String[] deleteId = params(req, "deleteId");
		System.out.println("deleteId's length:" + deleteId.length);
		if (deleteId.length == 0) {
			setAttr(req, TIP_NAME_KEY, "请选择要删除的配置数据");
			if (isAdmin) {
				this.list(req, resp);
				return SUCCESS;
			} else {
				this.listMy(req, resp);
				return FAIL;
			}
		}
		Bak model = new Bak();
		// 删除数据库分组
		int[] results = model.batchDelete(deleteId);
		log.debug("batchDelete results[0]: " + results[0]);
		if (results.length > 0 && results[0] > 0) {
			setAttr(req, TIP_NAME_KEY, "成功删除" + results[0] + "个备用配置数据");
		}
		if (isAdmin) {
			this.list(req, resp);
			return SUCCESS;
		} else {
			this.listMy(req, resp);
			return FAIL;
		}
	}

	@Result(success = "/WEB-INF/pages/bak/show.jsp", fail = "/WEB-INF/pages/bak/showMy.jsp")
	public String setDataConfig(HttpServletRequest req, HttpServletResponse resp) {
		Long did = Long.parseLong(param(req, "did"));
		String content = param(req, "content");
		String dataid = param(req, "dataid");
		String groupname = param(req, "groupname");
		String username = param(req, "username");
		String location = param(req, "location");
		boolean isAdmin = location.equals("advance") ? true : false;
		// 保存配置内容变更
		Data data = new Data();
		data.setId(did);
		data = data.get(did);
		String precontent = data.getContent();
		// 检查变更
		if (!StringUtils.equals(precontent, content)) {
			data.setContent(content);
			// 创建或者修改zookeeper数据节点
			ZooKeeper zk = (ZooKeeper) context.getAttribute(ZOOKEEPER_KEY);
			try {
				String groupNode = "/" + groupname;
				Stat groupExist = zk.exists(groupNode, new AutoDataWatcher(zk));
				if (groupExist == null) {
					setAttr(req, TIP_NAME_KEY, "切换配置失败，分组已被管理员删除！");
					if (isAdmin) {
						this.show(req, resp);
						return SUCCESS;
					} else {
						this.showMy(req, resp);
						return FAIL;
					}
				} else {
					log.debug("已存在分组节点" + groupNode + ",不能创建...");
				}
				String dataNode = groupNode + "/" + dataid;
				Stat dataExist = zk.exists(dataNode, new AutoDataWatcher(zk));
				if (dataExist == null) {
					setAttr(req, TIP_NAME_KEY, "发布失败，配置节点已被删除！");
					if (isAdmin) {
						this.show(req, resp);
						return SUCCESS;
					} else {
						this.showMy(req, resp);
						return FAIL;
					}
				} else {
					log.debug("已存在数据节点" + dataNode + ",开始切换配置数据内容...");
					zk.setData(dataNode, content.getBytes(), -1);
				}
			} catch (KeeperException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			data.setAddtime(new Timestamp(new Date().getTime()));
			if (data.save() > 0) {
				setAttr(req, TIP_NAME_KEY, "恭喜您，配置切换成功!");
				// 添加一条历史
				History history = new History();
				history.setDataid(dataid);
				history.setGroupname(groupname);
				history.setContent(precontent+" => "+content);
				history.setUsername(username);
				history.setAction(HistoryActionEnum.SWITCH.toString());
				history.setAddtime(new Timestamp(new Date().getTime()));
				history.save();
			} else
				setAttr(req, TIP_NAME_KEY, "很抱歉，配置切换失败!");
		} else {
			setAttr(req, TIP_NAME_KEY, "配置内容无任何变更，不进行切换!");
		}
		if (isAdmin) {
			this.show(req, resp);
			return SUCCESS;
		} else {
			this.showMy(req, resp);
			return FAIL;
		}
	}
	@Result(success = "/WEB-INF/pages/bak/viewModify.jsp")
	@Override
	public String viewModify(HttpServletRequest req, HttpServletResponse resp) {
		Long id = Long.valueOf(param(req, "id"));
		String location = param(req, "location");

		Bak model = new Bak();
		model.setId(id);
		model=model.get(id);
		setAttr(req, MODEL, model);
		setAttr(req, LOCATION, location);
		return SUCCESS;
	}

	@Result(success = "/WEB-INF/pages/bak/viewModify.jsp", fail = "/WEB-INF/pages/bak/viewModify.jsp")
	@Override
	public String modify(HttpServletRequest req, HttpServletResponse resp) {
		Long id = Long.valueOf(param(req, "id"));
		String location = param(req, "location");

		String content=param(req,"content");
		String description=param(req,"description");
		
		Bak model = new Bak();
		model.setId(id);
		model=model.get(id);
		setAttr(req, MODEL, model);
		setAttr(req, LOCATION, location);
		
		String precontent=model.getContent();
		String predescription=model.getDescription();
		
		if(StringUtils.isBlank(content)){
			setAttr(req,TIP_NAME_KEY,"请输入备用配置内容");
			return FAIL;
		}
		if(StringUtils.isBlank(description)){
			setAttr(req,TIP_NAME_KEY,"请输入备用配置描述");
			return FAIL;
		}
		if(StringUtils.equals(precontent, content)&&StringUtils.equals(predescription, description)){
			setAttr(req,TIP_NAME_KEY,"无任何修改");
			return FAIL;
		}
		model.setContent(content);
		model.setDescription(description);
		if(model.save()>0){
			setAttr(req,TIP_NAME_KEY,"恭喜您，备用配置修改成功");
			return SUCCESS;
		}
		else{
			setAttr(req,TIP_NAME_KEY,"对不起，备用配置修改失败，请稍候再试");
			return FAIL;
		}
		
	}

}
