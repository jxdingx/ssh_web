<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>淘淘商城后台管理系统</title>
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
<script type="text/javascript">
	$(function() {
		$('#cla1').combobox({
			url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode=0",
			required : true,
			editable : false,
			valueField : 'code',
			textField : 'claName',
			onSelect : function(cla1) {
				$('#cla2').combobox({
					url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode=" + cla1.code,
					editable : false,
					valueField : 'id',
					textField : 'claName',
				});
			}
		});

	})
</script>
<script type="text/javascript">
	//提交表单
	function submitForm() {
		//有效性验证
		var comDescr=$("#comDescr").texteditor("getValue");
		if (!$('#itemAddForm').form('validate')||comDescr=="") {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}
		//提交
		var form = new FormData(document.getElementById("itemAddForm"));
		var param = "<%=request.getContextPath()%>/update/insert.do"
		$.ajax({
			url : param+ "?comDescr=" + comDescr,
			type : "post",
			// 			data : $('#itemAddForm').serialize(),
			data : form,
			processData : false,//表示不是只输入数据
			contentType : false,
			dataType : "text",
			success : function(data) {
				if (data == "rep") {
					alert("编码重复，请重新输入！");
				} else {
					alert("添加成功");
					window.location.href="<%=request.getContextPath()%>/admin/com_add.jsp"
						}
					}
				});
	}
	function clearForm() {
		$('#itemAddForm').form('reset');
		$('input,select,textarea', $('form[id="itemAddForm"]')).attr(
				'readonly', false);
	}

	function $$(obj) {
		return document.getElementById(obj);
	}
	var str = "";
	function upload(f,name) {
		for (var i = 0; i < f.length; i++) {
			var reader = new FileReader();
			reader.readAsDataURL(f[i]);
			reader.onload = function(e) {
				str += "<img src='"+e.target.result+"' style='width:100px;height:110px;' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				$$("dd").innerHTML=str;
			}
		}
		$("#"+name).prop("hidden",true);
		$("#"+name).next().prop("hidden",false);
		
	}
	
	function cleanfile() {
		for (var i = 1; i < 4; i++) {
			$("#file"+i).prop("hidden",true);
			$("#file"+i).children().val('');
		}
		$("#file1").prop("hidden",false);
		str = "";
		$$("dd").innerHTML='';
	}
</script>
</head>
<body>
	<%@include file="admin_top.jsp"%>
	<div class="banner">
		<div class="banner">
			<div class="col-main">
				<div class="main-wrap">
					<div class="wrap-left">
						<div class="wrap-list">
							<!--商品添加 -->
							<div class="m-logistics">
								<div class="s-bar">
									<i class="s-icon"></i>
									商品添加
								</div>
							</div>
							<div style="padding: 20px 40px 60px 80px">
								<form id="itemAddForm" class="itemForm">
									<table>
										<tr style="height: 50px;">
											<td>
												<span style="font-size: 25px;">商品类目:</span>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</td>
											<td>
												<input id="cla1" style="height: 30px;" />
												&nbsp;&nbsp;&nbsp;&nbsp;
												<input id="cla2" name="comClassifyId" class="easyui-combobox" required=true style="height: 30px;" />
												<p>&nbsp;</p>

											</td>
										</tr>

										<tr>
											<td>
												<span style="font-size: 25px;">商品名称:</span>
											</td>
											<td>
												<input class="easyui-textbox" type="text" name="comName" data-options="required:true" style="height: 30px;"></input>
												<p>&nbsp;</p>
											</td>
										</tr>

										<tr>
											<td style="font-size: 25px;">商品描述:</td>
											<td>
												<div class="easyui-texteditor" id="comDescr" style="width: 380px; height: 200px;"></div>
												<p>&nbsp;</p>
											</td>
											<td>
												<span style="margin-left: 40px;">商品图片介绍：</span>
												<div style="border: 3px solid #eeeeee; height: 175px; width: 400px; margin-left: 40px;">
													<div id="file1" style="float: left;">
														<input type="file"  name="file1" onchange="upload(this.files,'file1')"  />
													</div>
													<div id="file2" style="float: left;" hidden="true">
														<input type="file" name="file2" onchange="upload(this.files,'file2')"  />
													</div>
													<div id="file3" style="float: left;" hidden="true">
														<input type="file" name="file3" onchange="upload(this.files,'file3')"  />
													</div>
													<div  id="clean"  style="float: right;" >
														<input type="button" style="width: 80px;" onclick="cleanfile()" value="重新上传" >
													</div>
													<br><br>
													<hr style="margin: 0px; height: 1px; border: 1px; background-color: #D5D5D5; color: #D5D5D5;" />
													<div id="dd"></div>
												</div>
											</td>
										</tr>
										<tr>
											<td style="font-size: 25px;">商品价格:</td>
											<td>
												<input class="easyui-numberbox" type="text" name="comPrice" style="height: 30px;" data-options="min:1,max:99999999,precision:2,required:true" />
												<p>&nbsp;</p>
											</td>
										</tr>
										<tr>
											<td style="font-size: 25px;">库存数量:</td>
											<td>
												<input class="easyui-numberbox" type="text" name="comRepository" style="height: 30px;" data-options="min:1,max:99999999,precision:0,required:true" />
												<p>&nbsp;</p>
											</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<td style="font-size: 25px;">编码：</td> -->
<!-- 											<td> -->
<!-- 												<input class="easyui-textbox" type="text" name="comCode" style="height: 30px;" data-options="required:true" /> -->
<!-- 												<p>&nbsp;</p> -->
<!-- 											</td> -->
<!-- 										</tr> -->
										<tr>
											<td style="font-size: 25px;">商品图片:</td>
											<td>
												<input type="file" name="file" value="上传图片" required=true />
												<img alt="" src="" id="image" style="margin-left: 200px; width: 70px; height: 70px;">
												<p>&nbsp;</p>
											</td>
										</tr>
									</table>
								</form>
								<div style="padding: 10px; margin-left: 20%;">
									<a class="easyui-linkbutton" onclick="submitForm()" style="width: 70px;">提交</a>
									<a class="easyui-linkbutton" onclick="clearForm()" style="width: 70px; margin-left: 5%">重置</a>
								</div>
							</div>
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
