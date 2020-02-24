-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema senior_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema senior_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `senior_app` DEFAULT CHARACTER SET utf8 ;
USE `senior_app` ;

-- -----------------------------------------------------
-- Table `senior_app`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`provider` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_ar` VARCHAR(255) NOT NULL,
  `name_en` VARCHAR(255) NOT NULL,
  `hotline` VARCHAR(15) NULL,
  `logo_path_ar` VARCHAR(255) NULL,
  `logo_path_en` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_ar_UNIQUE` (`name_ar` ASC),
  UNIQUE INDEX `name_en_UNIQUE` (`name_en` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name_ar` VARCHAR(100) NOT NULL,
  `name_en` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_ar_UNIQUE` (`name_ar` ASC),
  UNIQUE INDEX `name_en_UNIQUE` (`name_en` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`area` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_id` INT NOT NULL,
  `name_ar` VARCHAR(100) NOT NULL,
  `name_en` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_area_city1_idx` (`city_id` ASC),
  CONSTRAINT `fk_area_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `senior_app`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`branch` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provider_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `name_ar` VARCHAR(255) NOT NULL,
  `name_en` VARCHAR(255) NOT NULL,
  `open_at` TIME NOT NULL,
  `close_at` TIME NOT NULL,
  `phone` VARCHAR(20) NULL,
  `lat` DECIMAL(10,8) NULL,
  `lng` DECIMAL(11,8) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_branch_area_idx` (`area_id` ASC),
  INDEX `fk_branch_provider1_idx` (`provider_id` ASC),
  CONSTRAINT `fk_branch_area`
    FOREIGN KEY (`area_id`)
    REFERENCES `senior_app`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_branch_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `senior_app`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provider_id` INT NOT NULL,
  `name_ar` VARCHAR(255) NOT NULL,
  `name_en` VARCHAR(255) NOT NULL,
  `description_ar` TEXT NULL,
  `description_en` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_category_provider1_idx` (`provider_id` ASC),
  CONSTRAINT `fk_category_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `senior_app`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `name_ar` VARCHAR(255) NOT NULL,
  `name_en` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  `description_ar` TEXT NULL,
  `description_en` TEXT NULL,
  `image_path` VARCHAR(255) NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_product_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `senior_app`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`delivery_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`delivery_area` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `branch_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `delivery_fees` FLOAT NOT NULL,
  `deliver_in_minutes` INT NOT NULL,
  INDEX `fk_branch_has_area_area1_idx` (`area_id` ASC),
  INDEX `fk_branch_has_area_branch1_idx` (`branch_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_branch_has_area_branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `senior_app`.`branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_branch_has_area_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `senior_app`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`provider_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`provider_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provider_id` INT NOT NULL,
  `branch_id` INT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_provider_user_provider1_idx` (`provider_id` ASC),
  INDEX `fk_provider_user_branch1_idx` (`branch_id` ASC),
  CONSTRAINT `fk_provider_user_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `senior_app`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_user_branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `senior_app`.`branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`consumer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`consumer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `fullname` VARCHAR(255) NOT NULL,
  `gender` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`consumer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`consumer_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `consumer_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `street` VARCHAR(100) NOT NULL,
  `building` VARCHAR(100) NOT NULL,
  `floor` VARCHAR(100) NOT NULL,
  `flat` VARCHAR(100) NOT NULL,
  `landmark` VARCHAR(255) NULL,
  `lat` DECIMAL(10,8) NULL,
  `lng` DECIMAL(11,8) NULL,
  `label` VARCHAR(100) NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_consumer_address_area1_idx` (`area_id` ASC),
  INDEX `fk_consumer_address_consumer1_idx` (`consumer_id` ASC),
  CONSTRAINT `fk_consumer_address_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `senior_app`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consumer_address_consumer1`
    FOREIGN KEY (`consumer_id`)
    REFERENCES `senior_app`.`consumer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `consumer_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `area_id` INT NOT NULL,
  `consumer_address_id` INT NULL,
  `ordered_at` DATETIME NOT NULL,
  `delivery_fees` FLOAT NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_order_consumer1_idx` (`consumer_id` ASC),
  INDEX `fk_order_branch1_idx` (`branch_id` ASC),
  INDEX `fk_order_area1_idx` (`area_id` ASC),
  INDEX `fk_order_consumer_address1_idx` (`consumer_address_id` ASC),
  CONSTRAINT `fk_order_consumer1`
    FOREIGN KEY (`consumer_id`)
    REFERENCES `senior_app`.`consumer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_branch1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `senior_app`.`branch` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `senior_app`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_consumer_address1`
    FOREIGN KEY (`consumer_address_id`)
    REFERENCES `senior_app`.`consumer_address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`order_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` FLOAT NOT NULL,
  INDEX `fk_product_has_order_order1_idx` (`order_id` ASC),
  INDEX `fk_product_has_order_product1_idx` (`product_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_product_has_order_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `senior_app`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `senior_app`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `senior_app`.`admin_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `senior_app`.`admin_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `active` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
