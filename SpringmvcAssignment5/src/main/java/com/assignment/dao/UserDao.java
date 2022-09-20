package com.assignment.dao;

import com.assignment.model.User;

public interface UserDao {

	public void saveUser(User user);

	public User getUser(String uId);
}