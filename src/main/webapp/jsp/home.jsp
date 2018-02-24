<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商城</title>
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/demo.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/hmstyle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/skin.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
</head>
<script type="text/javascript">
    // 页面加载数据
	$(function() {
		<!--侧边导航 -->
		getData();
		getData1();
		getData2();		
	});
    
	
	function getData() {
	var param = "<%=request.getContextPath()%>/com_cla/cla.do";
		$.ajax({
			url : param,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				oneCla(data);
			}
		});
	}

	
// 	侧边导航 
	function oneCla(data) {
		var len = data.rows.length;
		var rows = data.rows;
		for (var i = 0; i < len; i++) {
			var row = rows[i];
			var code = row.code;
			var parCode = row.parCode;
			if (parCode == "0") {
				guide(data, row, code);
			}
		}
	}

	function guide(data, row, code) {
		var rows = data.rows;
		var len = data.rows.length;
		var ss = "";
		for (var i = 0; i < len; i++) {
			var row2 = rows[i];
			var parCode = row2.parCode;
			var code2 = row2.code;
			var title2 = row2.claName;
			if (parCode == code) {
				ss += "<dd><a href='<%=request.getContextPath()%>/search/tocomCla.do?comClassifyId="+row2.id+"'><span>" + title2
						+ "</span></a></dd>"
			}
		}
		var title = row.claName;
		var s1 = '<li id="'+code+'"class="appliance js_toggle relative"> <div class="category-info"> <h3 class="category-name b-category-name">';

		var s2 = " <a class='ml-22' title='"+code+"'>" + title + "</a> ";

		var s3 = " </h3> <em>&gt;</em> </div> <div class='menu-item menu-in top'> <div class='area-in'> <div class='area-bg'> <div class='menu-srot'> <div class='sort-side'> <dl class='dl-sort'> "

		var s4 = "<dd> <a title='' href='#'> <span>" + title
				+ "</span> </a> </dd>";

		var s5 = "</dl> </div> <div class='brand-side'> <dl class='dl-sort'>"
				+ ss + "</dl>"

		var s6 = "</div> </div> </div> </div> </div> <b class='arrow'></b></li><br>";

		var s = s1 + s2 + s3 + s4 + s5 + s6;
		$("#js_climit_li").append(s);
		$("li").hover(
				function() {
					$(".category-content .category-list li.first .menu-in")
							.css("display", "none");
					$(".category-content .category-list li.first").removeClass(
							"hover");
					$(this).addClass("hover");
					$(this).children("div.menu-in").css("display", "block")
				}, function() {
					$(this).removeClass("hover")
					$(this).children("div.menu-in").css("display", "none")
				});
		$("#js_climit_li").trigger("create");
	}
	
