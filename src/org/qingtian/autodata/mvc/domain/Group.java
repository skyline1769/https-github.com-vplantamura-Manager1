package org.qingtian.autodata.mvc.domain;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.db.DBHelper;
import org.qingtian.autodata.db.Model;

/**
 * 分组
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:29
 */
@SuppressWarnings("serial")
public class Group extends Model {

	private static final Log log = LogFactory.getLog(Group.class);

	private String groupname;

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	@Override
	public String toString() {
		return "Group [groupname=" + groupname + "]";
	}

	/**
	 * 分组名存在性
	 * 
	 * @param groupname
	 * @return
	 */
	public boolean isExist(String groupname) {
		boolean success = false;
		String sql = "select * from " + this.tableName() + " where groupname=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, groupname);
			rs = ps.executeQuery();
			if (rs.next()) {
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
