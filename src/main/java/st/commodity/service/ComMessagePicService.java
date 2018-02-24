package st.commodity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.commodity.mapper.ComMessagePicMapper;
import st.core.mapper.BaseMapper;
import st.core.service.BaseService;

@Service("comMessagePicServices")
public class ComMessagePicService<T> extends BaseService<T> {
	@Autowired
	private ComMessagePicMapper<T> comMessagePicMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return comMessagePicMapper;
	}

}
