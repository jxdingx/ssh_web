<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页</title>
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/systyle.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
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
		var param = "<%=request.getContextPath()%>/order/userorder.do";
		$.ajax({
			url : param,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				show(data);
			}
		});
	}
	function show(data) {
		var len1 = data.code.length;
		var len2 = data.rows.length;
		var codes = data.code;
		var rows = data.rows;
		var s = "";
		for (var i = 0; i < len1; i++) {
			var ss1 = '<div style="border:3px solid  #eeeeee"><div class="order-status5" ><div class="order-title"><div class="dd-num">订单编号：<span>'
				+ codes[i].orderCode
				+ '</span></div><span>成交时间：'
				+ codes[i].createTime + '</span><div class="am-btn am-btn-danger anniu" style="float: right;" onclick="deleteit('+codes[i].id+')">删除订单</div></div>';
			var ss2=""
			for (var j = 0; j < len2; j++) {
				if(codes[i].orderCode==rows[j].orderCode){
				    var s1='<div class="order-content"><div class="order-left"><ul class="item-list"><li class="td td-item"><div><a href="/st_web/show/introduction.do?id='+ rows[j].comId+'"><img src="'+rows[j].com.urla+'" style="width: 70px; height: 70px; float: left;"></a></div>';
				    var s2 = '<div class="item-info"><div class="item-basic-info"><p>'+rows[j].com.comName+'</p></div></div></li><li class="td td-price"><div class="item-price">x'+rows[j].comNum+'</div></li>';
				    var s3 = '<li class="td td-number"><div class="item-number"><span>￥'+rows[j].comPrice.toFixed(2)+'</span>'
						+ '</div></li><li class="td td-operation"><span>'+rows[j].name+'</span></li><div style="float: right;margin-right: 100px;"><br><a href="/st_web/order/showmes.do?id='+rows[j].id+'&addressId='+codes[i].addressId+'" style="margin-right: 50px;">查看详情</a>';
				    var s4 = '</div></ul></div></div></div>';
				    ss2+=s1+s2+s3+s4;
				}
			}
			s+=ss1+ss2+"</div></div></div><br>";
		}
		$("#order").html(s);
	}
	function deleteit(id) {
		var r=confirm("确认删除该订单？")
		  if (r==false)
		    {
		    return;
		    }
		var param = "<%=request.getContextPath()%>/order/deleteit.do";
		$.ajax({
			url : param,
			type : "POST",
			data : "id=" + id,
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				getData();
			}
		});
	}
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
					$("#user").text($("#newname").val());
					editName();
				}
			}
		});
	}
</script>
<body>
	<%@ include file="home_top.jsp"%><div class="banner">
		<div class="banner">
			<div class="col-main">
				<div class="main-wrap">
					<div class="wrap-left">
						<div class="wrap-list">
							<div class="m-user">
								<!--个人信息 -->
								<div class="m-bg"></div>
								<div class="m-userinfo" style="height: 117px;">
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
											<a href="#">
												<i class="am-icon-bell-o"></i>
												消息
											</a>
										</div>

									</div>
								</div>

								<!--个人资产-->
								<div class="m-userproperty">
									<div class="s-bar">
										<i class="s-icon"></i>
										个人资产
									</div>
									<p class="m-big">
										<a href="<%=request.getContextPath()%>/jsp/address.jsp">
											<i>
												<img src="../images/72h.png" />
											</i>
											<span class="m-title">我的收货地址</span>
										</a>
									</p>
									<p class="m-bonus">
										<a href="#">
											<i>
												<img src="../images/bonus.png" />
											</i>
											<span class="m-title">红包</span>
											<em class="m-num">2</em>
										</a>
									</p>
									<p class="m-coupon">
										<a href="#">
											<i>
												<img src="../images/coupon.png" />
											</i>
											<span class="m-title">优惠券</span>
											<em class="m-num">2</em>
										</a>
									</p>
									<p class="m-bill">
										<a href="#">
											<i>
												<img src="../images/wallet.png" />
											</i>
											<span class="m-title">钱包</span>
											<em class="m-num">2</em>
										</a>
									</p>
									<p class="m-big">
										<a href="#">
											<i>
												<img src="../images/day-to.png" />
											</i>
											<span class="m-title">签到有礼</span>
										</a>
									</p>
								</div>
							</div>
							<!--订单 -->
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
												<td class="td-inner">订单</td>
											</div>
											<div class="th th-number">
												<td class="td-inner"><span style="margin-left: 21px;">数量</span></td>
											</div>
											<div class="th th-price">
												<td class="td-inner"><span style="margin-left: 60px;">合计</span></td>
											</div>
											<div class="th th-amount">
												<td class="td-inner"><span style="margin-left: 40px;">收货人</span></td>
											</div>
										</div>
										<div class="order-main">
											<div class="order-list" id="order">
											</div>
										</div>
										<br>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="wrap-right">
						<!-- 日历-->
						<div class="day-list">
							<div class="s-bar">
								<a class="i-history-trigger s-icon" href="#"></a>
								我的日历
								<a class="i-setting-trigger s-icon" href="#"></a>
							</div>
							<div class="s-care s-care-noweather">
								<div class="s-date">
									<em>21</em>
									<span>星期一</span>
									<span>2017.12</span>
								</div>
							</div>
						</div>
						<!--新品 -->
						<div class="new-goods">
							<div class="s-bar">
								<i class="s-icon"></i>
								今日新品
								<a class="i-load-more-item-shadow"></a>
							</div>
						</div>

						<!--热卖推荐 -->
						<div class="new-goods">
							<div class="s-bar">
								<i class="s-icon"></i>
								热卖推荐
							</div>
						</div>

					</div>
				</div>
				<!--底部-->
				<%@ include file="home_down.jsp"%>

			</div>
			<%@ include file="meau.jsp"%>
		</div>
		<!--引导 -->
	</div>
</body>

</html>