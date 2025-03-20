-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `Menu_ID` INT NOT NULL,
  `Menu_Item` VARCHAR(255) NOT NULL,
  `Menu_type` VARCHAR(45) NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  `Price` DECIMAL NOT NULL,
  PRIMARY KEY (`Menu_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_Delivery_Status` (
  `Status_ID` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Status_updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`Status_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `Customer_ID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Email_Address` VARCHAR(255) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Customer_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staffs` (
  `Staff_ID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Address` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL,
  PRIMARY KEY (`Staff_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `Booking_ID` INT NOT NULL,
  `Table_No` INT NOT NULL,
  `Booking_Slot` DATETIME NOT NULL,
  `Customer_ID` INT NOT NULL,
  `Staff_ID` INT NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  INDEX `Customer_ID_idx` (`Customer_ID` ASC) VISIBLE,
  INDEX `Staff_ID_idx` (`Staff_ID` ASC) VISIBLE,
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `LittleLemonDB`.`Customers` (`Customer_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Staff_ID`
    FOREIGN KEY (`Staff_ID`)
    REFERENCES `LittleLemonDB`.`Staffs` (`Staff_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `Order_ID` INT NOT NULL,
  `Qunatity` INT NOT NULL,
  `Bill_Amount` DECIMAL NOT NULL,
  `Menu_ID` INT NOT NULL,
  `Status_ID` INT NOT NULL,
  `Booking_ID` INT NOT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `Menu_ID_idx` (`Menu_ID` ASC) VISIBLE,
  INDEX `Status_ID_idx` (`Status_ID` ASC) VISIBLE,
  INDEX `Booking_ID_idx` (`Booking_ID` ASC) VISIBLE,
  CONSTRAINT `Menu_ID`
    FOREIGN KEY (`Menu_ID`)
    REFERENCES `LittleLemonDB`.`Menus` (`Menu_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Status_ID`
    FOREIGN KEY (`Status_ID`)
    REFERENCES `LittleLemonDB`.`Order_Delivery_Status` (`Status_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Booking_ID`
    FOREIGN KEY (`Booking_ID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`Booking_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
