<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情页</title>
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/addstyle.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
</head><script type="text/javascript">
$(function() {
	getadd();
	getData();
});
function getadd() {
	var param = "<%=request.getContextPath()%>/address/show.do?id="+"${addressId}";
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
	for (var i = 0; i < len; i++) {
		var row = rows[i];
		var s1 = '<div class="icon-add"></div><p ><span class="new-txt">收货人:'+row.userName+'</span><br><br><span class="new-txt-rd2">电话:159****1622</span></p>';
		var s2 = '<br><div class="new-mu_l2a new-p-re"><p><span class="title">收货地址：</span>';
		var s3 = '<span class="province">' + row.userShengname
				+ '</span><span class="city">' + row.userShiname
				+ '</span><span class="dist">' + row.userQuname + '</span>';
		var s4 = '<br><span class="street">' + row.userAddress
				+ '</span></p></div>';
		s += s1 + s2 + s3 + s4 ;
	}
	$("#address").html(s);
}
function getData() {
	var param = "<%=request.getContextPath()%>/search/bycomId.do?comId="+"${ordermes.comId}";
	$.ajax({
		url : param,
		type : "POST",
		dataType : "json",
		contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
		success : function(data) {
			$("#comName").text(data.com.comName);
			$("#comPrice").text(data.com.comPrice);
			$("#urla").prop("src",data.com.urla);
			$("#comintro").prop("href",'<%=request.getContextPath()%>/search/show.do?comCode='+data.com.comCode);
		}
	});
}

</script>
<body><%@ include file="home_top.jsp"%>
	<div class="banner">
			<div class="col-main">
				<div class="main-wrap">
					<div class="user-orderinfo">
						<!--标题 -->
						<div class="am-cf am-padding">
							<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">订单详情</strong></div>
						</div>
						<hr/>
						<!--进度条-->
						<div class="m-progress">
							<div class="m-progress-list">
								<span class="step-1 step">
                                   <em class="u-progress-stage-bg"></em>
                                   <i class="u-stage-icon-inner">1<em class="bg"></em></i>
                                   <p class="stage-name">拍下商品</p>
                                </span>
								<span class="step-2 step">
                                   <em class="u-progress-stage-bg"></em>
                                   <i class="u-stage-icon-inner">2<em class="bg"></em></i>
                                   <p class="stage-name">卖家发货</p>
                                </span>
								<span class="step-3 step">
                                   <em class="u-progress-stage-bg"></em>
                                   <i class="u-stage-icon-inner">3<em class="bg"></em></i>
                                   <p class="stage-name">确认收货</p>
                                </span>
								<span class="step-4 step">
                                   <em class="u-progress-stage-bg"></em>
                                   <i class="u-stage-icon-inner">4<em class="bg"></em></i>
                                   <p class="stage-name">交易完成</p>
                                </span>
								<span class="u-progress-placeholder"></span>
							</div>
							<div class="u-progress-bar total-steps-2">
								<div class="u-progress-bar-inner"></div>
							</div>
						</div>
						<div class="order-infoaside">
							<div class="order-logistics">
									<div class="icon-log">
										<i><img src="../images/receive.png"></i>
									</div>
									<div class="latest-logistics">
										<p class="text">已签收,签收人是青年城签收，感谢使用天天快递，期待再次为您服务</p>
										<div class="time-list">
											<span class="date">2020-12-19</span><span class="week">周六</span><span class="time">15:35:42</span>
										</div>
										<div class="inquire">
											<span class="package-detail">物流：天天快递</span>
											<span class="package-detail">快递单号: </span>
											<span class="package-number">373269427868</span>
											<a href="logistics.html">查看</a>
										</div>
									</div>
									<span class="am-icon-angle-right icon"></span>
								<div class="clear"></div>
							</div>
							<div class="order-addresslist">
								<div class="order-address" id="address">
								</div>
							</div>
						</div>
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
								<div class="th th-operation">
									<td class="td-inner">商品操作</td>
								</div>
								<div class="th th-amount">
									<td class="td-inner">合计</td>
								</div>
								<div class="th th-status">
									<td class="td-inner">交易状态</td>
								</div>
								<div class="th th-change">
									<td class="td-inner">交易操作</td>
								</div>
							</div>

							<div class="order-main">

								<div class="order-status3">
									<div class="order-title">
										<div class="dd-num">订单编号:${ordermes.orderCode}</div>
										<span>成交时间:${ordermes.createTime}</span>
									</div>
									<div class="order-content">
										<div class="order-left">
											<ul class="item-list">
												<li class="td td-item">
													<div class="item-pic">
														<a id="comintro"  class="J_MakePoint">
															<img src="" id="urla" class="itempic J_ItemImg">
														</a>
													</div>
													<div class="item-info">
														<div class="item-basic-info">
													
																<p id="comName"></p>
																<p class="info-little">
																	<br/>包装：裸装 </p>
															
														</div>
													</div>
												</li>
												<li class="td td-price">
													<div class="item-price" >
														<p id="comPrice"></p>
													</div>
												</li>
												<li class="td td-number">
													<div class="item-number">
														<span>×</span>${ordermes.comNum}
													</div>
												</li>
												<li class="td td-operation">
													<div class="item-operation">
														退款/退货
													</div>
												</li>
											</ul>
										</div>
										<div class="order-right">
											<li class="td td-amount">
												<div class="item-status">
													合计：￥${ordermes.comPrice}
													<p>含运费</p>
												</div>
											</li>
											<div class="move-right">
												<li class="td td-status">
													<div class="item-status">
														<p class="Mystatus">已支付</p>
													</div>
												</li>
												<li class="td td-change">
													<div class="am-btn am-btn-danger anniu">
														确认收货</div>
												</li>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
				<%@ include file="home_down.jsp"%></div>
		<%@ include file="meau.jsp"%>
		</div>
</body>
</html>