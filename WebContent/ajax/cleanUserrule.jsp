<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*"%>
<%@ page import="org.qingtian.autodata.db.*" %>
<%@ page import="org.qingtian.autodata.mvc.action.*" %>
<%@ page import="org.qingtian.autodata.mvc.core.*" %>
<%@ page import="org.qingtian.autodata.mvc.domain.*" %>
<%@ page import="org.qingtian.autodata.mvc.filter.*" %>
<%@ page import="org.qingtian.autodata.util.*" %>
<%!public String encode(String source) {
		String destination = null;
		try {
			destination = new String(source.getBytes("iso-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			;// ignore
		}
		return destination;
	}%>
<%
UserRule model=new UserRule();
String userid=request.getParameter("userid");
String pattern=request.getParameter("pattern");
model.setUserid(Integer.parseInt(userid));
model.setPattern(pattern);
List<UserRule> list=(List<UserRule>)model.filter(" where userid="+userid+" and pattern='"+pattern+"'");
model=list.size()>0 ? list.get(0):model;
//1 stand for ok,0 stand for fail
if(model.delete()){
	out.print(1);
}
else{
	out.print(0);
}
%>
