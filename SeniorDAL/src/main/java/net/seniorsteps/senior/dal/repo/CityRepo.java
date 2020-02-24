/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.seniorsteps.senior.dal.repo;

import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import net.seniorsteps.senior.dal.entity.City;
import static net.seniorsteps.senior.dal.DBConnectionManager.getCurrentSession;
import org.hibernate.query.Query;

/**
 *
 * @author Senior Steps
 */
public class CityRepo extends AbstractEntityRepo<City> {

	public CityRepo() {
		super(City.class);
		this.setDefaultOrder("nameAr");
	}

	public City updateHQL(City city) {
		String hqlQuery = "UPDATE City SET nameAr = :na, nameEn = :ne WHERE id = :id";
		Query insertQuery = getCurrentSession().createQuery(hqlQuery);
		insertQuery.setParameter("na", city.getNameAr());
		insertQuery.setParameter("ne", city.getNameEn());
		insertQuery.setParameter("id", city.getId());
		int affectedRecords = insertQuery.executeUpdate();
		System.out.println("AFFECTED RECORDS : " + affectedRecords);
		return city;
	}

	public List<City> findLike(String keyword) {
		String pattern = "%" + keyword + "%";
		CriteriaBuilder criteriaBuilder = getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<City> cityCirteriaQuery = criteriaBuilder.createQuery(City.class);
		Root<City> root = cityCirteriaQuery.from(City.class);
		cityCirteriaQuery.select(root);
		Predicate[] likeConditions = new Predicate[2];
		likeConditions[0] = criteriaBuilder.like(root.get("nameAr"), pattern);
		likeConditions[1] = criteriaBuilder.like(root.get("nameEn"), pattern);
		cityCirteriaQuery.where(criteriaBuilder.or(likeConditions));
		cityCirteriaQuery.orderBy(criteriaBuilder.asc(root.get("nameAr")));
		Query<City> cityQuery = getCurrentSession().createQuery(cityCirteriaQuery);
		List<City> cityResultList = cityQuery.getResultList();
		return cityResultList;
	}

	public List<City> findListByHQL() {
		String hqlQuery = "FROM City ORDER BY nameAr";
		Query cityQuery = getCurrentSession().createQuery(hqlQuery);
		List<City> cityResultList = cityQuery.list();
		return cityResultList;
	}

	public List<City> findLikeByHQL(String keyword) {
		String hqlQuery = "FROM City "
				+ "WHERE nameAr LIKE :n OR nameEn LIKE :n "
				+ "ORDER BY nameAr";
		Query<City> cityQuery = getCurrentSession().createQuery(hqlQuery);
		String pattern = "%" + keyword + "%";
		cityQuery.setParameter("n", pattern);
		List<City> cityResultList = cityQuery.list();
		return cityResultList;
	}

	public Long countLike(String keyword) {
		String pattern = "%" + keyword + "%";
		CriteriaBuilder criteriaBuilder = getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<Long> cityCirteriaQuery = criteriaBuilder.createQuery(Long.class);
		Root<City> root = cityCirteriaQuery.from(City.class);
		cityCirteriaQuery.select(criteriaBuilder.count(root));
		Predicate[] likeConditions = new Predicate[2];
		likeConditions[0] = criteriaBuilder.like(root.get("nameAr"), pattern);
		likeConditions[1] = criteriaBuilder.like(root.get("nameEn"), pattern);
		cityCirteriaQuery.where(criteriaBuilder.or(likeConditions));
		Query<Long> countQuery = getCurrentSession().createQuery(cityCirteriaQuery);
		List<Long> cityResultList = countQuery.getResultList();

		return cityResultList.get(0);

	}

}
