<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页</title>
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/systyle.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
</head>
<script type="text/javascript">
function editName() {
	$("#edit").prop("hidden",$("#edit").prop("hidden")?false:true);
	$("#ok").prop("hidden",$("#ok").prop("hidden")?false:true);
	$("#newname").prop("value",$("#userName").text());
}

function updateName() {
	var newname=$("#newname").val();
	if(newname==""){
		editName();
		return;
	}
	var param = "<%=request.getContextPath()%>/user/updateName.do";
		$.ajax({
			url : param,
			type : "POST",
			data : "newName=" + newname,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				if (data == "ok") {
					$("#userName").text($("#newname").val());
					editName();
				}

			}
		});
	}
</script>
<body>
	<%@ include file="admin_top.jsp"%>
	<div class="banner">
		<div class="banner">
			<div class="col-main">
				<div class="main-wrap">
					<div class="wrap-left">
						<div class="wrap-list">
							<div class="m-user">
								个人信息
								<div class="m-bg"></div>
								<div class="m-userinfo">
									<div class="m-baseinfo">
										<a>
											<img src="../images/getAvatar.do.jpg">
										</a>
										<div id="edit">
											<span id="userName">${user.name }</span>
											<br>
											<a onclick="editName()" style="margin-left: 0px;"> 修改昵称 </a>
										</div>
										<div id="ok" hidden="true">
											<input type="text" id="newname" style="width: 90px;">
											<br>
											<a onclick="updateName()" style="margin-left: 0px;"> 确认 </a>
										</div>
									</div>
									<div class="m-right">
										<div class="m-new">
											<a href="">
												<i class="am-icon-bell-o"></i>
												消息
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="box-container-bottom"></div>
							<!--订单 -->
							<div class="m-logistics">
								<div class="s-bar">
									<i class="s-icon"></i>
									功能介绍
								</div>
							</div>
					    	<span style="margin-left: 40%; font-size: 50px;">欢迎！</span>
						</div>
					</div>
					<div class="wrap-right"></div>
				</div>
			</div>
			<%@ include file="meau.jsp"%>
		</div>
	</div>
</body>
</html>