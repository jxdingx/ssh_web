<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="menu">
	<ul>
		<li class="person">
			<span style="font-size: 20px;">个人中心</span>
		</li>
		<br>
		<li class="person">
			<span style="font-size: 17px;">我的信息:</span>
			<ul>
				<br />
				<li>
					<a href="<%=request.getContextPath()%>/jsp/user.jsp">个人资料</a>
				</li>
				<br />
				<li>
					<a href="<%=request.getContextPath()%>/jsp/address.jsp">收货地址</a>
				</li>
			</ul>
		</li>
		<br>
		<li class="person">
			<span style="font-size: 17px;">我的交易:</span>
			<ul>
				<br />
				<li>
					<a href="<%=request.getContextPath()%>/jsp/user.jsp">已成交订单</a>
				</li>
				<br />
				<li>
					<a href="<%=request.getContextPath()%>/jsp/ordercar.jsp">购物车</a>
				</li>
			</ul>
		</li>
		<br>
		<li class="person">
			<span style="font-size: 17px;">我的资产:</span>
			<ul>
				<br />
				<li>
					<span>优惠券 </span>
				</li>
				<br />
				<li>
					<span>红包</span>
				</li>
				<br />
				<li>
					<span>账单明细 </span>
				</li>
			</ul>
		</li>
	</ul>
</aside>