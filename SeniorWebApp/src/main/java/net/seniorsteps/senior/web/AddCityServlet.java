/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.senior.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.MediaType;
import net.seniorsteps.bll.SeniorBLGateway;
import net.seniorsteps.senior.common.bean.CityBean;

/**
 *
 * @author Senior Steps
 */
@WebServlet(name = "AddCityServlet", urlPatterns = {"/addCity"})
public class AddCityServlet extends HttpServlet {

	private final SeniorBLGateway seniorBLGateway = new SeniorBLGateway();

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
	 * methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType(MediaType.TEXT_HTML);
		response.setCharacterEncoding(StandardCharsets.UTF_8.name());
		// integration
		boolean added = false;
		try {
			String nameAr = request.getParameter("name_ar");
			String nameEn = request.getParameter("name_en");
			CityBean cityBean = new CityBean(nameAr, nameEn);
			CityBean savedCity = seniorBLGateway.addCity(cityBean);
			added = true;
		} catch (Exception e) {
			added = false;
		}

		// viewing
		response.sendRedirect("cities.jsp?s=" + added);
		
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		processRequest(request, response);
		response.sendError(405);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
