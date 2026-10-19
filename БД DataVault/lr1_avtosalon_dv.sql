-- =====================================================================
--  ЛР1. Вариант 9. Автосалон — участок «Отдел продаж автомобилей»
--  Модель данных Data Vault 2.0 (HUB / LINK / SATELLITE)
-- =====================================================================
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `avtosalon_dv`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
USE `avtosalon_dv`;

-- =====================================================================
-- HUBS — бизнес-ключи сущностей
-- =====================================================================

CREATE TABLE IF NOT EXISTS `hub_marka` (
  `marka_hk`       CHAR(32) NOT NULL,
  `nazvanie`       VARCHAR(45) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`marka_hk`),
  UNIQUE INDEX `hub_marka_bk_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_tip_kuzova` (
  `tip_kuzova_hk`  CHAR(32) NOT NULL,
  `nazvanie`       VARCHAR(30) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tip_kuzova_hk`),
  UNIQUE INDEX `hub_tip_kuzova_bk_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_model` (
  `model_hk`        CHAR(32) NOT NULL,
  `marka_nazvanie`  VARCHAR(45) NOT NULL,
  `model_nazvanie`  VARCHAR(45) NOT NULL,
  `pokolenie`       VARCHAR(20) NOT NULL,
  `load_date`       DATETIME NOT NULL,
  `record_source`   VARCHAR(100) NOT NULL,
  PRIMARY KEY (`model_hk`),
  UNIQUE INDEX `hub_model_bk_UNIQUE` (`marka_nazvanie` ASC, `model_nazvanie` ASC, `pokolenie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_komplektatsiya` (
  `komplektatsiya_hk`  CHAR(32) NOT NULL,
  `model_nazvanie`     VARCHAR(45) NOT NULL,
  `nazvanie`           VARCHAR(45) NOT NULL,
  `load_date`          DATETIME NOT NULL,
  `record_source`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`komplektatsiya_hk`),
  UNIQUE INDEX `hub_komplektatsiya_bk_UNIQUE` (`model_nazvanie` ASC, `nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_tsvet` (
  `tsvet_hk`       CHAR(32) NOT NULL,
  `kod_kraski`     VARCHAR(10) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tsvet_hk`),
  UNIQUE INDEX `hub_tsvet_bk_UNIQUE` (`kod_kraski` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_status` (
  `status_hk`      CHAR(32) NOT NULL,
  `nazvanie`       VARCHAR(30) NOT NULL,
  `tip_statusa`    VARCHAR(20) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`status_hk`),
  UNIQUE INDEX `hub_status_bk_UNIQUE` (`nazvanie` ASC, `tip_statusa` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_avtomobil` (
  `avtomobil_hk`   CHAR(32) NOT NULL,
  `vin`            CHAR(17) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`avtomobil_hk`),
  UNIQUE INDEX `hub_avtomobil_bk_UNIQUE` (`vin` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_dop_oborudovanie` (
  `dop_oborudovanie_hk`  CHAR(32) NOT NULL,
  `nazvanie`             VARCHAR(60) NOT NULL,
  `load_date`            DATETIME NOT NULL,
  `record_source`        VARCHAR(100) NOT NULL,
  PRIMARY KEY (`dop_oborudovanie_hk`),
  UNIQUE INDEX `hub_dop_oborudovanie_bk_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_klient` (
  `klient_hk`      CHAR(32) NOT NULL,
  `telefon`        VARCHAR(15) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`klient_hk`),
  UNIQUE INDEX `hub_klient_bk_UNIQUE` (`telefon` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_dolzhnost` (
  `dolzhnost_hk`   CHAR(32) NOT NULL,
  `nazvanie`       VARCHAR(45) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`dolzhnost_hk`),
  UNIQUE INDEX `hub_dolzhnost_bk_UNIQUE` (`nazvanie` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_sotrudnik` (
  `sotrudnik_hk`   CHAR(32) NOT NULL,
  `telefon`        VARCHAR(15) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`sotrudnik_hk`),
  UNIQUE INDEX `hub_sotrudnik_bk_UNIQUE` (`telefon` ASC) VISIBLE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hub_dogovor` (
  `dogovor_hk`      CHAR(32) NOT NULL,
  `nomer_dogovora`  VARCHAR(20) NOT NULL,
  `load_date`       DATETIME NOT NULL,
  `record_source`   VARCHAR(100) NOT NULL,
  PRIMARY KEY (`dogovor_hk`),
  UNIQUE INDEX `hub_dogovor_bk_UNIQUE` (`nomer_dogovora` ASC) VISIBLE
) ENGINE = InnoDB;

-- =====================================================================
-- LINKS — связи между хабами
-- =====================================================================

CREATE TABLE IF NOT EXISTS `link_model_marka_kuzov` (
  `link_model_marka_hk`  CHAR(32) NOT NULL,
  `model_hk`             CHAR(32) NOT NULL,
  `marka_hk`             CHAR(32) NOT NULL,
  `tip_kuzova_hk`        CHAR(32) NOT NULL,
  `load_date`            DATETIME NOT NULL,
  `record_source`        VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_model_marka_hk`),
  UNIQUE INDEX `link_model_marka_kuzov_uniq_UNIQUE` (`model_hk` ASC, `marka_hk` ASC, `tip_kuzova_hk` ASC) VISIBLE,
  INDEX `fk_lmmk_model_idx` (`model_hk` ASC) VISIBLE,
  INDEX `fk_lmmk_marka_idx` (`marka_hk` ASC) VISIBLE,
  INDEX `fk_lmmk_tip_kuzova_idx` (`tip_kuzova_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lmmk_model`
    FOREIGN KEY (`model_hk`) REFERENCES `hub_model` (`model_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lmmk_marka`
    FOREIGN KEY (`marka_hk`) REFERENCES `hub_marka` (`marka_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lmmk_tip_kuzova`
    FOREIGN KEY (`tip_kuzova_hk`) REFERENCES `hub_tip_kuzova` (`tip_kuzova_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_komplekt_model` (
  `link_komplekt_model_hk`  CHAR(32) NOT NULL,
  `komplektatsiya_hk`       CHAR(32) NOT NULL,
  `model_hk`                CHAR(32) NOT NULL,
  `load_date`               DATETIME NOT NULL,
  `record_source`           VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_komplekt_model_hk`),
  UNIQUE INDEX `link_komplekt_model_uniq_UNIQUE` (`komplektatsiya_hk` ASC, `model_hk` ASC) VISIBLE,
  INDEX `fk_lkm_komplektatsiya_idx` (`komplektatsiya_hk` ASC) VISIBLE,
  INDEX `fk_lkm_model_idx` (`model_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lkm_komplektatsiya`
    FOREIGN KEY (`komplektatsiya_hk`) REFERENCES `hub_komplektatsiya` (`komplektatsiya_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lkm_model`
    FOREIGN KEY (`model_hk`) REFERENCES `hub_model` (`model_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_avto_komplekt_tsvet_status` (
  `link_avto_kts_hk`   CHAR(32) NOT NULL,
  `avtomobil_hk`       CHAR(32) NOT NULL,
  `komplektatsiya_hk`  CHAR(32) NOT NULL,
  `tsvet_hk`           CHAR(32) NOT NULL,
  `status_hk`          CHAR(32) NOT NULL,
  `load_date`          DATETIME NOT NULL,
  `record_source`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_avto_kts_hk`),
  UNIQUE INDEX `link_avto_komplekt_tsvet_status_uniq_UNIQUE` (`avtomobil_hk` ASC, `komplektatsiya_hk` ASC, `tsvet_hk` ASC, `status_hk` ASC) VISIBLE,
  INDEX `fk_laks_avtomobil_idx` (`avtomobil_hk` ASC) VISIBLE,
  INDEX `fk_laks_komplektatsiya_idx` (`komplektatsiya_hk` ASC) VISIBLE,
  INDEX `fk_laks_tsvet_idx` (`tsvet_hk` ASC) VISIBLE,
  INDEX `fk_laks_status_idx` (`status_hk` ASC) VISIBLE,
  CONSTRAINT `fk_laks_avtomobil`
    FOREIGN KEY (`avtomobil_hk`) REFERENCES `hub_avtomobil` (`avtomobil_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_laks_komplektatsiya`
    FOREIGN KEY (`komplektatsiya_hk`) REFERENCES `hub_komplektatsiya` (`komplektatsiya_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_laks_tsvet`
    FOREIGN KEY (`tsvet_hk`) REFERENCES `hub_tsvet` (`tsvet_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_laks_status`
    FOREIGN KEY (`status_hk`) REFERENCES `hub_status` (`status_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_klient_dokument` (
  `link_klient_dok_hk`  CHAR(32) NOT NULL,
  `klient_hk`           CHAR(32) NOT NULL,
  `tip_dokumenta`       VARCHAR(30) NOT NULL,
  `seriya`              VARCHAR(10) NOT NULL,
  `nomer`               VARCHAR(20) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_klient_dok_hk`),
  UNIQUE INDEX `link_klient_dokument_uniq_UNIQUE` (`klient_hk` ASC, `tip_dokumenta` ASC, `seriya` ASC, `nomer` ASC) VISIBLE,
  INDEX `fk_lkd_klient_idx` (`klient_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lkd_klient`
    FOREIGN KEY (`klient_hk`) REFERENCES `hub_klient` (`klient_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_sotrudnik_dolzhnost` (
  `link_sotr_dolzh_hk`  CHAR(32) NOT NULL,
  `sotrudnik_hk`        CHAR(32) NOT NULL,
  `dolzhnost_hk`        CHAR(32) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_sotr_dolzh_hk`),
  UNIQUE INDEX `link_sotrudnik_dolzhnost_uniq_UNIQUE` (`sotrudnik_hk` ASC, `dolzhnost_hk` ASC) VISIBLE,
  INDEX `fk_lsd_sotrudnik_idx` (`sotrudnik_hk` ASC) VISIBLE,
  INDEX `fk_lsd_dolzhnost_idx` (`dolzhnost_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lsd_sotrudnik`
    FOREIGN KEY (`sotrudnik_hk`) REFERENCES `hub_sotrudnik` (`sotrudnik_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lsd_dolzhnost`
    FOREIGN KEY (`dolzhnost_hk`) REFERENCES `hub_dolzhnost` (`dolzhnost_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_sotrudnik_uchet` (
  `link_sotr_uchet_hk`  CHAR(32) NOT NULL,
  `sotrudnik_hk`        CHAR(32) NOT NULL,
  `login`               VARCHAR(45) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_sotr_uchet_hk`),
  UNIQUE INDEX `link_sotrudnik_uchet_uniq_UNIQUE` (`sotrudnik_hk` ASC, `login` ASC) VISIBLE,
  INDEX `fk_lsu_sotrudnik_idx` (`sotrudnik_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lsu_sotrudnik`
    FOREIGN KEY (`sotrudnik_hk`) REFERENCES `hub_sotrudnik` (`sotrudnik_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_test_drayv` (
  `link_test_drayv_hk`  CHAR(32) NOT NULL,
  `avtomobil_hk`        CHAR(32) NOT NULL,
  `klient_hk`           CHAR(32) NOT NULL,
  `sotrudnik_hk`        CHAR(32) NOT NULL,
  `data_vremya`         DATETIME NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_test_drayv_hk`),
  UNIQUE INDEX `link_test_drayv_uniq_UNIQUE` (`avtomobil_hk` ASC, `klient_hk` ASC, `sotrudnik_hk` ASC, `data_vremya` ASC) VISIBLE,
  INDEX `fk_ltd_avtomobil_idx` (`avtomobil_hk` ASC) VISIBLE,
  INDEX `fk_ltd_klient_idx` (`klient_hk` ASC) VISIBLE,
  INDEX `fk_ltd_sotrudnik_idx` (`sotrudnik_hk` ASC) VISIBLE,
  CONSTRAINT `fk_ltd_avtomobil`
    FOREIGN KEY (`avtomobil_hk`) REFERENCES `hub_avtomobil` (`avtomobil_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ltd_klient`
    FOREIGN KEY (`klient_hk`) REFERENCES `hub_klient` (`klient_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ltd_sotrudnik`
    FOREIGN KEY (`sotrudnik_hk`) REFERENCES `hub_sotrudnik` (`sotrudnik_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_dogovor` (
  `link_dogovor_hk`  CHAR(32) NOT NULL,
  `dogovor_hk`       CHAR(32) NOT NULL,
  `klient_hk`        CHAR(32) NOT NULL,
  `sotrudnik_hk`     CHAR(32) NOT NULL,
  `avtomobil_hk`     CHAR(32) NOT NULL,
  `status_hk`        CHAR(32) NOT NULL,
  `load_date`        DATETIME NOT NULL,
  `record_source`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_dogovor_hk`),
  UNIQUE INDEX `link_dogovor_uniq_UNIQUE` (`dogovor_hk` ASC, `klient_hk` ASC, `sotrudnik_hk` ASC, `avtomobil_hk` ASC, `status_hk` ASC) VISIBLE,
  INDEX `fk_ldog_dogovor_idx` (`dogovor_hk` ASC) VISIBLE,
  INDEX `fk_ldog_klient_idx` (`klient_hk` ASC) VISIBLE,
  INDEX `fk_ldog_sotrudnik_idx` (`sotrudnik_hk` ASC) VISIBLE,
  INDEX `fk_ldog_avtomobil_idx` (`avtomobil_hk` ASC) VISIBLE,
  INDEX `fk_ldog_status_idx` (`status_hk` ASC) VISIBLE,
  CONSTRAINT `fk_ldog_dogovor`
    FOREIGN KEY (`dogovor_hk`) REFERENCES `hub_dogovor` (`dogovor_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ldog_klient`
    FOREIGN KEY (`klient_hk`) REFERENCES `hub_klient` (`klient_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ldog_sotrudnik`
    FOREIGN KEY (`sotrudnik_hk`) REFERENCES `hub_sotrudnik` (`sotrudnik_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ldog_avtomobil`
    FOREIGN KEY (`avtomobil_hk`) REFERENCES `hub_avtomobil` (`avtomobil_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ldog_status`
    FOREIGN KEY (`status_hk`) REFERENCES `hub_status` (`status_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_dogovor_dop` (
  `link_dogovor_dop_hk`  CHAR(32) NOT NULL,
  `dogovor_hk`           CHAR(32) NOT NULL,
  `dop_oborudovanie_hk`  CHAR(32) NOT NULL,
  `load_date`            DATETIME NOT NULL,
  `record_source`        VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_dogovor_dop_hk`),
  UNIQUE INDEX `link_dogovor_dop_uniq_UNIQUE` (`dogovor_hk` ASC, `dop_oborudovanie_hk` ASC) VISIBLE,
  INDEX `fk_ldd_dogovor_idx` (`dogovor_hk` ASC) VISIBLE,
  INDEX `fk_ldd_dop_oborudovanie_idx` (`dop_oborudovanie_hk` ASC) VISIBLE,
  CONSTRAINT `fk_ldd_dogovor`
    FOREIGN KEY (`dogovor_hk`) REFERENCES `hub_dogovor` (`dogovor_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ldd_dop_oborudovanie`
    FOREIGN KEY (`dop_oborudovanie_hk`) REFERENCES `hub_dop_oborudovanie` (`dop_oborudovanie_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_platezh` (
  `link_platezh_hk`  CHAR(32) NOT NULL,
  `dogovor_hk`       CHAR(32) NOT NULL,
  `nomer_platezha`   VARCHAR(20) NOT NULL,
  `load_date`        DATETIME NOT NULL,
  `record_source`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_platezh_hk`),
  UNIQUE INDEX `link_platezh_uniq_UNIQUE` (`dogovor_hk` ASC, `nomer_platezha` ASC) VISIBLE,
  INDEX `fk_lpl_dogovor_idx` (`dogovor_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lpl_dogovor`
    FOREIGN KEY (`dogovor_hk`) REFERENCES `hub_dogovor` (`dogovor_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `link_trade_in` (
  `link_trade_in_hk`  CHAR(32) NOT NULL,
  `dogovor_hk`        CHAR(32) NOT NULL,
  `vin_trade_in`      CHAR(17) NOT NULL,
  `load_date`         DATETIME NOT NULL,
  `record_source`     VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_trade_in_hk`),
  UNIQUE INDEX `link_trade_in_uniq_UNIQUE` (`dogovor_hk` ASC, `vin_trade_in` ASC) VISIBLE,
  INDEX `fk_lti_dogovor_idx` (`dogovor_hk` ASC) VISIBLE,
  CONSTRAINT `fk_lti_dogovor`
    FOREIGN KEY (`dogovor_hk`) REFERENCES `hub_dogovor` (`dogovor_hk`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- =====================================================================
-- SATELLITES — описательные атрибуты с историей изменений
-- =====================================================================

CREATE TABLE IF NOT EXISTS `sat_marka` (
  `marka_hk`       CHAR(32) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `load_end_date`  DATETIME NULL,
  `hash_diff`      CHAR(32) NOT NULL,
  `strana`         VARCHAR(45) NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`marka_hk`, `load_date`),
  CONSTRAINT `fk_sat_marka_parent`
    FOREIGN KEY (`marka_hk`) REFERENCES `hub_marka` (`marka_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_model` (
  `model_hk`              CHAR(32) NOT NULL,
  `load_date`             DATETIME NOT NULL,
  `load_end_date`         DATETIME NULL,
  `hash_diff`             CHAR(32) NOT NULL,
  `data_nachala_prodazh`  DATE NULL,
  `record_source`         VARCHAR(100) NOT NULL,
  PRIMARY KEY (`model_hk`, `load_date`),
  CONSTRAINT `fk_sat_model_parent`
    FOREIGN KEY (`model_hk`) REFERENCES `hub_model` (`model_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_komplektatsiya` (
  `komplektatsiya_hk`  CHAR(32) NOT NULL,
  `load_date`          DATETIME NOT NULL,
  `load_end_date`      DATETIME NULL,
  `hash_diff`          CHAR(32) NOT NULL,
  `obem_dvigatelya`    DECIMAL(3,1) NULL,
  `moshchnost_ls`      INT NOT NULL,
  `tip_topliva`        VARCHAR(10) NOT NULL,
  `korobka`            VARCHAR(10) NOT NULL,
  `privod`             VARCHAR(10) NOT NULL,
  `bazovaya_tsena`     DECIMAL(12,2) NOT NULL,
  `record_source`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`komplektatsiya_hk`, `load_date`),
  CONSTRAINT `fk_sat_komplektatsiya_parent`
    FOREIGN KEY (`komplektatsiya_hk`) REFERENCES `hub_komplektatsiya` (`komplektatsiya_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_tsvet` (
  `tsvet_hk`       CHAR(32) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `load_end_date`  DATETIME NULL,
  `hash_diff`      CHAR(32) NOT NULL,
  `nazvanie`       VARCHAR(45) NOT NULL,
  `tip_pokrytiya`  VARCHAR(15) NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tsvet_hk`, `load_date`),
  CONSTRAINT `fk_sat_tsvet_parent`
    FOREIGN KEY (`tsvet_hk`) REFERENCES `hub_tsvet` (`tsvet_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_avtomobil` (
  `avtomobil_hk`       CHAR(32) NOT NULL,
  `load_date`          DATETIME NOT NULL,
  `load_end_date`      DATETIME NULL,
  `hash_diff`          CHAR(32) NOT NULL,
  `god_vypuska`        YEAR NOT NULL,
  `probeg_km`          INT NOT NULL,
  `data_postupleniya`  DATE NOT NULL,
  `tsena`              DECIMAL(12,2) NOT NULL,
  `record_source`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`avtomobil_hk`, `load_date`),
  CONSTRAINT `fk_sat_avtomobil_parent`
    FOREIGN KEY (`avtomobil_hk`) REFERENCES `hub_avtomobil` (`avtomobil_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_dop_oborudovanie` (
  `dop_oborudovanie_hk`  CHAR(32) NOT NULL,
  `load_date`            DATETIME NOT NULL,
  `load_end_date`        DATETIME NULL,
  `hash_diff`            CHAR(32) NOT NULL,
  `tsena`                DECIMAL(10,2) NOT NULL,
  `record_source`        VARCHAR(100) NOT NULL,
  PRIMARY KEY (`dop_oborudovanie_hk`, `load_date`),
  CONSTRAINT `fk_sat_dop_oborudovanie_parent`
    FOREIGN KEY (`dop_oborudovanie_hk`) REFERENCES `hub_dop_oborudovanie` (`dop_oborudovanie_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_klient` (
  `klient_hk`          CHAR(32) NOT NULL,
  `load_date`          DATETIME NOT NULL,
  `load_end_date`      DATETIME NULL,
  `hash_diff`          CHAR(32) NOT NULL,
  `imya`               VARCHAR(45) NOT NULL,
  `familiya`           VARCHAR(45) NOT NULL,
  `otchestvo`          VARCHAR(45) NULL,
  `data_rozhdeniya`    DATE NULL,
  `email`              VARCHAR(60) NULL,
  `adres`              VARCHAR(255) NULL,
  `data_registratsii`  DATE NOT NULL,
  `record_source`      VARCHAR(100) NOT NULL,
  PRIMARY KEY (`klient_hk`, `load_date`),
  CONSTRAINT `fk_sat_klient_parent`
    FOREIGN KEY (`klient_hk`) REFERENCES `hub_klient` (`klient_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_dokument` (
  `link_klient_dok_hk`  CHAR(32) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `load_end_date`       DATETIME NULL,
  `hash_diff`           CHAR(32) NOT NULL,
  `kem_vydan`           VARCHAR(255) NULL,
  `data_vydachi`        DATE NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_klient_dok_hk`, `load_date`),
  CONSTRAINT `fk_sat_dokument_parent`
    FOREIGN KEY (`link_klient_dok_hk`) REFERENCES `link_klient_dokument` (`link_klient_dok_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_dolzhnost` (
  `dolzhnost_hk`   CHAR(32) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `load_end_date`  DATETIME NULL,
  `hash_diff`      CHAR(32) NOT NULL,
  `oklad`          DECIMAL(10,2) NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`dolzhnost_hk`, `load_date`),
  CONSTRAINT `fk_sat_dolzhnost_parent`
    FOREIGN KEY (`dolzhnost_hk`) REFERENCES `hub_dolzhnost` (`dolzhnost_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_sotrudnik` (
  `sotrudnik_hk`   CHAR(32) NOT NULL,
  `load_date`      DATETIME NOT NULL,
  `load_end_date`  DATETIME NULL,
  `hash_diff`      CHAR(32) NOT NULL,
  `imya`           VARCHAR(45) NOT NULL,
  `familiya`       VARCHAR(45) NOT NULL,
  `otchestvo`      VARCHAR(45) NULL,
  `email`          VARCHAR(60) NULL,
  `data_priema`    DATE NOT NULL,
  `record_source`  VARCHAR(100) NOT NULL,
  PRIMARY KEY (`sotrudnik_hk`, `load_date`),
  CONSTRAINT `fk_sat_sotrudnik_parent`
    FOREIGN KEY (`sotrudnik_hk`) REFERENCES `hub_sotrudnik` (`sotrudnik_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_uchet_zapis` (
  `link_sotr_uchet_hk`  CHAR(32) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `load_end_date`       DATETIME NULL,
  `hash_diff`           CHAR(32) NOT NULL,
  `khesh_parolya`       VARCHAR(255) NOT NULL,
  `rol`                 VARCHAR(20) NOT NULL,
  `aktiven`             TINYINT(1) NOT NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_sotr_uchet_hk`, `load_date`),
  CONSTRAINT `fk_sat_uchet_zapis_parent`
    FOREIGN KEY (`link_sotr_uchet_hk`) REFERENCES `link_sotrudnik_uchet` (`link_sotr_uchet_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_test_drayv` (
  `link_test_drayv_hk`  CHAR(32) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `load_end_date`       DATETIME NULL,
  `hash_diff`           CHAR(32) NOT NULL,
  `dlitelnost_min`      INT NOT NULL,
  `otzyv`               VARCHAR(255) NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_test_drayv_hk`, `load_date`),
  CONSTRAINT `fk_sat_test_drayv_parent`
    FOREIGN KEY (`link_test_drayv_hk`) REFERENCES `link_test_drayv` (`link_test_drayv_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_dogovor` (
  `link_dogovor_hk`     CHAR(32) NOT NULL,
  `load_date`           DATETIME NOT NULL,
  `load_end_date`       DATETIME NULL,
  `hash_diff`           CHAR(32) NOT NULL,
  `data_zaklyucheniya`  DATE NOT NULL,
  `skidka`              DECIMAL(12,2) NOT NULL,
  `itogovaya_summa`     DECIMAL(12,2) NOT NULL,
  `data_vydachi_avto`   DATE NULL,
  `record_source`       VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_dogovor_hk`, `load_date`),
  CONSTRAINT `fk_sat_dogovor_parent`
    FOREIGN KEY (`link_dogovor_hk`) REFERENCES `link_dogovor` (`link_dogovor_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_pozitsiya_dop` (
  `link_dogovor_dop_hk`  CHAR(32) NOT NULL,
  `load_date`            DATETIME NOT NULL,
  `load_end_date`        DATETIME NULL,
  `hash_diff`            CHAR(32) NOT NULL,
  `kolichestvo`          INT NOT NULL,
  `tsena_fiks`           DECIMAL(10,2) NOT NULL,
  `record_source`        VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_dogovor_dop_hk`, `load_date`),
  CONSTRAINT `fk_sat_pozitsiya_dop_parent`
    FOREIGN KEY (`link_dogovor_dop_hk`) REFERENCES `link_dogovor_dop` (`link_dogovor_dop_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_platezh` (
  `link_platezh_hk`  CHAR(32) NOT NULL,
  `load_date`        DATETIME NOT NULL,
  `load_end_date`    DATETIME NULL,
  `hash_diff`        CHAR(32) NOT NULL,
  `summa`            DECIMAL(12,2) NOT NULL,
  `data_platezha`    DATETIME NOT NULL,
  `tip_platezha`     VARCHAR(15) NOT NULL,
  `sposob_oplaty`    VARCHAR(30) NOT NULL,
  `record_source`    VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_platezh_hk`, `load_date`),
  CONSTRAINT `fk_sat_platezh_parent`
    FOREIGN KEY (`link_platezh_hk`) REFERENCES `link_platezh` (`link_platezh_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `sat_trade_in` (
  `link_trade_in_hk`       CHAR(32) NOT NULL,
  `load_date`              DATETIME NOT NULL,
  `load_end_date`          DATETIME NULL,
  `hash_diff`              CHAR(32) NOT NULL,
  `marka_model`            VARCHAR(90) NOT NULL,
  `god_vypuska`            YEAR NOT NULL,
  `probeg_km`              INT NOT NULL,
  `otsenochnaya_stoimost`  DECIMAL(12,2) NOT NULL,
  `record_source`          VARCHAR(100) NOT NULL,
  PRIMARY KEY (`link_trade_in_hk`, `load_date`),
  CONSTRAINT `fk_sat_trade_in_parent`
    FOREIGN KEY (`link_trade_in_hk`) REFERENCES `link_trade_in` (`link_trade_in_hk`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
