<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		if ($("#user").text() != "") {
			$("#login").hide();
			$("#login1").hide();
			$("#exit").show();
		}
		carshownum();

	});
	function carshownum() {
		var userId = "${user.id }";
		if (userId != "") {
			$
					.ajax({
						url : "<%=request.getContextPath()%>/car/shownum.do",
						data : "userId=" + userId,
						type : "POST",
						dataType : "text",
						contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
						success : function(data) {
							$("#cartnum").text(data);
							$("#cartnum1").text(data);
						}
					});
		}
	}

	function tosearch() {
		$.ajax({
			url : '<%=request.getContextPath()%>' + "/search/tosearch.do",
			type : "POST",
			data : "comName=" + $("#searchInput").val(),
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				window.location.href = "<%=request.getContextPath()%>/jsp/search.jsp";
			}
		});
	}
</script>

<div class="hmtop">
	<!--顶部导航条 -->
	<div class="am-container header">
		<ul class="message-l">
			<div class="topMessage">
				<span id="user" style="font-size: 20px;">${user.name }</span>
				<div class="menu-hd" id="login">
					<a href="<%=request.getContextPath()%>/jsp/login.jsp" class="h">亲，请登录</a>
					/
					<a href="<%=request.getContextPath()%>/jsp/register.jsp">免费注册</a>
				</div>
				<a href="<%=request.getContextPath()%>/user/exit.do" class="h" id="exit" hidden="true">退出账号</a>
			</div>
		</ul>
		<ul class="message-r">
			<div class="topMessage home">
				<div class="menu-hd">
					<a href="<%=request.getContextPath()%>/jsp/home.jsp" target="_top" class="h">商城首页</a>
				</div>
			</div>
			<div class="topMessage my-shangcheng">
				<div class="menu-hd MyShangcheng">
					<a href="<%=request.getContextPath()%>/jsp/user.jsp" target="_top">
						<i class="am-icon-user am-icon-fw"></i>
						个人中心
					</a>
				</div>
			</div>
			<div class="topMessage mini-cart">
				<div class="menu-hd">
					<a id="mc-menu-hd" href="<%=request.getContextPath()%>/jsp/ordercar.jsp" target="_top">
						<i class="am-icon-shopping-cart  am-icon-fw"></i>
						<span>购物车</span>
						<span style="color: red; font-size: 18px;" id="cartnum"></span>
					</a>
				</div>
			</div>
		</ul>
	</div>

	<!--悬浮搜索框-->

	<div class="nav white">
		<div class="logoBig">
			<ul>
				<li>
					<a href="<%=request.getContextPath()%>/jsp/home.jsp">
						<img src="<%=request.getContextPath()%>/images/logobig.png" />
					</a>
				</li>
			</ul>
		</div>
		<div class="search-bar pr">
			<form>
				<input id="searchInput" name="index_none_header_sysc" type="text" placeholder="搜索" autocomplete="off">
				<input id="ai-topsearch" class="submit am-btn" value="搜索" index="1" type="submit" onclick="tosearch()">
			</form>
		</div>
	</div>
	<div class="clear"></div>
</div>
