<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单</title>
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/addstyle.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		getadd();
		getData();

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
			var s1 = '<li class="user-addresslist" onclick="checkaddress('
					+ row.id
					+ ')"><input type="radio" hidden id="addressId'+row.id+'" value="'+row.id+'" name="addressId"><span class="new-option-r"><i class="am-icon-check-circle"></i>选择地址</span>';
			var s2 = '<span class="new-txt">收件人:&nbsp;' + row.userName
					+ '<br></span><span class="new-txt-rd2">159****1622</span>';
			var s3 = '<div class="new-mu_l2a new-p-re"><p class="new-mu_l2cw"><span class="title">地址：</span>';
			var s4 = '<span class="province">' + row.userShengname
					+ '</span><span class="city">' + row.userShiname
					+ '</span><span class="dist">' + row.userQuname + '</span>';
			var s5 = '<br><span class="street">' + row.userAddress
					+ '</span></p></div></li>';
			s += s1 + s2 + s3 + s4 + s5;
		}
		$("#address").html(s);
	}
	function checkaddress(addressid) {
		var radio = $("#addressId" + addressid);
		radio.prop("checked", radio.is(":checked") ? false : true);
		$(":radio").each(function() {
			if ($(this).is(":checked")) {
				$(this).parent().css("background", "#DDDDDD");
			} else {
				$(this).parent().css("background", "white");
			}
		})
	}

	function getData() {
		var param = "<%=request.getContextPath()%>/order/show.do";
		$.ajax({
			url : param,
			type : "POST",
			data : "orderidlist=" + "${orderidlist}",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				show(data);
			}
		});
	}
	function show(data) {
		var len = data.rows.length;
		var rows = data.rows;
		var s = "";
		var prices = 0;
		for (var i = 0; i < len; i++) {
			var row = rows[i];
			var price = row.sellnum * row.comPrice;
			prices += price;
			var s1 = '<div class="order-status5"><div class="order-title"><div class="dd-num">订单编号：<span>'
					+ row.id
					+ '</span></div><span>成交时间：'
					+ row.updateTime
					+ '</span>';
			var s2 = '</div><div class="order-content"><div class="order-left"><ul class="item-list"><li class="td td-item"><div class="item-pic"><a href="#" class="J_MakePoint"><img src="'+row.urla+'" class="itempic J_ItemImg"></a></div>';
			var s3 = '<div class="item-info"><div class="item-basic-info"><p>'
					+ row.comDescr
					+ '</p><p class="info-little">包装：裸装<br/>包邮</p></div></div></li><li class="td td-price"><div class="item-price">￥'
					+ row.comPrice.toFixed(2) + '</div></li>';
			var s4 = '<li class="td td-number"><div class="item-number"><span>×</span>'
					+ row.sellnum
					+ '</div></li></div><div class="order-right"><li class="td td-amount"><div class="item-amount">共  :<br>￥'
					+ price + ' 元</div></li></div></div></div>';
			s += s1 + s2 + s3 + s4;
		}
		$("#order").html(s);
		$("#prices").text(prices.toFixed(2));
	}

	function pay() {
		var addressId = "";
		$(":radio").each(function() {
			if ($(this).is(":checked")) {
				addressId = $(this).val();
			}
		});
		if (addressId == "") {
			alert("请选择地址!");
			return;
		}
		$.ajax({
			url : "<%=request.getContextPath()%>/order/insert.do",
			type : "POST",
			data : "orderidlist=" + "${orderidlist}" + "&addressId="
					+ addressId,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				alert("支付成功!");
				window.location.href = "<%=request.getContextPath()%>/jsp/user.jsp";
			}
		});
	}
</script>
<body>
	<%@ include file="home_top.jsp"%>
	<b class="line"></b>
	<div class="banner">
		<div class="col-main">
			<div class="main-wrap">
				<!--标题 -->
				<div class="am-cf am-padding">
					<div class="am-fl am-cf">
						<strong class="am-text-danger am-text-lg">订单支付</strong>
					</div>
				</div>
				<div class="user-address">
					<!--标题 -->
					<hr />
					<ul class="am-avg-sm-1 am-avg-md-3 am-thumbnails" id="address"></ul>
			<a href="<%=request.getContextPath()%>/jsp/address.jsp"><span style="font-size: 20px;">地址管理</span>	</a></div>
				<div class="order-infomain">
					<div class="order-top">
						<div class="th th-item">
							<td class="td-inner">商品</td>
						</div>
						<div class="th th-price">
							<td class="td-inner">单价</td>
						</div>
						<div class="th th-number">
							<td class="td-inner">数量</td>
						</div>
					</div>
					<div class="order-main">
						<div class="order-status3" id="order"></div>
					</div>
					<br>
							<div style="background: #eeeeee; width: 100%; height: 47px;">
										<table style="margin-left: 70%;margin-top: 8px;">
										<tr >
										<td width="150px;">
										<div style="margin-top: 12px;">
											总共:&nbsp;&nbsp;￥
											<span id="prices" style="color: red;"></span>
											元
											</div>
											</td>
											<td>
											<input class="am-btn am-btn-danger anniu" style="width: 90px;margin-top: 1px;" onclick="pay()"  value="付款">
										</td></tr>
										</table>
									</div>
				</div>
			</div>
			<%@ include file="home_down.jsp"%></div>
		<%@ include file="meau.jsp"%>
	</div>
</body>
</html>