CREATE SCHEMA users;

CREATE TABLE users.users (
  id            BIGSERIAL       NOT NULL,
  created_at    TIMESTAMPTZ     NOT NULL,
  updated_at    TIMESTAMPTZ     NOT NULL,
  deleted_at    TIMESTAMPTZ                 DEFAULT NULL,
  username      VARCHAR(50)                 DEFAULT NULL,
  email         VARCHAR(255)    NOT NULL,
  password      VARCHAR(100)    NOT NULL,
  firstname     VARCHAR(255)    NOT NULL,
  lastname      VARCHAR(255)    NOT NULL,

  PRIMARY KEY (id),
  UNIQUE (username),
  UNIQUE (email)
);

CREATE INDEX users_users_username_index ON users.users USING BTREE (username);
CREATE INDEX users_users_email_index ON users.users USING BTREE (email);

CREATE TABLE users.addresses (
  id            BIGSERIAL       NOT NULL,
  created_at    TIMESTAMPTZ     NOT NULL,
  updated_at    TIMESTAMPTZ     NOT NULL,
  deleted_at    TIMESTAMPTZ                 DEFAULT NULL,
  user_id       BIGINT          NOT NULL,
  name          VARCHAR(300)    NOT NULL,
  line1         VARCHAR(255)    NOT NULL,
  line2         VARCHAR(255)                DEFAULT NULL,
  line3         VARCHAR(255)                DEFAULT NULL,
  city          VARCHAR(100)    NOT NULL,
  postalcode    VARCHAR(10)     NOT NULL,
  country       VARCHAR(100)    NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users.users (id)
);
