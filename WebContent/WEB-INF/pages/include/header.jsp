<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginUser" value="${sessionScope.loginUser }" ></c:set>
<c:set var="username" value="${fn:split(loginUser,'&')[1] }" ></c:set>
<c:set var="userid" value="${fn:split(loginUser,'&')[0] }" ></c:set>
<div id="headeroutter">
		<div id="headerinner">
			<div id="logo-container">
				<a href="action/global/index" class="logo" title="主页">
					<img src="common/images/logo.png" />
				</a>
			</div>
			<div id="fast-enter-container">
				<c:choose>
					<c:when test="${not empty loginUser}">
						欢迎您, ${username }&nbsp;<a href="action/global/home" class="more-tip-container">
							我的账号&nbsp;<span class="more-tip-corner more-tip-corner-down"></span>
						</a>
						<div id="account-info" class="downmenu">
							<ul>
								<li><a href="action/global/index"><span>系统概览</span></a></li>
								<c:if test="${username=='admin' }">
								<li><a href="action/global/advance"><span>高级管理</span></a></li>
								</c:if>
								<li class="sep-container"><div class="sep-line"></div></li>
								<li><a href="action/global/home"><span>我的主页</span></a></li>
								<li><a href="action/data/myData"><span>我的配置</span></a></li>
								<li><a href="action/history/filter"><span>我的历史</span></a></li>
								<li><a href="action/global/myChart"><span>我的统计</span></a></li>
								<li><a href="action/user/viewModifyPsw"><span>更改密码</span></a></li>
								<li class="sep-container"><div class="sep-line"></div></li>
								<li><a href="javascript:void(0);" class="jqModal"><span>退出系统</span></a></li>
							</ul>
						</div>
						<!-- 退出确定弹窗 -->
						<div id="dialog" class="common-dialog-container">
							<div class="outter-border" style="margin:0px auto;border-color:#6f6f6f;">
								<div class="inner-container">
									<div class="dialogTitle">
										<b>退出系统</b>
										<a href="javascript:void(0);" class="jqmClose" title="关闭">关闭</a>
									</div>
									<div class="dialogCt">
										<div class="dialog-icon-container">
											<div class="icon-outter">
												<img src="common/images/exit-icon.png" alt="退出"/>
											</div>
										</div>
										<div class="dialog-body-container">
											<p><b>您确认想退出系统嘛？</b></p>
											<div class="dialog-seperate-line"></div>
											<p>"退出系统"后,您将只能浏览数据和查看系统级的图表统计等,而不能管理个人的配置数据。</p>
										</div>
										<div class="clear"></div>
									</div>
									<div class="dialogBottom">
										<input type="button" class="common-bt" onclick="goUrl('action/user/logout');" value="确认退出"/>
										<input type="button" class="common-cancel-bt jqmClose" value="取消"/>
									</div>
								</div>
							</div>
						</div>
						<script type="text/javascript">
						$(function(){
							 $('#dialog').jqm();
						});
						</script>	
					</c:when>
					<c:otherwise>
						<a href="base/login.jsp" title="登录">登录</a> <a href="base/register.jsp" title="注册">注册</a> <a href="base/question.jsp" title="反馈">反馈</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
