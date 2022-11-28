package kr.co.Farmstory2.service;

import kr.co.Farmstory2.dao.ArticleDao;

public enum ArticleService {
	INSTANCE;
	private ArticleDao dao = ArticleDao.getInstance();
	
}