// 	今日推荐 
	function getData1() {
	  var param= "<%=request.getContextPath()%>/show/today.do";
		$.ajax({
			url : param,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				today(data);
			}
		});
	}
	function today(data) {
		var len = data.rows.length;
		var rows = data.rows;
		for (var i = 0; i < len; i++) {
		var row = rows[i];
		$("#today").children().eq(i+1).children().eq(0).children().eq(0).text(row.comName);
		$("#today").children().eq(i+1).children().eq(1).children().eq(0).prop("href","<%=request.getContextPath()%>/show/introduction.do?comCode="+row.comCode);
		$("#today").children().eq(i+1).children().eq(1).children().eq(0).children().prop("src",row.urla);
		}
	}
		
  // 	页面展示分类
	function getData2() {
			$.ajax({
				url : "<%=request.getContextPath()%>/show/comshow.do",
				type : "POST",
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
		for (var i = 0; i < len; i++) {
			var row=rows[i]
	       $("#com"+i).children().eq(0).children().eq(0).text(row.comName);
	       $("#com"+i).children().eq(1).prop("href","<%=request.getContextPath()%>/show/introduction.do?comCode="+row.comCode);
	       $("#com"+i).children().eq(1).children().eq(0).prop("src",row.urla);
		} 
}
</script>
<body>

	<%@ include file="home_top.jsp"%><div class="banner">
		<!--轮播 -->
		<div class="am-slider am-slider-default scoll" data-am-flexslider id="demo-slider-0">
			<ul class="am-slides">
				<li class="banner1">
					<a href="<%=request.getContextPath()%>/search/show.do?comCode=6001">
						<img src="<%=request.getContextPath()%>/images/ad1.jpg" style="width: 78%" />
					</a>
				</li>
				<li class="banner2">
					<a href="<%=request.getContextPath()%>/search/show.do?comCode=5001">
						<img src="<%=request.getContextPath()%>/images/ad2.jpg" style="width: 78%" />
					</a>
				</li>
				<li class="banner2">
					<a href="<%=request.getContextPath()%>/search/show.do?comCode=6005">
						<img src="<%=request.getContextPath()%>/images/ad3.jpg" style="width: 78%" />
					</a>
				</li>
			</ul>
		</div>
		<div class="clear"></div>
	</div>
	<div class="shopNav">
		<div class="slideall">
			<div class="long-title">
				<span class="all-goods">全部分类</span>
			</div>
			<div class="nav-cont">
				<ul>
					<li class="index">
						<span style="font-size: 20px;">热卖商品 : </span>
					</li>
					<li class="qc">
						<a href="<%=request.getContextPath()%>/search/tocomCla.do?comClassifyId=23">蛋糕</a>
					</li>
					<li class="qc">
						<a href="<%=request.getContextPath()%>/search/tocomCla.do?comClassifyId=25">巧克力</a>
					</li>
					<li class="qc">
						<a href="<%=request.getContextPath()%>/search/tocomCla.do?comClassifyId=24">坚果</a>
					</li>
				</ul>
			</div>

			<!--侧边导航 -->
			<div id="nav" class="navfull">
				<div class="area clearfix">
					<div class="category-content" id="guide_2">

						<div class="category">
							<ul class="category-list" id="js_climit_li">
							</ul>
						</div>
					</div>

				</div>
			</div>

			<!--走马灯 -->
			<div class="marqueen">
				<span class="marqueen-title">&nbsp;&nbsp;惊爆全场&nbsp;&nbsp;!</span>
				<div class="demo">
					<ul>
						<li class="title-first">
							<a target="_blank" href="#">
								<img src="<%=request.getContextPath()%>/images/tj2.png"></img>
								<span>[特惠]</span>
								商城爆品1分秒
							</a>
						</li>
						<li class="title-first">
							<a target="_blank" href="#">
								<span>[折扣]</span>
								清仓大甩卖，全场五折！
								<img src="<%=request.getContextPath()%>/images/tj.png"></img>
								<p>XXXXXXXXXXXXXXXXXX</p>
							</a>
						</li>

						<div class="mod-vip">
							<div class="m-baseinfo">
								<a href="<%=request.getContextPath()%>/jsp/user.jsp">
									<img src="<%=request.getContextPath()%>/images/getAvatar.do.jpg">
								</a>
								<em>
									<a href="<%=request.getContextPath()%>/jsp/user.jsp">
										Hi,
										<span class="s-name">用户：${user.name }</span>
									</a>
								</em>
							</div>
							<div class="member-logout" id="login1">
								<a class="am-btn-warning btn" href="<%=request.getContextPath()%>/jsp/login.jsp">登录</a>
								<a class="am-btn-warning btn" href="<%=request.getContextPath()%>/jsp/register.jsp">注册</a>
							</div>
							<div class="clear"></div>
						</div>

						<li>
							<a target="_blank" href="#">
								<span>[折扣]</span>
								只要你想买，我们就敢卖！
							</a>
						</li>
						<li>
							<a target="_blank" href="#">
								<span>[公告]</span>
								衣服·鞋限量销售
							</a>
						</li>
						<li>
							<a target="_blank" href="#">
								<span>[特惠]</span>
								家电狂欢千亿礼券 买1送1！
							</a>
						</li>

					</ul>
					<div class="advTip">
						<img src="<%=request.getContextPath()%>/images/advTip.jpg" />
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<!--菜单 -->
	<div class=tip>
		<div id="sidebar">
			<div id="wrap">
				<div id="prof" class="item ">
					<a href="<%=request.getContextPath()%>/jsp/user.jsp">
						<span class="setting "></span>
					</a>

				</div>
				<a href="<%=request.getContextPath()%>/jsp/ordercar.jsp">
				<div id="shopCart " class="item ">
					<p style="color: white;">购物车</p>
					<p class="cart_num" id="cartnum1"></p>
				</div>
					</a>
				<div id="asset " class="item ">
					<a href="# ">
						<span class="view "></span>
					</a>
					<div class="mp_tooltip ">
						我的资产
						<i class="icon_arrow_right_black "></i>
					</div>
				</div>

				<div id="foot " class="item ">
					<a href="# ">
						<span class="zuji "></span>
					</a>
					<div class="mp_tooltip ">
						我的足迹
						<i class="icon_arrow_right_black "></i>
					</div>
				</div>

				<div id="brand " class="item ">
					<a href="#">
						<span class="wdsc ">
							<img src="../images/wdsc.png " />
						</span>
					</a>
					<div class="mp_tooltip ">
						我的收藏
						<i class="icon_arrow_right_black "></i>
					</div>
				</div>

				<div id="broadcast " class="item ">
					<a href="# ">
						<span class="chongzhi ">
							<img src="../images/chongzhi.png " />
						</span>
					</a>
					<div class="mp_tooltip ">
						我要充值
						<i class="icon_arrow_right_black "></i>
					</div>
				</div>

				<div class="quick_toggle ">
					<li class="qtitem ">
						<a href="# ">
							<span class="kfzx "></span>
						</a>
						<div class="mp_tooltip ">
							客服中心
							<i class="icon_arrow_right_black "></i>
						</div>
					</li>
					<li class="qtitem ">
						<a href="#top " class="return_top ">
							<span class="top "></span>
						</a>
					</li>
				</div>

				<!--回到顶部 -->
				<div id="quick_links_pop " class="quick_links_pop hide "></div>

			</div>

		</div>
		<div id="prof-content " class="nav-content ">
		<a href="/st_web/jsp/user.jsp">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>我</div>
			</a>
		</div>
		<div id="shopCart-content " class="nav-content ">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>购物车</div>
		</div>
		<div id="asset-content " class="nav-content ">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>资产</div>

			<div class="ia-head-list ">
				<a href="# " target="_blank " class="pl ">
					<div class="num ">0</div>
					<div class="text ">优惠券</div>
				</a>
				<a href="# " target="_blank " class="pl ">
					<div class="num ">0</div>
					<div class="text ">红包</div>
				</a>
				<a href="# " target="_blank " class="pl money ">
					<div class="num ">￥0</div>
					<div class="text ">余额</div>
				</a>
			</div>

		</div>
		<div id="foot-content " class="nav-content ">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>足迹</div>
		</div>
		<div id="brand-content " class="nav-content ">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>收藏</div>
		</div>
		<div id="broadcast-content " class="nav-content ">
			<div class="nav-con-close ">
				<i class="am-icon-angle-right am-icon-fw "></i>
			</div>
			<div>充值</div>
		</div>
	</div>


	<!-- 	商品展览 -->

	<div class="shopMainbg">
		<div class="shopMain" id="shopmain">

			<!--今日推荐 -->

			<div class="am-g am-g-fixed recommendation" id="today">
				<div class="clock am-u-sm-3"">
					<img src="../images/2016.png "></img>
					<p>
						今日
						<br>
						推荐
					</p>
				</div>

				<div class="am-u-sm-4 am-u-lg-3">
					<div class="info ">
						<h3></h3>

					</div>
					<div class="recommendationMain one">
						<a href="">
							<img></img>
						</a>
					</div>
				</div>
				<div class="am-u-sm-4 am-u-lg-3">
					<div class="info ">
						<h3></h3>
					</div>
					<div class="recommendationMain two">
						<a>
							<img></img>
						</a>
					</div>
				</div>
				<div class="am-u-sm-4 am-u-lg-3 ">
					<div class="info ">
						<h3></h3>

					</div>
					<div class="recommendationMain three">
						<a>
							<img></img>
						</a>
					</div>
				</div>

			</div>
			<div class="clear "></div>


			<div id="f1">
				<!--甜点-->
				<div class="am-container ">
					<div class="shopTitle ">
						<h4>商品展览</h4>
						<span class="more ">
							<a href="<%=request.getContextPath()%>/jsp/search.jsp">
								更多
								<i class="am-icon-angle-right" style="padding-left: 10px;"></i>
							</a>
						</span>
					</div>
				</div>

				<div class="am-g am-g-fixed floodFour">
					<div class="am-u-sm-5 am-u-md-4 text-one list ">
						<div class="word">
							<a class="outer" href="#">
								<span class="inner">
									<b class="text">推荐商品</b>
								</span>
							</a>
						</div>
						<a href="# ">
							<div class="outer-con ">
								<div class="title ">开抢啦！</div>
							</div>
							<img src="../images/act1.png " />
						</a>
						<div class="triangle-topright"></div>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two sug" id="com0">
						<div class="outer-con ">
							<div class="title"></div>
							<div class="sub-title"></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="# ">
							<img />
						</a>
					</div>

					<div class="am-u-sm-7 am-u-md-4 text-two" id="com1">
						<div class="outer-con ">
							<div class="title"></div>
							<div class="sub-title"></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="# ">
							<img />
						</a>
					</div>


					<div class="am-u-sm-3 am-u-md-2 text-three big" id="com2">
						<div class="outer-con ">
							<div class="title"></div>
							<div class="sub-title"></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="# ">
							<img />
						</a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three sug" id="com3">
						<div class="outer-con">
							<div class="title"></div>
							<div class="sub-title "></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="# ">
							<img />
						</a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three" id="com4">
						<div class="outer-con ">
							<div class="title "></div>
							<div class="sub-title "></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="# ">
							<img />
						</a>
					</div>

					<div class="am-u-sm-3 am-u-md-2 text-three last big" id="com5">
						<div class="outer-con">
							<div class="title"></div>
							<div class="sub-title"></div>
							<i class="am-icon-shopping-basket am-icon-md  seprate"></i>
						</div>
						<a href="#">
							<img />
						</a>
					</div>
					<div class="clear "></div>
				</div>
				<%@ include file="home_down.jsp"%>
			</div>
		</div>
	</div>
</body>
</html>