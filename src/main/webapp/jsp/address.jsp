<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/addstyle.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
<title>地址管理</title>
<script type="text/javascript">
	$(function() {
		getadd();
	});
	function getadd() {
		var param = "<%=request.getContextPath()%>/address/show.do";
		$.ajax({
			url : param,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				showadderss(data);
			}
		});
	}
	function showadderss(data) {
		var len = data.rows.length;
		var rows = data.rows;
		var s = "";
		var prices = 0;
		for (var i = 0; i < len; i++) {
			var row = rows[i];
			var s1 = '<li class="user-addresslist"><input type="radio" hidden id="addressId'+row.id+'" value="'+row.id+'" name="addressId">';
			var s2 = '<span class="new-txt">收件人:&nbsp;' + row.userName
					+ '<br></span><span class="new-txt-rd2">159****1622</span>';
			var s3 = '<div class="new-mu_l2a new-p-re"><p class="new-mu_l2cw"><span class="title">地址：</span>';
			var s4 = '<span class="province">' + row.userShengname
					+ '</span><span class="city">' + row.userShiname
					+ '</span><span class="dist">' + row.userQuname + '</span>';
			var s5 = '<br><span class="street">' + row.userAddress
					+ '</span></p></div>';
			var s6 = '<div class="new-addr-btn"><a href="<%=request.getContextPath()%>/address/toupdate.do?id='
					+ row.id
					+ '"><i class="am-icon-edit"></i>编辑</a><span class="new-addr-bar">|</span><a href="<%=request.getContextPath()%>/address/delete.do?id='
					+ row.id
					+ '"><i class="am-icon-trash"></i>删除</a></div></li>';
			s += s1 + s2 + s3 + s4 + s5 + s6;
		}
		$("#address").html(s);
	}
</script>
</head>
<body>
	<%@ include file="home_top.jsp"%>
	<b class="line"></b>
	<div class="banner">
		<div class="col-main">
			<div class="main-wrap">
				<!--标题 -->
				<div class="am-cf am-padding">
					<div class="am-fl am-cf">
						<strong class="am-text-danger am-text-lg">地址管理</strong>
					</div>
				</div>
				<!--标题 -->
				<div class="user-address">
					<hr />
					<ul class="am-avg-sm-1 am-avg-md-3 am-thumbnails" id="address"></ul>
				</div>
				<div class="add-dress">
					<!--标题 -->
					<div class="am-cf am-padding" style="width: 30%;">
						<div class="am-fl am-cf">
							<a href="<%=request.getContextPath()%>/jsp/address_update.jsp">
								<strong class="am-text-danger am-text-lg" style="font-size: 30px;">新增地址</strong>
							</a>
							<p>最多有三个收货地址</p>
						</div>
					</div>
					<hr />
				</div>
			</div>
			<%@ include file="home_down.jsp"%></div>
		<%@ include file="meau.jsp"%>
	</div>
</body>
</html>