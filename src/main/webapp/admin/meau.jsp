<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="menu" style="height: 600px;">
	<ul>
		<li class="person">
			<span style="font-size: 20px;">功能列表</span>
		<br /><br />
		</li>
		<li class="person">
			<span style="font-size: 19px;">商品操作</span>
				<br /><br />
			<ul>
				<li>
					<a href="<%=request.getContextPath()%>/admin/com_add.jsp">添加商品</a>
				<br /></li>
				<li>
					<a href="<%=request.getContextPath()%>/admin/com_list.jsp">查看商品</a>
				</li>
			</ul>
		<br>
		</li>
			<li class="person">
			<span style="font-size: 19px;">订单管理</span>
				<br /><br />
			<ul>
				<br />
				<li>
					<a href="<%=request.getContextPath()%>/admin/order_list.jsp">查看订单</a>
				</li>
			</ul>
		<br>
		</li>
		<li class="person">
			<span style="font-size: 19px;">页面管理</span>
				<br /><br />
			<ul>
				<li>
					<a href="<%=request.getContextPath()%>/admin/content_pic.jsp">首页轮播</a>
				<br /><br />
				</li>
				<li>
					<a href="<%=request.getContextPath()%>/admin/content_today.jsp">今日推荐</a>
				</li>
			</ul>
		<br>
		</li>
	</ul>
</aside>