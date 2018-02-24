package st.commodity.model;

import java.math.BigDecimal;

public class ComMessageModel extends ComMessagePicModel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String comName;
	private String comCode;
	private BigDecimal comPrice;
	private String comDescr;
	private Integer comRepository;
	private Integer sellerId;
	private String comStatus;
	private String comClassifyId;
	private String claname;
	private Integer sellnum;
	private Integer sellcomid;
	private BigDecimal sellPrice;
	private String urla;
	private String urlb;
	private String urlc;
	private String urld;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getComCode() {
		return comCode;
	}

	public void setComCode(String comCode) {
		this.comCode = comCode;
	}

	public BigDecimal getComPrice() {
		return comPrice;
	}

	public void setComPrice(BigDecimal comPrice) {
		this.comPrice = comPrice;
	}

	public String getComDescr() {
		return comDescr;
	}

	public void setComDescr(String comDescr) {
		this.comDescr = comDescr;
	}

	public Integer getComRepository() {
		return comRepository;
	}

	public void setComRepository(Integer comRepository) {
		this.comRepository = comRepository;
	}

	public Integer getSellerId() {
		return sellerId;
	}

	public void setSellerId(Integer sellerId) {
		this.sellerId = sellerId;
	}

	public String getComStatus() {
		return comStatus;
	}

	public void setComStatus(String comStatus) {
		this.comStatus = comStatus;
	}

	public String getComClassifyId() {
		return comClassifyId;
	}

	public void setComClassifyId(String comClassifyId) {
		this.comClassifyId = comClassifyId;
	}
	public String getClaname() {
		return claname;
	}

	public void setClaname(String claname) {
		this.claname = claname;
	}

	public Integer getSellnum() {
		return sellnum;
	}

	public void setSellnum(Integer sellnum) {
		this.sellnum = sellnum;
	}

	public Integer getSellcomid() {
		return sellcomid;
	}

	public void setSellcomid(Integer sellcomid) {
		this.sellcomid = sellcomid;
	}

	public BigDecimal getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(BigDecimal sellPrice) {
		this.sellPrice = sellPrice;
	}

	public String getUrla() {
		return urla;
	}

	public void setUrla(String urla) {
		this.urla = urla;
	}

	public String getUrlb() {
		return urlb;
	}

	public void setUrlb(String urlb) {
		this.urlb = urlb;
	}

	public String getUrlc() {
		return urlc;
	}

	public void setUrlc(String urlc) {
		this.urlc = urlc;
	}

	public String getUrld() {
		return urld;
	}

	public void setUrld(String urld) {
		this.urld = urld;
	}

}
