package st.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.core.mapper.BaseMapper;
import st.core.service.BaseService;
import st.order.mapper.CartMapper;

@Service("carService")
public class CartService<T> extends BaseService<T> {
	@Autowired
	private CartMapper<T> cartMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return cartMapper;
	}

}
