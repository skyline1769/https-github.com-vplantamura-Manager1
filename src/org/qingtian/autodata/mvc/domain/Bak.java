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
 * 备用配置
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:12
 */
@SuppressWarnings("serial")
public class Bak extends Model {
	
	private static final Log log=LogFactory.getLog(Bak.class);
	
	private Integer dataid;
	private String content;
	private String description;
	private Timestamp addtime;
	public Integer getDataid() {
		return dataid;
	}
	public void setDataid(Integer dataid) {
		this.dataid = dataid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Timestamp getAddtime() {
		return addtime;
	}
	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}
	@Override
	public String toString() {
		return "Bak [dataid=" + dataid + ", content=" + content
				+ ", description=" + description + ", addtime=" + addtime + "]";
	}
	public boolean isExist(Integer dataid, String content) {
		boolean success = false;
		String sql = "select * from " + this.tableName()
				+ " where dataid=? and content=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, dataid);
			ps.setObject(2, content);
			rs = ps.executeQuery();
			if (rs.next()) {
				setId(rs.getLong("id"));
				setDataid(rs.getInt("dataid"));
				setContent(rs.getString("content"));
				setDescription(rs.getString("description"));
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
