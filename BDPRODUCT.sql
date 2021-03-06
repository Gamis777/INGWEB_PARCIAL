SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bdproduct
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bdproduct
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bdproduct` DEFAULT CHARACTER SET utf8 ;
USE `bdproduct` ;

-- -----------------------------------------------------
-- Table `bdproduct`.`PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PRODUCT` (
  `idPRODUCT` INT NOT NULL AUTO_INCREMENT,
  `NAME_PRODUCT` VARCHAR(45) NOT NULL,
  `DATE_INTRODUCTION` DATE NOT NULL,
  `DATE_SALES_DISCON` DATE NULL,
  `DATE_SUPPORT_DISCON` DATE NULL,
  `COMMENT` VARCHAR(45) NULL,
  `GOOD` TINYINT NULL,
  `SERVICE` TINYINT NULL,
  PRIMARY KEY (`idPRODUCT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PRODUCT CAT CLASSIFICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PRODUCT CAT CLASSIFICATION` (
  `idPRODUCT_CLAS` INT NOT NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  `DATE_FROM` DATE NULL,
  `DATE_THRU` DATE NULL,
  `COMMENT` VARCHAR(80) NULL,
  `USAGE_CATE` TINYINT NULL,
  `INDUSTRY_CATE` TINYINT NULL,
  `MATERIALS_CATE` TINYINT NULL,
  PRIMARY KEY (`idPRODUCT_CLAS`, `PRODUCT_idPRODUCT`),
  INDEX `fk_PRODUCT CAT CLASSIFICATION_PRODUCT_idx` (`PRODUCT_idPRODUCT` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT CAT CLASSIFICATION_PRODUCT`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PRODUCT_CAT_ROLLUP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PRODUCT_CAT_ROLLUP` (
  `PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION` INT NOT NULL,
  `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT` INT NOT NULL,
  `PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION1` INT NOT NULL,
  `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT1` INT NOT NULL,
  PRIMARY KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION`, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`, `PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION1`, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT1`),
  INDEX `fk_PRODUCT CAT CLASSIFICATION_has_PRODUCT CAT CLASSIFICATIO_idx` (`PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION1` ASC, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT1` ASC) VISIBLE,
  INDEX `fk_PRODUCT CAT CLASSIFICATION_has_PRODUCT CAT CLASSIFICATIO_idx1` (`PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION` ASC, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCT CAT CLASSIFICATION_has_PRODUCT CAT CLASSIFICATION_1`
    FOREIGN KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION` , `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT CAT CLASSIFICATION` (`idPRODUCT_CLAS` , `PRODUCT_idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCT CAT CLASSIFICATION_has_PRODUCT CAT CLASSIFICATION_2`
    FOREIGN KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT CAT CLASSIFICATION1` , `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT1`)
    REFERENCES `bdproduct`.`PRODUCT CAT CLASSIFICATION` (`idPRODUCT_CLAS` , `PRODUCT_idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PARTY TIPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PARTY TIPE` (
  `idPARTY TIPE` INT NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`idPARTY TIPE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`MARKET_INTEREST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`MARKET_INTEREST` (
  `PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS` INT NOT NULL,
  `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT` INT NOT NULL,
  `PARTY TIPE_idPARTY TIPE` INT NOT NULL,
  `DATE_FROM` DATE NULL,
  `DATE_THRU` DATE NULL,
  PRIMARY KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS`, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`, `PARTY TIPE_idPARTY TIPE`),
  INDEX `fk_MARKET_INTEREST_PARTY TIPE1_idx` (`PARTY TIPE_idPARTY TIPE` ASC) VISIBLE,
  CONSTRAINT `fk_MARKET_INTEREST_PRODUCT CAT CLASSIFICATION1`
    FOREIGN KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS` , `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT CAT CLASSIFICATION` (`idPRODUCT_CLAS` , `PRODUCT_idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MARKET_INTEREST_PARTY TIPE1`
    FOREIGN KEY (`PARTY TIPE_idPARTY TIPE`)
    REFERENCES `bdproduct`.`PARTY TIPE` (`idPARTY TIPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PROD_FEATURE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PROD_FEATURE` (
  `idPROD_FEATURE` INT NOT NULL,
  `DESCRIPTION` VARCHAR(80) NOT NULL,
  `PRODUCT QUALITY` VARCHAR(45) NOT NULL,
  `COLOR` VARCHAR(45) NOT NULL,
  `DIMENSION` DOUBLE NOT NULL,
  `SIZE` DOUBLE NOT NULL,
  `BRAND` VARCHAR(45) NOT NULL,
  `SOFTWARE FEATURE` VARCHAR(45) NOT NULL,
  `HARDWARE FEATURE` VARCHAR(45) NOT NULL,
  `BILLING FEATURE` VARCHAR(45) NOT NULL,
  `OTHER FEATURE` VARCHAR(45) NULL,
  PRIMARY KEY (`idPROD_FEATURE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PR0D_FEATURE_APPLI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PR0D_FEATURE_APPLI` (
  `DATE_FROM` DATE NULL,
  `DATE_THRU` DATE NULL,
  `REQUIRED FEATURE` VARCHAR(45) NOT NULL,
  `STANDARD FEATURE` VARCHAR(45) NULL,
  `OPTIONAL FEATURE` VARCHAR(45) NULL,
  `SELECTABLE FEATURE` VARCHAR(45) NULL,
  `PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS` INT NOT NULL,
  `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT` INT NOT NULL,
  `PROD_FEATURE_idPROD_FEATURE` INT NOT NULL,
  PRIMARY KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS`, `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`, `PROD_FEATURE_idPROD_FEATURE`),
  INDEX `fk_PR0D_FEATURE_APPLI_PROD_FEATURE1_idx` (`PROD_FEATURE_idPROD_FEATURE` ASC) VISIBLE,
  CONSTRAINT `fk_PR0D_FEATURE_APPLI_PRODUCT CAT CLASSIFICATION1`
    FOREIGN KEY (`PRODUCT CAT CLASSIFICATION_idPRODUCT_CLAS` , `PRODUCT CAT CLASSIFICATION_PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT CAT CLASSIFICATION` (`idPRODUCT_CLAS` , `PRODUCT_idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PR0D_FEATURE_APPLI_PROD_FEATURE1`
    FOREIGN KEY (`PROD_FEATURE_idPROD_FEATURE`)
    REFERENCES `bdproduct`.`PROD_FEATURE` (`idPROD_FEATURE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`ORGANIZATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`ORGANIZATION` (
  `idORGANIZATION` INT NOT NULL,
  `NAME_ORGANIZATION` VARCHAR(45) NULL,
  PRIMARY KEY (`idORGANIZATION`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`SUPPLIER PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`SUPPLIER PRODUCT` (
  `DATE_FROM_AVAL` DATE NULL,
  `DATE_THRU_AVAL` DATE NULL,
  `TIME_STANDARD_LEAD` TIME NULL,
  `COMMENT` VARCHAR(80) NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  `ORGANIZATION_idORGANIZATION` INT NOT NULL,
  PRIMARY KEY (`PRODUCT_idPRODUCT`, `ORGANIZATION_idORGANIZATION`),
  INDEX `fk_SUPPLIER PRODUCT_ORGANIZATION1_idx` (`ORGANIZATION_idORGANIZATION` ASC) VISIBLE,
  CONSTRAINT `fk_SUPPLIER PRODUCT_PRODUCT1`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SUPPLIER PRODUCT_ORGANIZATION1`
    FOREIGN KEY (`ORGANIZATION_idORGANIZATION`)
    REFERENCES `bdproduct`.`ORGANIZATION` (`idORGANIZATION`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`LOT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`LOT` (
  `idLOT` INT NOT NULL,
  `DATE_CREATION` DATE NULL,
  `QUANTITY` VARCHAR(45) NULL,
  `DATE_EXPIRATION` DATE NULL,
  PRIMARY KEY (`idLOT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`INVENTORY ITEM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`INVENTORY ITEM` (
  `idINVENTORY ITEM` INT NOT NULL,
  `SERIALEZ_ITEM` TINYINT NULL,
  `NON_SERIALEZ_ITEM` TINYINT NULL,
  `LOT_idLOT` INT NOT NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  PRIMARY KEY (`idINVENTORY ITEM`, `LOT_idLOT`, `PRODUCT_idPRODUCT`),
  INDEX `fk_INVENTORY ITEM_LOT1_idx` (`LOT_idLOT` ASC) VISIBLE,
  INDEX `fk_INVENTORY ITEM_PRODUCT1_idx` (`PRODUCT_idPRODUCT` ASC) VISIBLE,
  CONSTRAINT `fk_INVENTORY ITEM_LOT1`
    FOREIGN KEY (`LOT_idLOT`)
    REFERENCES `bdproduct`.`LOT` (`idLOT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INVENTORY ITEM_PRODUCT1`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`INVEN_TEM_VARIANCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`INVEN_TEM_VARIANCE` (
  `DATE_INVEN_PHYSICAL` DATE NOT NULL,
  `QUANTITY` INT NULL,
  `COMMENT` VARCHAR(80) NULL,
  `INVENTORY ITEM_idINVENTORY ITEM` INT NOT NULL,
  `INVENTORY ITEM_LOT_idLOT` INT NOT NULL,
  `INVENTORY ITEM_PRODUCT_idPRODUCT` INT NOT NULL,
  PRIMARY KEY (`INVENTORY ITEM_idINVENTORY ITEM`, `INVENTORY ITEM_LOT_idLOT`, `INVENTORY ITEM_PRODUCT_idPRODUCT`),
  CONSTRAINT `fk_INVEN_TEM_VARIANCE_INVENTORY ITEM1`
    FOREIGN KEY (`INVENTORY ITEM_idINVENTORY ITEM` , `INVENTORY ITEM_LOT_idLOT` , `INVENTORY ITEM_PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`INVENTORY ITEM` (`idINVENTORY ITEM` , `LOT_idLOT` , `PRODUCT_idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`BASE PRICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`BASE PRICE` (
  `BASE_PRICE` INT NOT NULL,
  `DISCOUNT_COMP` DECIMAL NULL,
  `SURCHARGE_COMP` DECIMAL NULL,
  `MANUFACTURER_SUGGESTED` DECIMAL NULL,
  PRIMARY KEY (`BASE_PRICE`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bdproduct`.`PRICE COMPONENT`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `bdproduct`.`PRICE COMPONENT` (
  `idPRICE_COMP` INT NOT NULL,
  `DATE_FROM` DATE NOT NULL,
  `DATE_THRU` DATE NULL,
  `PRICE` DECIMAL NOT NULL,
  `PERCENT` FLOAT NOT NULL,
  `COMMENT` VARCHAR(80) NULL,
  `ONE_TIME_CHARGE` DECIMAL NULL,
  `RECURRING_CHARGE` DECIMAL NULL,
  `UTILIZATION_CHARGE` DECIMAL NULL,
  `BASE PRICE_BASE PRICEcol` VARCHAR(45) NOT NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  `PROD_FEATURE_idPROD_FEATURE` INT NOT NULL,
  PRIMARY KEY (`idPRICE_COMP`, `BASE PRICE_BASE PRICEcol`, `PRODUCT_idPRODUCT`, `PROD_FEATURE_idPROD_FEATURE`),
  INDEX `fk_PRICE COMPONENT_BASE PRICE1_idx` (`BASE PRICE_BASE PRICEcol` ASC) VISIBLE,
  INDEX `fk_PRICE COMPONENT_PRODUCT1_idx` (`PRODUCT_idPRODUCT` ASC) VISIBLE,
  INDEX `fk_PRICE COMPONENT_PROD_FEATURE1_idx` (`PROD_FEATURE_idPROD_FEATURE` ASC) VISIBLE,
  CONSTRAINT `fk_PRICE COMPONENT_BASE PRICE1`
    FOREIGN KEY (`BASE PRICE_BASE PRICEcol`)
    REFERENCES `bdproduct`.`BASE PRICE` (`BASE_PRICE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRICE COMPONENT_PRODUCT1`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `mydb`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRICE COMPONENT_PROD_FEATURE1`
    FOREIGN KEY (`PROD_FEATURE_idPROD_FEATURE`)
    REFERENCES `bdproduct`.`PROD_FEATURE` (`idPROD_FEATURE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`COST_COMP_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`COST_COMP_TYPE` (
  `idCOST_COMP_TYPE` INT NOT NULL,
  `DESCRIPTION` VARCHAR(80) NULL,
  `ESTIMATED_MAT_COST` DECIMAL NULL,
  `ESTIMATED_LAB_COST` DECIMAL NULL,
  `ESTIMATED_OTHER_COST` DECIMAL NULL,
  PRIMARY KEY (`idCOST_COMP_TYPE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`ESTIMATED_PROD_COST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`ESTIMATED_PROD_COST` (
  `idESTIMATED_COST` INT NOT NULL,
  `DATE_FROM` DATE NULL,
  `DATE_THRU` DATE NULL,
  `COST` DECIMAL NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  `COST_COMP_TYPE_idCOST_COMP_TYPE` INT NOT NULL,
  PRIMARY KEY (`idESTIMATED_COST`, `PRODUCT_idPRODUCT`, `COST_COMP_TYPE_idCOST_COMP_TYPE`),
  INDEX `fk_ESTIMATED_PROD_COST_PRODUCT1_idx` (`PRODUCT_idPRODUCT` ASC) VISIBLE,
  INDEX `fk_ESTIMATED_PROD_COST_COST_COMP_TYPE1_idx` (`COST_COMP_TYPE_idCOST_COMP_TYPE` ASC) VISIBLE,
  CONSTRAINT `fk_ESTIMATED_PROD_COST_PRODUCT1`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ESTIMATED_PROD_COST_COST_COMP_TYPE1`
    FOREIGN KEY (`COST_COMP_TYPE_idCOST_COMP_TYPE`)
    REFERENCES `bdproduct`.`COST_COMP_TYPE` (`idCOST_COMP_TYPE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bdproduct`.`PROD_ASSOCIATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bdproduct`.`PROD_ASSOCIATION` (
  `DATE_FROM` DATE NULL,
  `DATE_THRU` DATE NULL,
  `REASON` VARCHAR(45) NULL,
  `MARKET_PACKAGE` VARCHAR(45) NULL,
  `PROD_SUBSTITUTE` TINYINT NULL,
  `PROD_OBSOLESENCE` TINYINT NULL,
  `PROD_COMPLEMENT` TINYINT NULL,
  `PROD_INCOMPATIBILITY` TINYINT NULL,
  `PRODUCT_idPRODUCT` INT NOT NULL,
  PRIMARY KEY (`PRODUCT_idPRODUCT`),
  CONSTRAINT `fk_PROD_ASSOCIATION_PRODUCT1`
    FOREIGN KEY (`PRODUCT_idPRODUCT`)
    REFERENCES `bdproduct`.`PRODUCT` (`idPRODUCT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;