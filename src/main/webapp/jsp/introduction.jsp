<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情页面</title>
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/demo.css" rel="stylesheet" type="text/css" />
<link type="text/css" href="<%=request.getContextPath()%>/css/optstyle.css" rel="stylesheet" />
<link type="text/css" href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/quick_links.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.imagezoom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.flexslider.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/list.js"></script>
</head>
<script type="text/javascript">
	function add(sta) {
		var userId = "${user.id }";
		if (userId == "") {
			alert("请先登陆");
			window.location.href = "<%=request.getContextPath()%>/jsp/login.jsp";
			return;
		}
		var comNum = parseInt($("#text_box").val());
		var comId = "${com.id }";
		$.ajax({
			url : "<%=request.getContextPath()%>/" + sta + "/add.do",
			type : "POST",
			data : "comNum=" + comNum + "&comId=" + comId + "&userId=" + userId
					+ "&1",
			dataType : "text",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				if (data == "ok") {
					window.location.href = "<%=request.getContextPath()%>/jsp/order.jsp";
						} else {
							alert("添加成功！");
							carshownum();
						}
					}
				});
	}
	function changeimg(src) {
		$("#comPic").prop("src",src);
	}
</script>
<body>

	<%@ include file="home_top.jsp"%>
	<div class="listMain">
		<!--分类-->
		<div class="nav-table">
			<a href="<%=request.getContextPath()%>/jsp/home.jsp">
				<div class="long-title">
					<span class="all-goods">首页</span>
				</div>
			</a>
			<div class="nav-cont">
				<ul>
					<li class="index">
						<span style="font-size: 20px;">热卖商品 : </span>
					</li>
					<li class="qc">
						<a href="#">蛋糕</a>
					</li>
					<li class="qc">
						<a href="#">巧克力</a>
					</li>
					<li class="qc">
						<a href="#">坚果</a>
					</li>
					<li class="qc last">
						<a href="#">花茶</a>
					</li>
				</ul>
			</div>
		</div>
		<ol class="am-breadcrumb am-breadcrumb-slash">
			<li>
				<a href="<%=request.getContextPath()%>/jsp/home.jsp">首页</a>
			</li>
			<li>
				<a href="#">内容</a>
			</li>
		</ol>
		<!--放大镜-->
		<div class="item-inform">
			<div class="clearfixLeft" id="clearcontent">
				<div class="box">
					<script type="text/javascript">
								$(document).ready(function() {
									$(".jqzoom").imagezoom();
									$("#thumblist li a").click(function() {
										$(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
										$(".jqzoom").attr('src', $(this).find("img").attr("mid"));
										$(".jqzoom").attr('rel', $(this).find("img").attr("big"));
									});
								});
							</script>
					<div class="tb-booth tb-pic tb-s310">
						<a href="../images/01.jpg">
							<img src="${com.urla }" id="comPic" class="jqzoom" rel="${com.urla }" />
						</a>
					</div>
					<ul class="tb-thumb" id="thumblist">

						<li style="margin-left: 40px;">
							<div class="tb-pic tb-s40">
								<a onclick="changeimg('${com.urla }')">
									<img src="${com.urla }">
								</a>
							</div>
						</li>
						<li style="margin-left: 30px;">
							<div class="tb-pic tb-s40">
								<a onclick="changeimg('${com.urlb }')">
									<img src="${com.urlb }">
								</a>
							</div>
						</li>
						<li style="margin-left: 30px;">
							<div class="tb-pic tb-s40">
								<a onclick="changeimg('${com.urlc }')">
									<img src="${com.urlc }">
								</a>
							</div>
						</li>
						<li style="margin-left: 30px;">
							<div class="tb-pic tb-s40">
								<a onclick="changeimg('${com.urld }')">
									<img src="${com.urld }">
								</a>
							</div>
						</li>
					</ul>
				</div>

				<div class="clear"></div>
			</div>
			<div class="clearfixRight">
				<!--规格属性-->
				<!--名称-->
				<div class="tb-detail-hd">
					<h1>${com.comName }</h1>
				</div>
				<div class="tb-detail-list">
					<!--价格-->
					<div class="tb-detail-price">
						<li class="price iteminfo_price">
							<dt>促销价</dt>
							<dd>
								<em>¥</em>
								<b class="sys_item_price">${com.comPrice }</b>
							</dd>
						</li>
						<li class="price iteminfo_mktprice">
							<dt>原价</dt>
							<dd>
								<em>¥</em>
								<b class="sys_item_mktprice">98.00</b>
							</dd>
						</li>
						<div class="clear"></div>
					</div>

					<!--地址-->
					<dl class="iteminfo_parameter freight">
						<dt>配送至</dt>
						<div class="iteminfo_freprice">
							<div class="am-form-content address">
								<select data-am-selected>
									<option value="a">山东省</option>
								</select>
								<select data-am-selected>
									<option value="a">青岛市</option>
									<option value="b">潍坊市</option>
								</select>
								<select data-am-selected>
									<option value="a">市南区</option>
									<option value="b">市北区</option>
								</select>
							</div>
							<div class="pay-logis">
								快递
								<b class="sys_item_freprice">10</b>
								元
							</div>
						</div>
					</dl>
					<div class="clear"></div>

					<!--销量-->
					<ul class="tm-ind-panel">
						<li class="tm-ind-item tm-ind-sellCount canClick">
							<div class="tm-indcon">
								<span class="tm-label">月销量</span>
								<span class="tm-count">1015</span>
							</div>
						</li>
						<li class="tm-ind-item tm-ind-sumCount canClick">
							<div class="tm-indcon">
								<span class="tm-label">累计销量</span>
								<span class="tm-count">6015</span>
							</div>
						</li>
						<li class="tm-ind-item tm-ind-reviewCount canClick tm-line3">
							<div class="tm-indcon">
								<span class="tm-label">累计评价</span>
								<span class="tm-count">640</span>
							</div>
						</li>
					</ul>
					<div class="clear"></div>

					<!--各种规格-->
					<dl class="iteminfo_parameter sys_item_specpara">
						<dt class="theme-login">
							<div class="cart-title">
								可选规格
								<span class="am-icon-angle-right"></span>
							</div>
						</dt>
						<dd>
							<!--操作页面-->
							<div class="theme-popover-mask"></div>
							<div class="theme-popover">
								<div class="theme-span"></div>
								<div class="theme-poptit">
									<a href="javascript:;" title="关闭" class="close">×</a>
								</div>
								<div class="theme-popbod dform">
									<form class="theme-signin" name="loginform" action="" method="post">
										<div class="theme-signin-left">

											<div class="theme-options">
												<div class="cart-title">口味</div>
												<ul>
													<li class="sku-line selected">
														原味
														<i></i>
													</li>
													<li class="sku-line">
														奶油
														<i></i>
													</li>
													<li class="sku-line">
														炭烧
														<i></i>
													</li>
													<li class="sku-line">
														咸香
														<i></i>
													</li>
												</ul>
											</div>
											<div class="theme-options">
												<div class="cart-title">包装</div>
												<ul>
													<li class="sku-line selected">
														手袋单人份
														<i></i>
													</li>
													<li class="sku-line">
														礼盒双人份
														<i></i>
													</li>
													<li class="sku-line">
														全家福礼包
														<i></i>
													</li>
												</ul>
											</div>
											<div class="theme-options">
												<div class="cart-title number">数量</div>
												<dd>
													<input id="min" class="am-btn am-btn-default" name="" type="button" value="-" />
													<input id="text_box" name="" type="text" value=1 style="width: 30px;" />
													<input id="add" class="am-btn am-btn-default" name="" type="button" value="+" />
													<span id="Stock" class="tb-hidden">
														库存
														<span class="stock" id="comrep">${com.comRepository }</span>
														件
													</span>
												</dd>
											</div>
											<div class="clear"></div>
										</div>
									</form>
								</div>
						</dd>
					</dl>
					<div class="clear"></div>
					<!--活动	-->
					<div class="shopPromotion gold">
						<div class="hot">
							<dt class="tb-metatit">店铺优惠</dt>
							<div class="gold-list">
								<p>
									购物满2件打8折，满3件7折
									<span>
										点击领券
										<i class="am-icon-sort-down"></i>
									</span>
								</p>
							</div>
						</div>
						<div class="clear"></div>
						<div class="coupon">
							<dt class="tb-metatit">优惠券</dt>
							<div class="gold-list">
								<ul>
									<li>125减5</li>
									<li>198减10</li>
									<li>298减20</li>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="pay">
					<div class="pay-opt">
						<a href="home.html">
							<span class="am-icon-home am-icon-fw">首页</span>
						</a>
						<a>
							<span class="am-icon-heart am-icon-fw">收藏</span>
						</a>

					</div>
					<li>
						<div class="clearfix tb-btn tb-btn-buy theme-login">
							<a id="LikBuy" title="点此按钮到下一步确认购买信息" onclick="add('order')">立即购买</a>
						</div>
					</li>
					<li>
						<div class="clearfix tb-btn tb-btn-basket theme-login">
							<a id="LikBasket" title="加入购物车" onclick="add('car')">
								<i></i>
								加入购物车
							</a>
						</div>
					</li>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<!-- introduce-->

		<div class="introduce">
			<div class="browse">
				<div class="mc">
					<ul>
						<div class="mt">
							<h2>看了又看</h2>
						</div>

						<li class="first">
							<div class="p-img">
								<a href="#">
									<img class="" src="<%=request.getContextPath()%>/images/browse1.jpg">
								</a>
							</div>
							<div class="p-name">
								<a href="#"> 【三只松鼠_开口松子】零食坚果特产炒货东北红松子原味 </a>
							</div>
							<div class="p-price">
								<strong>￥35.90</strong>
							</div>
						</li>
						<li>
							<div class="p-img">
								<a href="#">
									<img class="" src="<%=request.getContextPath()%>/images/browse1.jpg">
								</a>
							</div>
							<div class="p-name">
								<a href="#"> 【三只松鼠_开口松子】零食坚果特产炒货东北红松子原味 </a>
							</div>
							<div class="p-price">
								<strong>￥35.90</strong>
							</div>
						</li>
						<li>
							<div class="p-img">
								<a href="#">
									<img class="" src="<%=request.getContextPath()%>/images/browse1.jpg">
								</a>
							</div>
							<div class="p-name">
								<a href="#"> 【三只松鼠_开口松子】零食坚果特产炒货东北红松子原味 </a>
							</div>
							<div class="p-price">
								<strong>￥35.90</strong>
							</div>
						</li>

						<li>
							<div class="p-img">
								<a href="#">
									<img class="" src="<%=request.getContextPath()%>/images/browse1.jpg">
								</a>
							</div>
							<div class="p-name">
								<a href="#"> 【三只松鼠_开口松子218g】零食坚果特产炒货东北红松子原味 </a>
							</div>
							<div class="p-price">
								<strong>￥35.90</strong>
							</div>
						</li>

					</ul>
				</div>
			</div>
			<div class="introduceMain">
				<div class="am-tabs" data-am-tabs="">
					<ul class="am-avg-sm-3 am-tabs-nav am-nav am-nav-tabs" otop="997.6666870117188" style="position: static; top: 0px; z-index: 998;">
						<li class="am-active">
							<a href="#">
								<span class="index-needs-dt-txt">宝贝详情</span>
							</a>
						</li>
						<li class="">
							<a href="#">
								<span class="index-needs-dt-txt">产品参数</span>
							</a>
						</li>
						<li class="">
							<a href="#">
								<span class="index-needs-dt-txt">全部评价</span>
							</a>
						</li>
					</ul>

					<div class="am-tabs-bd" style="touch-action: pan-y; -moz-user-select: none;">

						<div class="am-tab-panel am-fade am-active am-in">
							<div class="J_Brand">
								<div class="attr-list-hd tm-clear">
									<h4>商品描述：</h4>
								</div>
								<div class="clear"></div>
								${com.comDescr }
								<div class="clear"></div>
							</div>
							<div class="details">
								<div class="attr-list-hd after-market-hd">
									<h4>商品细节</h4>
								</div>
								<div class="twlistNews">
									<img src="${com.urla }" style="height: 800px;"><br><br>
									<img src="${com.urlb }" style="height: 800px;"><br><br>
									<img src="${com.urlc }" style="height: 800px;"><br><br>
									<img src="${com.urld }" style="height: 800px;">
								</div>
							</div>
							<div class="clear"></div>
						</div>
						<div class="am-tab-panel am-fade am-active am-in">

							<div class="J_Brand">
								<div class="attr-list-hd tm-clear">
									<h4>产品参数：</h4>
								</div>
								<div class="clear"></div>
								<ul id="J_AttrUL">
									<li title="">产品类型:&nbsp;烘炒类</li>
									<li title="">原料产地:&nbsp;巴基斯坦</li>
									<li title="">产地:&nbsp;湖北省武汉市</li>
									<li title="">配料表:&nbsp;进口松子、食用盐</li>
									<li title="">产品规格:&nbsp;210g</li>
									<li title="">保质期:&nbsp;180天</li>
									<li title="">产品标准号:&nbsp;GB/T 22165</li>
									<li title="">生产许可证编号：&nbsp;QS4201 1801 0226</li>
									<li title="">储存方法：&nbsp;请放置于常温、阴凉、通风、干燥处保存</li>
									<li title="">食用方法：&nbsp;开袋去壳即食</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>
						<div class="am-tab-panel am-fade am-active am-in">
							<div class="actor-new">
								<div class="rate">
									<strong>
										100
										<span>%</span>
									</strong>
									<br>
									<span>好评度</span>
								</div>
								<dl>
									<dt>买家印象</dt>
									<dd class="p-bfc">
										<q class="comm-tags">
											<span>味道不错</span>
											<em>(2177)</em>
										</q>
										<q class="comm-tags">
											<span>颗粒饱满</span>
											<em>(1860)</em>
										</q>
										<q class="comm-tags">
											<span>口感好</span>
											<em>(1823)</em>
										</q>
										<q class="comm-tags">
											<span>商品不错</span>
											<em>(1689)</em>
										</q>
										<q class="comm-tags">
											<span>香脆可口</span>
											<em>(1488)</em>
										</q>
										<q class="comm-tags">
											<span>个个开口</span>
											<em>(1392)</em>
										</q>
										<q class="comm-tags">
											<span>价格便宜</span>
											<em>(1119)</em>
										</q>
										<q class="comm-tags">
											<span>特价买的</span>
											<em>(865)</em>
										</q>
										<q class="comm-tags">
											<span>皮很薄</span>
											<em>(831)</em>
										</q>
									</dd>
								</dl>
							</div>
							<div class="clear"></div>
							<div class="tb-r-filter-bar">
								<ul class=" tb-taglist am-avg-sm-4">
									<li class="tb-taglist-li tb-taglist-li-current">
										<div class="comment-info">
											<span>全部评价</span>
											<span class="tb-tbcr-num">(32)</span>
										</div>
									</li>

									<li class="tb-taglist-li tb-taglist-li-1">
										<div class="comment-info">
											<span>好评</span>
											<span class="tb-tbcr-num">(32)</span>
										</div>
									</li>

									<li class="tb-taglist-li tb-taglist-li-0">
										<div class="comment-info">
											<span>中评</span>
											<span class="tb-tbcr-num">(32)</span>
										</div>
									</li>

									<li class="tb-taglist-li tb-taglist-li--1">
										<div class="comment-info">
											<span>差评</span>
											<span class="tb-tbcr-num">(32)</span>
										</div>
									</li>
								</ul>
							</div>
							<div class="clear"></div>

							<ul class="am-comments-list am-comments-list-flip">
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">b***1 (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年11月02日 17:46</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="255776406962">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">摸起来丝滑柔软，不厚，没色差，颜色好看！买这个衣服还接到诈骗电话，我很好奇他们是怎么知道我买了这件衣服，并且还知道我的电话的！</div>
												<div class="tb-r-act-bar">颜色分类：柠檬黄&nbsp;&nbsp;尺码：S</div>
											</div>

										</div>
										<!-- 评论内容 -->
									</div>
								</li>
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">h***n (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年11月25日 12:48</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="258040417670">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">式样不错，初冬穿</div>
												<div class="tb-r-act-bar">颜色分类：柠檬黄&nbsp;&nbsp;尺码：L</div>
											</div>
										</div>
										<!-- 评论内容 -->
									</div>
								</li>
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">b***1 (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年11月02日 17:46</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="255776406962">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">摸起来丝滑柔软，不厚，没色差，颜色好看！买这个衣服还接到诈骗电话，我很好奇他们是怎么知道我买了这件衣服，并且还知道我的电话的！</div>
												<div class="tb-r-act-bar">颜色分类：柠檬黄&nbsp;&nbsp;尺码：S</div>
											</div>

										</div>
										<!-- 评论内容 -->
									</div>
								</li>
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">l***4 (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年10月28日 11:33</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="255095758792">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">没有色差，很暖和……美美的</div>
												<div class="tb-r-act-bar">颜色分类：蓝调灰&nbsp;&nbsp;尺码：2XL</div>
											</div>

										</div>
										<!-- 评论内容 -->
									</div>
								</li>
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">b***1 (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年11月02日 17:46</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="255776406962">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">摸起来丝滑柔软，不厚，没色差，颜色好看！买这个衣服还接到诈骗电话，我很好奇他们是怎么知道我买了这件衣服，并且还知道我的电话的！</div>
												<div class="tb-r-act-bar">颜色分类：柠檬黄&nbsp;&nbsp;尺码：S</div>
											</div>

										</div>
										<!-- 评论内容 -->
									</div>
								</li>
								<li class="am-comment">
									<!-- 评论容器 -->
									<a href="">
										<img class="am-comment-avatar" src="../images/hwbn40x40.jpg">
										<!-- 评论者头像 -->
									</a>

									<div class="am-comment-main">
										<!-- 评论内容容器 -->
										<header class="am-comment-hd">
											<!--<h3 class="am-comment-title">评论标题</h3>-->
											<div class="am-comment-meta">
												<!-- 评论元数据 -->
												<a href="#link-to-user" class="am-comment-author">h***n (匿名)</a>
												<!-- 评论者 -->
												评论于
												<time datetime="">2015年11月25日 12:48</time>
											</div>
										</header>

										<div class="am-comment-bd">
											<div class="tb-rev-item " data-id="258040417670">
												<div class="J_TbcRate_ReviewContent tb-tbcr-content ">式样不错，初冬穿</div>
												<div class="tb-r-act-bar">颜色分类：柠檬黄&nbsp;&nbsp;尺码：L</div>
											</div>
										</div>
										<!-- 评论内容 -->
									</div>
								</li>

							</ul>
							<div class="clear"></div>

							<div class="clear"></div>

							<div class="tb-reviewsft">
								<div class="tb-rate-alert type-attention">
									购买前请查看该商品的
									<a href="#" target="_blank">购物保障</a>
									，明确您的售后保障权益。
								</div>
							</div>

						</div>
					</div>
				</div>
				<div class="clear"></div>
				<%@ include file="home_down.jsp"%>
			</div>
		</div>
	</div>

</body>
</html>