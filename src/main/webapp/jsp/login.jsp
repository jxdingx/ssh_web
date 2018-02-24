<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆页面</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/amazeui.css" />
<link href="<%=request.getContextPath()%>/css/dlstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/icon.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		$(":text").focusin(function() {
			$("#err").text("");
		});
	});
</script>
<script type="text/javascript">
	//校验数据是否为空
	function login() {
		if ($("#username").val() == "") {
			$("#err").text("请输入账号！");
			return;
		}
		if ($("#userpass").val() == "") {
			$("#err").text("请输入密码！");
			return;
		}
		if ($("#code").val() == "") {
			$("#err").text("输入验证码！");
			return;
		}
		active();
	}

	//AJAX提交数据至UserServlet
	function active() {
		var param = "<%=request.getContextPath()%>/user/login.do";
		$.ajax({
			url : param,
			type : "post",
			data : "userName=" + $("#username").val() + "&userPass="
					+ $("#userpass").val() + "&code=" + $("#code").val(),
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			dataType : "text",
			success : function(data) {
				if (data == "err_code") {
					$("#err").text("验证码错误！");
				} else if (data == "ok") {
					window.location.href = "<%=request.getContextPath()%>/jsp/home.jsp";
				} else if (data == "isseller") {
					window.location.href = "<%=request.getContextPath()%>/admin/admin.jsp";
				} else {
					$("#err").text("账号不存在！");
				}
			}
		});
	}
</script>

<body>
	<div class="login-boxtitle">
		<a href="<%=request.getContextPath()%>/jsp/home.jsp">
			<img alt="logo" src="<%=request.getContextPath()%>/images/logobig.png" />
		</a>
	</div>
	<div class="login-banner">
		<div class="login-main">
			<div class="login-banner-bg">
				<span></span>
				<img src="<%=request.getContextPath()%>/images/big.jpg" />
			</div>
			<div class="login-box">
				<h3 class="title">登录商城</h3>
				<div class="clear"></div>
				<div class="login-form">
					<form>
						<div class="user-name">
							<label for="user">
								<i class="am-icon-user"></i>
							</label>
							<input type="text" id="username" placeholder="账号">
						</div>
						<div class="user-pass">
							<label for="password">
								<i class="am-icon-lock"></i>
							</label>
							<input type="password" id="userpass" placeholder="请输入密码">
						</div>
						<br>
						<div>

							<img alt="" class="code" src="<%=request.getContextPath()%>/ImageServlet" onclick="this.src='<%=request.getContextPath()%>/ImageServlet?'+Math.random()" />
							<input type="text" id="code" style="vertical-align: middle; padding: 20px; width: 150px;" placeholder="验证码">
							<span id="err" style="color: red;"></span>
						</div>
					</form>
				</div>
				<div class="login-links"></div>
				<div class="am-cf">
					<input onclick="login()" value="登 录" class="am-btn am-btn-primary am-btn-sm" type="submit">
				</div>
				<br />
				<a href="<%=request.getContextPath()%>/jsp/register.jsp" style="float: right; font-size: 15px;">没有账号？点击注册</a>
				<div class="partner">
					<h3>合作账号</h3>
					<div class="am-btn-group">
						<li>
							<a href="#">
								<img alt="" class="icon" src="<%=request.getContextPath()%>/images/qq.png">
								<span class="icon_font">QQ登录</span>
							</a>
						</li>
						<li>
							<a href="#">
								<img alt="" class="icon" src="<%=request.getContextPath()%>/images/weibo.png">
								<span class="icon_font">微博登录</span>
							</a>
						</li>
						<li>
							<a href="#">
								<img alt="" class="icon" src="<%=request.getContextPath()%>/images/weixin.png">
								<span class="icon_font">微信登录</span>
							</a>
						</li>
					</div>
				</div>

			</div>
		</div>
	</div>
	<div class="footer ">
		<div class="footer-hd ">
			<p>
				<b>|</b>
				<a href="# ">商城首页</a>
				<b>|</b>
				<a href="# ">支付宝</a>
				<b>|</b>
				<a href="# ">物流</a>
			</p>
		</div>
		<div class="footer-bd ">
			<p>
				<a href="# ">合作伙伴</a>
				<a href="# ">联系我们</a>
				<a href="# ">网站地图</a>
			</p>
		</div>
	</div>

</body>
</html>