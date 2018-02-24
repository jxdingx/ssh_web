<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册页面</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/amazeui.css" />
<link href="<%=request.getContextPath()%>/css/dlstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/icon.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	function register() {
		$(':text').each(function() { //校验是否为空
			if ($(this).val() == "") {
				$("#err").text("不能为空");
				return;
			}
		});
		if ($("#userPass").val() == "") {
			$("#err").text("密码为空!");
			return;
		}
		if ($("#userPass").val() != $("#repass").val()) {// //校验两次密码是否一致
			$("#err").text("密码不一致");
			return;
		}
		active();
	}

	function active() {
		var param = "<%=request.getContextPath()%>/user/register.do"
		$.ajax({
			url : param,
			type : "post",
			data : $('#registerform').serialize(),
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			dataType : "text",
			success : function(data) {
				if (data == "err_code") {
					$("#err").text("验证码错误！");
				} else if (data == "ok") {
					alert("注册成功!");
					window.location.href = "<%=request.getContextPath()%>/jsp/login.jsp";
						} else {
							$("#err").text("账号已注册！");
						}
					}
				});
	}
</script>
</head>
<body>
	<div class="login-boxtitle">
		<a href="home.jsp">
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
				<h3 class="title">账号注册</h3>
				<div class="clear"></div>
				<div class="login-form">
					<form id="registerform">
						<div class="user-name">
							<label for="user">
								<i class="am-icon-user"></i>
							</label>
							<input type="text" name="userName" id="userName" placeholder="账号">
						</div>
							<div class="user-name">
							<label for="user">
								<i class="am-icon-user"></i>
							</label>
							<input type="text" name="name" id="name" placeholder="昵称">
						</div>
						<div class="user-pass">
							<label for="password">
								<i class="am-icon-lock"></i>
							</label>
							<input type="password" name="userPass" id="userPass" placeholder="设置密码">
						</div>
						<div class="user-pass">
							<label for="passwordRepeat">
								<i class="am-icon-lock"></i>
							</label>
							<input type="password" id="repass" placeholder="确认密码">
						</div>
						<br>
						<div>
							<img alt="" class="code" src="<%=request.getContextPath()%>/ImageServlet" onclick="this.src='<%=request.getContextPath()%>/ImageServlet?'+Math.random()" />
							<input type="text" name="code" style="vertical-align: middle; padding: 20px; width: 150px;" placeholder="验证码">
							<span id="err" style="color: red; width: 30px;"></span>
						</div>
				</div>
				<input type="radio" name="isuser" value="1" checked="checked">
				普通用户&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="isuser" value="0">
				卖家用户
				<br>
				</form>
				<div class="am-cf">
					<input onclick="register()" value="注册" class="am-btn am-btn-primary am-btn-sm am-fl">
				<a href="<%=request.getContextPath()%>/jsp/login.jsp" style="float: right; font-size: 15px;">账号登陆</a>
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