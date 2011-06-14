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
 * 发布规则
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:35:06
 */
@SuppressWarnings("serial")
public class Rule extends Model {
	
	private static final Log log=LogFactory.getLog(Rule.class);
	
	private String pattern;

	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	@Override
	public String toString() {
		return "Rule [pattern=" + pattern + "]";
	}
	public boolean isExist(String pattern) {
		boolean success = false;
		String sql = "select * from " + this.tableName() + " where pattern=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, pattern);
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
