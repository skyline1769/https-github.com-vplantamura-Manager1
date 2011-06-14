package org.qingtian.autodata.mvc.core.zookeeper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.Watcher.Event.EventType;
import org.apache.zookeeper.ZooKeeper;
import org.qingtian.autodata.mvc.core.Configuration;

/**
 * 服务集群配置监听者，与原生zookeeper java api 打交道
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:39:53
 */
public class AutoDataWatcher implements Watcher, Configuration {

	private static final Log log = LogFactory.getLog(AutoDataWatcher.class);

	private ZooKeeper zk;

	public AutoDataWatcher(ZooKeeper zk) {
		this.zk = zk;
	}

	@Override
	public void process(WatchedEvent event) {
		if (event.getPath() != null
				&& SERVER_CLUSTER_NODE.equals(event.getPath())) {
			try {
				EventType et = event.getType();
				if (et == EventType.NodeCreated) {
					log.debug("节点" + SERVER_CLUSTER_NODE + "被创建了...");
				}
				if (et == EventType.NodeDataChanged) {
					log.debug("最新服务器列表数据为:"
							+ zk.getData(SERVER_CLUSTER_NODE, true, null));
				}
				if (et == EventType.NodeDeleted) {
					log.debug("节点" + SERVER_CLUSTER_NODE + "被删除了...");
				}
			} catch (KeeperException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

}
