/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.bll;

import java.util.List;
import net.seniorsteps.bll.manager.LookupsManager;
import net.seniorsteps.bll.manager.MenuManager;
import net.seniorsteps.bll.manager.impl.LookupsManagerImpl;
import net.seniorsteps.bll.manager.impl.MenuManagerImpl;
import net.seniorsteps.senior.common.bean.CityBean;
import net.seniorsteps.senior.common.bean.ProductBean;

/**
 *
 * @author Senior Steps
 */
public class SeniorBLGateway {

	private MenuManager menuManager = new MenuManagerImpl();
	private LookupsManager lookupsManager = new LookupsManagerImpl();

	public List<CityBean> findCities() {
		return lookupsManager.findCities();
	}

	public CityBean addCity(CityBean cityBean) {
		return lookupsManager.addCity(cityBean);
	}

	public ProductBean addProduct(ProductBean product) {
		return menuManager.addProduct(product);
	}

	public CityBean getCity(Integer id) {
		return lookupsManager.getCity(id);
	}

}
