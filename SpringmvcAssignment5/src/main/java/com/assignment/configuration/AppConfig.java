package com.assignment.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.assignment.dao.Dao;
import com.assignment.dao.UserDao;
import com.assignment.daoImp.DaoImp;
import com.assignment.daoImp.UserDaoImp;
import com.assignment.service.UserService;

@Configuration
@EnableScheduling
public class AppConfig {

	@Bean
	public Dao getDao() {
		return new DaoImp();
	}

	@Bean
	public UserDao getUserDao() {
		return new UserDaoImp();
	}

	@Bean
	public UserService getUserService() {
		return new UserService();
	}
	
//	@Bean
//	public BookDao getBookDao() {
//		return new BookDaoImp();
//	}
//
//	@Bean
//	public BookService getBookService() {
//		return new BookService();
//	}

}