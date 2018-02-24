package st.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.core.mapper.BaseMapper;
import st.core.service.BaseService;
import st.user.mapper.UserMapper;

@Service("logResService")
public class LogResService<T> extends BaseService<T> {

	@Autowired
	private UserMapper<T> userMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return userMapper;
	}

}
