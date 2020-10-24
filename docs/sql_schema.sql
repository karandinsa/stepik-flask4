-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema stepik4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stepik4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stepik4` DEFAULT CHARACTER SET utf8 ;
USE `stepik4` ;

-- -----------------------------------------------------
-- Table `stepik4`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`customers` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `idx_name_phone` (`customer_name` ASC, `customer_phone` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`dows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`dows` (
  `dow` VARCHAR(45) NOT NULL,
  `dow_name` VARCHAR(45) NOT NULL,
  `dow_order` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dow`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`teachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`teachers` (
  `row_id` INT(11) NOT NULL AUTO_INCREMENT,
  `id` INT(11) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `about` TEXT NOT NULL,
  `rating` DECIMAL(4,1) NOT NULL,
  `picture` VARCHAR(120) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`row_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 66
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`scheduler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`scheduler` (
  `row_id` INT(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` INT(11) NOT NULL,
  `dow_id` VARCHAR(45) NOT NULL,
  `time` TIME NOT NULL,
  `occupied` TINYINT(4) NOT NULL,
  PRIMARY KEY (`row_id`),
  INDEX `fk_teacher_id_idx` (`teacher_id` ASC) ,
  INDEX `fk_dow_idx` (`dow_id` ASC) ,
  CONSTRAINT `fk_dow`
    FOREIGN KEY (`dow_id`)
    REFERENCES `stepik4`.`dows` (`dow`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_teacher_id`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `stepik4`.`teachers` (`row_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2018
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`booking_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`booking_requests` (
  `request_uid` VARCHAR(45) NOT NULL,
  `scheduler_id` INT(11) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  PRIMARY KEY (`request_uid`),
  INDEX `fk_customers_booking_requests` (`customer_id` ASC) ,
  INDEX `fk_scheduler_booking_requests` (`scheduler_id` ASC) ,
  CONSTRAINT `fk_customers_booking_requests`
    FOREIGN KEY (`customer_id`)
    REFERENCES `stepik4`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_scheduler_booking_requests`
    FOREIGN KEY (`scheduler_id`)
    REFERENCES `stepik4`.`scheduler` (`row_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`goals` (
  `goal` VARCHAR(45) NOT NULL,
  `goal_name` VARCHAR(45) CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (`goal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`teacher_goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`teacher_goals` (
  `row_id` INT(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` INT(11) NOT NULL,
  `goal_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`row_id`),
  INDEX `idx_teacher_id` (`teacher_id` ASC) ,
  INDEX `idx_goal_id` (`goal_id` ASC) ,
  CONSTRAINT `fk_goals`
    FOREIGN KEY (`goal_id`)
    REFERENCES `stepik4`.`goals` (`goal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_teachers`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `stepik4`.`teachers` (`row_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 109
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `stepik4`.`teacher_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`teacher_requests` (
  `request_uid` VARCHAR(45) NOT NULL,
  `goal` VARCHAR(45) NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  PRIMARY KEY (`request_uid`),
  INDEX `fk_customers_teacher_requests` (`customer_id` ASC) ,
  CONSTRAINT `fk_customers_teacher_reauests`
    FOREIGN KEY (`customer_id`)
    REFERENCES `stepik4`.`customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `stepik4` ;

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_booking_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_booking_requests` (`request_uid` INT, `customer_name` INT, `customer_phone` INT, `time` INT, `occupied` INT, `dow_name` INT, `name` INT, `rating` INT, `price` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_common`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_common` (`teachers_row_id` INT, `id` INT, `name` INT, `about` INT, `rating` INT, `picture` INT, `price` INT, `scheduler_row_id` INT, `scheduler_teacher_id` INT, `dow_id` INT, `time` INT, `occupied` INT, `dow` INT, `dow_name` INT, `teacher_goals_row_id` INT, `teacher_goals_teacher_id` INT, `goal_id` INT, `goal` INT, `goal_name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_scheduler_dows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_scheduler_dows` (`row_id` INT, `teacher_id` INT, `id` INT, `dow_id` INT, `time` INT, `occupied` INT, `dow_name` INT, `dow_order` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_stepik4`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_stepik4` (`scheduler_row_id` INT, `id` INT, `name` INT, `about` INT, `rating` INT, `picture` INT, `price` INT, `goal` INT, `goal_name` INT, `dow` INT, `dow_name` INT, `time` INT, `occupied` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_teacher_goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_teacher_goals` (`row_id` INT, `teacher_id` INT, `goal_id` INT, `goal_name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `stepik4`.`view_teacher_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stepik4`.`view_teacher_requests` (`request_uid` INT, `goal` INT, `time` INT, `customer_name` INT, `customer_phone` INT);

-- -----------------------------------------------------
-- procedure sp_add_booking_request
-- -----------------------------------------------------

DELIMITER $$
USE `stepik4`$$
CREATE DEFINER=`stepik4`@`%` PROCEDURE `sp_add_booking_request`( in p_request_uid varchar(45), 
in p_scheduler_id int, in p_customer_name varchar(45), in p_customer_phone varchar(45))
BEGIN
set @customer_id=0;
SELECT 
    `customers`.`customer_id`
INTO @customer_id FROM
    `stepik4`.`customers`
WHERE
    `customers`.`customer_name` = p_customer_name
        AND `customers`.`customer_phone` = p_customer_phone;
IF @customer_id = 0
THEN
	START TRANSACTION;
    INSERT INTO `stepik4`.`customers`
	(`customer_name`,
	`customer_phone`)
	VALUES
	(p_customer_name,
	p_customer_phone);
	SELECT LAST_INSERT_ID() INTO @customer_id;
    COMMIT;
END IF;

INSERT INTO `stepik4`.`booking_requests`
(`request_uid`,
`scheduler_id`,
`customer_id`)
VALUES
(p_request_uid,
p_scheduler_id,
@customer_id);

UPDATE `stepik4`.`scheduler`
SET 
`occupied` = 1
WHERE `row_id` = p_scheduler_id;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_add_teacher_request
-- -----------------------------------------------------

DELIMITER $$
USE `stepik4`$$
CREATE DEFINER=`stepik4`@`%` PROCEDURE `sp_add_teacher_request`( in p_request_uid varchar(45), 
in p_goal varchar(45), in p_time varchar(45), in p_customer_name varchar(45), in p_customer_phone varchar(45))
BEGIN
set @customer_id=0;
SELECT 
    `customers`.`customer_id`
INTO @customer_id FROM
    `stepik4`.`customers`
WHERE
    `customers`.`customer_name` = p_customer_name
        AND `customers`.`customer_phone` = p_customer_phone;
IF @customer_id = 0
THEN
	START TRANSACTION;
    INSERT INTO `stepik4`.`customers`
	(`customer_name`,
	`customer_phone`)
	VALUES
	(p_customer_name,
	p_customer_phone);
	SELECT LAST_INSERT_ID() INTO @customer_id;
    COMMIT;
END IF;

INSERT INTO `stepik4`.`teacher_requests`
(`request_uid`,
`goal`,
`time`,
`customer_id`)
VALUES
(p_request_uid,
p_goal,
p_time,
@customer_id);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_get_scheduler_id
-- -----------------------------------------------------

DELIMITER $$
USE `stepik4`$$
CREATE DEFINER=`stepik4`@`%` PROCEDURE `sp_get_scheduler_id`(in p_id varchar(45), in p_dow varchar(10), 
in p_time varchar(10), out p_row_id int)
BEGIN
SELECT row_id into p_row_id FROM stepik4.view_scheduler_dows 
where id = cast(p_id as unsigned int) and dow_id = p_dow and time=cast(p_time as time);
select p_row_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `stepik4`.`view_booking_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_booking_requests`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_booking_requests` AS select `stepik4`.`booking_requests`.`request_uid` AS `request_uid`,`stepik4`.`customers`.`customer_name` AS `customer_name`,`stepik4`.`customers`.`customer_phone` AS `customer_phone`,`stepik4`.`scheduler`.`time` AS `time`,`stepik4`.`scheduler`.`occupied` AS `occupied`,`stepik4`.`dows`.`dow_name` AS `dow_name`,`stepik4`.`teachers`.`name` AS `name`,`stepik4`.`teachers`.`rating` AS `rating`,`stepik4`.`teachers`.`price` AS `price` from ((((`stepik4`.`booking_requests` join `stepik4`.`customers` on((`stepik4`.`customers`.`customer_id` = `stepik4`.`booking_requests`.`customer_id`))) join `stepik4`.`scheduler` on((`stepik4`.`scheduler`.`row_id` = `stepik4`.`booking_requests`.`scheduler_id`))) join `stepik4`.`dows` on((`stepik4`.`dows`.`dow` = `stepik4`.`scheduler`.`dow_id`))) join `stepik4`.`teachers` on((`stepik4`.`teachers`.`row_id` = `stepik4`.`scheduler`.`teacher_id`)));

-- -----------------------------------------------------
-- View `stepik4`.`view_common`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_common`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_common` AS select `stepik4`.`teachers`.`row_id` AS `teachers_row_id`,`stepik4`.`teachers`.`id` AS `id`,`stepik4`.`teachers`.`name` AS `name`,`stepik4`.`teachers`.`about` AS `about`,`stepik4`.`teachers`.`rating` AS `rating`,`stepik4`.`teachers`.`picture` AS `picture`,`stepik4`.`teachers`.`price` AS `price`,`stepik4`.`scheduler`.`row_id` AS `scheduler_row_id`,`stepik4`.`scheduler`.`teacher_id` AS `scheduler_teacher_id`,`stepik4`.`scheduler`.`dow_id` AS `dow_id`,`stepik4`.`scheduler`.`time` AS `time`,`stepik4`.`scheduler`.`occupied` AS `occupied`,`stepik4`.`dows`.`dow` AS `dow`,`stepik4`.`dows`.`dow_name` AS `dow_name`,`stepik4`.`teacher_goals`.`row_id` AS `teacher_goals_row_id`,`stepik4`.`teacher_goals`.`teacher_id` AS `teacher_goals_teacher_id`,`stepik4`.`teacher_goals`.`goal_id` AS `goal_id`,`stepik4`.`goals`.`goal` AS `goal`,`stepik4`.`goals`.`goal_name` AS `goal_name` from ((((`stepik4`.`scheduler` join `stepik4`.`teachers` on((`stepik4`.`scheduler`.`teacher_id` = `stepik4`.`teachers`.`row_id`))) join `stepik4`.`dows` on((`stepik4`.`dows`.`dow` = `stepik4`.`scheduler`.`dow_id`))) join `stepik4`.`teacher_goals` on((`stepik4`.`teacher_goals`.`teacher_id` = `stepik4`.`teachers`.`row_id`))) join `stepik4`.`goals` on((`stepik4`.`goals`.`goal` = `stepik4`.`teacher_goals`.`goal_id`)));

-- -----------------------------------------------------
-- View `stepik4`.`view_scheduler_dows`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_scheduler_dows`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_scheduler_dows` AS select `stepik4`.`scheduler`.`row_id` AS `row_id`,`stepik4`.`scheduler`.`teacher_id` AS `teacher_id`,`stepik4`.`teachers`.`id` AS `id`,`stepik4`.`scheduler`.`dow_id` AS `dow_id`,`stepik4`.`scheduler`.`time` AS `time`,`stepik4`.`scheduler`.`occupied` AS `occupied`,`stepik4`.`dows`.`dow_name` AS `dow_name`,`stepik4`.`dows`.`dow_order` AS `dow_order` from ((`stepik4`.`scheduler` join `stepik4`.`dows` on((`stepik4`.`scheduler`.`dow_id` = `stepik4`.`dows`.`dow`))) join `stepik4`.`teachers` on((`stepik4`.`scheduler`.`teacher_id` = `stepik4`.`teachers`.`row_id`))) order by `stepik4`.`dows`.`dow_order`,`stepik4`.`scheduler`.`time`;

-- -----------------------------------------------------
-- View `stepik4`.`view_stepik4`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_stepik4`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_stepik4` AS select `stepik4`.`scheduler`.`row_id` AS `scheduler_row_id`,`stepik4`.`teachers`.`id` AS `id`,`stepik4`.`teachers`.`name` AS `name`,`stepik4`.`teachers`.`about` AS `about`,`stepik4`.`teachers`.`rating` AS `rating`,`stepik4`.`teachers`.`picture` AS `picture`,`stepik4`.`teachers`.`price` AS `price`,`stepik4`.`goals`.`goal` AS `goal`,`stepik4`.`goals`.`goal_name` AS `goal_name`,`stepik4`.`dows`.`dow` AS `dow`,`stepik4`.`dows`.`dow_name` AS `dow_name`,`stepik4`.`scheduler`.`time` AS `time`,`stepik4`.`scheduler`.`occupied` AS `occupied` from ((((`stepik4`.`scheduler` join `stepik4`.`teachers` on((`stepik4`.`scheduler`.`teacher_id` = `stepik4`.`teachers`.`row_id`))) join `stepik4`.`dows` on((`stepik4`.`dows`.`dow` = `stepik4`.`scheduler`.`dow_id`))) join `stepik4`.`teacher_goals` on((`stepik4`.`teacher_goals`.`teacher_id` = `stepik4`.`teachers`.`row_id`))) join `stepik4`.`goals` on((`stepik4`.`goals`.`goal` = `stepik4`.`teacher_goals`.`goal_id`)));

-- -----------------------------------------------------
-- View `stepik4`.`view_teacher_goals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_teacher_goals`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_teacher_goals` AS select `stepik4`.`teacher_goals`.`row_id` AS `row_id`,`stepik4`.`teacher_goals`.`teacher_id` AS `teacher_id`,`stepik4`.`teacher_goals`.`goal_id` AS `goal_id`,`stepik4`.`goals`.`goal_name` AS `goal_name` from (`stepik4`.`teacher_goals` join `stepik4`.`goals` on((`stepik4`.`teacher_goals`.`goal_id` = `stepik4`.`goals`.`goal`)));

-- -----------------------------------------------------
-- View `stepik4`.`view_teacher_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stepik4`.`view_teacher_requests`;
USE `stepik4`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`stepik4`@`%` SQL SECURITY DEFINER VIEW `stepik4`.`view_teacher_requests` AS select `stepik4`.`teacher_requests`.`request_uid` AS `request_uid`,`stepik4`.`teacher_requests`.`goal` AS `goal`,`stepik4`.`teacher_requests`.`time` AS `time`,`stepik4`.`customers`.`customer_name` AS `customer_name`,`stepik4`.`customers`.`customer_phone` AS `customer_phone` from (`stepik4`.`customers` join `stepik4`.`teacher_requests` on((`stepik4`.`teacher_requests`.`customer_id` = `stepik4`.`customers`.`customer_id`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
