<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	//提交表单
	function submitForm() {
		var comDescr=$("#comDescr").texteditor("getValue");
		//有效性验证
		if (!$('#itemAddForm').form('validate')||comDescr=="") {
			$.messager.alert('提示', '表单还未填写完成!');
			return;
		}
		//提交
		var form = new FormData(document.getElementById("itemAddForm"));
		var param = "<%=request.getContextPath()%>/update/update.do"
		$.ajax({
			url : param+ "?comDescr=" + comDescr,
			type : "post",
			// 			data : $('#itemAddForm').serialize(),
			data : form,
			processData : false,
			contentType : false,
			dataType : "text",
			success : function(data) {
				if (data == "rep") {
					$.messager.alert('提示', '编码重复，请重新输入！');
				} else {
					$.messager.alert('提示', '修改成功!');
					exit();
					search(pagenumber, pagesize);
				}
			}
		});
	}

	function loaddata(data) {
		//			alert(data.comcla1);
		$('#cla1').combobox({
			url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode=0",
			required : true,
			editable : false,
			valueField : 'code',
			textField : 'claName',
			onLoadSuccess : function() {
				$('#cla1').combobox('select',data.comcla1);
				$('#cla2').combobox('select',data.comcla2);
			},
			onSelect : function(cla1) {
				$('#cla2').combobox({
					url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode="
															+ cla1.code,
													editable : false,
													valueField : 'id',
													textField : 'claName',
												});
							},
							onChange : function() {
								$('#cla2').combobox('setValue', "");
							}

						});
		$("#comName").textbox("setValue", data.com.comName);
		$("#comDescr").texteditor("setValue", data.com.comDescr)
		$("#comPrice").numberbox("setValue", data.com.comPrice);
		$("#comRepository").numberbox("setValue", data.com.comRepository);
		$("#comCode").textbox("setValue", data.com.comCode);
		$("#image").prop("src", data.com.urla + '?' + Math.random());
		var strtemp = '';
		if (data.com.urlb != null) {
			strtemp += "<img id='urlb' src='"
					+ data.com.urlb
					+ "?"
					+ Math.random()
					+ "' style='width:100px;height:120px;' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		}
		if (data.com.urlc != null) {
			strtemp += "<img id='urlc' src='"
					+ data.com.urlc
					+ "?"
					+ Math.random()
					+ "' style='width:100px;height:120px;' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		}
		if (data.com.urld != null) {
			strtemp += "<img id='urld' src='"
					+ data.com.urld
					+ "?"
					+ Math.random()
					+ "' style='width:100px;height:120px;' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		}
		$$("dd").innerHTML = strtemp;
	}

	function $$(obj) {
		return document.getElementById(obj);
	}
	var str = "";
	function upload(f, name) {
		for (var i = 0; i < f.length; i++) {
			var reader = new FileReader();
			reader.readAsDataURL(f[i]);
			reader.onload = function(e) {
				str += "<img src='"+e.target.result+"' style='width:100px;height:120px;' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				$$("dd").innerHTML = str;
			}
		}
		$("#" + name).prop("hidden", true);
		$("#" + name).next().prop("hidden", false);

	}

	function cleanfile() {
		for (var i = 1; i < 4; i++) {
			$("#file" + i).prop("hidden", true);
			$("#file" + i).children().val('');
		}
		$("#file1").prop("hidden", false);
		str = "";
		$$("dd").innerHTML = '';
	}
</script>
<div style="padding: 60px 80px 60px 80px">
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
					<input id="cla2" name="comClassifyId" class="easyui-combobox" data-options="required:true" style="height: 30px;" />
					<p>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td>
					<span style="font-size: 25px;">商品名称:</span>
				</td>
				<td>
					<input class="easyui-textbox" type="text" name="comName" id="comName" data-options="required:true" style="height: 30px;"></input>
					<p>&nbsp;</p>
				</td>

			</tr>
			<tr>
				<td style="font-size: 25px;">商品描述:</td>
				<td>
					<div class="easyui-texteditor" id="comDescr" style="width: 380px; height: 200px;"></div>
					<!-- 					<input class="easyui-textbox" name="comDescr" id="comDescr" data-options="required:true,multiline:true" style="height: 60px; width: 280px;"></input> -->
					<p>&nbsp;</p>
				</td>
				<td>
					<span style="margin-left: 40px;">商品图片介绍：</span>
					<div style="border: 3px solid #eeeeee; height: 175px; width: 400px; margin-left: 40px;">
						<div id="file1" style="float: left;" hidden="true">
							<input type="file" name="file1" onchange="upload(this.files,'file1')" />
						</div>
						<div id="file2" style="float: left;" hidden="true">
							<input type="file" name="file2" onchange="upload(this.files,'file2')" />
						</div>
						<div id="file3" style="float: left;" hidden="true">
							<input type="file" name="file3" onchange="upload(this.files,'file3')" />
						</div>
						<div id="clean" style="float: right;">
							<input type="button" style="width: 80px;" onclick="cleanfile()" value="重新上传">
						</div>
						<br>
						<br>
						<hr style="margin: 0px; height: 1px; border: 1px; background-color: #D5D5D5; color: #D5D5D5;" />
						<div id="dd"></div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="font-size: 25px;">商品价格:</td>
				<td>
					<input class="easyui-numberbox" type="text" name="comPrice" id="comPrice" style="height: 30px;" data-options="min:1,max:99999999,precision:2,required:true" />
					<p>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td style="font-size: 25px;">库存数量:</td>
				<td>
					<input class="easyui-numberbox" type="text" name="comRepository" id="comRepository" style="height: 30px;" data-options="min:1,max:99999999,precision:0,required:true" />
					<p>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td style="font-size: 25px;">编码：</td>
				<td>
					<input class="easyui-textbox" type="text" name="comCode" id="comCode" style="height: 30px;" data-options="required:true" />
					<p>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td style="font-size: 25px;">商品图片:</td>
				<td>
					<input type="file" name="file" value="上传图片" />
					<img alt="" src="" id="image" style="width: 50px; height: 50px;">
					<p>&nbsp;</p>
				</td>
			</tr>
		</table>
	</form>
	<div style="padding: 10px; margin-left: 20%;">
		<a class="easyui-linkbutton" onclick="submitForm()" style="width: 70px;">确认修改</a>
		<a class="easyui-linkbutton" onclick="clearForm()" style="width: 70px; margin-left: 5%">取消修改</a>
	</div>
</div>

