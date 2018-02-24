package st.user.model;

import st.core.model.BaseModel;

public class UserAddressModel extends BaseModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer userId;
	private String userName;
	private String userSheng;
	private String userShi;
	private String userQu;
	private String userAddress;

	private String userShengname;
	private String userShiname;
	private String userQuname;

	public String getUserShengname() {
		return userShengname;
	}

	public void setUserShengname(String userShengname) {
		this.userShengname = userShengname;
	}

	public String getUserShiname() {
		return userShiname;
	}

	public void setUserShiname(String userShiname) {
		this.userShiname = userShiname;
	}

	public String getUserQuname() {
		return userQuname;
	}

	public void setUserQuname(String userQuname) {
		this.userQuname = userQuname;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserSheng() {
		return userSheng;
	}

	public void setUserSheng(String userSheng) {
		this.userSheng = userSheng;
	}

	public String getUserShi() {
		return userShi;
	}

	public void setUserShi(String userShi) {
		this.userShi = userShi;
	}

	public String getUserQu() {
		return userQu;
	}

	public void setUserQu(String userQu) {
		this.userQu = userQu;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

}
