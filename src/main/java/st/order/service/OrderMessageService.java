package st.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.core.mapper.BaseMapper;
import st.core.service.BaseService;
import st.order.mapper.OrderMessageMapper;

@Service("orderMessageService")
public class OrderMessageService<T> extends BaseService<T> {
	@Autowired
	private OrderMessageMapper<T> orderMessageMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return orderMessageMapper;
	}
	
	
}
