package st.commodity.controller;

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

@Controller
@RequestMapping("/search")
public class ComSearchController {

	@Autowired
	private ComMessageService<ComMessageModel> comMessageService;

	/**
	 * 点击搜索框，回到前台跳转到search页面
	 * 
	 * @param comName
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/tosearch.do", method = RequestMethod.POST)
	@ResponseBody
	public String tosearch(String comName, HttpServletRequest request) {
		request.getSession().setAttribute("comName", comName);
		return "ok";
	}

	/**
	 * 点击首页左侧分类，回到前台跳转到search页面
	 * 
	 * @param comClassifyId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/tocomCla.do")
	@ResponseBody
	public ModelAndView comCla(String comClassifyId, HttpServletRequest request) {
		ModelAndView m = new ModelAndView();
		m.setViewName("comcla");
		m.addObject("comClassifyId", comClassifyId);
		return m;
	}

	/**
	 * 根据商品名搜索数据库
	 * 
	 * @param com
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/bycomName.do", method = RequestMethod.POST)
	@ResponseBody
	public void comsearch(ComMessageModel com, HttpServletResponse response) throws Exception {
		List<ComMessageModel> infoList = comMessageService.selectModel(com);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", com.getPager().getRowCount());
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 根据商品id搜索数据库
	 * 
	 * @param comId
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/bycomId.do", method = RequestMethod.POST)
	@ResponseBody
	public void bycomId(String comId, HttpServletResponse response) throws Exception {
		ComMessageModel com = comMessageService.selectId(Integer.parseInt(comId));
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("com", com);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 根据商品分类搜索数据库
	 * 
	 * @param com
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/bycomClassifyId.do")
	@ResponseBody
	public void comcla(ComMessageModel com, HttpServletResponse response) throws Exception {
		List<ComMessageModel> infoList = comMessageService.selectModel(com);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", com.getPager().getRowCount());
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 点击商品，进入商品详情页
	 * 
	 * @param com
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/show.do")
	public ModelAndView comshow(ComMessageModel com, HttpServletResponse response) throws Exception {
		List<ComMessageModel> infoList = comMessageService.selectAll(com);
		// 设置页面数据
		ModelAndView m = new ModelAndView();
		m.setViewName("introduction");
		m.addObject("com", infoList.get(0));
		return m;
	}

}
