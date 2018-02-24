package st.commodity.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import st.commodity.model.ComClassifyModel;
import st.commodity.model.ComMessageModel;
import st.commodity.model.ComMessagePicModel;
import st.commodity.service.ComClassifyService;
import st.commodity.service.ComMessagePicService;
import st.commodity.service.ComMessageService;
import st.core.session.HtmlUtil;
import st.user.model.UserModel;

@Controller
@RequestMapping("/update")
public class ComUpdateController {
	@Autowired
	private ComMessageService<ComMessageModel> comMessageService;
	@Autowired
	private ComMessagePicService<ComMessagePicModel> comMessagePicService;

	@Autowired
	private ComClassifyService<ComClassifyModel> comClassifyService;

	/**
	 * 商品添加
	 * 
	 * @param file
	 * @param com
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	@ResponseBody
	public String insert(@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "file1", required = false) MultipartFile file1,
			@RequestParam(value = "file2", required = false) MultipartFile file2,
			@RequestParam(value = "file3", required = false) MultipartFile file3, ComMessageModel com,
			HttpServletRequest request) throws Exception {
		UserModel user = (UserModel) request.getSession().getAttribute("user");
		com.setComCode(String.valueOf((int)(Math.random()*10000)));
		ComMessageModel comtemp = new ComMessageModel();
		comtemp.setComCode(com.getComCode());
		List<ComMessageModel> list = comMessageService.selectAll(comtemp);
		if (list != null && !list.isEmpty()) {
			return "rep";
		}
		com.setSellerId(user.getId());
		com.setComStatus("上架");
		comMessageService.insert(com);
		ComMessagePicModel compic = new ComMessagePicModel();
		compic.setComId(com.getId());
		if (!file.isEmpty()) {
			compic.setUrla(this.uploadimg(file, request));
		}
		if (!file1.isEmpty()) {
			compic.setUrlb(this.uploadimg(file1, request));
		}
		if (!file2.isEmpty()) {
			compic.setUrlc(this.uploadimg(file2, request));
		}
		if (!file3.isEmpty()) {
			compic.setUrld(this.uploadimg(file3, request));
		}
		comMessagePicService.insert(compic);
		return "ok";
	}

	private String uploadimg(MultipartFile file, HttpServletRequest request) {
		String path = request.getSession().getServletContext().getRealPath("images");
		String name = file.getOriginalFilename();
		String fileType = name.substring(name.lastIndexOf("."));
		String fileName = new Date().getTime() + fileType;
		File targetFile = new File(path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		// 保存图片
		try {
			file.transferTo(targetFile);

		} catch (Exception e) {
			e.printStackTrace();
		}
		String realpath = request.getContextPath() + "/images/" + fileName;
		return realpath;
	}

	/**
	 * 跳转到商品更新页面
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/toupdate.do", method = RequestMethod.POST) //
	@ResponseBody
	public void toupdate(String id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessageModel com = comMessageService.selectId(id);
		ComClassifyModel comclatemp = new ComClassifyModel();
		comclatemp.setId(Integer.parseInt(com.getComClassifyId()));

		ComClassifyModel comcla2 = comClassifyService.selectId(comclatemp);
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		ComClassifyModel comcla2temp = new ComClassifyModel();
		comcla2temp.setCode(comcla2.getParCode());

		List<ComClassifyModel> comcla1list = comClassifyService.selectAll(comcla2temp);
		if (comcla1list != null && !comcla1list.isEmpty()) {
			ComClassifyModel comcla1 = comcla1list.get(0);
			// request.getSession().setAttribute("comcla1", comcla1.getCode());
			jsonMap.put("comcla1", comcla1.getCode());
		}
		jsonMap.put("comcla2", comcla2.getId());
		// request.getSession().setAttribute("comcla2", comcla2.getId());
		jsonMap.put("com", com);
		HtmlUtil.writerJson(response, jsonMap);
		request.getSession().setAttribute("com", com);
	}

	/**
	 * 商品数据更新
	 * 
	 * @param file
	 * @param com
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST) //
	@ResponseBody
	public String update(@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "file1", required = false) MultipartFile file1,
			@RequestParam(value = "file2", required = false) MultipartFile file2,
			@RequestParam(value = "file3", required = false) MultipartFile file3, ComMessageModel com,
			HttpServletRequest request) throws Exception {
		ComMessageModel comTemp = (ComMessageModel) request.getSession().getAttribute("com");
		com.setId(comTemp.getId());
		com.setSellerId(comTemp.getSellerId());
		com.setComStatus(comTemp.getComStatus());
		ComMessageModel comtemp = new ComMessageModel();
		comtemp.setComCode(com.getComCode());
		if (!comTemp.getComCode().equals(com.getComCode())) {
			List<ComMessageModel> list = comMessageService.selectAll(comtemp);
			if (list != null && !list.isEmpty()) {
				return "rep";
			}
		}
		ComMessagePicModel compic = new ComMessagePicModel();
		compic.setComId(com.getId());
		if (!file.isEmpty()) { // 更新urla图片的执行
			this.updateimg(file, comTemp.getUrla(), request);
		}
		compic.setUrla(comTemp.getUrla());
		if (!file1.isEmpty()) { // 更新urlb图片的执行
			if (comTemp.getUrlb() == null) {
				compic.setUrlb(uploadimg(file1, request));
			} else {
				compic.setUrlb(comTemp.getUrlb());
				this.updateimg(file1, comTemp.getUrlb(), request);
			}
		} else {
			compic.setUrlb(comTemp.getUrlb());
		}
		if (!file2.isEmpty()) {
			if (comTemp.getUrlc() == null) {
				compic.setUrlc(uploadimg(file2, request));
			} else {
				compic.setUrlc(comTemp.getUrlc());
				this.updateimg(file2, comTemp.getUrlc(), request);
			}
		} else {
			compic.setUrlc(comTemp.getUrlc());
		}
		if (!file3.isEmpty()) {
			if (comTemp.getUrld() == null) {
				compic.setUrld(uploadimg(file3, request));
			} else {
				compic.setUrld(comTemp.getUrld());
				this.updateimg(file3, comTemp.getUrld(), request);
			}
		} else {
			compic.setUrld(comTemp.getUrld());
		}
		comMessageService.update(com);
		comMessagePicService.update(compic);
		return null;
	}

	private void updateimg(MultipartFile file, String realpath, HttpServletRequest request) {
		String filename = realpath.split("/")[3];
		String path = request.getSession().getServletContext().getRealPath("images");
		File targetFile = new File(path, filename);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		// 保存图片
		try {
			targetFile.delete();
			file.transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// delete

	/**
	 * 商品根据id删除
	 * 
	 * @param com
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST) //
	@ResponseBody
	public String delete(ComMessageModel com, HttpServletRequest request) throws Exception {
		comMessageService.delete(com.getId());
		ComMessagePicModel cp = new ComMessagePicModel();
		cp.setComId(com.getId());
		List<ComMessagePicModel> compic = comMessagePicService.selectAll(cp);
		if (compic != null && !compic.isEmpty()) {
			ComMessagePicModel compictemp = compic.get(0);
			comMessagePicService.delete(compictemp.getId());
			String filename = compictemp.getUrla().split("/")[3];
			String path = request.getSession().getServletContext().getRealPath("images");
			File targetFile = new File(path, filename);
			targetFile.delete();
			if (compictemp.getUrlb() != null) {
				String filename1 = compictemp.getUrlb().split("/")[3];
				targetFile = new File(path, filename1);
				targetFile.delete();
			}
			if (compictemp.getUrlc() != null) {
				String filename2 = compictemp.getUrlc().split("/")[3];
				targetFile = new File(path, filename2);
				targetFile.delete();
			}
			if (compictemp.getUrld() != null) {
				String filename3 = compictemp.getUrld().split("/")[3];
				targetFile = new File(path, filename3);
				targetFile.delete();
			}
		}

		return "ok";
	}
}
