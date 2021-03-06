CREATE DATABASE `Guestbook`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE `Guestbook`;

CREATE TABLE IF NOT EXISTS `Users` (
  id SERIAL,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL, -- http://php.net/manual/de/function.password-hash.php
  mail VARCHAR(80),
  role VARCHAR(30) DEFAULT 'user',
  active TINYINT(1)  DEFAULT 1,
  deleted TINYINT(1) DEFAULT 0,

  PRIMARY KEY (id)
) ENGINE INNODB CHECKSUM 1;

CREATE TABLE IF NOT EXISTS `Posts` (
  id SERIAL,
  title VARCHAR(150),
  content TEXT,
  `date` TIMESTAMP DEFAULT  CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` BIGINT UNSIGNED,
  reply_to BIGINT UNSIGNED,
  active TINYINT(1)  DEFAULT 1,
  deleted TINYINT(1) DEFAULT 0,

  PRIMARY KEY (id),
  FOREIGN KEY (`user`) REFERENCES `Users`(id) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (reply_to) REFERENCES Posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FULLTEXT index (content)
) ENGINE INNODB CHECKSUM 1;