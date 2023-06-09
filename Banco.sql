-- MySQL Workbench Forward Engineering

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
-- Table `mydb`.`TipoPerfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TipoPerfil` (
  `idTipo` INT NOT NULL,
  `TipoPerfil` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Perfil` (
  `matricula` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  `Tipo_idTipo` INT NOT NULL,
  `sobre` VARCHAR(1024) NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Perfil_Tipo1_idx` (`Tipo_idTipo` ASC) VISIBLE,
  CONSTRAINT `fk_Perfil_Tipo1`
    FOREIGN KEY (`Tipo_idTipo`)
    REFERENCES `mydb`.`TipoPerfil` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `idcurso` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idcurso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Faculdade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Faculdade` (
  `idFaculdade` INT NOT NULL,
  `curso_idcurso` INT NOT NULL,
  PRIMARY KEY (`idFaculdade`),
  INDEX `fk_Faculdade_curso1_idx` (`curso_idcurso` ASC) VISIBLE,
  CONSTRAINT `fk_Faculdade_curso1`
    FOREIGN KEY (`curso_idcurso`)
    REFERENCES `mydb`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vaga` (
  `idVaga` INT NOT NULL,
  PRIMARY KEY (`idVaga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Perfil_has_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Perfil_has_curso` (
  `Perfil_matricula` INT NOT NULL,
  `curso_idcurso` INT NOT NULL,
  PRIMARY KEY (`Perfil_matricula`, `curso_idcurso`),
  INDEX `fk_Perfil_has_curso_curso1_idx` (`curso_idcurso` ASC) VISIBLE,
  INDEX `fk_Perfil_has_curso_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Perfil_has_curso_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Perfil_has_curso_curso1`
    FOREIGN KEY (`curso_idcurso`)
    REFERENCES `mydb`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Post` (
  `idPost` INT NOT NULL,
  `Postcol` VARCHAR(45) NULL,
  `Perfil_matricula` INT NOT NULL,
  PRIMARY KEY (`idPost`),
  INDEX `fk_Post_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Post_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Experiencia` (
  `idExperiencia` INT NOT NULL,
  `Perfil_matricula` INT NOT NULL,
  `empresa` VARCHAR(45) NULL,
  `cargo` VARCHAR(45) NULL,
  `inicio` VARCHAR(45) NULL,
  `termino` VARCHAR(45) NULL,
  `atual` TINYINT NULL,
  `comentario` VARCHAR(512) NULL,
  `Experienciacol` VARCHAR(45) NULL,
  PRIMARY KEY (`idExperiencia`),
  INDEX `fk_Experiencia_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Experiencia_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Faculdade_has_Vaga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Faculdade_has_Vaga` (
  `Faculdade_idFaculdade` INT NOT NULL,
  `Vaga_idVaga` INT NOT NULL,
  PRIMARY KEY (`Faculdade_idFaculdade`, `Vaga_idVaga`),
  INDEX `fk_Faculdade_has_Vaga_Vaga1_idx` (`Vaga_idVaga` ASC) VISIBLE,
  INDEX `fk_Faculdade_has_Vaga_Faculdade1_idx` (`Faculdade_idFaculdade` ASC) VISIBLE,
  CONSTRAINT `fk_Faculdade_has_Vaga_Faculdade1`
    FOREIGN KEY (`Faculdade_idFaculdade`)
    REFERENCES `mydb`.`Faculdade` (`idFaculdade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Faculdade_has_Vaga_Vaga1`
    FOREIGN KEY (`Vaga_idVaga`)
    REFERENCES `mydb`.`Vaga` (`idVaga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comentario` (
  `Post_idPost` INT NOT NULL,
  `momento` DATETIME NULL,
  `mensagem` VARCHAR(512) NULL,
  `Perfil_matricula` INT NOT NULL,
  INDEX `fk_Comentario_Post1_idx` (`Post_idPost` ASC) VISIBLE,
  INDEX `fk_Comentario_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Comentario_Post1`
    FOREIGN KEY (`Post_idPost`)
    REFERENCES `mydb`.`Post` (`idPost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Perfil_has_Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Perfil_has_Perfil` (
  `Perfil_matricula` INT NOT NULL,
  `Perfil_matricula1` INT NOT NULL,
  PRIMARY KEY (`Perfil_matricula`, `Perfil_matricula1`),
  INDEX `fk_Perfil_has_Perfil_Perfil2_idx` (`Perfil_matricula1` ASC) VISIBLE,
  INDEX `fk_Perfil_has_Perfil_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Perfil_has_Perfil_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Perfil_has_Perfil_Perfil2`
    FOREIGN KEY (`Perfil_matricula1`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Competencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Competencias` (
  `idCompetencias` INT NOT NULL,
  `competencias` VARCHAR(45) NULL,
  `Perfil_matricula` INT NOT NULL,
  PRIMARY KEY (`idCompetencias`),
  INDEX `fk_Competencias_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Competencias_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CursosComplementares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CursosComplementares` (
  `idCurso` INT NOT NULL,
  `curso` VARCHAR(45) NULL,
  `Perfil_matricula` INT NOT NULL,
  PRIMARY KEY (`idCurso`),
  INDEX `fk_Curso_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Publicacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Publicacoes` (
  `idPublicacoes` INT NOT NULL,
  `Perfil_matricula` INT NOT NULL,
  PRIMARY KEY (`idPublicacoes`),
  INDEX `fk_Publicacoes_Perfil1_idx` (`Perfil_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Publicacoes_Perfil1`
    FOREIGN KEY (`Perfil_matricula`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recomendacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recomendacoes` (
  `idRecomendacoes` INT NOT NULL,
  `recomendado` INT NOT NULL,
  `recomendou` INT NOT NULL,
  PRIMARY KEY (`idRecomendacoes`),
  INDEX `fk_Recomendacoes_Perfil1_idx` (`recomendado` ASC) VISIBLE,
  INDEX `fk_Recomendacoes_Perfil2_idx` (`recomendou` ASC) VISIBLE,
  CONSTRAINT `fk_Recomendacoes_Perfil1`
    FOREIGN KEY (`recomendado`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recomendacoes_Perfil2`
    FOREIGN KEY (`recomendou`)
    REFERENCES `mydb`.`Perfil` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
