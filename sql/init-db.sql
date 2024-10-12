-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.27 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for sabuydy
CREATE DATABASE IF NOT EXISTS `sabuydy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sabuydy`;

-- Dumping structure for view sabuydy.consol_royalty
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `consol_royalty` (
	`LEVEL` BIGINT(19) NULL,
	`sales` DECIMAL(32,0) NULL,
	`royalties` DECIMAL(37,4) NULL
) ENGINE=MyISAM;

-- Dumping structure for view sabuydy.consol_royalty_system
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `consol_royalty_system` (
	`LEVEL` BIGINT(19) NULL,
	`sales` DECIMAL(32,0) NULL,
	`royalties` DECIMAL(37,4) NULL
) ENGINE=MyISAM;

-- Dumping structure for view sabuydy.cumul_royalty
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `cumul_royalty` (
	`LEVEL` BIGINT(19) NULL,
	`sales` DECIMAL(32,0) NULL,
	`royalties` DECIMAL(37,4) NULL
) ENGINE=MyISAM;

-- Dumping structure for view sabuydy.cumul_royalty_system
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `cumul_royalty_system` (
	`LEVEL` BIGINT(19) NULL,
	`sales` DECIMAL(32,0) NULL,
	`royalties` DECIMAL(37,4) NULL
) ENGINE=MyISAM;

-- Dumping structure for table sabuydy.grades
CREATE TABLE `grades` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(12) NOT NULL COLLATE 'utf8mb4_general_ci',
	`max_nos_levels` INT(10) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4;

-- Dumping data for table sabuydy.grades: ~2 rows (approximately)
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
REPLACE INTO `grades` (`id`, `title`) VALUES
	(1, 'Silver'),
	(2, 'Gold'),
	(3, 'Platinum');
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;

