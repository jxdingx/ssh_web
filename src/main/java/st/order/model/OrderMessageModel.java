package st.order.model;

import java.math.BigDecimal;

import st.commodity.model.ComMessageModel;
import st.core.model.BaseModel;

public class OrderMessageModel extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer userId;
	private Integer comId;
	private Integer comNum;
	private BigDecimal comPrice;
	private String orderCode;
	private String name;
	private ComMessageModel com;
	private Integer sellerId;
    

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSellerId() {
		return sellerId;
	}

	public void setSellerId(Integer sellerId) {
		this.sellerId = sellerId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public ComMessageModel getCom() {
		return com;
	}

	public void setCom(ComMessageModel com) {
		this.com = com;
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

	public Integer getComId() {
		return comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
	}

	public Integer getComNum() {
		return comNum;
	}

	public void setComNum(Integer comNum) {
		this.comNum = comNum;
	}

	public BigDecimal getComPrice() {
		return comPrice;
	}

	public void setComPrice(BigDecimal comPrice) {
		this.comPrice = comPrice;
	}

}
