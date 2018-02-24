package st.order.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
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
import st.commodity.model.ComMessageModel;
import st.commodity.service.ComMessageService;
import st.core.session.HtmlUtil;
import st.order.model.CartModel;
import st.order.service.CartService;
import st.user.model.UserModel;

@Controller
@RequestMapping("/car")
public class CartController {

	@Autowired
	private CartService<CartModel> cartService;
	@Autowired
	private ComMessageService<ComMessageModel> comMessageService;

	/**
	 * 添加商品到购物车
	 * 
	 * @param order
	 * @throws Exception
	 */
	@RequestMapping("/add.do")
	@ResponseBody
	public void add(CartModel order) throws Exception {
		CartModel ordertemp = new CartModel();
		ordertemp.setComId(order.getComId());
		ordertemp.setUserId(order.getUserId());
		List<CartModel> orderList = cartService.selectAll(ordertemp);
		if (orderList != null && !orderList.isEmpty()) {
			CartModel ordertemp2 = orderList.get(0);
			int num1 = ordertemp2.getComNum();
			int num2 = order.getComNum();
			ordertemp2.setComNum(num1 + num2);
			cartService.update(ordertemp2);
		} else {
			cartService.insert(order);
		}
	}

	/**
	 * 根据id删除购物车
	 * 
	 * @param order
	 * @throws Exception
	 */
	@RequestMapping("/delete.do")
	@ResponseBody
	public void delete(CartModel order) throws Exception {
		cartService.delete(order.getId());
	}

	/**
	 * 根据id修改购物车
	 * 
	 * @param order
	 * @throws Exception
	 */
	@RequestMapping("/update.do")
	@ResponseBody
	public void update(CartModel order) throws Exception {
		cartService.delete(order.getId());
	}

	// shownum
	/**
	 * 展示购物车数量
	 * 
	 * @param order
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/shownum.do")
	@ResponseBody
	public String shownum(CartModel order) throws Exception {
		return String.valueOf(cartService.selectCount(order));
	}

	/**
	 * 展示该用户的购物车中商品
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	// @AuthLogin(verifyLogin = true)
	@RequestMapping(value = "/show.do", method = RequestMethod.POST)
	@ResponseBody
	public void show(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		CartModel cart = new CartModel();
		cart.setUserId(user.getId());
		List<CartModel> orderList = cartService.selectAll(cart);
		List<ComMessageModel> infoList = new ArrayList<ComMessageModel>();
		for (CartModel o : orderList) {
			ComMessageModel c = new ComMessageModel();
			c.setId(o.getComId());
			List<ComMessageModel> infoListtemp = comMessageService.selectAll(c);
			ComMessageModel cc = infoListtemp.get(0);
			cc.setSellnum(o.getComNum());
			cc.setSellcomid(o.getId());
			cc.setCreateTime(o.getCreateTime());

			BigDecimal price = cc.getComPrice();
			BigDecimal num = new BigDecimal(o.getComNum());
			BigDecimal prices = price.multiply(num);
			cc.setSellPrice(prices);

			infoList.add(cc);
		}
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 计算选择的购物车订单的总价
	 * 
	 * @param str
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/account.do", method = RequestMethod.POST)
	@ResponseBody
	public String account(String str, HttpServletRequest request) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		CartModel cart = new CartModel();
		cart.setUserId(user.getId());
		List<CartModel> orderList = new ArrayList<CartModel>();
		String[] arry = str.split(",");
		int len = arry.length;
		for (int i = 1; i < len; i++) {
			CartModel cartcom = cartService.selectId(Integer.parseInt(arry[i]));
			orderList.add(cartcom);
		}
		if (orderList == null || orderList.isEmpty()) {
			return "0";
		}
		BigDecimal prices = new BigDecimal("0");
		for (CartModel o : orderList) {
			ComMessageModel comtemp = comMessageService.selectId(o.getComId());
			BigDecimal price = comtemp.getComPrice();
			BigDecimal num = new BigDecimal(o.getComNum());
			prices = prices.add(price.multiply(num));
		}
		return prices.toString();
	}

	// numchange
	/**
	 * 购物车商品数量变化后的总价
	 * 
	 * @param cart
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/numchange.do", method = RequestMethod.POST)
	@ResponseBody
	public String numchange(CartModel cart, HttpServletRequest request) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		cart.setUserId(user.getId());
		cartService.updateActive(cart);
		CartModel carttemp = cartService.selectId(cart);
		ComMessageModel comtemp = comMessageService.selectId(carttemp.getComId());
		BigDecimal price = comtemp.getComPrice();
		BigDecimal num = new BigDecimal(cart.getComNum());
		BigDecimal prices = price.multiply(num);
		return prices.toString();
	}
}
