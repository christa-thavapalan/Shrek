-- Table event_status
CREATE TABLE event_status
(
   event_status_id   NUMBER (22,0) NOT NULL,
   status_name       VARCHAR2 (50) NOT NULL,
   created_by        NUMBER (22,0) NOT NULL,
   created_date      DATE NOT NULL,
   updated_by        NUMBER (22,0),
   updated_date      DATE
);

CREATE TABLE audit_event_status
(
   event_status_id   NUMBER (22,0),
   status_name       VARCHAR2 (50),
   created_by        NUMBER (22,0),
   created_date      DATE,
   updated_by        NUMBER (22,0),
   updated_date      DATE,
   deleted_by        NUMBER(22,0),
   deleted_date      DATE
);
-- Add keys for table event_status

ALTER TABLE event_status ADD CONSTRAINT event_status_pk PRIMARY KEY(event_status_id);
ALTER TABLE event_status ADD CONSTRAINT event_status_uk1 UNIQUE(event_status_id);

-- Table event

CREATE TABLE event
(
   event_id       NUMBER (22,0) NOT NULL,
   title          VARCHAR2 (50) NOT NULL,
   description    VARCHAR2 (4000),
   date_time      TIMESTAMP (6),
   min_cap        NUMBER (2,0),
   max_cap        NUMBER (2,0),
   organiser_id   NUMBER (22,0) NOT NULL,
   status_id      NUMBER (22,0) NOT NULL,
   url            VARCHAR2 (4000),
   doodle         VARCHAR2 (4000),
   image          BLOB,
   created_by     NUMBER (22,0) NOT NULL,
   created_date   DATE NOT NULL,
   updated_by     NUMBER (22,0),
   updated_date   DATE
);

CREATE TABLE audit_event
(
   event_id       NUMBER (22,0),
   title          VARCHAR2 (50),
   description    VARCHAR2 (4000),
   date_time      TIMESTAMP (6),
   min_cap        NUMBER (2,0),
   max_cap        NUMBER (2,0),
   organiser_id   NUMBER (22,0),
   status_id      NUMBER (22,0),
   url            VARCHAR2 (4000),
   doodle         VARCHAR2 (4000),
   image          BLOB,
   created_by     NUMBER (22,0),
   created_date   DATE,
   updated_by     NUMBER (22,0),
   updated_date   DATE,
   deleted_by     NUMBER(22,0),
   deleted_date   DATE
);
-- Add keys for table event

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY (event_id);
ALTER TABLE event ADD CONSTRAINT event_uk1 UNIQUE (event_id);
-- Table event_user

CREATE TABLE event_user
(
   event_user_id   NUMBER (22,0) NOT NULL,
   event_id        NUMBER (22,0) NOT NULL,
   user_id         NUMBER (22,0) NOT NULL,
   status_id       NUMBER (22,0) NOT NULL,
   organiser_id    NUMBER (22,0) NOT NULL,
   created_by      NUMBER (22,0) NOT NULL,
   created_date    DATE NOT NULL,
   updated_by      NUMBER (22,0),
   updated_date    DATE
  
);

CREATE TABLE audit_event_user
(
   event_user_id   NUMBER (22,0),
   event_id        NUMBER (22,0),
   user_id         NUMBER (22,0),
   status_id       NUMBER (22,0),
   organiser_id    NUMBER (22,0),
   created_by      NUMBER (22,0),
   created_date    DATE,
   updated_by      NUMBER (22,0),
   updated_date    DATE,
   deleted_by      NUMBER(22,0),
   deleted_date    DATE
);
-- Add keys for table event_user

ALTER TABLE event_user ADD CONSTRAINT event_user_pk PRIMARY KEY (event_user_id);
ALTER TABLE event_user ADD CONSTRAINT event_user_uk1 UNIQUE (event_user_id);

-- Table app_user

CREATE TABLE app_user
(
   app_user_id    NUMBER (22,0) NOT NULL,
   username       VARCHAR2 (50) NOT NULL,
   first_name     VARCHAR2 (50) NOT NULL,
   last_name      VARCHAR2 (50) NOT NULL,
   email          VARCHAR2 (50) NOT NULL,
   password       VARCHAR2 (50) NOT NULL,
   created_by     NUMBER (22,0) NOT NULL,
   created_date   DATE NOT NULL,
   updated_by     NUMBER (22, 0),
   updated_date   DATE
);

CREATE TABLE audit_app_user
(
   app_user_id    NUMBER (22,0),
   username       VARCHAR2 (50),
   first_name     VARCHAR2 (50),
   last_name      VARCHAR2 (50),
   email          VARCHAR2 (50),
   password       VARCHAR2 (50),
   created_by     NUMBER (22,0),
   created_date   DATE,
   updated_by     NUMBER (22,0),
   updated_date   DATE,
   deleted_by     NUMBER(22,0),
   deleted_date   DATE
);
-- Add keys for table app_user

ALTER TABLE app_user ADD CONSTRAINT app_user_pk PRIMARY KEY (app_user_id);
ALTER TABLE app_user ADD CONSTRAINT email_uk1 UNIQUE (email);
ALTER TABLE app_user ADD CONSTRAINT app_user_uk2 UNIQUE (app_user_id);