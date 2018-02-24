<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		
		
			var userId = "${user.id }";
			if (userId == "") {
				alert("请先登陆");
				window.location.href = "<%=request.getContextPath()%>/jsp/login.jsp";
				return;
			}

		if ($("#user").text() != "") {
			$("#login").hide();
			$("#login1").hide();
			$("#exit").show();
		}
// 		carshownum();

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
		<div class="logoBig">
			<a href="<%=request.getContextPath()%>/admin/admin.jsp">
				<img src="<%=request.getContextPath()%>/images/logobig.png" style="height: 100px; width: 200px;" />
			</a>
			<a href="<%=request.getContextPath()%>/user/exit.do" class="h" id="exit">退出账号</a>
		</div>
		<!-- 		<ul class="message-l"> -->
		<div class="topMessage"></div>
		<!-- 		</ul> -->
	</div>

	<!--悬浮搜索框-->

	<div class="nav white"></div>
	<div class="clear"></div>
</div>
