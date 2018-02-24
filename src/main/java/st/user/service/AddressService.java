package st.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import st.core.mapper.BaseMapper;
import st.core.service.BaseService;
import st.user.mapper.UserAddressMapper;

@Service("addressService")
public class AddressService<T> extends BaseService<T> {
	@Autowired
	private UserAddressMapper<T> userAddressMapper;

	@Override
	public BaseMapper<T> getMapper() {
		// TODO Auto-generated method stub
		return userAddressMapper;
	}

}
