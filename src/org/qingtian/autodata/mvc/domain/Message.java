package org.qingtian.autodata.mvc.domain;

import java.sql.Timestamp;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.qingtian.autodata.db.Model;

/**
 * 用户反馈
 * 
 * @author qingtian
 *
 * 2011-5-11 上午11:34:57
 */
@SuppressWarnings("serial")
public class Message extends Model {
	private static final Log log = LogFactory.getLog(Message.class);

	private String type;
	private String title;
	private String content;
	private String reportuser;
	private Timestamp addtime;
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public static Log getLog() {
		return log;
	}

	public String getReportuser() {
		return reportuser;
	}

	public void setReportuser(String reportuser) {
		this.reportuser = reportuser;
	}

	public Timestamp getAddtime() {
		return addtime;
	}

	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}

	@Override
	public String toString() {
		return "Message [type=" + type + ", title=" + title + ", content="
				+ content + ", reportuser=" + reportuser + ", addtime="
				+ addtime + "]";
	}

}
