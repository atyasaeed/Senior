package net.seniorsteps.senior.dal.entity;
// Generated Jan 8, 2020 9:50:27 PM by Hibernate Tools 4.3.1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Category generated by hbm2java
 */
@Entity
@Table(name = "category", catalog = "senior_app"
)
public class Category implements java.io.Serializable {

	private Integer id;
	private Provider provider;
	private String nameAr;
	private String nameEn;
	private String descriptionAr;
	private String descriptionEn;
	private Set<Product> products = new HashSet<Product>(0);

	public Category() {
	}

	public Category(Provider provider, String nameAr, String nameEn) {
		this.provider = provider;
		this.nameAr = nameAr;
		this.nameEn = nameEn;
	}

	public Category(Provider provider, String nameAr, String nameEn, String descriptionAr, String descriptionEn, Set<Product> products) {
		this.provider = provider;
		this.nameAr = nameAr;
		this.nameEn = nameEn;
		this.descriptionAr = descriptionAr;
		this.descriptionEn = descriptionEn;
		this.products = products;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "provider_id", nullable = false)
	public Provider getProvider() {
		return this.provider;
	}

	public void setProvider(Provider provider) {
		this.provider = provider;
	}

	@Column(name = "name_ar", nullable = false)
	public String getNameAr() {
		return this.nameAr;
	}

	public void setNameAr(String nameAr) {
		this.nameAr = nameAr;
	}

	@Column(name = "name_en", nullable = false)
	public String getNameEn() {
		return this.nameEn;
	}

	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}

	@Column(name = "description_ar", length = 65535)
	public String getDescriptionAr() {
		return this.descriptionAr;
	}

	public void setDescriptionAr(String descriptionAr) {
		this.descriptionAr = descriptionAr;
	}

	@Column(name = "description_en", length = 65535)
	public String getDescriptionEn() {
		return this.descriptionEn;
	}

	public void setDescriptionEn(String descriptionEn) {
		this.descriptionEn = descriptionEn;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "category")
	public Set<Product> getProducts() {
		return this.products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

}