-- Dumping structure for table sabuydy.lotto_draws
CREATE TABLE IF NOT EXISTS `lotto_draws` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`draw_date` DATETIME NULL DEFAULT NULL,
	`sgambling_date` DATETIME NULL DEFAULT NULL,
	`egambling_date` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `draw_date` (`draw_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.members
CREATE TABLE IF NOT EXISTS `members` (
	`id` int NOT NULL AUTO_INCREMENT,
	`userid` int NOT NULL DEFAULT '0',
	`membername` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
	`parentid` int DEFAULT NULL,
	`sales_comm_perc` float DEFAULT '20',
	`approved` tinyint NOT NULL DEFAULT '0',
	`createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
	`approvedDate` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `userid` (`userid`) USING BTREE,
	UNIQUE INDEX `membername` (`membername`) USING BTREE,
	INDEX `parentid` (`parentid`) USING BTREE,
	CONSTRAINT `FK_members_members` FOREIGN KEY (`parentid`) REFERENCES `sabuydy`.`members` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table sabuydy.memberships
CREATE TABLE IF NOT EXISTS `memberships` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`gradeid` INT(10) NULL DEFAULT NULL,
	`fee` INT(10) NULL DEFAULT NULL,
	`royalty` INT(10) NULL DEFAULT '1',
	PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.member_profiles
CREATE TABLE IF NOT EXISTS `member_profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `memberid` int NOT NULL,
  `gradeid` INT(10) NOT NULL DEFAULT '1',
	`firstname` VARCHAR(24) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`firstnameE` VARCHAR(24) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`lastname` VARCHAR(24) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`lastnameE` VARCHAR(24) NULL DEFAULT NULL COLLATE 'utf8mb4_0900_ai_ci',
  `gender` bit(1) NOT NULL,
  `profile_image` varchar(228) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `geo_long` float NOT NULL,
  `geo_lat` float NOT NULL,
  `active` tinyint DEFAULT '0',
  `member_fee` tinyint DEFAULT '0',
  `activated_at` datetime NOT NULL,
  `deactivated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `memberid` (`memberid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.member_revenues
CREATE TABLE IF NOT EXISTS `member_revenues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `memberid` int NOT NULL DEFAULT '0',
  `sales` int NOT NULL,
  `royalties` int NOT NULL,
  `draw_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table sabuydy.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
REPLACE INTO `roles` (`id`, `description`) VALUES
	(1, 'Regular user'),
	(2, 'Admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table sabuydy.sales_activities
CREATE TABLE IF NOT EXISTS `sales_activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drawid` int NOT NULL DEFAULT '0',
  `memberid` int NOT NULL,
  `sales` int NOT NULL,
  `commissions` int NOT NULL,
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.sys_settings
CREATE TABLE IF NOT EXISTS `sys_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nos_applied_levels` int NOT NULL,
  `royalty_perlevel` float NOT NULL,
  `sys_fee` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `memberid` int NOT NULL,
  `amount` int NOT NULL,
  `tx_type` tinyint DEFAULT '2',
  `status` tinyint DEFAULT '0',
  `dc` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'D',
  `transferpeer` int NOT NULL, -- MemberID
  `qrcode_path` varchar(228) COLLATE utf8mb4_general_ci NOT NULL,
  `notes` INT(10) NOT NULL DEFAULT '1',
  `tchain` INT(10) NULL DEFAULT NULL, -- For transfer dual
  `createdDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `completedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `createdDate` (`createdDate`) USING BTREE,
  INDEX `completedDate` (`completedDate`) USING BTREE,
  INDEX `tchain` (`tchain`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping structure for table sabuydy.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phoneno` VARCHAR(16) NULL DEFAULT '' COLLATE 'utf8mb4_0900_ai_ci',
  `password` varchar(264) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `roleid` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `username` (`username`) USING BTREE,
	INDEX `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Dumping structure for table sabuydy.vault
CREATE TABLE `vault` (
	`memberid` INT(10) NULL DEFAULT NULL,
	`amount` INT(10) NULL DEFAULT NULL,
	`dc` CHAR(1) NULL DEFAULT 'D' COLLATE 'utf8mb4_general_ci',
	`vtxtype` TINYINT(3) NULL DEFAULT NULL, -- 1-Deposit; 2-Ticket payment; 3-Personal expenses
	`paidout` TINYINT(3) NULL DEFAULT '0',
	`createdDate` DATETIME NULL DEFAULT NULL,
	INDEX `memberid` (`memberid`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

-- Dumping structure for table sabuydy.rvn_remittance
CREATE TABLE `rvn_remittance` (
	`id` INT(10) NOT NULL AUTO_INCREMENT,
	`amount` INT(10) NULL DEFAULT NULL,
	`paidDate` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

-- Dumping structure for trigger sabuydy.sales_activities_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `sales_activities_before_insert` BEFORE INSERT ON `sales_activities` FOR EACH ROW BEGIN
	SET NEW.commissions = NEW.sales*20/100;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger sabuydy.sales_activities_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `sales_activities_before_update` BEFORE UPDATE ON `sales_activities` FOR EACH ROW BEGIN
	SET NEW.commissions = NEW.sales*20/100;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger sabuydy.vault_inout_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `vault_inout_after_update` BEFORE UPDATE ON `sales_activities` FOR EACH ROW BEGIN
	IF NEW.status = 1 THEN -- transaction completed
		IF NEW.tx_type = 1 THEN -- deposit
			INSERT INTO vault VALUES (NEW.memberid, NEW.amount, "D", 1, 0, NEW.createdDate);
		ELSEIF NEW.tx_type = 2 THEN -- withdrawal
			IF NEW.notes = 1 THEN -- pay ticket
				INSERT INTO vault VALUES (NEW.memberid, NEW.amount, "C", 2, 0, NEW.createdDate);
			ELSEIF NEW.notes = 2 THEN -- personal expenses
				INSERT INTO vault VALUES (NEW.memberid, NEW.amount, "C", 3, 1, NEW.createdDate);
			END IF;
		END IF;
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger sabuydy.vault_out_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `vault_out_after_insert` BEFORE UPDATE ON `sales_activities` FOR EACH ROW BEGIN
	IF NEW.status = 1 THEN -- transaction completed
		IF NEW.tx_type = 2 THEN -- withdrawal
			IF NEW.notes = 1 THEN -- pay ticket
				INSERT INTO vault VALUES (NEW.memberid, NEW.amount, "C", 2, 0, NEW.createdDate);
			END IF;
		END IF;
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for procedure sabuydy.sp_search_grade_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_grade_by_id`(
	IN `gradeid` INT
)
BEGIN
    SELECT * FROM grades
    where id = gradeid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_lotto_draw_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_lotto_draw_by_id`(
	IN `lotto_drawid` INT
)
BEGIN
   SELECT * FROM lotto_draws
   WHERE id = lotto_drawid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_membership_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_membership_by_id`(
	IN `membershipid` INT
)
BEGIN
   SELECT * FROM memberships
   WHERE id = membershipid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_create_member_blank
DELIMITER //
CREATE PROCEDURE `sp_create_member_blank`(
	IN `mem_info` JSON
)
BEGIN
	DECLARE nextUserID INT;
	DECLARE parentID INT;
		
	SET information_schema_stats_expiry = 0;
		
	SET nextUserID = (SELECT AUTO_INCREMENT
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'users'
			AND TABLE_SCHEMA = 'sabuydy');
			
	SET parentID = (SELECT id
			FROM users
			WHERE `username` = JSON_EXTRACT(`mem_info`, '$.referrerid'));
	
	INSERT INTO members (`userid`, `membername`, `parentid`) 
	VALUES (nextUserID, JSON_UNQUOTE(`mem_info`->>'$.username'), parentID);
	   
	INSERT INTO users (`username`, `email`, `phoneno`, `password`, `roleid`) 
	VALUES (JSON_UNQUOTE(`mem_info`->>'$.username'), 
			JSON_UNQUOTE(`mem_info`->>'$.email'), 
			JSON_UNQUOTE(`mem_info`->>'$.phoneno'), 
			JSON_UNQUOTE(`mem_info`->>'$.password'), 
			JSON_UNQUOTE(`mem_info`->>'$.roleid'));
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_create_member_signup
DELIMITER //
CREATE PROCEDURE `sp_create_member_signup`(
	IN `mem_info` JSON
)
BEGIN
	DECLARE userID INT;
	DECLARE parentID INT;
		
	SET userID = (SELECT id
			FROM users
			WHERE `username` = JSON_EXTRACT(`mem_info`, '$.username'));
			
	SET parentID = (SELECT id
			FROM users
			WHERE `username` = JSON_EXTRACT(`mem_info`, '$.referrerid'));
	
	INSERT INTO members (`userid`, `membername`, `parentid`) 
	VALUES (userID, JSON_UNQUOTE(`mem_info`->>'$.username'), parentID);
	   
	UPDATE `users` SET `email` = JSON_UNQUOTE(`mem_info`->>'$.email'), 
		`phoneno` = JSON_UNQUOTE(`mem_info`->>'$.phoneno'), 
		`password` = JSON_UNQUOTE(`mem_info`->>'$.password') 
		WHERE `username` = JSON_EXTRACT(`mem_info`, '$.username');
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_member_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_member_by_id`(
	IN `memberid` INT
)
BEGIN
   SELECT membername, parentid, sales_comm_perc
   FROM members
   WHERE id = memberid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_member_by_membername
DELIMITER //
CREATE PROCEDURE `sp_search_member_by_membername`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	SELECT userid, membername, parent.username AS referrerid, users.phoneno, users.email, approved
   	FROM members 
		LEFT JOIN users AS parent ON members.parentid = parent.id 
		LEFT JOIN users ON members.userid = users.id
   	WHERE membername = memname COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_members
DELIMITER //
CREATE PROCEDURE `sp_fetch_members`()
BEGIN
    SELECT id, membername, approved, createdDate, approvedDate
    FROM members
	WHERE membername != 'system' ORDER BY createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_filter_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetch_filter_members`(
	IN `parapproved` TINYINT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
    SELECT `id`, `membername`, `approved`, `createdDate`, `approvedDate`
    FROM members
	WHERE `approved` = parapproved
	ORDER BY `membername`, `createdDate`;
END

-- Dumping structure for procedure sabuydy.sp_approve_registration
DELIMITER //
CREATE PROCEDURE `sp_approve_registration`(
	IN `memname` VARCHAR(50)
)
BEGIN
	UPDATE members SET `approved` = TRUE
	WHERE `membername` = memname COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_approve_batch_registration
DELIMITER //
CREATE PROCEDURE `sp_approve_batch_registration`(
	IN `memberids` TEXT
)
BEGIN
	SET @sql = CONCAT('UPDATE members SET `approved` = TRUE, `approvedDate` = CURRENT_TIMESTAMP WHERE `id` IN (', memberids, ')');
	
	PREPARE stmt FROM @sql;
  	EXECUTE stmt;
  	SELECT ROW_COUNT() AS affectedRows;
  	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_authenticate
DELIMITER //
CREATE PROCEDURE `sp_authenticate`(
	IN `usrname` CHAR(50)
)
BEGIN
    SELECT `password` AS Bytes
    FROM users
    where username = usrname COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_member_profile_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_member_profile_by_id`(
	IN `mem_profid` INT
)
BEGIN
   SELECT * FROM member_profiles
   WHERE id = mem_profid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_member_revenue_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_member_revenue_by_id`(
	IN `mem_rvnid` INT
)
BEGIN
   SELECT * FROM member_revenues
   WHERE id = mem_rvnid ORDER BY draw_date DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_role_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_role_by_id`(
	IN `roleid` INT
)
BEGIN
   SELECT * FROM roles
   WHERE id = roleid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_sales_activity_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_sales_activity_by_id`(
	IN `sal_actid` INT
)
BEGIN
   SELECT * FROM sales_activities
   WHERE id = sal_actid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_sys_setting_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_sys_setting_by_id`(
	IN `settingid` INT
)
BEGIN
   SELECT * FROM sys_settings
   WHERE id = settingid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_deposits
DELIMITER //
CREATE PROCEDURE `sp_fetch_deposits`(
	IN `partx_type` TINYINT
)
BEGIN
   	SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id
   	WHERE t.tx_type = partx_type ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_deposit
DELIMITER //
CREATE PROCEDURE `sp_search_deposit`(
	IN `parid` INT,
	IN `partx_type` TINYINT
)
BEGIN
   	SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id
   	WHERE t.memberid = parid AND t.tx_type = partx_type ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_filter_deposits
DELIMITER //
CREATE PROCEDURE `sp_fetch_filter_deposits`(
	IN `parstatus` TINYINT,
	IN `partx_type` TINYINT
)
BEGIN
   	SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id
   	WHERE t.tx_type = partx_type AND IF(t.`status`-1, FALSE, TRUE) = parstatus ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_deposit
DELIMITER //
CREATE PROCEDURE `sp_confirm_deposit`(
	IN `parid` INT
)
BEGIN
	UPDATE transactions SET tx_type = 1, `status` = 1, `dc` = "D", `completedDate` = CURRENT_TIMESTAMP
	WHERE `id` = parid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_batch_deposit
DELIMITER //
CREATE PROCEDURE `sp_confirm_batch_deposit`(
	IN `ids` TEXT
)
BEGIN
	SET @sql = CONCAT('UPDATE transactions SET `status` = 1, `dc` = "D", `completedDate` = CURRENT_TIMESTAMP WHERE `id` IN (', ids, ')');
	
	PREPARE stmt FROM @sql;
  	EXECUTE stmt;
  	SELECT ROW_COUNT() AS affectedRows;
  	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_withdrawals
DELIMITER //
CREATE PROCEDURE `sp_fetch_withdrawals`(
	IN `partx_type` TINYINT
)
BEGIN
   	SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.notes, t.createdDate, t.completedDate
	FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id
   	WHERE t.tx_type = partx_type ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_filter_withdrawals
DELIMITER //
CREATE PROCEDURE `sp_fetch_filter_withdrawals`(
	IN `parstatus` TINYINT,
	IN `withdraw_type` TINYINT,
	IN `partx_type` TINYINT
)
BEGIN
	IF withdraw_type = 0 THEN SET @sql = CONCAT('SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.notes, t.createdDate, t.completedDate '
													'FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id '
   												'WHERE t.tx_type = ', partx_type, ' AND IF(t.`status`-1, FALSE, TRUE) = ', parstatus, ' ORDER BY t.createdDate DESC');
  	ELSEIF withdraw_type != 0 THEN SET @sql = CONCAT('SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.notes, t.createdDate, t.completedDate '
													'FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id '
   												'WHERE t.tx_type = ', partx_type, ' AND IF(t.`status`-1, FALSE, TRUE) = ', parstatus, ' AND t.notes = ', withdraw_type, ' ORDER BY t.createdDate DESC');										
   	END IF;
	
	PREPARE stmt FROM @sql;
  	EXECUTE stmt;
  	SELECT ROW_COUNT() AS affectedRows;
  	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_withdrawals
DELIMITER //
CREATE PROCEDURE `sp_search_withdrawals`(
	IN `parid` INT,
	IN `partx_type` TINYINT
)
BEGIN
   	SELECT t.id, m.membername, t.amount, t.tx_type, IF(t.`status`=1, TRUE, FALSE) AS completed, t.notes, t.createdDate, t.completedDate
	FROM transactions AS t LEFT JOIN members AS m ON t.memberid = m.id
   	WHERE t.memberid = parid AND t.tx_type = partx_type ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_withdrawal
DELIMITER //
CREATE PROCEDURE `sp_confirm_withdrawal`(
	IN `parid` INT
)
BEGIN
	UPDATE transactions SET tx_type = 2, `status` = 1, `dc` = "C", `notes` = 2, `completedDate` = CURRENT_TIMESTAMP
	WHERE `id` = parid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_batch_withdrawal
DELIMITER //
CREATE PROCEDURE `sp_confirm_batch_withdrawal`(
	IN `ids` TEXT
)
BEGIN
	SET @sql = CONCAT('UPDATE transactions SET tx_type = 2, `status` = 1, `dc` = "C", `notes` = 2, `completedDate` = CURRENT_TIMESTAMP WHERE `id` IN (', ids, ')');
	
	PREPARE stmt FROM @sql;
  	EXECUTE stmt;
  	SELECT ROW_COUNT() AS affectedRows;
  	DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_transfers
DELIMITER //
CREATE PROCEDURE `sp_fetch_transfers`(
)
BEGIN
	SELECT t.id, m1.membername AS sender, m2.membername AS receiver, t.amount, t.dc, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t INNER JOIN members AS m1 ON m1.id = t.memberid INNER JOIN members AS m2 ON m2.id = t.transferpeer
	WHERE t.tchain IS NOT NULL
	GROUP BY t.tchain ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_filter_transfers
DELIMITER //
CREATE PROCEDURE `sp_fetch_filter_transfers`(
	IN `parstatus` TINYINT
)
BEGIN
	SELECT t.id, m1.membername AS sender, m2.membername AS receiver, t.amount, t.dc, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t INNER JOIN members AS m1 ON m1.id = t.memberid INNER JOIN members AS m2 ON m2.id = t.transferpeer
	WHERE t.tchain IS NOT NULL AND IF(t.`status`-1, FALSE, TRUE) = parstatus
	GROUP BY t.tchain ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_transfer
DELIMITER //
CREATE PROCEDURE `sp_search_transfer`(
	IN `parid` INT
)
BEGIN
	SELECT t.id, m1.membername AS sender, m2.membername AS receiver, t.amount, t.dc, IF(t.`status`=1, TRUE, FALSE) AS completed, t.createdDate, t.completedDate
	FROM transactions AS t INNER JOIN members AS m1 ON m1.id = t.memberid INNER JOIN members AS m2 ON m2.id = t.transferpeer
	WHERE t.tchain IS NOT NULL AND t.id = parid
	GROUP BY t.tchain;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_transfer
DELIMITER //
CREATE PROCEDURE `sp_confirm_transfer`(
	IN `parid` INT
)
BEGIN
	DECLARE vtchain INT;

	SET vtchain = (SELECT tchain
		FROM transactions
		WHERE `id` = parid);

	UPDATE transactions SET `status` = 1, `completedDate` = CURRENT_TIMESTAMP
	WHERE tchain = vtchain;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_confirm_batch_transfer
DELIMITER //
CREATE PROCEDURE `sp_confirm_batch_transfer`(
	IN `ids` TEXT
)
BEGIN
	DECLARE colval INT DEFAULT NULL;
	DECLARE done tinyint DEFAULT FALSE;
	DECLARE cursor1 CURSOR FOR SELECT tchain FROM vw_myproc;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
   
 	SET @sql = CONCAT('SELECT t1.tchain
     	FROM transactions t1
	  	WHERE id IN (', ids, ')');
   SET @select = CONCAT('CREATE VIEW vw_myproc AS ', @sql);
   PREPARE stm FROM @select;
   EXECUTE stm;
   DEALLOCATE PREPARE stm;
   
   SET @cnt = 0;
	START TRANSACTION;
     	OPEN cursor1;
         my_loop: 
         LOOP
            FETCH NEXT FROM cursor1 INTO colval;
            IF done THEN 
               LEAVE my_loop; 
            ELSE  
               CALL `sp_confirm_transfer_bytchain`(colval);
               SET @cnt = @cnt+1;
            END IF;
         END LOOP;
     	CLOSE cursor1;
     	
     	SELECT @cnt*2 AS affectedRows;
     	DROP VIEW vw_myproc;
	COMMIT;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_tx_history
DELIMITER //
CREATE PROCEDURE `sp_fetch_tx_history`(
	IN `memname` VARCHAR(50),
	IN `pfrom` INT,
	IN `pto` INT
)
BEGIN
	SELECT ROW_NUMBER() OVER(PARTITION BY 'id' ) AS No, T.tx_type, T.amount, T.`status`, T.dc, T.createdDate, T.notes, T.peer
	FROM (SELECT U.memberid, U.tx_type, U.amount, U.`status`, U.dc, U.createdDate, U.notes, V.membername AS peer, row_number() over (partition BY U.tx_type) as r 
		FROM transactions AS U LEFT JOIN members AS V ON U.transferpeer = V.id
		ORDER BY U.createdDate DESC) AS T LEFT JOIN members AS M ON T.memberid = M.id
	WHERE M.membername = memname AND T.r >= pfrom AND T.r <= pto ORDER BY T.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_filter_tx_history
DELIMITER //
CREATE PROCEDURE `sp_fetch_filter_tx_history`(
	IN `memname` VARCHAR(50),
	IN `partx_type` TINYINT,
	IN `pfrom` INT,
	IN `pto` INT
)
BEGIN
	SELECT ROW_NUMBER() OVER(PARTITION BY 'id' ) AS NO, T.tx_type, T.amount, T.`status`, T.dc, T.createdDate, T.notes, T.peer
	FROM (SELECT U.memberid, U.tx_type, U.amount, U.`status`, U.dc, U.createdDate, U.notes, V.membername AS peer, row_number() over (partition BY U.tx_type) as r 
		FROM transactions AS U LEFT JOIN members AS V ON U.transferpeer = V.id
		WHERE U.tx_type = partx_type
		ORDER BY U.createdDate DESC) AS T LEFT JOIN members AS M ON T.memberid = M.id
	WHERE M.membername = memname AND T.r >= pfrom AND T.r <= pto COLLATE'utf8mb4_0900_ai_ci' ORDER BY t.createdDate DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_get_cur_balance
DELIMITER //
CREATE PROCEDURE `sp_get_cur_balance`(
	IN `memname` VARCHAR(50)
)
BEGIN
	SELECT IFNULL(SUM(IF(T.dc = "D", T.amount, -T.amount)), 0) AS Balance
	FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
	WHERE M.membername = memname AND T.`status` = 1 COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_add_deposit
DELIMITER //
CREATE PROCEDURE `sp_add_deposit`(
	IN `memname` VARCHAR(50),
	IN `amnt` INT
)
BEGIN
	DECLARE memberID INT;
	
	SET memberID = (SELECT `id` FROM members WHERE `membername` = memname COLLATE'utf8mb4_0900_ai_ci');

	INSERT INTO transactions (`memberid`, `amount`, `tx_type`, `status`, `dc`) 
	VALUES (memberID, amnt, 1, 2, "D");
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_add_withdrawal
DELIMITER //
CREATE PROCEDURE `sp_add_withdrawal`(
	IN `memname` VARCHAR(50),
	IN `amnt` INT
)
BEGIN
	DECLARE memberID INT;
	
	SET memberID = (SELECT `id` FROM members WHERE `membername` = memname COLLATE'utf8mb4_0900_ai_ci');
	-- ATTENTION -> In ticket payments go in hand with sales_activities INSERT (Intrinsic)
	INSERT INTO transactions (`memberid`, `amount`, `tx_type`, `status`, `notes`, `dc`) 
	VALUES (memberID, amnt, 2, 2, 2, "C");
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_add_transfer
DELIMITER //
CREATE PROCEDURE `sp_add_transfer`(
	IN `memname` VARCHAR(50),
	IN `amnt` INT,
	IN `peermemname` VARCHAR(50)
)
BEGIN
	DECLARE memberID INT;
	DECLARE peerID INT;
	DECLARE nextTxID INT;
	
	SET information_schema_stats_expiry = 0;
	
	START TRANSACTION;
		SET memberID = (SELECT `id` FROM members WHERE `membername` = memname COLLATE'utf8mb4_0900_ai_ci');
		SET peerID = (SELECT `id` FROM members WHERE `membername` = peermemname COLLATE'utf8mb4_0900_ai_ci');
		
		SET nextTxID = (SELECT AUTO_INCREMENT
		FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_NAME = 'transactions'
		AND TABLE_SCHEMA = 'sabuydy');
	
		INSERT INTO transactions (`memberid`, `transferpeer`, `amount`, `tx_type`, `status`, `dc`, `tchain`) 
		VALUES (memberID, peerID, amnt, 3, 2, "C", nextTxID);
		
		INSERT INTO transactions (`memberid`, `transferpeer`, `amount`, `tx_type`, `status`, `dc`, `tchain`) 
		VALUES (peerID, memberID, amnt, 3, 2, "D", nextTxID);
	COMMIT;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_tickets_payment
DELIMITER //
CREATE PROCEDURE `sp_tickets_payment`(
	IN `usrname` VARCHAR(50),
	IN `paramount` INT,
	IN `sdrawdate` DATETIME,
	IN `edrawdate` DATETIME
)
BEGIN
	DECLARE memberID INT DEFAULT NULL;
	DECLARE salesFeesCommis FLOAT DEFAULT 0.0;
	DECLARE lastDrawDate DATETIME DEFAULT NULL;
	DECLARE lastOrNextDrawID INT DEFAULT NULL;
	
	DECLARE ancestorids TEXT DEFAULT '';
	DECLARE _next TEXT DEFAULT NULL;
	DECLARE _nextlen INT DEFAULT NULL;
	DECLARE _value TEXT DEFAULT NULL; -- memberid of the ancestors up to e.g. 5 levels above
	DECLARE r INT DEFAULT 0; -- running No. of row (memberid) from the list ancestor ids
	
	SET information_schema_stats_expiry = 0;
	
	START TRANSACTION;
		SET lastDrawDate = (SELECT DATE(MAX(draw_date)) FROM lotto_draws);
		IF lastDrawDate != edrawdate THEN 
			SET lastOrNextDrawID = (SELECT AUTO_INCREMENT
				FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_NAME = 'lotto_draws'
				AND TABLE_SCHEMA = 'sabuydy');
			
			INSERT INTO lotto_draws(draw_date, sgambling_date, egambling_date) 
			VALUES (edrawdate, sdrawdate, edrawdate);
		ELSE
			SET lastOrNextDrawID = (SELECT MAX(id) FROM lotto_draws);
		END IF;
		
		(SELECT id, sales_comm_perc
			FROM members
			WHERE `membername` = usrname) INTO memberID, salesFeesCommis;
		
		-- Record into transaction journal
		INSERT INTO transactions (`memberid`, `amount`, `tx_type`, `status`, `dc`, `notes`, `completedDate`) 
		VALUES (memberID, paramount*(100-salesFeesCommis)/100, 2, 1, "C", 1, CURRENT_TIMESTAMP);
		
		-- Record for MLM reporting
		INSERT INTO sales_activities(drawid, memberid, sales) 
		VALUES (lastOrNextDrawID, memberID, paramount*(100-salesFeesCommis)/100);
		
		-- Distribute revenue shares (royalties) to line ancestors (e.g. 5 upper levels)
		CALL sp_cte_get_ancestorid_list(memname, ancestorids);
			
		iterator: 
		LOOP
			IF CHAR_LENGTH(TRIM(ancestorids)) = 0 OR ancestorids IS NULL THEN
		   	LEAVE iterator;
		  	END IF;
	
			SET r = r + 1;
			SET _next = SUBSTRING_INDEX(ancestorids,',',1);
			SET _nextlen = CHAR_LENGTH(_next);
			SET _value = TRIM(_next);
			
			INSERT INTO transactions(`amount`, `tx_type`, `status`, `dc`, `transferpeer`, `notes`, `completedDate`) 
			VALUES (paramount*1/100, 1, 1, "D", _value, 5, CURRENT_TIMESTAMP);
	
			SET ancestorids = INSERT(ancestorids, 1, _nextlen + 1, '');
		END LOOP iterator;
		SELECT r AS affectedRows;
	COMMIT;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_remittances
DELIMITER //
CREATE PROCEDURE `sp_fetch_remittances`()
BEGIN
	SELECT ROW_NUMBER() OVER(PARTITION BY 'id' ) AS id, amount, paidDate 
	FROM rvn_remittance;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_unpaid_remittance
DELIMITER //
CREATE PROCEDURE `sp_fetch_unpaid_remittance`()
BEGIN
	SELECT CAST(SUM(amount)*share/100 AS UNSIGNED) AS Total, MAX(createdDate) AS RecentDate
	FROM vault, firm_share WHERE vtxtype = 2 AND paidout = 0;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_add_remittance
DELIMITER //
CREATE PROCEDURE `sp_add_remittance`()
BEGIN
	START TRANSACTION;
		INSERT INTO rvn_remittance (amount, paidDate)
		SELECT SUM(amount)*share/100 AS Total, CURRENT_TIME()
		FROM vault, firm_share WHERE vtxtype = 2 AND paidout = 0;
		
		UPDATE vault SET `paidout` = 1
		WHERE vtxtype = 2 AND paidout = 0;
		SELECT ROW_COUNT() AS affectedRows;
	COMMIT;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_revenues_current
DELIMITER //
CREATE PROCEDURE `sp_fetch_revenues_current`(
	IN `memname` VARCHAR(50),
	IN `sdate` DATETIME,
	IN `edate` DATETIME,
	IN `draw_date` DATETIME,
	OUT `precent_sales` INT,
	OUT `precent_commissions` INT,
	OUT `precent_remittances` INT
)
BEGIN
	DECLARE _draw_date DateTime DEFAULT NULL;
	DECLARE _recent_sales INT DEFAULT NULL;
	DECLARE _recent_commissions INT DEFAULT NULL;
	DECLARE _recent_remittances INT DEFAULT NULL;
	
	SELECT edate AS draw_date, SUM(sales) AS recent_sales, SUM(commissions) AS recent_commissions, SUM(remittances) AS recent_remittances
	FROM 
	(SELECT SUM(T.amount) AS sales, SUM(T.amount)*M.sales_comm_perc/100 AS commissions, SUM(T.amount)*(100-M.sales_comm_perc)/100 AS remittances
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 2 AND T.notes = 1 AND T.createdDate >= sdate AND T.createdDate <= edate COLLATE'utf8mb4_0900_ai_ci'
	) AS Recent INTO _draw_date, _recent_sales, _recent_commissions, _recent_remittances;

   	SELECT _draw_date AS draw_date, IFNULL(_recent_sales, 0) AS recent_sales, IFNULL(_recent_commissions, 0) AS recent_commissions, IFNULL(_recent_remittances, 0) AS recent_remittances;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_revenues_cumulative
DELIMITER //
CREATE PROCEDURE `sp_fetch_revenues_cumulative`(
	IN `memname` VARCHAR(50),
	OUT `psales_comm_perc` INT,
	OUT `proyalty_perlevel` INT,
	OUT `pdeposits` INT,
	OUT `psales` INT,
	OUT `pcommissions` INT,
	OUT `premittances` INT,
	OUT `ptransfers_in` INT,
	OUT `ptransfers_out` INT,
	OUT `pwithdrawals` INT
)
BEGIN
	DECLARE _sales_comm_perc INT DEFAULT NULL;
	DECLARE _royalty_perlevel INT DEFAULT NULL;
	DECLARE _deposits INT DEFAULT NULL;
	DECLARE _sales INT DEFAULT NULL;
	DECLARE _commissions INT DEFAULT NULL;
	DECLARE _remittances INT DEFAULT NULL;
	DECLARE _transfers_in INT DEFAULT NULL;
	DECLARE _transfers_out INT DEFAULT NULL;
	DECLARE _withdrawals INT DEFAULT NULL;
	
	SELECT sales_comm_perc, 1.0 AS royalty_perlevel, SUM(deposits) AS deposits, SUM(sales) AS sales, SUM(commissions) AS commissions, 
		SUM(remittances) AS remittances, SUM(transfers_in) AS transfers_in, SUM(transfers_out) AS transfers_out, SUM(withdrawals) AS withdrawals
	FROM
	(SELECT sales_comm_perc, 0 AS deposits, SUM(T.amount) AS sales, SUM(T.amount)*M.sales_comm_perc/100 AS commissions, 
		SUM(T.amount)*(100-M.sales_comm_perc)/100 AS remittances, 0 AS transfers_in, 0 AS transfers_out, 0 AS withdrawals
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 2 AND T.notes = 1 COLLATE'utf8mb4_0900_ai_ci'
	UNION
	SELECT M.sales_comm_perc AS sales_comm_perc, SUM(T.amount) AS deposits, 0 AS sales, 0 AS commissions,  
		0 AS remittances, 0 AS transfers_in, 0 AS transfers_out, 0 AS withdrawals
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 1 AND T.status = 1 COLLATE'utf8mb4_0900_ai_ci'
	UNION
	SELECT M.sales_comm_perc AS sales_comm_perc, 0 AS deposits, 0 AS sales, 0 AS commissions, 
		0 AS remittances, SUM(T.amount) AS transfers_in, 0 AS transfers_out, 0 AS withdrawals
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 3 AND T.dc = "D" AND T.status = 1 COLLATE'utf8mb4_0900_ai_ci'
	UNION
	SELECT M.sales_comm_perc AS sales_comm_perc, 0 AS deposits, 0 AS sales, 0 AS commissions, 
		0 AS remittances, 0 AS transfers_in, SUM(T.amount) AS transfers_out, 0 AS withdrawals
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 3 AND T.dc = "C" AND T.status = 1 COLLATE'utf8mb4_0900_ai_ci'
	UNION
	SELECT M.sales_comm_perc AS sales_comm_perc, 0 AS deposits, 0 AS sales, 0 AS commissions, 
		0 AS remittances, 0 AS transfers_in, 0 AS transfers_out, SUM(T.amount) AS withdrawals
		FROM transactions AS T LEFT JOIN members AS M ON T.memberid = M.id
		WHERE M.membername = memname AND T.tx_type = 2 AND T.notes = 2 AND T.status = 1 COLLATE'utf8mb4_0900_ai_ci'
	) AS Cumulative INTO _sales_comm_perc, _royalty_perlevel, _deposits, _sales, _commissions, _remittances, _transfers_in, _transfers_out, _withdrawals;

   	SELECT _sales_comm_perc AS sales_comm_perc, _royalty_perlevel AS royalty_perlevel, IFNULL(_deposits, 0) AS deposits, IFNULL(_sales, 0) AS sales, IFNULL(_commissions,0) AS commissions, 
			IFNULL(_remittances, 0) AS remittances, IFNULL(_transfers_in, 0) AS transfers_in, IFNULL(_transfers_out, 0) AS transfers_out, IFNULL(_withdrawals, 0) AS withdrawals;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_fetch_revenues_members
DELIMITER //
CREATE PROCEDURE `sp_fetch_revenues_members`(
	IN `memname` VARCHAR(50),
	IN `sdate` DATETIME,
	IN `edate` DATETIME
)
BEGIN
	DECLARE draw_date DATETIME;
	DECLARE recent_sales INT;
	DECLARE recent_commissions INT;
	DECLARE recent_remittances INT;
	
	DECLARE sales_comm_perc INT;
	DECLARE royalty_perlevel INT;
	DECLARE deposits INT;
	DECLARE sales INT;
	DECLARE commissions INT;
	DECLARE remittances INT;
	DECLARE transfers_in INT;
	DECLARE transfers_out INT;
	DECLARE withdrawals INT;
	
	DECLARE currentDrawId INT;
	
	SET currentDrawId = (SELECT l.id FROM lotto_draws AS l WHERE l.draw_date=edate);
	
	CALL sp_fetch_revenues_current(memname, sdate, edate, draw_date, recent_sales, recent_commissions, recent_remittances);
	CALL sp_fetch_revenues_cumulative(memname, sales_comm_perc, royalty_perlevel, deposits, sales, commissions, remittances, transfers_in, transfers_out, withdrawals);
	CALL sp_cte_members_rvn_rec_by_lvl(memname, currentDrawId);
	CALL sp_cte_members_rvn_cum_by_lvl(memname);
END//
DELIMITER ;





-- Dumping structure for procedure sabuydy.sp_create_user
DELIMITER //
CREATE PROCEDURE `sp_create_user`(
	IN `user_info` JSON
)
BEGIN
	INSERT INTO users (`username`, `email`, `phoneno`, `password`, `roleid`) 
	VALUES (JSON_UNQUOTE(`user_info`->>'$.username'), 
			JSON_UNQUOTE(`user_info`->>'$.email'), 
			JSON_UNQUOTE(`user_info`->>'$.phoneno'), 
			JSON_UNQUOTE(`user_info`->>'$.password'), 
			JSON_UNQUOTE(`user_info`->>'$.roleid'));
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_user_by_id
DELIMITER //
CREATE PROCEDURE `sp_search_user_by_id`(
	IN `userid` INT
)
BEGIN
   SELECT username, email, phoneno, password, roleid
   FROM users
   WHERE id = userid;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_usernames
DELIMITER //
CREATE PROCEDURE `sp_search_usernames`(
	IN `usrname` VARCHAR(50)
)
BEGIN
   SELECT username
   FROM users
   WHERE username LIKE CONCAT('%', usrname, '%') COLLATE'utf8mb4_0900_ai_ci' ORDER BY created_at DESC;
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_user_by_username
DELIMITER //
CREATE PROCEDURE `sp_search_user_by_username`(
	IN `usrname` VARCHAR(50)
)
BEGIN
   SELECT id, username, email, phoneno, roleid, LOCATE(":", `password`) AS approved
   FROM users
   WHERE username = usrname COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_update_user_for_member
DELIMITER //
CREATE PROCEDURE `sp_update_user_for_member`(
	IN `mem_info` JSON
)
BEGIN
	UPDATE users SET `email` = JSON_UNQUOTE(`mem_info`->>'$.email'), 
		`phoneno` = JSON_UNQUOTE(`mem_info`->>'$.phoneno'), 
		`password` = JSON_UNQUOTE(`mem_info`->>'$.password') 
	WHERE `username` = JSON_EXTRACT(`mem_info`, '$.username');
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_search_profile_by_membername
DELIMITER //
CREATE PROCEDURE `sp_search_profile_by_membername`(
	IN `memname` VARCHAR(50)
)
BEGIN
	SELECT members.membername, parent.username AS referrerid, member_profiles.firstname, member_profiles.lastname, 
		users.phoneno, users.email, members.approved
	FROM members
		LEFT JOIN users AS parent ON members.parentid = parent.id 
		LEFT JOIN users ON members.userid = users.id
		LEFT JOIN member_profiles ON members.id = member_profiles.memberid
	WHERE members.membername = memname COLLATE'utf8mb4_0900_ai_ci';
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_create_member_profile
DELIMITER //
CREATE PROCEDURE `sp_create_member_profile`(
	IN `mem_info` JSON
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLSTATE '23000' CALL sp_update_member_profile(`mem_info`); -- duplicate-key error
	INSERT INTO member_profiles (`memberid`, `firstname`, `lastname`) 
	   VALUES ((SELECT id
		FROM members
		WHERE `membername` = JSON_EXTRACT(`mem_info`, '$.username')),
		JSON_UNQUOTE(`mem_info`->>'$.firstname'),
		JSON_UNQUOTE(`mem_info`->>'$.lastname'));
	
	UPDATE users SET `email` = JSON_UNQUOTE(`mem_info`->>'$.email'), 
		`phoneno` = JSON_UNQUOTE(`mem_info`->>'$.phoneno'), 
		`password` = JSON_UNQUOTE(`mem_info`->>'$.password') 
	WHERE `username` = JSON_EXTRACT(`mem_info`, '$.username');
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_update_member_profile
DELIMITER //
CREATE PROCEDURE `sp_update_member_profile`(
	IN `mem_info` JSON
)
BEGIN
	UPDATE member_profiles SET `firstname` = JSON_UNQUOTE(`mem_info`->>'$.firstname'), 
			`lastname` = JSON_UNQUOTE(`mem_info`->>'$.lastname') 
		WHERE `memberid` = (SELECT id
			FROM members
			WHERE `membername` = JSON_EXTRACT(`mem_info`, '$.username'));
		
	UPDATE users SET `email` = JSON_UNQUOTE(`mem_info`->>'$.email'), 
		`phoneno` = JSON_UNQUOTE(`mem_info`->>'$.phoneno'), 
		`password` = JSON_UNQUOTE(`mem_info`->>'$.password') 
	WHERE `username` = JSON_EXTRACT(`mem_info`, '$.username');
END//
DELIMITER ;

-- Dumping structure for procedure sabuydy.sp_register_from_referral
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_from_referral`(
	IN `mem_info` JSON
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE nextUserID INT;
	DECLARE nextMemberID INT;
	DECLARE parentID INT;
	
	SET information_schema_stats_expiry = 0;
	
	SET nextUserID = (SELECT AUTO_INCREMENT
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'users'
			AND TABLE_SCHEMA = 'sabuydy');
			
	SET nextMemberID = (SELECT AUTO_INCREMENT
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_NAME = 'members'
			AND TABLE_SCHEMA = 'sabuydy');
			
	SET parentID = (SELECT id
			FROM `users`
			WHERE `username` = JSON_EXTRACT(`mem_info`, '$.referrerid'));
	
   INSERT INTO `users` (`username`, `email`, `phoneno`, `password`) 
   VALUES (JSON_UNQUOTE(`mem_info`->>'$.username'), 
         JSON_UNQUOTE(`mem_info`->>'$.email'), 
         JSON_UNQUOTE(`mem_info`->>'$.phoneno'),
			JSON_UNQUOTE(`mem_info`->>'$.password'));
	
	INSERT INTO `members` (`userid`, `membername`, `parentid`) 
   VALUES (nextUserID, 
         JSON_UNQUOTE(`mem_info`->>'$.username'),
			parentID);
	
	INSERT INTO `member_profiles` (`memberid`, `email`, `phoneno`) 
   VALUES (nextMemberID, 
         JSON_UNQUOTE(`mem_info`->>'$.email'),
			JSON_UNQUOTE(`mem_info`->>'$.phoneno'));
END


-- Dumping structure for view sabuydy.consol_royalty
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `consol_royalty`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `consol_royalty` AS with recursive `reporting_chain` (`id`,`LEVEL`,`sales`,`royalty`) as (select `ms`.`id` AS `id`,1 AS `1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities` where (`sales_activities`.`drawid` = 2)) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` where (`ms`.`parentid` = 5) union all select `ms`.`id` AS `id`,(`r`.`LEVEL` + 1) AS `r.LEVEL+1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (`reporting_chain` `r` join (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities` where (`sales_activities`.`drawid` = 2)) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` on((`r`.`id` = `ms`.`parentid`)))) select `r`.`LEVEL` AS `LEVEL`,sum(`r`.`sales`) AS `sales`,sum(`r`.`royalty`) AS `royalties` from `reporting_chain` `r` where (`r`.`LEVEL` < 6) group by `r`.`LEVEL`;

-- Dumping structure for view sabuydy.consol_royalty_system
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `consol_royalty_system`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `consol_royalty_system` AS with recursive `reporting_chain` (`id`,`LEVEL`,`sales`,`royalty`) as (select `ms`.`id` AS `id`,0 AS `0`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities` where (`sales_activities`.`drawid` = 2)) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` where (`ms`.`parentid` is null) union all select `ms`.`id` AS `id`,(`r`.`LEVEL` + 1) AS `r.LEVEL+1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (`reporting_chain` `r` join (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities` where (`sales_activities`.`drawid` = 2)) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` on((`r`.`id` = `ms`.`parentid`)))) select `r`.`LEVEL` AS `LEVEL`,sum(`r`.`sales`) AS `sales`,sum(`r`.`royalty`) AS `royalties` from `reporting_chain` `r` group by `r`.`LEVEL`;

-- Dumping structure for view sabuydy.cumul_royalty
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `cumul_royalty`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `cumul_royalty` AS with recursive `reporting_chain` (`id`,`LEVEL`,`sales`,`royalty`) as (select `ms`.`id` AS `id`,1 AS `1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities`) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` where (`ms`.`parentid` = 5) union all select `ms`.`id` AS `id`,(`r`.`LEVEL` + 1) AS `r.LEVEL+1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (`reporting_chain` `r` join (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities`) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` on((`r`.`id` = `ms`.`parentid`)))) select `r`.`LEVEL` AS `LEVEL`,sum(`r`.`sales`) AS `sales`,sum(`r`.`royalty`) AS `royalties` from `reporting_chain` `r` where (`r`.`LEVEL` < 6) group by `r`.`LEVEL`;

-- Dumping structure for view sabuydy.cumul_royalty_system
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `cumul_royalty_system`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `cumul_royalty_system` AS with recursive `reporting_chain` (`id`,`LEVEL`,`sales`,`royalty`) as (select `ms`.`id` AS `id`,0 AS `0`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities`) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` where (`ms`.`parentid` is null) union all select `ms`.`id` AS `id`,(`r`.`LEVEL` + 1) AS `r.LEVEL+1`,`ms`.`sales` AS `sales`,((`ms`.`sales` * 1) / 100) AS `royalty` from (`reporting_chain` `r` join (select `m`.`id` AS `id`,`m`.`membername` AS `membername`,`m`.`parentid` AS `parentid`,`m`.`sales_comm_perc` AS `sales_comm_perc`,`m`.`created_at` AS `created_at`,`s`.`sales` AS `sales` from (`members` `m` left join (select `sales_activities`.`id` AS `id`,`sales_activities`.`drawid` AS `drawid`,`sales_activities`.`memberid` AS `memberid`,`sales_activities`.`sales` AS `sales`,`sales_activities`.`commissions` AS `commissions`,`sales_activities`.`created_at` AS `created_at` from `sales_activities`) `s` on((`m`.`id` = `s`.`memberid`)))) `ms` on((`r`.`id` = `ms`.`parentid`)))) select `r`.`LEVEL` AS `LEVEL`,sum(`r`.`sales`) AS `sales`,sum(`r`.`royalty`) AS `royalties` from `reporting_chain` `r` group by `r`.`LEVEL`;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;


-- CTE 
-- Dumping structure for procedure sabuydy.sp_cte_members_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_system`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	WITH RECURSIVE members_path (id, membername, path, level) AS
	(
	  SELECT id, membername, CAST(membername AS CHAR(100)), 0 level
	    FROM members
	    WHERE approved = 1 AND parentid IS NULL
	  UNION ALL
	  SELECT m.id, m.membername, CONCAT(mp.path, ' > ', m.membername), mp.level + 1
	    FROM members_path AS mp JOIN members AS m
	      ON mp.id = m.parentid WHERE m.approved = 1
	)
	SELECT * FROM members_path
	ORDER BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_path (id, membername, path, level) AS
	(
	  SELECT id, membername, CAST(membername AS CHAR(100)), 1 level
	    	FROM members
	   	 WHERE approved = 1 AND parentid = memberID
	  UNION ALL
	  SELECT m.id, m.membername, CONCAT(mp.path, ' > ', m.membername), mp.level + 1
	    	FROM members_path AS mp JOIN members AS m
	      ON mp.id = m.parentid WHERE m.approved = 1
	)
	SELECT * FROM members_path 
		WHERE level<maxLevel 
		ORDER BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members_rvn_rec_by_desc
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_rvn_rec_by_desc`(
	IN `memname` VARCHAR(50),
	IN `pdrawid` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, membername, sales, commissions, royalties, level) AS (
	  	SELECT m.id, m.membername, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.membername, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.membername, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT id, membername, IFNULL(sales, 0) AS sales, CAST(IFNULL(commissions, 0) AS UNSIGNED) AS commissions, CAST(IFNULL(royalties, 0) AS UNSIGNED) AS royalties, level FROM members_rvn
		WHERE level<maxLevel 
		ORDER BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members_rvn_rec_by_lvl
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_rvn_rec_by_lvl`(
	IN `memname` VARCHAR(50),
	IN `pdrawid` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, sales, commissions, royalties, level) AS (
	  	SELECT m.id, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalties FROM members_rvn
		WHERE level<maxLevel 
		GROUP BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members_rvn_cum_by_desc
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_rvn_cum_by_desc`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, membername, sales, commissions, royalties, level) AS (
	  	SELECT m.id, m.membername, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.membername, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.membername, m.parentid, s.sales AS sales, s.commissions AS commissions FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT id, membername, CAST(IFNULL(sales, 0) AS UNSIGNED) AS sales, CAST(IFNULL(commissions, 0) AS UNSIGNED) AS commissions, CAST(IFNULL(royalties, 0) AS UNSIGNED) AS royalties, level FROM members_rvn
		WHERE level<maxLevel 
		ORDER BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members_rvn_cum_by_lvl
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_rvn_cum_by_lvl`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, sales, commissions, royalties, level) AS (
	 	SELECT m.id, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    		FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	    WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalties FROM members_rvn
		WHERE level<maxLevel 
		GROUP BY level;
END


-- Dumping structure for procedure sabuydy.sp_cte_members_rvn_cum_with_path
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_rvn_cum_with_path`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, membername, path, sales, commissions, royalties, level) AS (
	  	SELECT m.id, m.membername, CAST(membername AS CHAR(100)), s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.membername, CONCAT(r.path, ' > ', ms.membername), ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.membername, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT id, membername, path, level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalty 
		FROM members_rvn
		WHERE level<maxLevel 
		GROUP BY id
		ORDER BY level, membername;
END


-- Dumping structure for procedure sabuydy.sp_cte_get_ancestorids
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_get_ancestorids`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 5; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);

	WITH RECURSIVE ancestorMembers AS (
	   SELECT id, membername, parentid, 0 AS depth
	      FROM members
	      WHERE approved = 1 AND id = memberID
	   UNION ALL
	   SELECT m.id, m.membername, m.parentid, am.depth - 1
	      FROM ancestorMembers AS am 
	        JOIN members AS m ON am.parentid = m.id WHERE m.approved = 1)
		SELECT * FROM ancestorMembers
		  	WHERE id !=1 AND depth BETWEEN -maxLevel AND -1 -- id=1 -> system
		  	ORDER BY depth;
END


-- Dumping structure for procedure sabuydy.sp_cte_get_ancestorid_list
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_get_ancestorid_list`(
	IN `memname` VARCHAR(50),
	OUT `ancestor_ids` TEXT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 5; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);

	WITH RECURSIVE ancestorMembers(id, parentid, depth, parentids) AS (
	   SELECT id, parentid, 0 AS depth, CAST(parentid AS CHAR(100))
	      FROM members
	      WHERE approved = 1 AND id = memberID
	   UNION ALL
	   SELECT m.id, m.parentid, am.depth - 1, CONCAT(am.parentids, ', ', m.parentid)
	      FROM ancestorMembers AS am 
	        JOIN members AS m ON am.parentid = m.id WHERE m.approved = 1)
		SELECT parentids INTO ancestor_ids FROM ancestorMembers
	  	WHERE id !=1 AND depth BETWEEN -maxLevel AND -1 -- id=1 -> system
		  	ORDER BY depth
			LIMIT 1,1;
END


-- Dumping structure for procedure sabuydy.sp_cte_get_ancestorid_pathlist
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_get_ancestorid_pathlist`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 5; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);

	WITH RECURSIVE ancestorMembers AS (
	   SELECT id, membername, parentid, 0 AS depth
	      FROM members
	      WHERE approved = 1 AND id = memberID
	   UNION ALL
	   SELECT m.id, m.membername, m.parentid, am.depth - 1
	      FROM ancestorMembers AS am 
	        JOIN members AS m ON am.parentid = m.id WHERE m.approved = 1)
		SELECT * FROM ancestorMembers
		  	WHERE id !=1 AND depth BETWEEN -maxLevel AND -1 -- id=1 -> system
		  	ORDER BY depth;
END


-- Dumping structure for procedure sabuydy.sp_cte_members_sys_rvn_cum_by_lvl
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_sys_rvn_cum_by_lvl`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, sales, commissions, royalties, level) AS (
	  	SELECT m.id, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	   	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	   	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	   	FROM members_rvn AS r JOIN (SELECT m.id, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalties FROM members_rvn
		WHERE level<maxLevel 
		GROUP BY level;
END

-- Dumping structure for procedure sabuydy.sp_cte_members_sys_rvn_rec_by_lvl
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_sys_rvn_rec_by_lvl`(
	IN `memname` VARCHAR(50),
	IN `pdrawid` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE members_rvn (id, sales, commissions, royalties, level) AS (
	  	SELECT m.id, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN (SELECT * FROM sales_activities WHERE drawid=pdrawid) s ON m.id = s.memberid) AS ms ON r.id = ms.parentid)
	SELECT level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalties FROM members_rvn
		WHERE level<maxLevel 
		GROUP BY level;
END

-- Dumping structure for procedure sabuydy.sp_fetch_sys_revenues_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetch_sys_revenues_members`(
	IN `memname` VARCHAR(50),
	IN `sdate` DATETIME,
	IN `edate` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE currentDrawId INT;
	
	SET currentDrawId = (SELECT l.id FROM lotto_draws AS l WHERE l.draw_date=edate);
	
	CALL sp_cte_members_sys_rvn_rec_by_lvl(memname, currentDrawId);
	CALL sp_cte_members_sys_rvn_cum_by_lvl(memname);
END

-- Dumping structure for procedure sabuydy.sp_cte_members_sys_rvn_cum_with_path
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_members_sys_rvn_cum_with_path`(
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	WITH RECURSIVE members_rvn (id, membername, path, sales, commissions, royalties, level) AS
	(
	  	SELECT m.id, m.membername, CAST(m.membername AS CHAR(100)), s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 0 level
	   	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	    	WHERE m.parentid IS NULL
	  	UNION
	  	SELECT ms.id, ms.membername, CONCAT(r.path, ' > ', ms.membername), ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.membername, m.parentid, s.sales, s.commissions FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid
	)
	SELECT id, membername, path, level AS LEVEL, CAST(IFNULL(SUM(sales), 0) AS UNSIGNED) AS sales, CAST(IFNULL(SUM(commissions), 0) AS UNSIGNED) AS commissions, CAST(IFNULL(SUM(royalties), 0) AS UNSIGNED) AS royalty 
		FROM members_rvn
		GROUP BY id
		ORDER BY level, membername;
END


-- Dumping structure for procedure sabuydy.sp_cte_fetch_gambling_season
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_fetch_gambling_season`(
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE sayBef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET saybef = get_days_before(fdd);
	
	WITH RECURSIVE drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL (-saybef + IF(YEAR(DATE_ADD(fdd, INTERVAL -saybef DAY)) = pyear AND MONTH(DATE_ADD(fdd, INTERVAL -saybef DAY)) = pmonth, 0, IF(WEEKDAY(fdd) = 0, 2, 1))) DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	)
	SELECT * FROM drawdates;
END


-- Dumping structure for procedure sabuydy.sp_cte_rvn_nos_children_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_nos_children_members`(
	IN `memname` VARCHAR(50),
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE 
	drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	),
	members_children (id, integrdate, level) AS
	(
	  	SELECT id, approvedDate AS integrdate, 1 LEVEL
	    	FROM members
	    	WHERE approved = 1 AND parentid = memberID
	  	UNION ALL
	  	SELECT m.id, m.approvedDate AS integrdate, mc.level + 1
	    	FROM members_children AS mc JOIN members AS m ON mc.id = m.parentid
	    	WHERE m.approved = 1
	)
	SELECT edate AS drawdate, CAST(IFNULL(mc.noschildren, 0) AS UNSIGNED) AS noschildren
		FROM drawdates LEFT JOIN (SELECT integrdate, COUNT(*) AS noschildren FROM members_children
		WHERE level<maxLevel GROUP BY integrdate) mc ON edate=mc.integrdate;
END



-- Dumping structure for procedure sabuydy.sp_cte_rvn_nos_children_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_nos_children_system`(
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);
	
	WITH RECURSIVE 
	drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	),
	members_children (integrdate, noschildren) AS
	(
	  	SELECT get_rel_drawdate(approvedDate) AS integrdate, COUNT(*) AS noschildren
	    	FROM members
	    	WHERE approved = 1
	    	GROUP BY integrdate
	)
	SELECT edate AS drawdate, CAST(IFNULL(noschildren, 0) AS UNSIGNED) AS noschildren
		FROM drawdates AS dd LEFT JOIN members_children AS mc ON dd.edate = mc.integrdate;
END


-- Dumping structure for procedure sabuydy.sp_cte_rvn_royalties_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_royalties_members`(
	IN `memname` VARCHAR(50),
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5, 1000 for 'system'
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);

	WITH RECURSIVE drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	),
	members_rvn (id, royalties, draw_date, level) AS (
	  	SELECT m.id, s.sales*1/100 AS royalties, l.draw_date, 1 level
	    	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid LEFT JOIN lotto_draws l ON s.drawid = l.id
	    	WHERE parentid = memberID
	  	UNION
	  	SELECT ms.id, ms.sales*1/100 AS royalties, ms.draw_date, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.parentid, s.sales AS sales, l.draw_date 
		 	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid LEFT JOIN lotto_draws l ON s.drawid = l.id) AS ms ON r.id = ms.parentid
	)
	SELECT edate AS drawdate, CAST(IFNULL(mr.royalties, 0) AS UNSIGNED) AS royalties FROM drawdates LEFT JOIN (SELECT draw_date, SUM(royalties) AS royalties FROM members_rvn
	WHERE level<maxLevel) mr ON edate=mr.draw_date;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_royalties_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_royalties_system`(
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);

	WITH RECURSIVE drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates 
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	)
	SELECT dd.edate AS drawdate, CAST(IFNULL(SUM(sa.sales)*1/100, 0) AS UNSIGNED) AS royalties FROM drawdates dd LEFT JOIN (SELECT s.drawid, s.sales, l.draw_date 
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id) sa ON dd.edate = sa.draw_date
		GROUP BY dd.edate;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_sales_commissions_member
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_sales_commissions_member`(
	IN `memname` VARCHAR(50),
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);

	WITH RECURSIVE drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates 
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	)
	SELECT dd.edate AS drawdate, IFNULL(sa.commissions, 0) AS commissions FROM drawdates dd LEFT JOIN (SELECT s.drawid, s.sales, s.commissions, l.draw_date 
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id LEFT JOIN members m ON s.memberid = m.id 
		WHERE m.membername = memname) sa ON dd.edate = sa.draw_date;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_sales_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_sales_system`(
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE daysbef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET daysbef = get_days_before(fdd);

	WITH RECURSIVE drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -daysbef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates 
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	)
	SELECT dd.edate AS drawdate, IFNULL(SUM(sa.sales), 0) AS sales FROM drawdates dd LEFT JOIN (SELECT s.drawid, s.sales, l.draw_date 
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id) sa ON dd.edate = sa.draw_date
		GROUP BY dd.edate;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_cumulative_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_cumulative_members`(
	IN `memname` VARCHAR(50),
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE sayBef INT DEFAULT NULL;
	
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5, 1000 for 'system'
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET saybef = get_days_before(fdd);
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE
	drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -saybef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	),
	members_commissions (drawdate, revenues) AS (
		SELECT l.draw_date AS drawdate, s.commissions AS revenues
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id LEFT JOIN members m ON s.memberid = m.id 
		WHERE m.membername = memname
	),
	members_royalties (id, drawdate, revenues, level) AS (
	  	SELECT m.id, l.draw_date AS drawdate, s.sales*1/100 AS revenues, 1 level
	    	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid LEFT JOIN lotto_draws l ON s.drawid = l.id
	    	WHERE parentid = memberID AND l.draw_date IS NOT NULL
	  	UNION
	  	SELECT ms.id, ms.draw_date AS drawdate, ms.sales*1/100 AS revenues, r.level + 1
	    	FROM members_royalties AS r JOIN (SELECT m.id, m.parentid, s.sales AS sales, l.draw_date 
		 	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid LEFT JOIN lotto_draws l ON s.drawid = l.id) AS ms ON r.id = ms.parentid
		 	WHERE ms.draw_date IS NOT NULL
	),
	members_all_revenues (drawdate, revenues) AS (
		SELECT drawdate, revenues FROM members_commissions
		UNION ALL
		SELECT drawdate, revenues FROM members_royalties
	),
	members_totals (drawdate, revenues) AS (
		SELECT drawdate, SUM(SUM(revenues)) OVER (ORDER BY drawdate ASC) AS CumulRevenues  
		FROM members_all_revenues
		GROUP BY drawdate
	)
	SELECT edate AS drawdate, CAST(IFNULL(revenues, 0) AS UNSIGNED) AS CumulRevenues 
		FROM drawdates AS dd LEFT JOIN members_totals mt ON dd.edate = mt.drawdate;
