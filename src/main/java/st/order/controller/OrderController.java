package st.order.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import st.commodity.model.ComMessageModel;
import st.commodity.service.ComMessageService;
import st.core.session.HtmlUtil;
import st.order.model.CartModel;
import st.order.model.OrderMessageModel;
import st.order.model.OrderModel;
import st.order.service.CartService;
import st.order.service.OrderMessageService;
import st.order.service.OrderService;
import st.user.model.UserModel;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private CartService<CartModel> cartService;
	@Autowired
	private ComMessageService<ComMessageModel> comMessageService;
	@Autowired
	private OrderMessageService<OrderMessageModel> orderMessageService;
	@Autowired
	private OrderService<OrderModel> orderService;

	/**
	 * 订单完成添加至订单表
	 * 
	 * @param addressId
	 * @param orderidlist
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	@ResponseBody
	public String insert(String addressId, String orderidlist, HttpServletRequest request) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		String[] arry = orderidlist.split(",");
		int len = arry.length;
		String orderCode = String.valueOf(new Date().getTime());

		OrderModel ordertemp = new OrderModel();
		ordertemp.setOrderCode(orderCode);
		ordertemp.setUserId(user.getId());
		ordertemp.setAddressId(Integer.valueOf(addressId));
		ordertemp.setOrderStatus("已支付");
		orderService.insert(ordertemp);

		for (int i = 1; i < len; i++) {
			CartModel cartcom = cartService.selectId(Integer.parseInt(arry[i]));
			cartService.delete(Integer.parseInt(arry[i]));
			OrderMessageModel order = new OrderMessageModel();
			order.setComId(cartcom.getComId());
			order.setComNum(cartcom.getComNum());
			ComMessageModel comtemp = comMessageService.selectId(cartcom.getComId());
			BigDecimal price = comtemp.getComPrice();
			BigDecimal num = new BigDecimal(cartcom.getComNum());
			order.setComPrice(price.multiply(num));
			order.setSellerId(comtemp.getSellerId());
			order.setOrderCode(orderCode);
			order.setUserId(user.getId());
			order.setIsdelete("n");
			orderMessageService.insert(order);
			comtemp.setComRepository(comtemp.getComRepository() - cartcom.getComNum());
			comMessageService.update(comtemp);
		}
		return "ok";
	}

	/**
	 * 将购物车选择的商品跳转到订单支付页面
	 * 
	 * @param ck
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toorder.do", method = RequestMethod.POST)
	public ModelAndView toroder(String[] ck, HttpServletRequest request) throws Exception {
		ModelAndView m = new ModelAndView();
		m.setViewName("order");
		StringBuffer temp = new StringBuffer();
		if (ck != null) {
			for (String i : ck) {
				temp.append("," + i);
			}
		}
		m.addObject("orderidlist", temp);
		return m;
	}

	/**
	 * 订单页面展示购物车订单
	 * 
	 * @param orderidlist
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/show.do", method = RequestMethod.POST)
	@ResponseBody
	public void show(String orderidlist, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String[] arry = orderidlist.split(",");
		int len = arry.length;
		List<ComMessageModel> orderList = new ArrayList<ComMessageModel>();
		for (int i = 1; i < len; i++) {
			CartModel cartcom = cartService.selectId(Integer.parseInt(arry[i]));
			ComMessageModel comtemp = comMessageService.selectId(cartcom.getComId());
			comtemp.setSellnum(cartcom.getComNum());
			orderList.add(comtemp);
		}
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", orderList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 个人中心展示该用户的订单
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/userorder.do", method = RequestMethod.POST)
	@ResponseBody
	public void userorder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		OrderMessageModel userorder = new OrderMessageModel();
		userorder.setUserId(user.getId());
		userorder.setIsdelete("n");
		List<OrderModel> orderCodeList = orderService.selectAll(new OrderModel());
		List<OrderMessageModel> orderList = orderMessageService.selectAll(userorder);
		// 设置页面数据
		int length = orderList.size();
		for (int i = 0; i < length; i++) {
			OrderMessageModel order = orderList.get(i);
			ComMessageModel com = comMessageService.selectId(order.getComId());
			order.setCom(com);
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("code", orderCodeList);
		jsonMap.put("rows", orderList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	// selllerorder
	/**
	 * 卖家中心展示该用户的订单
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/selllerorder.do", method = RequestMethod.POST)
	@ResponseBody
	public void selllerorder(OrderMessageModel userorder,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		userorder.setSellerId(user.getId());
		List<OrderMessageModel> orderList = orderMessageService.selectModel(userorder);
		// 设置页面数据
		int length = orderList.size();
		for (int i = 0; i < length; i++) {
			OrderMessageModel order = orderList.get(i);
			ComMessageModel com = comMessageService.selectId(order.getComId());
			order.setCom(com);
		}
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", userorder.getPager().getRowCount());
		jsonMap.put("rows", orderList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 直接添加订单，转到页面后直接进入订单支付页面
	 * 
	 * @param order
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/add.do")
	@ResponseBody
	public String add(CartModel order, HttpServletRequest request) throws Exception {
		cartService.insert(order);
		List<CartModel> orderlist = cartService.selectAll(order);
		StringBuffer temp = new StringBuffer();
		if (orderlist != null) {
			temp.append("," + orderlist.get(0).getId());
		}
		request.getSession().setAttribute("orderidlist", temp);
		return "ok";
	}

	// deleteit
	/**
	 * 根据id删除订单
	 * 
	 * @param order
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteit.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteit(OrderModel order, HttpServletRequest request) throws Exception {
		OrderModel ordertemp = orderService.selectId(order.getId());
		OrderMessageModel orderMess = new OrderMessageModel();
		orderMess.setOrderCode(ordertemp.getOrderCode());
		List<OrderMessageModel> orderMessList = orderMessageService.selectAll(orderMess);
		for (OrderMessageModel o : orderMessList) {
			o.setIsdelete("y");
			orderMessageService.update(o);
		}
		orderService.delete(order.getId());
		return "ok";
	}

	/**
	 * 卖家根据id删除订单
	 * 
	 * @param order
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sellerdeleteit.do", method = RequestMethod.POST)
	@ResponseBody
	public String sellerdeleteit(OrderMessageModel order, HttpServletRequest request) throws Exception {
		orderMessageService.delete(order.getId());
		return "ok";
	}

	// showmes

	/**
	 * 买家展示订单的详情
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/showmes.do")
	public ModelAndView showmes(String id, String addressId) throws Exception {
		ModelAndView m = new ModelAndView();
		m.setViewName("ordermes");
		OrderMessageModel order = orderMessageService.selectId(Integer.parseInt(id));
		m.addObject("ordermes", order);
		m.addObject("addressId", addressId);
		return m;
	}
}
