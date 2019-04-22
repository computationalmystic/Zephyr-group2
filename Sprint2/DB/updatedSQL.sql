-- Zephyr Group 2
-- April 22, 2019
-- Sprint 2

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `UserID` INT NOT NULL,
  `UserUsername` VARCHAR(45) NOT NULL,
  `UserpermissionsLevel` INT NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `username_UNIQUE` (`UserUsername` ASC) VISIBLE,
  UNIQUE INDEX `ID_UNIQUE` (`UserID` ASC) VISIBLE);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`device` (
  `deviceID` INT NOT NULL,
  `deviceName` VARCHAR(45) NOT NULL,
  `MACAddress` VARCHAR(17) NOT NULL,
  `IPAddress` VARCHAR(15) NOT NULL,
  `connectionStatus` INT NOT NULL,
  `timeLastConnected` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`deviceID`),
  UNIQUE INDEX `deviceID_UNIQUE` (`deviceID` ASC) VISIBLE,
  UNIQUE INDEX `deviceName_UNIQUE` (`deviceName` ASC) VISIBLE,
  UNIQUE INDEX `MACADdress_UNIQUE` (`MACAddress` ASC) VISIBLE,
  UNIQUE INDEX `IPAddress_UNIQUE` (`IPAddress` ASC) VISIBLE);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`deviceSecurity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`deviceSecurity` (
  `approvedDeviceID` INT NOT NULL,
  `approvalEndTime` DATETIME NULL DEFAULT NULL,
  `userID` INT NOT NULL,
  `approvedActions` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`approvedDeviceID`, `userID`),
  INDEX `fk_deviceSecurity_device_idx` (`approvedDeviceID` ASC) VISIBLE,
  INDEX `fk_deviceSecurity_Users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_deviceSecurity_device`
    FOREIGN KEY (`approvedDeviceID`)
    REFERENCES `mydb`.`device` (`deviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deviceSecurity_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `mydb`.`Users` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rooms` (
  `roomID` INT NOT NULL,
  `desiredTemperature` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`roomID`));
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`temperatureData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`temperatureData` (
  `temperature` FLOAT NULL DEFAULT NULL,
  `time` DATETIME NOT NULL,
  `deviceID` INT NOT NULL,
  `roomID` INT NOT NULL,
  PRIMARY KEY (`time`, `roomID`),
  INDEX `fk_temperatureData_device1_idx` (`deviceID` ASC) VISIBLE,
  INDEX `fk_temperatureData_rooms1_idx` (`roomID` ASC) VISIBLE,
  CONSTRAINT `fk_temperatureData_device1`
    FOREIGN KEY (`deviceID`)
    REFERENCES `mydb`.`device` (`deviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_temperatureData_rooms1`
    FOREIGN KEY (`roomID`)
    REFERENCES `mydb`.`rooms` (`roomID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`eventHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventHistory` (
  `event` VARCHAR(500) NOT NULL,
  `timeInitiated` DATETIME NOT NULL,
  `userIDWhoInitiated` INT NOT NULL,
  INDEX `fk_eventHistory_Users1_idx` (`userIDWhoInitiated` ASC) VISIBLE,
  PRIMARY KEY (`userIDWhoInitiated`, `timeInitiated`, `event`),
  CONSTRAINT `fk_eventHistory_Users1`
    FOREIGN KEY (`userIDWhoInitiated`)
    REFERENCES `mydb`.`Users` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`scheduledTasks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`scheduledTasks` (
  `taskID` INT NOT NULL,
  `taskName` VARCHAR(45) NULL DEFAULT NULL,
  `taskCommand` VARCHAR(500) NOT NULL,
  `interval` INT NOT NULL,
  `deviceID` INT NOT NULL,
  PRIMARY KEY (`taskID`, `deviceID`),
  INDEX `fk_scheduledTasks_device1_idx` (`deviceID` ASC) VISIBLE,
  CONSTRAINT `fk_scheduledTasks_device1`
    FOREIGN KEY (`deviceID`)
    REFERENCES `mydb`.`device` (`deviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`securityInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`securityInfo` (
  `deviceID` INT NOT NULL,
  `phoneNumberToAlert` INT NULL DEFAULT NULL,
  `isArmed` TINYINT NOT NULL,
  `soundAlarmWhenTriggered` TINYINT NOT NULL,
  `shouldContactLawEnforcement` TINYINT NOT NULL,
  `lawEnforcementPhoneNumber` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`deviceID`),
  CONSTRAINT `fk_securityInfo_device1`
    FOREIGN KEY (`deviceID`)
    REFERENCES `mydb`.`device` (`deviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`securityHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`securityHistory` (
  `deviceIDTriggered` INT NOT NULL,
  `timeTriggered` DATETIME NOT NULL,
  `eventDetected` VARCHAR(500) NULL DEFAULT NULL,
  `actionsTaken` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`deviceIDTriggered`, `timeTriggered`),
  CONSTRAINT `fk_securityHistory_device1`
    FOREIGN KEY (`deviceIDTriggered`)
    REFERENCES `mydb`.`device` (`deviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
-- ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`webServer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`webServer` (
  `serverIPAddress` VARCHAR(15) NOT NULL,
  `isPublic` TINYINT NOT NULL,
  `PINIfNotPublic` INT NULL DEFAULT NULL,
  `serverURL` VARCHAR(100) NULL,
  `pathToRoot` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`serverIPAddress`),
  UNIQUE INDEX `serverURL_UNIQUE` (`serverURL` ASC) VISIBLE,
  UNIQUE INDEX `pathToRoot_UNIQUE` (`pathToRoot` ASC) VISIBLE);
-- ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
