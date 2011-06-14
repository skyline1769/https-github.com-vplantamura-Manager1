package org.qingtian.autodata.mvc.domain;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.db.DBHelper;
import org.qingtian.autodata.db.Model;

/**
 * 配置
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:21
 */
@SuppressWarnings("serial")
public class Data extends Model {

	private static final Log log = LogFactory.getLog(Data.class);

	private String dataid;
	private String groupname;
	private String content;
	private Timestamp addtime;
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Override
	public String toString() {
		return "Data [dataid=" + dataid + ", groupname=" + groupname
				+ ", content=" + content + ", addtime=" + addtime
				+ ", username=" + username + "]";
	}

	public boolean isExist(String dataid, String groupname) {
		boolean success = false;
		String sql = "select * from " + this.tableName()
				+ " where dataid=? and groupname=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, dataid);
			ps.setObject(2, groupname);
			rs = ps.executeQuery();
			if (rs.next()) {
				setId(rs.getLong("id"));
				setDataid(rs.getString("dataid"));
				setGroupname(rs.getString("groupname"));
				setContent(rs.getString("content"));
				setUsername(rs.getString("username"));
				success = true;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DbUtils.closeQuietly(rs);
			DbUtils.closeQuietly(ps);
			sql = null;
		}
		return success;
	}

}
