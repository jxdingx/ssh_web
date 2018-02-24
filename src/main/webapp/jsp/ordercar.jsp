<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/icon.css" />
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
</head>

<script type="text/javascript">
	$(function() {
		var userId = "${user.id }";
		if (userId == "") {
			alert("请先登陆");
			window.location.href = "<%=request.getContextPath()%>/jsp/login.jsp";
			return;
		}
		getData();
	});
	function getData() {
		var param = "<%=request.getContextPath()%>/car/show.do";
		$.ajax({
			url : param,
			type : "POST",
			data : "userId=" + "${user.id}",
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
			prices += row.sellPrice;
			var s1 = '<div class="order-status5"><div class="order-title"><div class="dd-num">订单编号：<span>'
					+ row.sellcomid
					+ '</span></div><span>添加时间：'
					+ row.createTime + '</span>';
			var s2 = '</div><div class="order-content"><div class="order-left"><input type="checkbox"  name="ck" checked style="zoom:150%;" value="'
					+ row.sellcomid
					+ '" /><ul class="item-list"><li class="td td-item"><div class="item-pic"><a href="<%=request.getContextPath()%>/search/show.do?comCode='
					+ row.comCode
					+ '" class="J_MakePoint"><img src="'+row.urla+'" class="itempic J_ItemImg"></a></div>';
			var s3 = '<div class="item-info"><div class="item-basic-info"><p>'
					+ row.comName
					+ '</p><p class="info-little">包装：裸装<br/>包邮</p></div></div></li><li class="td td-price"><div class="item-price">￥'
					+ row.comPrice.toFixed(2) + '</div></li>';
			var s4 = '<li class="td td-number"><div class="item-number"><span>×</span>'
					+ '</div></li><li class="td td-operation"><div class="item-operation"><input id="s'+i+'" required="required" value="11" style="width:100px;height:30px;"><div hidden><input id="ss'+i+'" value="'+row.sellcomid+'" /><input id="sellnum'+i+'"  value="'+row.sellnum+'"/><input id="comRepository'+i+'"  value="'+row.comRepository+'"/></div></div></li></ul></div><div class="order-right"><li class="td td-amount"><div class="item-amount">共  :<br>￥<span id="sss'+i+'">'
					+ row.sellPrice.toFixed(2) + ' </span>元</div></li>';
			var s5 = '<div class="move-right"><li class="td td-status"></li><li class="td td-change"><div class="am-btn am-btn-danger anniu" onclick="deleteit('
					+ row.sellcomid
					+ ')">删除订单</div></li></div></div></div></div>';
			s += s1 + s2 + s3 + s4 + s5;
		}
		if(len ==0){
			$("#accunt").hide();
			$("#order").html('<br><br><a href="<%=request.getContextPath()%>/jsp/home.jsp"><span style="font-size: 30px;margin-left: 20%" id="shopmess">购物车内暂时没有商品，赶快去购物吧!</span></a>');
			return;
		}
		$("#order").html(s);
		// 		$("#order").trigger("create");
		$("#prices").text(prices.toFixed(2));

		$(":checkbox").change(function() {
			checkbox();
		});
		for (var i = 0; i < len; i++) {
		      var maxnum =$("#comRepository" + i).val();
			$('#s' + i).numberspinner({
				min : 1,
				max : maxnum,
				value : $("#sellnum" + i).val(),
// 				editable : false,
				onChange : function() {
					if(parseInt($(this).val())>parseInt(maxnum)){
						$.messager.alert('提示', '购买数量超出限制!');
					 $(this).numberspinner("setValue",1);
					 return;
					}
					var cartid = $("#s" + $(this).prop("id")).val();
					numchange(cartid, $(this).val(), $(this).prop("id"))
				}
			});
		}

		// 		<input id="'+row.id+'" class="easyui-numberspinner" value='+row.sellnum+' style="width:80px;"required="required" data-options="min:1,max:'+row.comRepository+',editable:false">

	}
	function checkbox() {
		var str = "";
		$(":checkbox").each(function() {
			if ($(this).is(':checked')) {
				str += "," + $(this).val();
			}
		});
		$.ajax({
			url : "<%=request.getContextPath()%>/car/account.do",
			type : "POST",
			data : "str=" + str,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				$("#prices").text(data);
			}
		});
	}

	function numchange(cartid, num, id) {
		$.ajax({
			url : "<%=request.getContextPath()%>/car/numchange.do",
			type : "POST",
			data : "id=" + cartid + "&comNum=" + num,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				$("#ss" + id).text(data);
				checkbox();
			}
		});

	}
	function deleteit(cartid) {
		if (confirm("确认删除订单？")) {
		} else {
			return;
		}
		var param = "<%=request.getContextPath()%>/car/delete.do";
		$.ajax({
			url : param,
			type : "POST",
			data : "id=" + cartid,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				getData();
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
				<div class="user-order">
					<!--标题 -->
					<div class="am-cf am-padding">
						<div class="am-fl am-cf">
							<strong class="am-text-danger am-text-lg">购物车订单</strong>
						</div>
					</div>
					<hr />

					<div class="am-tabs am-tabs-d2 am-margin" data-am-tabs>

						<ul class="am-avg-sm-5 am-tabs-nav am-nav am-nav-tabs">
							<li class="am-active">
								<a href="#tab1">所有订单</a>
							</li>
						</ul>
						<div class="am-tabs-bd">
							<div class="am-tab-panel am-fade am-in am-active" id="tab1">
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
									<div class="th th-operation">
										<td class="td-inner">数量操作</td>
									</div>
									<div class="th th-amount">
										<td class="td-inner">合计</td>
									</div>
									<div class="th th-status">
										<td class="td-inner">交易操作</td>
									</div>
								</div>
								<form action="<%=request.getContextPath()%>/order/toorder.do" method="post">
									<div class="order-main">
										<div class="order-list" id="order">
										
										</div>
									</div>
									<br>
									<div style="background: #eeeeee; width: 100%; height: 47px;" id="accunt">
										<table style="margin-left: 70%; margin-top: 8px;">
											<tr>
												<td width="150px;">
													<div style="margin-top: 12px;">
														总共:&nbsp;&nbsp;￥
														<span id="prices" style="color: red;"></span>
														元
													</div>
												</td>
												<td>
													<input class="am-btn am-btn-danger anniu" style="width: 90px; margin-top: 1px;" type="submit" value="结算">
												</td>
											</tr>
										</table>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--底部-->
			<%@ include file="home_down.jsp"%>
		</div>
		<%@ include file="meau.jsp"%>
	</div>
</body>
</html>