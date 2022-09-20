package com.assignment.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.assignment.dao.Dao;
import com.assignment.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private Dao dao;
	
	@RequestMapping("/SignIn")
	public ModelAndView signIn(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		ModelAndView mv = new ModelAndView();

		String uId = request.getParameter("uId");
		String uPswd = request.getParameter("uPswd");

		if(!userService.validateUser(uId, uPswd)) {
			mv.setViewName("index");
			return mv;
		}
		session.setAttribute("uId", uId);
		mv.addObject("uId", uId);
		mv.setViewName("booklist1");

		return mv;
	}

	@RequestMapping("/SignUp")
	public ModelAndView signUp(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();

		String uId = request.getParameter("uId");
		String uPswd = request.getParameter("uPswd");
		String cuPswd = request.getParameter("cuPswd");

		if (!uPswd.equals(cuPswd)) {
			mv.setViewName("index");
			return mv;
		}

		userService.saveUser(uId, uPswd);

		mv.addObject("uId", uId);
		mv.setViewName("booklist1");
		return mv;
	}
	
	@RequestMapping("/SignOut")
	public ModelAndView signOut(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("uId", null);
		mv.setViewName("index");
		
		session.invalidate();
		//dao.getSession().clear();
		return mv;
	}
}