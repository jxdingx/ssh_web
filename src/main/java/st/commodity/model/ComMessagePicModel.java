package st.commodity.model;

import st.core.model.BaseModel;

public class ComMessagePicModel extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer comId;
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

	public Integer getComId() {
		return comId;
	}

	public void setComId(Integer comId) {
		this.comId = comId;
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
