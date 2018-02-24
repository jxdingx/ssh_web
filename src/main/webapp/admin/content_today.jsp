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
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.texteditor.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui-lang-zh_CN.js"></script>
<title></title>
</head>
<body>
<%@ include file="admin_top.jsp"%>
	<div class="banner">
		<div class="banner">
			<div class="col-main">
				<div class="main-wrap">
					<div class="wrap-left">
						<div class="wrap-list">
							<!--首页轮播 -->
							<div class="m-logistics">
								<div class="s-bar">
									<i class="s-icon"></i>
									首页轮播
								</div>
							</div>
							<br>
							<br>
							<br>
							<table style="width: 900px;">
								<tr>
									<td>
										<span style="font-size: 30px;">今日推荐:</span>
									</td>
									<td>
										<span onclick="addcom(1)">选择商品</span>
										<input type="text" id="com1" disabled="disabled">
									</td>
									<td>
										<input type="file"  value="选择图片">
									</td>
									<td>
										<img alt="" src="../images/01.jpg" style="width: 80px; height: 80px;">
										<br>
										<br>
									</td>
								</tr>
							</table>
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