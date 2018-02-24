<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/texteditor.css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/systyle.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/orstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.texteditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
<script type="text/javascript">
	$(function() {
		search(1, 6);

	});
	function search(pageNumber, pageSize) {
		$.ajax({
			url : "<%=request.getContextPath()%>/order/selllerorder.do",
			type : "POST",
			data : "page=" + pageNumber + "&rows="+ pageSize,
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				show(data, pageNumber, pageSize);
			}
		});
	}
    var pagenumber;
    var pagesize;
	function show(data, pageNumber, pageSize) {
		pagenumber=pageNumber;
		pagesize=pageSize;
		var s = "";
		var len = data.rows.length;
		var rows = data.rows;
		var total = data.total;
		$("#num").text(total);
		for (var i = 0; i < len; i++) {
		var row = rows[i]	
		var s1 = '<div class="order-status5"><div class="order-content"><div class="order-left"><ul class="item-list">';
		var s2 = '<li class="td td-item"><div class="item-pic"><a href="/st_web/search/show.do?id='+row.comId+'" class="J_MakePoint"><img src="'+row.com.urla+'?'+Math.random()+'" class="itempic J_ItemImg"></a></div><div class="item-info"><div class="item-basic-info"><p>'+row.com.comName+'</p><br><p class="info-little">'+row.com.comDescr+'</p></div></div></li>'
		
		var s3 = '<li class="td td-price"><div class="item-amount">'+row.orderCode+'</div></li><li class="td td-number"><div class="item-amount">'+row.name+'</div></li><li class="td td-price"><div class="item-price">x'+row.comNum+'</div></li>';
		
		var s4 = '<li class="td td-price"><div class="td td-amount"><span>￥'+row.comPrice+'</span></div></li><li class="td td-number"><div class="td td-amount"><span>已支付</span></li>';
		
		var s5 = '<li class="td td-operation" style="width:90px;margin-left: 30px;"></li>';
		var s6 = '<li class="td th-operation" style="width:90px;margin-left: 50px;margin-top: 20px;"><div class="am-btn am-btn-danger anniu" onclick="deleteit('+row.id+')" >删除</div></li></div></div></div>';
		s += s1 + s2 + s3 + s4 + s5+s6;
		}
		var last = Math.ceil(total / pageSize);
		s += "<div class='clear'></div><ul class='am-pagination am-pagination-right' ><li><a href = 'javascript:search(1,6)' >首页</a>&nbsp</li>";
		s += "<li><a href='javascript:search("
				+ (pageNumber == 1 ? 1 : pageNumber - 1)
				+ ",6)' >上一页</a>&nbsp;</li>";
		s += "<li><a href='javascript:search("
				+ (pageNumber == last ? last : pageNumber + 1)
				+ ",6)' >下一页</a>&nbsp;</li>";
		s += "<li><a href='javascript:search(" + last
				+ ",6)' >末页</a>&nbsp;</li>";
		s += "第<span id='pageNumber'>" + pageNumber + "</span>页/共" + last
				+ "页</ul>";
		$("#show").html(s);
	}
	function deleteit(id) {
		var r=confirm("确认删除该订单？")
		  if (r==false)
		    {
		    return;
		    }
		$.ajax({
			url : '<%=request.getContextPath()%>/order/sellerdeleteit.do',
			type : "post",
			data : "id=" + id,
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			success : function(data) {
				if (data != "ok") {
					alert("系统错误！");
					return;
				}
				$.messager.alert('提示', '删除成功!');
				search(pagenumber, pagesize);
			}
		});
	}
</script>
</head>
<body>
	<%@include file="admin_top.jsp"%>
	<div class="banner">
		<div class="col-main">
			<p style="margin-left: 5px;">
			<div class="main-wrap">
				<div class="user-order">
					<!--标题 -->
					<div class="am-cf am-padding">
						<div class="am-fl am-cf">
							<strong class="am-text-danger am-text-lg">所有订单</strong>
						</div>
					</div>
					<div class="am-tabs am-tabs-d2 am-margin" data-am-tabs>
						<div class="am-tabs-bd">
							<div class="am-tab-panel am-fade am-in am-active" id="tab1">
								<div class="order-top">
									<div class="th th-item">
										<td class="td-inner">订单商品</td>
									</div>
									<div class="th th-amount">
										<td class="td-inner">订单编码</td>
									</div>
									<div class="th th-claname">
										<td class="td-inner">&nbsp;&nbsp;&nbsp;&nbsp;买家</td>
									</div>
									<div class="th th-price">
										<td class="td-inner">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;数量</td>
									</div>
									<div class="th th-number">
										<td class="td-inner">总价</td>
									</div>
									<div class="th th-status">
										<td class="td-inner">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</td>
									</div>
									<!-- 										<div class="th th-operation"> -->
									<!-- 											<td class="td-inner">订单查看</td> -->
									<!-- 										</div> -->
									<div class="th th-delete">
										<td class="td-inner">
											<span style="margin-left: 215px;"></span>
											删除
										</td>
									</div>
								</div>
								<div class="order-main">
									<div class="order-list" id="show"></div>
								</div>
								<br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="meau.jsp"%>
	</div>

</body>
</html>