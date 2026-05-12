CREATE TABLE `app_all`
(
    `app_id` INTEGER NOT NULL,
    PRIMARY KEY (`app_id`)
);

CREATE TABLE `app_events` (
  `event_id` INTEGER NOT NULL,
  `app_id` INTEGER NOT NULL,
  `is_installed` INTEGER NOT NULL,
  `is_active` INTEGER NOT NULL,
  PRIMARY KEY (`event_id`,`app_id`),
  FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `app_events_relevant` (
  `event_id` INTEGER NOT NULL,
  `app_id` INTEGER NOT NULL,
  `is_installed` INTEGER DEFAULT NULL,
  `is_active` INTEGER DEFAULT NULL,
  PRIMARY KEY (`event_id`,`app_id`),
  FOREIGN KEY (`event_id`) REFERENCES `events_relevant` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`app_id`) REFERENCES `app_all` (`app_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `app_labels` (
  `app_id` INTEGER NOT NULL,
  `label_id` INTEGER NOT NULL,
  FOREIGN KEY (`label_id`) REFERENCES `label_categories` (`label_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`app_id`) REFERENCES `app_all` (`app_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `events` (
  `event_id` INTEGER NOT NULL,
  `device_id` INTEGER DEFAULT NULL,
  `timestamp` DATETIME DEFAULT NULL,
  `longitude` REAL DEFAULT NULL,
  `latitude` REAL DEFAULT NULL,
  PRIMARY KEY (`event_id`)
);

CREATE TABLE `events_relevant` (
  `event_id` INTEGER NOT NULL,
  `device_id` INTEGER DEFAULT NULL,
  `timestamp` DATETIME NOT NULL,
  `longitude` REAL NOT NULL,
  `latitude` REAL NOT NULL,
  PRIMARY KEY (`event_id`),
  FOREIGN KEY (`device_id`) REFERENCES `gender_age` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `gender_age` (
  `device_id` INTEGER NOT NULL,
  `gender` TEXT DEFAULT NULL,
  `age` INTEGER DEFAULT NULL,
  `group` TEXT DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  FOREIGN KEY (`device_id`) REFERENCES `phone_brand_device_model2` (`device_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `gender_age_test` (
  `device_id` INTEGER NOT NULL,
  PRIMARY KEY (`device_id`)
);

CREATE TABLE `gender_age_train` (
  `device_id` INTEGER NOT NULL,
  `gender` TEXT DEFAULT NULL,
  `age` INTEGER DEFAULT NULL,
  `group` TEXT DEFAULT NULL,
  PRIMARY KEY (`device_id`)
);

CREATE TABLE `label_categories` (
  `label_id` INTEGER NOT NULL,
  `category` TEXT DEFAULT NULL,
  PRIMARY KEY (`label_id`)
);

CREATE TABLE `phone_brand_device_model2` (
  `device_id` INTEGER NOT NULL,
  `phone_brand` TEXT NOT NULL,
  `device_model` TEXT NOT NULL,
  PRIMARY KEY (`device_id`,`phone_brand`,`device_model`)
);

CREATE TABLE `sample_submission` (
  `device_id` INTEGER NOT NULL,
  `F23-` REAL DEFAULT NULL,
  `F24-26` REAL DEFAULT NULL,
  `F27-28` REAL DEFAULT NULL,
  `F29-32` REAL DEFAULT NULL,
  `F33-42` REAL DEFAULT NULL,
  `F43+` REAL DEFAULT NULL,
  `M22-` REAL DEFAULT NULL,
  `M23-26` REAL DEFAULT NULL,
  `M27-28` REAL DEFAULT NULL,
  `M29-31` REAL DEFAULT NULL,
  `M32-38` REAL DEFAULT NULL,
  `M39+` REAL DEFAULT NULL,
  PRIMARY KEY (`device_id`)
);