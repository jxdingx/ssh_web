package st.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import st.core.tool.Constant;
import st.tool.FormatMD5;
import st.user.model.UserModel;
import st.user.service.LogResService;

@Controller
@RequestMapping("/user")
public class LogResController {
	@Autowired
	private LogResService<UserModel> logResService;

	/**
	 * 用户登陆
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@ResponseBody
	public String login(UserModel user, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String code = (String) request.getSession().getAttribute(Constant.SYS_SESSION_VALIDATECODE);
		if (!code.equalsIgnoreCase(user.getCode())) {
			return "err_code";
		}
		user.setUserPass(FormatMD5.MD5(user.getUserPass()));
		List<UserModel> listtemp = logResService.selectAll(user);
		if (listtemp == null || listtemp.isEmpty()) {
			return "notexits"; // 返回无此用户
		}
		UserModel userTemp = listtemp.get(0); // 得到该用户信息
		request.getSession().setAttribute("user", userTemp); // 存入session

		if ("0".equals(userTemp.getIsuser())) {
			return "isseller"; // 若为卖家跳转到admin
		}
		return "ok"; // 返回登陆成功
	}

	/**
	 * 用户注册
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	@ResponseBody
	public String register(UserModel user, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String code = (String) request.getSession().getAttribute(Constant.SYS_SESSION_VALIDATECODE);
		if (!code.equalsIgnoreCase(user.getCode())) {
			return "err_code";
		}
		UserModel userTemp = new UserModel();
		userTemp.setUserName(user.getUserName());
		List<UserModel> listtemp = logResService.selectAll(userTemp);
		if (listtemp != null && !listtemp.isEmpty()) {
			return "userrep"; // 返回账号重复 userrep
		}
		user.setUserPass(FormatMD5.MD5(user.getUserPass()));
		logResService.insert(user);
		return "ok";
	}

	/**
	 * 退出登陆
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/exit.do")
	public ModelAndView exit(HttpServletRequest request) {
		request.getSession().removeAttribute("user"); // 移除session
		ModelAndView m = new ModelAndView();
		m.setViewName("home");
		return m;
	}
	// updateName

	/**
	 * 用户昵称跟新
	 * 
	 * @param newName
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateName.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateName(String newName, HttpServletRequest request) throws Exception {

		UserModel user = (UserModel) request.getSession().getAttribute("user");
		if (newName != null) {
			user.setName(newName);
			logResService.update(user);
			request.getSession().setAttribute("user", user);
			return "ok";
		}
		return "fail";
	}

//	@RequestMapping("/tologin.do")
//	public ModelAndView login11(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		ModelAndView m = new ModelAndView();
//		m.setViewName("login");
//		System.out.println("aaaaaaaa");
//		return m;
//	}

}
