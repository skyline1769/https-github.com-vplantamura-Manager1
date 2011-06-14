<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.qingtian.autodata.db.*" %>
<%@ page import="org.qingtian.autodata.mvc.action.*" %>
<%@ page import="org.qingtian.autodata.mvc.core.*" %>
<%@ page import="org.qingtian.autodata.mvc.domain.*" %>
<%@ page import="org.qingtian.autodata.mvc.filter.*" %>
<%@ page import="org.qingtian.autodata.util.*" %>
<%
UserRule model = new UserRule();
List<UserRule> list = (List<UserRule>) model.filter(" where userid=" +request.getParameter("userid"));
if(list.size()>0){
	out.print("您的发布规则为：<span class=\"red\">"+list.get(0).getPattern()+"</span>");
}
else{
	out.print("<span class=\"red\">尚未赋予发布规则，请尽快联系管理员</span>");
}
%>
