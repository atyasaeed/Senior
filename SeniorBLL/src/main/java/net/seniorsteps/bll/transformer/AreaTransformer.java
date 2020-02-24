/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.bll.transformer;

import net.seniorsteps.senior.common.bean.AreaBean;
import net.seniorsteps.senior.common.constant.SeniorConstant;
import net.seniorsteps.senior.dal.entity.Area;

/**
 *
 * @author Senior Steps
 */
public class AreaTransformer implements SeniorConstant, CommonTransformer<Area, AreaBean> {

	@Override
	public AreaBean fromEntityToBean(Area entity, String lang) {
		AreaBean areaBean = new AreaBean();
		areaBean.setId(entity.getId());
		areaBean.setNameAr(entity.getNameAr());
		areaBean.setNameEn(entity.getNameEn());
//		if (LANG_AR.equals(lang)) {
//			areaBean.setName(entity.getNameAr());
//		} else {
//			areaBean.setName(entity.getNameEn());
//		}
		return areaBean;
	}

	@Override
	public Area fromBeanToEntity(AreaBean bean) {
		throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
	}

}
