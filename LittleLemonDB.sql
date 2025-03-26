-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customers` (
  `Customer_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Email_Address` VARCHAR(255) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staffs` (
  `Staff_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `Booking_ID` INT NOT NULL AUTO_INCREMENT,
  `Table_No` INT NOT NULL,
  `Booking_Slot` DATETIME NOT NULL,
  `Customer_ID` INT NOT NULL,
  `Staff_ID` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Staff_ID_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `littlelemondb`.`customers` (`Customer_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Staff_ID`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `littlelemondb`.`staffs` (`Staff_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menu_items` (
  `Menu_Items_ID` INT NOT NULL AUTO_INCREMENT,
  `Course_Name` VARCHAR(45) NOT NULL,
  `Starter_Name` VARCHAR(45) NOT NULL,
  `Dessert_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Menu_Items_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menus` (
  `Menu_ID` INT NOT NULL AUTO_INCREMENT,
  `Menu_Name` VARCHAR(45) NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(10,0) NOT NULL,
  `Menu_Items_ID` INT NOT NULL,
  PRIMARY KEY (`Menu_ID`),
  INDEX `Menu_Items_ID_idx` (`Menu_Items_ID` ASC) VISIBLE,
  CONSTRAINT `Menu_Items_ID`
    FOREIGN KEY (`Menu_Items_ID`)
    REFERENCES `littlelemondb`.`menu_items` (`Menu_Items_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`order_delivery_status` (
  `Status_ID` INT NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(45) NOT NULL,
  `Status_updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`Status_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `Order_ID` INT NOT NULL AUTO_INCREMENT,
  `Qunatity` INT NOT NULL,
  `Bill_Amount` DECIMAL(10,0) NOT NULL,
  `Menu_ID` INT NOT NULL,
  `Status_ID` INT NOT NULL,
  `Booking_ID` INT NOT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Menu_ID_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Status_ID_idx` (`Status_ID` ASC) VISIBLE,
  INDEX `Booking_ID_idx` (`Booking_ID` ASC) VISIBLE,
  CONSTRAINT `Booking_ID`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `littlelemondb`.`bookings` (`Booking_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Menu_ID`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `littlelemondb`.`menus` (`Menu_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Status_ID`
    FOREIGN KEY (`Status_ID`)
    REFERENCES `littlelemondb`.`order_delivery_status` (`Status_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
