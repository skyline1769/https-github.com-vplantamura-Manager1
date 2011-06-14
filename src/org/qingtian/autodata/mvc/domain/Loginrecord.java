package org.qingtian.autodata.mvc.domain;

import java.sql.Timestamp;

import org.qingtian.autodata.db.Model;

/**
 * 登录记录
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:45
 */
@SuppressWarnings("serial")
public class Loginrecord extends Model {

	private String username;
	private Timestamp logintime;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Timestamp getLogintime() {
		return logintime;
	}

	public void setLogintime(Timestamp logintime) {
		this.logintime = logintime;
	}

	@Override
	public String toString() {
		return "LoginRecord [username=" + username + ", logintime=" + logintime
				+ "]";
	}
}
