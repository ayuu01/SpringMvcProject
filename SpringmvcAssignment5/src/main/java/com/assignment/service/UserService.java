package com.assignment.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.assignment.dao.UserDao;
import com.assignment.model.User;

public class UserService {

	@Autowired
	private UserDao userdao;

	public void saveUser(String uId, String uPswd) {

		User user = new User();
		user.setUId(uId);
		user.setuPswd(uPswd);
		userdao.saveUser(user);
	}

	public boolean validateUser(String uId, String uPswd) {

		User user = userdao.getUser(uId);

		return user != null && user.getuPswd().equals(uPswd);
	}

}