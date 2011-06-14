package org.qingtian.autodata.mvc.domain;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.db.DBHelper;
import org.qingtian.autodata.db.Model;
import org.qingtian.autodata.mvc.domain.useful.AdvanceHistory;

/**
 * 配置发布历史
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:36
 */
@SuppressWarnings("serial")
public class History extends Model {

	private static final Log log = LogFactory.getLog(History.class);

	private String dataid;
	private String groupname;
	private String content;
	private Timestamp addtime;
	private String action;
	private String username;

	public String getDataid() {
		return dataid;
	}

	public void setDataid(String dataid) {
		this.dataid = dataid;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getAddtime() {
		return addtime;
	}

	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "History [dataid=" + dataid + ", groupname=" + groupname
				+ ", content=" + content + ", addtime=" + addtime + ", action="
				+ action + ", username=" + username + "]";
	}

	public List<AdvanceHistory> getAdvance(String where, String groupby) {
		List<AdvanceHistory> list = new ArrayList<AdvanceHistory>();
		String sql = "select year(addtime) , month(addtime), day(addtime),hour(addtime),minute(addtime),second(addtime), count(*) ,"
				+ " id , dataid , groupname , content , addtime , action , username "
				+ " from "
				+ this.tableName()
				+ where
				+ " "
				+ " group by "
				+ groupby + " order by addtime asc";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdvanceHistory ah = new AdvanceHistory();
				ah.setYear(rs.getInt(1));
				ah.setMonth(rs.getInt(2));
				ah.setDay(rs.getInt(3));
				ah.setHour(rs.getInt(4));
				ah.setMinute(rs.getInt(5));
				ah.setSecond(rs.getInt(6));
				ah.setCount(rs.getInt(7));

				History history = new History();
				history.setId(rs.getLong("id"));
				history.setDataid(rs.getString("dataid"));
				history.setGroupname(rs.getString("groupname"));
				history.setContent(rs.getString("content"));
				history.setAddtime(rs.getTimestamp("addtime"));
				history.setAction(rs.getString("action"));
				history.setUsername(rs.getString("username"));
				ah.setHistory(history);

				list.add(ah);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DbUtils.closeQuietly(rs);
			DbUtils.closeQuietly(ps);
			sql = null;
		}
		return list;
	}
	
	public List<AdvanceHistory> getAdvance(String where, String groupby,String order) {
		List<AdvanceHistory> list = new ArrayList<AdvanceHistory>();
		String sql = "select year(addtime) , month(addtime), day(addtime),hour(addtime),minute(addtime),second(addtime), count(*) ,"
				+ " id , dataid , groupname , content , addtime , action , username "
				+ " from "
				+ this.tableName()
				+ where
				+ " "
				+ " group by "
				+ groupby + " order by "+order;
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdvanceHistory ah = new AdvanceHistory();
				ah.setYear(rs.getInt(1));
				ah.setMonth(rs.getInt(2));
				ah.setDay(rs.getInt(3));
				ah.setHour(rs.getInt(4));
				ah.setMinute(rs.getInt(5));
				ah.setSecond(rs.getInt(6));
				ah.setCount(rs.getInt(7));

				History history = new History();
				history.setId(rs.getLong("id"));
				history.setDataid(rs.getString("dataid"));
				history.setGroupname(rs.getString("groupname"));
				history.setContent(rs.getString("content"));
				history.setAddtime(rs.getTimestamp("addtime"));
				history.setAction(rs.getString("action"));
				history.setUsername(rs.getString("username"));
				ah.setHistory(history);

				list.add(ah);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DbUtils.closeQuietly(rs);
			DbUtils.closeQuietly(ps);
			sql = null;
		}
		return list;
	}
}
