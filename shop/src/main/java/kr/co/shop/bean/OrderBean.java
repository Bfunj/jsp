package kr.co.shop.bean;

public class OrderBean {
	private int orderNo;
	private String orderid;
	private int orderproduct;
	private int ordercount;
	private String orderdate;
	private String name;
	
	private String prodName;
	public int getOrderNo() {
		return orderNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public int getOrderproduct() {
		return orderproduct;
	}
	public void setOrderproduct(int orderproduct) {
		this.orderproduct = orderproduct;
	}
	public int getOrdercount() {
		return ordercount;
	}
	public void setOrdercount(int ordercount) {
		this.ordercount = ordercount;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	
	
	
	
}
