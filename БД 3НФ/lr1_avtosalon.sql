-- =====================================================================
--  ЛР1. Вариант 9. Автосалон — участок «Отдел продаж автомобилей»
--  Модель данных в 3НФ (MySQL 8 / MySQL Workbench)
-- =====================================================================
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `avtosalon`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
USE `avtosalon`;

-- ---------------------------------------------------------------------
-- Справочники автомобилей
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `marka` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(45) NOT NULL,
  `strana`   VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `marka_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `tip_kuzova` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tip_kuzova_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `model` (
  `id`            INT NOT NULL AUTO_INCREMENT,
  `nazvanie`      VARCHAR(45) NOT NULL,
  `marka_id`      INT NOT NULL,
  `tip_kuzova_id` INT NOT NULL,
  `pokolenie`     VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `model_marka_nazvanie_UNIQUE` (`marka_id` ASC, `nazvanie` ASC, `pokolenie` ASC) VISIBLE,
  INDEX `fk_model_marka_idx`      (`marka_id` ASC)      VISIBLE,
  INDEX `fk_model_tip_kuzova_idx` (`tip_kuzova_id` ASC) VISIBLE,
  CONSTRAINT `fk_model_marka`
    FOREIGN KEY (`marka_id`) REFERENCES `marka` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_model_tip_kuzova`
    FOREIGN KEY (`tip_kuzova_id`) REFERENCES `tip_kuzova` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `komplektatsiya` (
  `id`             INT NOT NULL AUTO_INCREMENT,
  `model_id`       INT NOT NULL,
  `nazvanie`       VARCHAR(45) NOT NULL,
  `obem_dvigatelya` DECIMAL(3,1) NULL,
  `moshchnost_ls`  INT NOT NULL,
  `tip_topliva`    ENUM('benzin','dizel','gibrid','elektro') NOT NULL,
  `korobka`        ENUM('MKPP','AKPP','robot','variator') NOT NULL,
  `privod`         ENUM('peredniy','zadniy','polnyy') NOT NULL,
  `bazovaya_tsena` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `komplektatsiya_model_nazvanie_UNIQUE` (`model_id` ASC, `nazvanie` ASC) VISIBLE,
  INDEX `fk_komplektatsiya_model_idx` (`model_id` ASC) VISIBLE,
  CONSTRAINT `fk_komplektatsiya_model`
    FOREIGN KEY (`model_id`) REFERENCES `model` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `tsvet` (
  `id`        INT NOT NULL AUTO_INCREMENT,
  `nazvanie`  VARCHAR(45) NOT NULL,
  `kod_kraski` VARCHAR(10) NOT NULL,
  `tip_pokrytiya` ENUM('nemetallik','metallik','perlamutr','matovyy') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tsvet_kod_UNIQUE` (`kod_kraski` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `status_avtomobilya` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_avtomobilya_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `avtomobil` (
  `id`                INT NOT NULL AUTO_INCREMENT,
  `vin`               CHAR(17) NOT NULL,
  `komplektatsiya_id` INT NOT NULL,
  `tsvet_id`          INT NOT NULL,
  `status_id`         INT NOT NULL,
  `god_vypuska`       YEAR NOT NULL,
  `probeg_km`         INT NOT NULL DEFAULT 0,
  `data_postupleniya` DATE NOT NULL,
  `tsena`             DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `avtomobil_vin_UNIQUE` (`vin` ASC) VISIBLE,
  INDEX `fk_avtomobil_komplektatsiya_idx` (`komplektatsiya_id` ASC) VISIBLE,
  INDEX `fk_avtomobil_tsvet_idx`          (`tsvet_id` ASC)          VISIBLE,
  INDEX `fk_avtomobil_status_idx`         (`status_id` ASC)         VISIBLE,
  CONSTRAINT `fk_avtomobil_komplektatsiya`
    FOREIGN KEY (`komplektatsiya_id`) REFERENCES `komplektatsiya` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_avtomobil_tsvet`
    FOREIGN KEY (`tsvet_id`) REFERENCES `tsvet` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_avtomobil_status`
    FOREIGN KEY (`status_id`) REFERENCES `status_avtomobilya` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dop_oborudovanie` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(60) NOT NULL,
  `tsena`    DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dop_oborudovanie_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- Клиенты
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `klient` (
  `id`                INT NOT NULL AUTO_INCREMENT,
  `imya`              VARCHAR(45) NOT NULL,
  `familiya`          VARCHAR(45) NOT NULL,
  `otchestvo`         VARCHAR(45) NULL,
  `data_rozhdeniya`   DATE NULL,
  `telefon`           VARCHAR(15) NOT NULL,
  `email`             VARCHAR(60) NULL,
  `adres`             VARCHAR(255) NULL,
  `data_registratsii` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `klient_telefon_UNIQUE` (`telefon` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dokument` (
  `id`            INT NOT NULL AUTO_INCREMENT,
  `klient_id`     INT NOT NULL,
  `tip_dokumenta` VARCHAR(30) NOT NULL,
  `seriya`        VARCHAR(10) NULL,
  `nomer`         VARCHAR(20) NOT NULL,
  `kem_vydan`     VARCHAR(255) NULL,
  `data_vydachi`  DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dokument_nomer_UNIQUE` (`tip_dokumenta` ASC, `seriya` ASC, `nomer` ASC) VISIBLE,
  INDEX `fk_dokument_klient_idx` (`klient_id` ASC) VISIBLE,
  CONSTRAINT `fk_dokument_klient`
    FOREIGN KEY (`klient_id`) REFERENCES `klient` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- Персонал
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `dolzhnost` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(45) NOT NULL,
  `oklad`    DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dolzhnost_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sotrudnik` (
  `id`           INT NOT NULL AUTO_INCREMENT,
  `imya`         VARCHAR(45) NOT NULL,
  `familiya`     VARCHAR(45) NOT NULL,
  `otchestvo`    VARCHAR(45) NULL,
  `telefon`      VARCHAR(15) NOT NULL,
  `email`        VARCHAR(60) NULL,
  `data_priema`  DATE NOT NULL,
  `dolzhnost_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sotrudnik_telefon_UNIQUE` (`telefon` ASC) VISIBLE,
  INDEX `fk_sotrudnik_dolzhnost_idx` (`dolzhnost_id` ASC) VISIBLE,
  CONSTRAINT `fk_sotrudnik_dolzhnost`
    FOREIGN KEY (`dolzhnost_id`) REFERENCES `dolzhnost` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `uchet_zapis` (
  `id`            INT NOT NULL AUTO_INCREMENT,
  `sotrudnik_id`  INT NOT NULL,
  `login`         VARCHAR(45) NOT NULL,
  `khesh_parolya` VARCHAR(255) NOT NULL,
  `rol`           VARCHAR(20) NOT NULL DEFAULT 'menedzher',
  `aktiven`       TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uchet_zapis_login_UNIQUE`     (`login` ASC)        VISIBLE,
  UNIQUE INDEX `uchet_zapis_sotrudnik_UNIQUE` (`sotrudnik_id` ASC) VISIBLE,
  CONSTRAINT `fk_uchet_zapis_sotrudnik`
    FOREIGN KEY (`sotrudnik_id`) REFERENCES `sotrudnik` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- Процесс продажи
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `test_drayv` (
  `id`             INT NOT NULL AUTO_INCREMENT,
  `avtomobil_id`   INT NOT NULL,
  `klient_id`      INT NOT NULL,
  `sotrudnik_id`   INT NOT NULL,
  `data_vremya`    DATETIME NOT NULL,
  `dlitelnost_min` INT NOT NULL DEFAULT 30,
  `otzyv`          VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_test_drayv_avtomobil_idx` (`avtomobil_id` ASC) VISIBLE,
  INDEX `fk_test_drayv_klient_idx`    (`klient_id` ASC)    VISIBLE,
  INDEX `fk_test_drayv_sotrudnik_idx` (`sotrudnik_id` ASC) VISIBLE,
  CONSTRAINT `fk_test_drayv_avtomobil`
    FOREIGN KEY (`avtomobil_id`) REFERENCES `avtomobil` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_test_drayv_klient`
    FOREIGN KEY (`klient_id`) REFERENCES `klient` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_test_drayv_sotrudnik`
    FOREIGN KEY (`sotrudnik_id`) REFERENCES `sotrudnik` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `status_dogovora` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_dogovora_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dogovor_prodazhi` (
  `id`                 INT NOT NULL AUTO_INCREMENT,
  `nomer_dogovora`     VARCHAR(20) NOT NULL,
  `klient_id`          INT NOT NULL,
  `sotrudnik_id`       INT NOT NULL,
  `avtomobil_id`       INT NOT NULL,
  `status_id`          INT NOT NULL,
  `data_zaklyucheniya` DATE NOT NULL,
  `skidka`             DECIMAL(12,2) NOT NULL DEFAULT 0,
  `itogovaya_summa`    DECIMAL(12,2) NOT NULL,
  `data_vydachi_avto`  DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dogovor_nomer_UNIQUE`     (`nomer_dogovora` ASC) VISIBLE,
  UNIQUE INDEX `dogovor_avtomobil_UNIQUE` (`avtomobil_id` ASC)   VISIBLE,
  INDEX `fk_dogovor_klient_idx`    (`klient_id` ASC)    VISIBLE,
  INDEX `fk_dogovor_sotrudnik_idx` (`sotrudnik_id` ASC) VISIBLE,
  INDEX `fk_dogovor_status_idx`    (`status_id` ASC)    VISIBLE,
  INDEX `dogovor_data_idx`         (`data_zaklyucheniya` ASC) VISIBLE,
  CONSTRAINT `fk_dogovor_klient`
    FOREIGN KEY (`klient_id`) REFERENCES `klient` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_dogovor_sotrudnik`
    FOREIGN KEY (`sotrudnik_id`) REFERENCES `sotrudnik` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_dogovor_avtomobil`
    FOREIGN KEY (`avtomobil_id`) REFERENCES `avtomobil` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_dogovor_status`
    FOREIGN KEY (`status_id`) REFERENCES `status_dogovora` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pozitsiya_dop` (
  `dogovor_id`          INT NOT NULL,
  `dop_oborudovanie_id` INT NOT NULL,
  `kolichestvo`         INT NOT NULL DEFAULT 1,
  `tsena_fiks`          DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`dogovor_id`, `dop_oborudovanie_id`),
  INDEX `fk_pozitsiya_dop_oborud_idx` (`dop_oborudovanie_id` ASC) VISIBLE,
  CONSTRAINT `fk_pozitsiya_dop_dogovor`
    FOREIGN KEY (`dogovor_id`) REFERENCES `dogovor_prodazhi` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pozitsiya_dop_oborud`
    FOREIGN KEY (`dop_oborudovanie_id`) REFERENCES `dop_oborudovanie` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trade_in` (
  `id`                  INT NOT NULL AUTO_INCREMENT,
  `dogovor_id`          INT NOT NULL,
  `vin`                 CHAR(17) NOT NULL,
  `marka_model`         VARCHAR(90) NOT NULL,
  `god_vypuska`         YEAR NOT NULL,
  `probeg_km`           INT NOT NULL,
  `otsenochnaya_stoimost` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `trade_in_dogovor_UNIQUE` (`dogovor_id` ASC) VISIBLE,
  CONSTRAINT `fk_trade_in_dogovor`
    FOREIGN KEY (`dogovor_id`) REFERENCES `dogovor_prodazhi` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sposob_oplaty` (
  `id`       INT NOT NULL AUTO_INCREMENT,
  `nazvanie` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sposob_oplaty_nazvanie_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `platezh` (
  `id`            INT NOT NULL AUTO_INCREMENT,
  `dogovor_id`    INT NOT NULL,
  `sposob_id`     INT NOT NULL,
  `summa`         DECIMAL(12,2) NOT NULL,
  `data_platezha` DATETIME NOT NULL,
  `tip_platezha`  ENUM('predoplata','doplata','kredit','trade_in') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_platezh_dogovor_idx` (`dogovor_id` ASC) VISIBLE,
  INDEX `fk_platezh_sposob_idx`  (`sposob_id` ASC)  VISIBLE,
  CONSTRAINT `fk_platezh_dogovor`
    FOREIGN KEY (`dogovor_id`) REFERENCES `dogovor_prodazhi` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_platezh_sposob`
    FOREIGN KEY (`sposob_id`) REFERENCES `sposob_oplaty` (`id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
