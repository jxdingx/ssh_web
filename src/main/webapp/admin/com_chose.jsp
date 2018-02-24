<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		$('#cla1').combobox({
			url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode=0",
			required : true,
			editable : false,
			valueField : 'code',
			textField : 'claName',
			onChange : function(cla1) {
				$('#cla2').combobox({
					url : "<%=request.getContextPath()%>/com_cla/getcla.do?parCode="
															+ cla1,
													editable : false,
													valueField : 'id',
													textField : 'claName',
													onSelect : function(cla2) {
														chosecom(cla2.id);
													}
												});
							}
						});
	});
	function chosecom(id) {
		$.ajax({
			url : "<%=request.getContextPath()%>/search/bycomClassifyId.do?comClassifyId="+id,
			type : "POST",
			dataType : "json",
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
			success : function(data) {
				$('#cc').combobox({
					data: data.rows,
					editable : false,
<%-- 					url : "<%=request.getContextPath()%>/search/tocomCla.do?comClassifyId="+id, --%>
					valueField : 'id',
					textField : 'comName'
				});
			}
		});
		
		
		
		
	};
</script>
</head>
<body>
	<div style="margin-left: 70px; margin-top: 40px;">
		<span>一级分类&nbsp;&nbsp;</span>
		<input id="cla1" style="height: 30px;" />
		&nbsp;&nbsp;&nbsp;&nbsp;
		<span>二级分类&nbsp;&nbsp;</span>
		<input id="cla2" name="comClassifyId" class="easyui-combobox" required=true style="height: 30px;" />
		<p>&nbsp;</p>
	</div>
	<div style="margin-left: 70px; margin-top: 40px;">
		<span>选择商品&nbsp;&nbsp;</span><input id="cc" class="easyui-combobox"  style="width: 300px;height: 30px;" name="dept" >
	</div>