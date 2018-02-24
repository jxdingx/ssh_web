<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>地址管理</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/icon.css" />
<link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/personal.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/addstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui-lang-zh_CN.js"></script>
<script src="<%=request.getContextPath()%>/js/amazeui.min.js"></script>
</head>
<script type="text/javascript">
	$(function() {
		var id = "${addresid}";
		if (id != "") {
			getdata(id);
		}else{
			getcla1();
		}
	});

	function getcla1() {
		$('#cla1').combobox({
			url : "<%=request.getContextPath()%>/dict/getcla.do?parentCode=0",
			required : true,
			editable : false,
			valueField : 'code',
			textField : 'name',
			onChange : function(cla1) {
				$('#cla2').combobox("clear");
				$('#cla3').combobox("clear");
				getcla2(cla1);
			}
		});
	}
	function getcla2(code) {
		$('#cla2').combobox({
			url : "<%=request.getContextPath()%>/dict/getcla.do?parentCode=" + code,
			editable : false,
			valueField : 'code',
			textField : 'name',
			onChange : function(cla2) {
				getcla3(cla2);
			}
		});
	}
	function getcla3(code) {
		$('#cla3').combobox({
			url : "<%=request.getContextPath()%>/dict/getcla.do?parentCode=" + code,
			editable : false,
			valueField : 'code',
			textField : 'name',
		});
	}

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

	function getdata(id) {
		var param = "<%=request.getContextPath()%>/address/showupdate.do";
		$.ajax({
					url : param,
					data : "id=" + id,
					type : "POST",
					dataType : "json",
					contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
					success : function(data) {
						// 				$('#addressForm').formEdit(data.useradd); //插件自动填充表单
						$("#userName").textbox("setValue",
								data.useradd.userName);
						$("#userAddress").textbox("setValue",
								data.useradd.userAddress);
						getcla1();
						$('#cla1').combobox("setValue", data.useradd.userSheng);
						$('#cla2').combobox("setValue", data.useradd.userShi);
						$('#cla3').combobox("setValue", data.useradd.userQu);
						return;
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
			var s4 = '<span class="province">' + row.userSheng
					+ '</span><span class="city">' + row.userShi
					+ '</span><span class="dist">' + row.userQu + '</span>';
			var s5 = '<br><span class="street">' + row.userAddress
					+ '</span></p></div>';
			var s6 = '<div class="new-addr-btn"><a href="#"><i class="am-icon-edit"></i>编辑</a><span class="new-addr-bar">|</span><a href="javascript:void(0);" onclick="delClick(this);"><i class="am-icon-trash"></i>删除</a></div></li>';
			s += s1 + s2 + s3 + s4 + s5 + s6;
		}
		$("#address").html(s);
	}
	function submitForm() {
		//有效性验证
		if (!$('#addressForm').form('validate')) {
			$.messager.alert('提示', '地址还未填写完成!');
			return;
		}
		//提交
		var param = "<%=request.getContextPath()%>/address/update.do?id=" + "${addresid}";
		$.ajax({
			url : param,
			type : "post",
			data : $('#addressForm').serialize(),
			dataType : "text",
			success : function(data) {
				if (data == "overnum") {
					alert("地址超过3个！")
				}else{
				alert("修改成功！");}
				window.location.href = "<%=request.getContextPath()%>/jsp/address.jsp";
					}
				});

	}
</script>
<body>
	<%@ include file="home_top.jsp"%>
	<b class="line"></b>
	<div class="banner">
		<div class="col-main">
			<div class="main-wrap" style="margin-left: 20%;">
				<div class="add-dress" style="width: 70%;">
					<!--标题 -->
					<div class="am-cf am-padding">
						<div class="am-fl am-cf">
							<strong class="am-text-danger am-text-lg">新增地址</strong>
						</div>
					</div>
					<hr />
					<div class="am-u-md-12 am-u-lg-8" style="margin-top: 10px;">
						<form class="am-form am-form-horizontal" id="addressForm">
							<div class="am-form-group">
								<label for="user-name" class="am-form-label">收货人</label>
								<div class="am-form-content">
									<input type="text" class="easyui-textbox" required=true id="userName" name="userName" style="width: 280px;" placeholder="收货人">
								</div>
							</div>
							<div class="am-form-group">
								<label for="user-address" class="am-form-label">所在地</label>
								<div class="am-form-content address">
									<input id="cla1" name="userSheng" style="width: 140px;" />
									<input id="cla2" name="userShi" style="width: 140px;" class="easyui-combobox" editable=false required=true />
									<input id="cla3" name="userQu" style="width: 140px;" class="easyui-combobox" editable=false required=true />
								</div>
							</div>
							<br>
							<div class="am-form-group">
								<label for="user-intro" class="am-form-label">详细地址</label>
								<div class="am-form-content">
									<input class="easyui-textbox" name="userAddress" id="userAddress" data-options="required:true,multiline:true" style="height: 90px; width: 280px;"></input>
									<br>
									<small>100字以内写出你的详细地址...</small>
								</div>
							</div>
							<br>
							<div class="am-form-group">
								<div class="am-u-sm-9 am-u-sm-push-3">
									<a class="am-btn am-btn-danger" onclick="submitForm()">保存</a>
									<a href="<%=request.getContextPath()%>/jsp/address.jsp" class="am-btn am-btn-danger" style="margin-left: 10%">取消</a>
								</div>
							</div>
						</form>
					</div>

				</div>
			</div>
			<%@ include file="home_down.jsp"%></div>
		<%@ include file="meau.jsp"%>
	</div>
</body>
</html>