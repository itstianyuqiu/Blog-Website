package Utilities;

import java.util.List;

public class QuaryModal<T> {
	private int pageNO;// current page
	private int pageSize;// every page show size
	private int num;// totily size
	private List<T> list;// who  use this model

	public int getPageNO() {

		return pageNO;
		
	}

	public void setPageNO(int pageNO) {
		if (pageNO < 1) {
			pageNO = 1;
		}
		this.pageNO = pageNO;
		
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public int getPageal() {// all pages size
		int all;
		all=num % pageSize == 0 ? num / pageSize : (num / pageSize) + 1;
		if(all==0)all=1;
		return all;
	}

	public int getPropage() {//  pro page
		pageNO=this.pageNO ;
		if (pageNO <1) {
			return 1;
		}
		return pageNO - 1;
	}

	public int getNextpage() {// next page
		pageNO = this.pageNO;
		if (pageNO >=getPageal()) {
			return getPageal();
		}
		return pageNO + 1;
	}

	public int getFirstpage() {// first page

		return 1;
	}

	public int getLastpage() {// last page
		return getPageal();
	}
}
