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
 * 用户
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:35:17
 */
@SuppressWarnings("serial")
public class User extends Model {
	private final static Log log = LogFactory.getLog(User.class);
	
	private String username;
	private String password;
	private Timestamp registertime;
	private Timestamp lastlogintime;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Timestamp getRegistertime() {
		return registertime;
	}

	public void setRegistertime(Timestamp registertime) {
		this.registertime = registertime;
	}

	public Timestamp getLastlogintime() {
		return lastlogintime;
	}

	public void setLastlogintime(Timestamp lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password
				+ ", registertime=" + registertime + ", lastlogintime="
				+ lastlogintime + "]";
	}
	
	//业务相关
	/**
	 * 用户登录
	 * 
	 * @return
	 */
	public boolean login() {
		boolean success = false;
		String sql = "select * from " + this.tableName()
				+ " where username=? and password=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, getUsername());
			ps.setObject(2, getPassword());
			rs = ps.executeQuery();
			if (rs.next()) {
				success = true;
				this.setId(rs.getLong("id"));
				this.setRegistertime(rs.getTimestamp("registertime"));
				this.setLastlogintime(rs.getTimestamp("lastlogintime"));
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
	
	/**
	 * 用户名存在性
	 * 
	 * @param username
	 * @return
	 */
	public boolean isExist(String username){
		boolean success=false;
		String sql="select * from "+this.tableName()+" where username=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			ps=DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, username);
			rs=ps.executeQuery();
			if(rs.next()){
				success=true;
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
	
	/**
	 * 用户原密码正确性验证
	 * 
	 * @param username 用户名
	 * @param prepassword 原密码
	 * @return
	 */
	public boolean isRightPrepassword(String username,String prepassword){
		boolean success=false;
		String sql="select password from "+this.tableName()+" where username=?";
		log.debug(sql);
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			ps=DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, username);
			rs=ps.executeQuery();
			if(rs.next()){
				if(rs.getString("password").equals(prepassword))
					success=true;
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
	
	/**
	 * 更改用户密码
	 * 
	 * @param username 用户名
	 * @param newpassword 新密码
	 * @return
	 */
	public boolean updatePassword(String username,String newpassword){
		boolean success=false;
		String sql="update "+this.tableName()+" set password=? where username=?";
		log.debug(sql);
		PreparedStatement ps = null;
		try{
			ps=DBHelper.getConnection().prepareStatement(sql);
			ps.setObject(1, newpassword);
			ps.setObject(2, username);
			int result=ps.executeUpdate();
			if(result>0)
				success=true;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DbUtils.closeQuietly(ps);
			sql = null;
		}
		return success;
	}
}
