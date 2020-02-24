/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.senior.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Senior Steps
 */
public class AuthManager {
	public boolean isAuthorized(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			if ("authorized".equals(cookies[i].getName())){
				return true;
			}
		}
		return false;
	}
}
