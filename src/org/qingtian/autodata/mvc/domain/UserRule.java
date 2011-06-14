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
 * 用户与发布规则对应关系
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:35:26
 */
@SuppressWarnings("serial")
public class UserRule extends Model {

	private static final Log log=LogFactory.getLog(UserRule.class);
	
	private Integer userid;
	private String pattern;

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	@Override
	public String toString() {
		return "UserRule [userid=" + userid + ", pattern=" + pattern + "]";
	}
	public boolean isExist(Integer userid) {
		boolean success = false;
		String sql = "select * from " + this.tableName() + " where userid=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, userid);
			rs = ps.executeQuery();
			if (rs.next()) {
				setId(rs.getLong("id"));
				setUserid(rs.getInt("userid"));
				setPattern(rs.getString("pattern"));
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
	public boolean isExist(Integer userid,String pattern) {
		boolean success = false;
		String sql = "select * from " + this.tableName() + " where userid=? and pattern=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, userid);
			ps.setObject(2, pattern);
			rs = ps.executeQuery();
			if (rs.next()) {
				setId(rs.getLong("id"));
				setUserid(rs.getInt("userid"));
				setPattern(rs.getString("pattern"));
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
