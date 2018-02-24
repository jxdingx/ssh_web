package st.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.core.mapper.BaseMapper;
import st.core.service.BaseService;
import st.order.mapper.OrderMapper;
@Service("orderService")
public class OrderService<T>  extends BaseService<T> {

	@Autowired
	private OrderMapper<T> orderMapper;
	
	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return orderMapper;
	}

}
