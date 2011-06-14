<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>"></base> 
<title> 帮助 </title>
</head>
<body>
<div id="crumb" class="clearBorder">当前位置<span class="to"></span><a href="action/global/index">系统概览</a><span class="to"></span>帮助</div>
<div id="base-main-container-inner">
	<div id="help-container">
		<div id="help-container-inner">
			<h2><img src="common/images/help.png" /> 帮助</h2>
			<div class="noteword">如果您在使用过程中有任何问题，都可以通过“帮助”系统来自行解决，这里列出了几乎所有您可能遇到的问题，如果还是无法解决请<a href="base/question.jsp">提出BUG或意见</a>给我们！谢谢</div>
			<div class="main-box">
				<div id="help-theme-container">
					<h3>问题分类</h3>
					<ul class="help-theme">
						<li class="help-theme-title">
							<a href="javascript:void(0);" class="title-operator"><img src="common/images/common-icon.png" class="icon fixpos"/><span>常规问题</span></a>
							<ul class="help-theme-question">
								<li><a href="javascript:void(0);" class="q-item-bar" id="1"><span class="m-to-i"></span><span>如何注册？</span></a></li>
								<li><a href="javascript:void(0);" class="q-item-bar" id="2"><span class="m-to-i"></span><span>如何登录？</span></a></li>
								<li><a href="javascript:void(0);" class="q-item-bar" id="3"><span class="m-to-i"></span><span>注册后我能做什么？</span></a></li>
								<li><a href="javascript:void(0);" class="q-item-bar" id="4"><span class="m-to-i"></span><span>注册后我想发布配置怎么办？</span></a></li>
							</ul>
						</li>
						<li class="help-theme-title">
							<a href="javascript:void(0);" class="title-operator"><img src="common/images/config-data.png" class="icon fixpos" /><span>配置相关问题</span></a>
							<ul class="help-theme-question">
								<li><a href="javascript:void(0);" class="q-item-bar" id="5"><span class="m-to-i"></span><span>如何发布配置？</span></a></li>
								<li><a href="javascript:void(0);" class="q-item-bar" id="6"><span class="m-to-i"></span><span>如何添加备用配置？</span></a></li>
								<li><a href="javascript:void(0);" class="q-item-bar" id="7"><span class="m-to-i"></span><span>如何切换配置？</span></a></li>
							</ul>
						</li>
						<li class="help-theme-title">
							<a href="javascript:void(0);" class="title-operator"><img src="common/images/api-icon.png" class="icon fixpos" /><span>API使用问题</span></a>
							<ul class="help-theme-question">
								<li><a href="javascript:void(0);" class="q-item-bar" id="8"><span class="m-to-i"></span><span>如何使用订阅API来获取配置？</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
				<div id="help-theme-content-container">
					<div id="question-1" class="question-container">
						<h4>如何注册？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>注册请点击网站顶部右上角的"<b>注册</b>"链接，效果如<img src="common/images/help/help-1.png" />，进入"<b>注册</b>"页面，页面效果如下：</p>
							<p class="center"><img src="common/images/help/help-2.png" /></p>
							<p><span class="seri-num">2. </span>输入基本用户信息，包括"<b>用户名</b>","<b>密码</b>","<b>确认密码</b>","<b>验证码</b>"四项内容，为了防止您的用户名已被他人注册，所以我们建议您输入完"<b>用户名</b>"后，便点击"<b>检测</b>"链接来验证用户名是否被他人占用</p>
							<p><span class="seri-num">3. </span>如右图即表明您的用户名未被他人注册，可以注册！<img src="common/images/help/help-3.png" /></p>
							<p><span class="seri-num">4. </span>确认各项都填写完成并正确后，点击"<b>注册</b>"按钮，<p>
							<p>如果注册成功将会直接跳转到"<b>登录</b>"页面，如：<img src="common/images/help/help-4.png" /></p>
							<p>如果信息填写不全或者不正确，将返回注册页面重填，如：<img src="common/images/help/help-5.png" /></p>
						</div>
					</div>
					<div id="question-2" class="question-container">
						<h4>如何登录？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>登录请点击网站顶部右上角的"<b>登录</b>"链接，效果如<img src="common/images/help/help-6.png" />，进入"<b>登录</b>"页面，页面效果如下：</p>
							<p class="center"><img src="common/images/help/help-7.png" /></p>
							<p><span class="seri-num">2. </span>输入用户登录所需信息，包括"<b>用户名</b>","<b>密码</b>","<b>验证码</b>"三项内容，然后点击"<b>登录</b>"按钮</p>
							<p>如果登录成功将会直接跳转到"<b>我的主页</b>"页面，如：<img src="common/images/help/help-8.png" /></p>
							<p>如果登录信息填写不全或者不正确，将返回登录页面重填，如：<img src="common/images/help/help-9.png" /></p>
						</div>
					</div>
					<div id="question-3" class="question-container">
						<h4>注册后我能做什么？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>注册完成后，您进入"<b>我的主页</b>"，可以看到左侧导航菜单中两个菜单面板，分别为：</p>
							<p>"<b>个人中心</b>"<img src="common/images/help/help-10.png" />，"<b>配置数据</b>"<img src="common/images/help/help-11.png" /></p>
							<p><span class="seri-num">2. </span>在"<b>我的主页</b>"您可以"<b>更改密码</b>",通过输入"<b>旧密码</b>","<b>新密码</b>","<b>确认密码</b>"三项完成密码的修改，防止其他用户使用的账号进行配置操作，保障您的账号安全<img src="common/images/help/help-12.png" /></p>
							<p><span class="seri-num">3. </span>另外，您还可以浏览账号的登录情况，以便更直观的了解账号的使用情况，如发现可疑登录行为可以尽快处理。"<b>登录记录</b>"可以按"<b>本日</b>","<b>本月</b>","<b>本年</b>"三种模式查看<img src="common/images/help/help-13.png" /></p>
							<p><span class="seri-num">4. </span>在您还未向管理请求发布规则前，你查看"<b>我的发布规则</b>"将看到如图所示：<img src="common/images/help/help-14.png" /></p>
							<p><span class="seri-num">5. </span>正因为您还没有被授予发布规则，所以您在"<b>我的推送历史</b>"、"<b>我的统计图表</b>"、"<b>配置信息</b>"中都显示无任何数据</p>
							<p><img src="common/images/help/help-15.png" /></p>
							<p><img src="common/images/help/help-16.png" /></p>
							<p><img src="common/images/help/help-17.png" /></p>
							<p>表明目前您还不能发布任何配置</p>
							<p><img src="common/images/help/help-18.png" /></p>
							<p><img src="common/images/help/help-19.png" /></p>
						</div>
					</div>
					<div id="question-4" class="question-container">
						<h4>注册后我想发布配置怎么办？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>您可以主动联系管理员，让其为你添加发布规则，通过绑定发布规则到用户，您就可以发布配置了。管理员为您添加发布规则后，您点击"<b>我的发布规则</b>"便可以看到如图所示的相似内容：</p>
							<p><img src="common/images/help/help-20.png" /></p>
							<p><span class="seri-num">2. </span>从现在开始您便可以发布指定订阅键的配置数据了，点击"<b>我的发布规则</b>"</p>
							<p><img src="common/images/help/help-21.png" /></p>
						</div>
					</div>
					<div id="question-5" class="question-container">
						<h4>如何发布配置？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>当您拥有相应发布规则授权后，您便可以在发布规则允许范围内发布指定订阅键的配置，如您的发布规则为：org.qingtian.test1，它的含义为：您只能发布订阅键为org.qingtian.test1的配置</p>
							<p><img src="common/images/help/help-18.png" /></p>
							<p><span class="seri-num">2. </span>点击"<b>我要发布</b>"链接 ，您填写完"<b>订阅键</b>"、"<b>分组</b>"、"<b>内容</b>"三个内容后，点击"<b>发布</b>"后，发布成功或者失败都将显示提示信息，具体可以浏览操作后的提示，这里不赘述</p>
							<p><img src="common/images/help/help-22.png" /></p>
						</div>
					</div>
					<div id="question-6" class="question-container">
						<h4>如何添加备用配置？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>点击"<b>我的配置</b>"链接，可以看到您所发布的所有配置，系统以分页形式进行展示，在一条配置后的"<b>操作</b>"一列中，点击"<b>添加备用配置</b>"链接</p>
							<p><img src="common/images/help/help-23.png" /></p>
							<p><span class="seri-num">2. </span>填写"<b>配置内容</b>"、"<b>配置描述</b>"两项后，点击"<b>添加</b>"按钮后，便完成了备用配置的添加</p>
							<p><img src="common/images/help/help-24.png" /></p>
						</div>
					</div>
					<div id="question-7" class="question-container">
						<h4>如何切换配置？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>点击"<b>我的配置</b>"链接，可以看到您所发布的所有配置，系统以分页形式进行展示，在一条配置后的"<b>操作</b>"一列中，点击"<b>浏览备用配置</b>"链接</p>
							<p><img src="common/images/help/help-25.png" /></p>
							<p><span class="seri-num">2. </span>点击"<b>查看</b>"按钮后，查看备用配置的详细，再次点击"<b>设置为默认配置</b>"按钮，弹出确认窗品，点击"<b>确认并设置为默认配置</b>"按钮，完成备用切换</p>
							<p><img src="common/images/help/help-26.png" /></p>
						</div>
					</div>
					<div id="question-8" class="question-container">
						<h4>如何使用订阅API来获取配置？<span class="top"><a href="base/help.jsp#" title="回到顶部">回到顶部</a></span></h4>
						<div class="question-content">
							<p><span class="seri-num">1. </span>声明并实例化一个配置管理器类对象：DefaultAutoDataManager manager = new DefaultAutoDataManager();</p>
							<p><span class="seri-num">2. </span>通过调用manager.config("autodata.properties");来加载类路径下的autodata.properties属性文件，文件名称可以根据情况更改</p>
							<p>autodata.properties 属性文件必配置键有如下几个：</p>
							<p style="padding-left:25px;">autodata.ip=127.0.0.1 配置管理服务运行机器的IP</p>
							<p style="padding-left:25px;">autodata.port=2181 配置管理服务运行机器的端口</p>
							<p style="padding-left:25px;">autodata.timeout=50000 配置管理服务运行机器的会话过期时间</p>
							<p style="padding-left:25px;">autodata.interval=1000 配置管理器对象休眠时间</p>
							<p><span class="seri-num">3. </span>通过manager.register(dcl)注册监听器并重写相关的回调方法，可选的监听器有DataChangedListener、DataCreatedListener、DataDeletedListener三种。在回调方法里可以完成自定义的业务逻辑：如重新获取配置内容等,特别强调一点：只有在event.isFired()返回true时，才表明事件被触发</p>
							<p><span class="seri-num">4. </span>启动配置管理器线程并保持监听配置情况，根据注册的监听器监听特定的事件发生：manager.start();</p>
							<p><span class="seri-num">5. </span>调用manager.forData("配置订阅键","分组名")来获取当前最新的配置内容</p>
							<p>以下附上一个完整订阅API使用示例 <b>Main.java</b>，代码如下：</p>
