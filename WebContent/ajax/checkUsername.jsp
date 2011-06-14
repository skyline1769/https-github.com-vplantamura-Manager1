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
User model=new User();
String username=request.getParameter("username");
//1 stand for useful,0 stand for used
if(model.isExist(username)){
	out.print(0);
}
else{
	out.print(1);
}
%>
