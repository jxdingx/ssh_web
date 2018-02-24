package st.commodity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.commodity.mapper.ComClassifyMapper;
import st.core.mapper.BaseMapper;
import st.core.service.BaseService;

@Service("comClassifyServices")
public class ComClassifyService<T> extends BaseService<T> {

	@Autowired
	private ComClassifyMapper<T> comClassifyMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return comClassifyMapper;
	}

}