END


-- Dumping structure for procedure sabuydy.sp_cte_rvn_cumulative_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_cumulative_system`(
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE fdd DATETIME DEFAULT NULL; -- First draw date of the month;
	DECLARE sayBef INT DEFAULT NULL;
	
	SET fdd = get_first_drawdate(pyear, pmonth);
	SET saybef = get_days_before(fdd);
	
	WITH RECURSIVE
	drawdates AS (
		SELECT DATE_ADD(fdd, INTERVAL -saybef DAY) AS sdate, fdd AS edate -- Initial Condition
	  	UNION ALL
	  	SELECT DATE_ADD(get_next_drawdate(edate), INTERVAL -get_days_before(get_next_drawdate(edate)) DAY), get_next_drawdate(edate)
		  FROM drawdates
		  WHERE edate < DATE_ADD(DATE_ADD(CONCAT(pyear, '-', pmonth, '-', 1), INTERVAL 1 MONTH), INTERVAL -1 DAY) -- Recursive Condition
	),
	members_royalties (drawdate, revenues) AS (
	  	SELECT l.draw_date AS drawdate, s.sales*1/100 AS revenues 
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id
	),
	members_totals (drawdate, revenues) AS (
		SELECT drawdate, SUM(SUM(revenues)) OVER (ORDER BY drawdate ASC) AS CumulRevenues  
		FROM members_royalties
		GROUP BY drawdate
	)
	SELECT edate AS drawdate, CAST(IFNULL(revenues, 0) AS UNSIGNED) AS CumulRevenues 
		FROM drawdates AS dd LEFT JOIN members_totals mt ON dd.edate = mt.drawdate;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_average_members
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_average_members`(
	IN `memname` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE memberID INT;
	DECLARE maxLevel INT DEFAULT 6; -- Max 5
	
	SET memberID = (SELECT id FROM members WHERE membername = memname);
	
	WITH RECURSIVE 
	members_rvn (id, membername, sales, commissions, royalties, level) AS (
	  	SELECT m.id, m.membername, s.sales AS sales, s.commissions AS commissions, s.sales*1/100 AS royalties, 1 level
	    	FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid
	    	WHERE parentid = memberID AND YEAR(s.createdDate) <= pyear AND MONTH(s.createdDate) <= pmonth
	  	UNION
	  	SELECT ms.id, ms.membername, ms.sales AS sales, ms.commissions AS commissions, ms.sales*1/100 AS royalties, r.level + 1
	    	FROM members_rvn AS r JOIN (SELECT m.id, m.membername, m.parentid, s.sales AS sales, s.commissions AS commissions, s.createdDate 
			FROM members m LEFT JOIN sales_activities s ON m.id = s.memberid) AS ms ON r.id = ms.parentid 
			WHERE YEAR(ms.createdDate) <= pyear AND MONTH(ms.createdDate) <= pmonth)
	SELECT CAST(AVG(IFNULL(commissions + royalties, 0)) AS UNSIGNED) AS avgRevenues FROM members_rvn;
END

-- Dumping structure for procedure sabuydy.sp_cte_rvn_average_system
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cte_rvn_average_system`(
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	WITH 
	members_royalties (royalties) AS (
	  	SELECT s.sales*1/100 AS royalties 
		FROM sales_activities s LEFT JOIN lotto_draws l ON s.drawid = l.id 
		WHERE YEAR(s.createdDate) <= pyear AND MONTH(s.createdDate) <= pmonth
	),
	members_averages (royalties) AS (
		SELECT AVG(royalties) AS avgRevenues  
		FROM members_royalties
	)
	SELECT CAST(IFNULL(royalties, 0) AS UNSIGNED) AS avgRevenues 
	FROM members_averages;
END


-- Dumping structure for procedure sabuydy.sp_fetch_batch_chart_revenues
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetch_batch_chart_revenues`(
	IN `memname` VARCHAR(50),
	IN `pyear` INT,
	IN `pmonth` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF memname != 'system' THEN 
		CALL sp_cte_rvn_sales_commissions_member(memname, pyear, pmonth);
		CALL sp_cte_rvn_royalties_members(memname, pyear, pmonth);
		CALL sp_cte_rvn_nos_children_members(memname, pyear, pmonth);
		CALL sp_cte_rvn_cumulative_members(memname, pyear, pmonth);
		CALL sp_cte_rvn_average_members(memname, pyear, pmonth);
	ELSE
		CALL sp_cte_rvn_sales_system(pyear, pmonth);
		CALL sp_cte_rvn_royalties_system(pyear, pmonth);
		CALL sp_cte_rvn_nos_children_system(pyear, pmonth);
		CALL sp_cte_rvn_cumulative_system(pyear, pmonth);
		CALL sp_cte_rvn_average_system(pyear, pmonth);
	END IF;
END
















-- Dumping structure for function sabuydy.get_days_before
CREATE DEFINER=`root`@`localhost` FUNCTION `get_days_before`(
	`pdrawdate` DATETIME
)
RETURNS int
LANGUAGE SQL
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE curDrawWDay INT DEFAULT NULL;
	DECLARE daysBefore INT DEFAULT NULL;
	
	SET curDrawWDay = WEEKDAY(pdrawdate);
	
	CASE
    	WHEN curDrawWDay = 0 THEN
			SET daysBefore = 2;
    	WHEN curDrawWDay = 2 THEN
    		SET daysBefore = 1;
    	WHEN curDrawWDay = 4 THEN
			SET daysBefore = 1;
	END CASE;

	RETURN daysBefore;
END

-- Dumping structure for function sabuydy.get_first_drawdate
CREATE DEFINER=`root`@`localhost` FUNCTION `get_first_drawdate`(
	`pyear` INT,
	`pmonth` INT
)
RETURNS datetime
LANGUAGE SQL
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE dtFirstDDate DATETIME DEFAULT NULL;
	DECLARE dayDDate INT DEFAULT NULL;
	DECLARE d INT DEFAULT 1;
	
	SET @drawWDays = '0,2,4'; -- 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday
	SET @maxNosDays = 30;

  	iterator: WHILE d<=@maxNosDays DO
  		SET dtFirstDDate = STR_TO_DATE(CONCAT(pyear, '-', pmonth, '-', d),'%Y-%m-%d');
  		IF (FIND_IN_SET(WEEKDAY(dtFirstDDate), @drawWDays) != 0) THEN
  			LEAVE iterator;
  		END IF;
    	SET d = d + 1;
  	END WHILE iterator;
  	
	RETURN dtFirstDDate;
END

-- Dumping structure for function sabuydy.get_next_drawdate
CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_drawdate`(
	`pdrawdate` DATETIME
)
RETURNS datetime
LANGUAGE SQL
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE dtNextDDate DATETIME DEFAULT NULL;
	DECLARE curDrawWDay INT DEFAULT NULL;
	DECLARE nextDrawDay INT DEFAULT NULL;
	
	SET curDrawWDay = WEEKDAY(pdrawdate);
	
	CASE
    	WHEN curDrawWDay = 0 THEN
			SET nextDrawDay = 2;
    	WHEN curDrawWDay = 2 THEN
    		SET nextDrawDay = 2;
    	WHEN curDrawWDay = 4 THEN
			SET nextDrawDay = 3;
	END CASE;
	
	SET dtNextDDate = DATE_ADD(pdrawdate, INTERVAL nextDrawDay DAY);
	
	RETURN dtNextDDate;
END

-- Dumping structure for function sabuydy.get_rel_drawdate
CREATE DEFINER=`root`@`localhost` FUNCTION `get_rel_drawdate`(
	`inputdate` DATETIME
)
RETURNS datetime
LANGUAGE SQL
NOT DETERMINISTIC
NO SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE drawDate DATETIME DEFAULT NULL;
	DECLARE vweekday INT DEFAULT NULL;
	DECLARE diffDay INT DEFAULT NULL;
	
	SET vweekday = WEEKDAY(inputdate);
	
	-- 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday
	CASE
    	WHEN vweekday = 0 THEN SET diffDay = 0;
    	WHEN vweekday = 1 THEN SET diffDay = 1;
    	WHEN vweekday = 2 THEN SET diffDay = 0;
    	WHEN vweekday = 3 THEN SET diffDay = 1;
    	WHEN vweekday = 4 THEN SET diffDay = 0;
    	WHEN vweekday = 5 THEN SET diffDay = 2;
    	WHEN vweekday = 6 THEN SET diffDay = 1;
	END CASE;
	
	SET drawDate = DATE_ADD(inputdate, INTERVAL diffDay DAY);
	
	RETURN drawDate;
END