package st.commodity.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
@RequestMapping("/show")
public class ComShowController {

	@Autowired
	private ComMessageService<ComMessageModel> comMessageService;

	/**
	 * 得到首页需展示在今日推荐栏的商品
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/today.do", method = RequestMethod.POST)
	@ResponseBody
	public void comtoday(HttpServletResponse response) throws Exception {
		ComMessageModel com = new ComMessageModel();
		com.setComStatus("今日推荐");
		List<ComMessageModel> infoList = comMessageService.selectAll(com);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 得到首页需展示在商品展示栏的商品
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/comshow.do", method = RequestMethod.POST)
	@ResponseBody
	public void comshow(HttpServletResponse response) throws Exception {
		ComMessageModel com = new ComMessageModel();
		com.setComStatus("商品展示");
		List<ComMessageModel> infoList = comMessageService.selectAll(com);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 搜索页的商品显示，带有分页
	 * 
	 * @param com
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getdata.do", method = RequestMethod.POST)
	@ResponseBody
	public void comdata(ComMessageModel com, HttpServletResponse response) throws Exception {
		List<ComMessageModel> infoList = comMessageService.selectModel(com);
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("total", com.getPager().getRowCount());
		jsonMap.put("rows", infoList);
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 详情页面的商品显示
	 * 
	 * @param com
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/introduction.do")
	public ModelAndView comshow(ComMessageModel com, HttpServletResponse response) throws Exception {
		List<ComMessageModel> infoList = comMessageService.selectAll(com);
		// 设置页面数据
		ModelAndView m = new ModelAndView();
		m.setViewName("introduction");
		m.addObject("com", infoList.get(0));
		return m;
	}
}
