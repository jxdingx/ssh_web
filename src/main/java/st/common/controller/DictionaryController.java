package st.common.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import st.common.model.DictionaryModel;
import st.common.service.DictionaryServices;
import st.core.session.HtmlUtil;

@Controller
@RequestMapping("dict")
public class DictionaryController {
	@Autowired
	private DictionaryServices<DictionaryModel> dictionaryServices;

	/**
	 * 得到地址一级二级三级分类
	 * 
	 * @param dict
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getcla.do")
	public void getComClassify2(DictionaryModel dict, HttpServletResponse response) throws Exception {
		List<DictionaryModel> infoList = dictionaryServices.selectAll(dict);
		// 设置页面数据
		HtmlUtil.writerJson(response, infoList);
	}
}
