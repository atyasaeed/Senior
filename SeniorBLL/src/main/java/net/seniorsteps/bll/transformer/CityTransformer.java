/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.bll.transformer;

import java.util.ArrayList;
import net.seniorsteps.senior.common.bean.AreaBean;
import net.seniorsteps.senior.common.bean.CityBean;
import net.seniorsteps.senior.common.constant.SeniorConstant;
import net.seniorsteps.senior.dal.entity.Area;
import net.seniorsteps.senior.dal.entity.City;

/**
 *
 * @author Senior Steps
 */
public class CityTransformer implements SeniorConstant, CommonTransformer<City, CityBean> {

	private AreaTransformer areaTransformer = new AreaTransformer();

	@Override
	public CityBean fromEntityToBean(City cityEntity, String lang) {
		CityBean cityBean = new CityBean();
		cityBean.setId(cityEntity.getId());
		cityBean.setNameAr(cityEntity.getNameAr());
		cityBean.setNameEn(cityEntity.getNameEn());
		if (LANG_AR.equals(lang)) {
			cityBean.setName(cityEntity.getNameAr());
		} else {
			cityBean.setName(cityEntity.getNameEn());
		}
		return cityBean;
	}

	public CityBean fromEntityToBeanWithAreas(City cityEntity, String lang) {
		CityBean cityBean = fromEntityToBean(cityEntity, lang);
		cityBean.setAreasList(new ArrayList<>());
		for (Area areaEntity : cityEntity.getAreas()) {
			AreaBean areaBean = areaTransformer.fromEntityToBean(areaEntity, lang);
			cityBean.getAreasList().add(areaBean);
		}
		return cityBean;
	}

	@Override
	public City fromBeanToEntity(CityBean cityBean) {
		City city = new City();
		city.setId(cityBean.getId());
		city.setNameAr(cityBean.getNameAr());
		city.setNameEn(cityBean.getNameEn());
		return city;
	}
}
