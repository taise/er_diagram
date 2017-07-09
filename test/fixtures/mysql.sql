CREATE TABLE schema_migrations (
  version varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY unique_schema_migrations (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  email varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  created_at datetime DEFAULT NULL,
  updated_at datetime DEFAULT NULL,
  password_digest varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY index_users_on_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE roles (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  name varchar(255) DEFAULT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE user_roles (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  user_id int(11) DEFAULT NULL,
  role_id int(11) DEFAULT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
