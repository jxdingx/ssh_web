package st.commodity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.commodity.mapper.ComMessageMapper;
import st.core.mapper.BaseMapper;
import st.core.service.BaseService;

@Service("comMessageServices")
public class ComMessageService<T> extends BaseService<T> {
	@Autowired
	private ComMessageMapper<T> comMessageMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return comMessageMapper;
	}

}
