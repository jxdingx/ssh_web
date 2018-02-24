package st.user.controller;

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

import st.core.session.HtmlUtil;
import st.user.model.UserAddressModel;
import st.user.model.UserModel;
import st.user.service.AddressService;

@Controller
@RequestMapping("/address")
public class AddressController {
	@Autowired
	private AddressService<UserAddressModel> addressService;

	/**
	 * 展示该用户的地址
	 * 
	 * @param useradd
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/show.do", method = RequestMethod.POST)
	@ResponseBody
	public void show(UserAddressModel useradd, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		useradd.setUserId(user.getId());
		List<UserAddressModel> addlist = addressService.selectAll(useradd);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", addlist);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 跳转到地址修改页面
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toupdate.do")
	@ResponseBody
	public ModelAndView toaddressupdate(String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ModelAndView m = new ModelAndView();
		m.setViewName("address_update");
		m.addObject("addresid", id);
		return m;
	}

	/**
	 * 修改时改地址的信息
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/showupdate.do", method = RequestMethod.POST)
	public void update(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserAddressModel useradd = addressService.selectId(Integer.parseInt(id));
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("useradd", useradd);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 更新地址
	 * 
	 * @param useradd
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	@ResponseBody
	public String update(UserAddressModel useradd, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		useradd.setUserId(user.getId());
		if (useradd.getId() == null) {
			int num = addressService.selectCount(new UserAddressModel());
			if (num == 3) {
				return "overnum";
			}
			addressService.insert(useradd);
			return "insert";
		}
		addressService.update(useradd);
		return "update";
	}

	/**
	 * 根据id删除地址
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete.do")
	public String delete(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		addressService.delete(Integer.parseInt(id));
		return "address";
	}

}