<pre>
import java.io.IOException;

import org.qingtian.autodata.api.event.DataChangedEvent;
import org.qingtian.autodata.api.listener.DataChangedListener;

public class Main {
	public static void main(String[] args) {
		DefaultAutoDataManager manager = new DefaultAutoDataManager();
		try {
			manager.config("autodata.properties");
		} catch (IOException e) {
			e.printStackTrace();
		}
		DataChangedListener dcl=new DataChangedListener(){

			@Override
			public void processDataChanged(DataChangedEvent event) {
				System.out.println("变更事件 ："+event);
				if(event.isFired()){
					String newData=event.getManager().forData(event.getPath());
					System.out.println("最新数据："+newData);
				}
				else{
					System.out.println("未监听到数据变更...");
				}
			}
		};
		//注册
		System.out.println("注册数据变更监听器");
		manager.register(dcl); 
		try {
			manager.start();
			String data = new String(manager.forData("org.qingtian.test3",
					"DEFAULT"));
			System.out.println("首次获得数据："+data);
			// 1分钟后关掉配置监听器
			Thread.sleep(60000);
			System.out.println("注销数据变更监听器");
			manager.unregister(dcl);
			Thread.sleep(30000);
			System.out.println("监听数据线程关闭");
			manager.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
</pre>
							<p><b>autodata.properties</b>属性文件内容如下：</p>
							<p style="padding-left:25px;">autodata.ip=127.0.0.1</p>
							<p style="padding-left:25px;">autodata.port=2181</p>
							<p style="padding-left:25px;">autodata.timeout=50000</p>
							<p style="padding-left:25px;">autodata.interval=1000</p>
						</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
</div>
<script language="javascript">
$(function(){
	$('.q-item-bar').click(function(){
		var target=$(this).attr('id');
		$(this).attr('href','base/help.jsp#question-'+target);
	});
});
</script>
</body>
</html>