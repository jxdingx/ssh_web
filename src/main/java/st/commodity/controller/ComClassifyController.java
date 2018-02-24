package st.commodity.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import st.commodity.model.ComClassifyModel;
import st.commodity.service.ComClassifyService;
import st.core.session.HtmlUtil;

@Controller
@RequestMapping("/com_cla")
public class ComClassifyController {

	@Autowired
	private ComClassifyService<ComClassifyModel> comClassifyService;

	/**
	 * 首页展示左侧分类导航
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/cla.do", method = RequestMethod.POST)
	public void comClassify(HttpServletResponse response) throws Exception {
		List<ComClassifyModel> infoList = comClassifyService.selectAll(new ComClassifyModel());
		// 设置页面数据
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		jsonMap.put("rows", infoList);
		// System.out.println(JSONUtil.toJSONString(infoList));
		HtmlUtil.writerJson(response, jsonMap);
	}

	/**
	 * 得到一级或二级分类
	 * 
	 * @param com
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getcla.do")
	public void getComClassify2(ComClassifyModel com, HttpServletResponse response) throws Exception {
		List<ComClassifyModel> infoList = comClassifyService.selectAll(com);
		// 设置页面数据
		HtmlUtil.writerJson(response, infoList);
	}

}
