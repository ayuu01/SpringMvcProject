package com.assignment.daoImp;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import com.assignment.dao.Dao;
import com.assignment.dao.UserDao;
import com.assignment.model.User;

public class UserDaoImp implements UserDao {

	final static Logger LOG = Logger.getLogger(UserDaoImp.class);

	@Autowired
	private Dao dao;

	public void saveUser(User user) {
		LOG.info("Saving new user : " + user.getUId());
		
		dao.begin();
		dao.getSession().save(user);
		dao.commit();
		dao.close();

		LOG.info("Saved new user : " + user.getUId() + "successfully.");
	}

	public User getUser(String uId) {
		LOG.info("Retriving User : " + uId);
		
		dao.begin();
		User user = (User) dao.getSession().get(User.class, uId);
		dao.commit();
		dao.close();

		LOG.info("Retrived User : " + uId + " successfully.");
		return user;
	}
	
}