/*
Dropping old tables
*/

DROP TABLE port, terminal, ship, undgs, undgs_label, undgs_tank_special_provision, undgs_tankcode, undgs_description, container_type;

/*
Creating new tables
 */

CREATE TABLE port (
  pid  serial  NOT NULL,
  name varchar NOT NULL,
  unlo varchar,
  PRIMARY KEY (pid)
);

CREATE TABLE terminal (
  tid           serial  NOT NULL,
  name          varchar NOT NULL,
  terminal_code varchar NOT NULL,
  type          varchar,
  unlo          varchar,
  port_id       integer NOT NULL,
  PRIMARY KEY (tid),
  FOREIGN KEY (port_id) REFERENCES port (pid)
);

CREATE TABLE ship (
  sid        serial  NOT NULL,
  imo        varchar NOT NULL,
  name       varchar NOT NULL,
  callsign   varchar,
  mmsi       character(9),
  ship_depth real,
  PRIMARY KEY (sid)
);


CREATE TABLE undgs (
  uid                              serial  NOT NULL,
  classification                   varchar NOT NULL,
  classification_code              varchar NOT NULL,
  collective                       boolean,
  hazard_no                        varchar,
  not_applicable                   boolean,
  packing_group                    integer,
  station                          varchar,
  transport_category               varchar,
  transport_forbidden              boolean,
  tunnel_code                      varchar,
  un_no                            integer,
  vehicleTank_carriage             varchar,
  PRIMARY KEY (uid)
);

CREATE TABLE undgs_label (
  ulid     serial  NOT NULL,
  name     varchar NOT NULL,
  PRIMARY KEY (ulid)
);

CREATE TABLE undgs_has_label (
  uid   integer NOT NULL,
  ulid  integer NOT NULL,
  PRIMARY KEY (uid, ulid),
  FOREIGN KEY (uid)  REFERENCES undgs,
  FOREIGN KEY (ulid) REFERENCES undgs_label
);

CREATE TABLE undgs_tank_special_provision (
  utsid    serial  NOT NULL,
  name     varchar NOT NULL,
  PRIMARY KEY (utsid)
);

CREATE TABLE undgs_has_tank_special_provision (
  uid   integer NOT NULL,
  utsid integer NOT NULL,
  PRIMARY KEY (uid, utsid),
  FOREIGN KEY (uid)   REFERENCES undgs,
  FOREIGN KEY (utsid) REFERENCES undgs_tank_special_provision
);

CREATE TABLE undgs_tankcode (
  utid     serial  NOT NULL,
  name     varchar NOT NULL,
  PRIMARY KEY (utid)
);

CREATE TABLE undgs_has_tankcode (
  uid  integer NOT NULL,
  utid integer NOT NULL,
  PRIMARY KEY (uid, utid),
  FOREIGN KEY (uid)  REFERENCES undgs,
  FOREIGN KEY (utid) REFERENCES undgs_tankcode
);

CREATE TABLE undgs_description (
  udid           serial  NOT NULL,
  undgs_language varchar NOT NULL,
  decription     varchar NOT NULL,
  undgs_id       integer NOT NULL,
  PRIMARY KEY (udid),
  FOREIGN KEY (undgs_id) REFERENCES undgs (uid)
);

CREATE TABLE container_type (
  cid          serial  NOT NULL,
  display_name varchar NOT NULL,
  iso_code     varchar,
  description  varchar,
  c_length     integer NOT NULL,
  c_height     integer NOT NULL,
  reefer       boolean,
  PRIMARY KEY (cid)
);

/*
Application specific tables
*/

/*
Dropping old tables
 */


DROP TABLE user, application, conflict, history;

/**
Creating new tables
 */

CREATE TABLE user (
  uid                 SERIAL  NOT NULL,
  name                varchar NOT NULL,
  email               varchar,
  email_notifications boolean NOT NULL DEFAULT false,
  darkmode            boolean NOT NULL DEFAULT false,
  last_login          timestamp,
  PRIMARY KEY (uid)
);

CREATE TABLE application (
  aid     SERIAL  NOT NULL,
  name    varchar NOT NULL,
  api_key varchar NOT NULL,
  PRIMARY KEY (aid)
);

CREATE TABLE conflict (
  cid         SERIAL    NOT NULL,
  created_by  integer   NOT NULL,
  solved_by   integer,
  table_name  varchar   NOT NULL,
  column_name varchar   NOT NULL,
  value       varchar   NOT NULL,
  added_at    timestamp NOT NULL DEFAULT now(),
  updated_at  timestamp,
  PRIMARY KEY (cid),
  FOREIGN KEY (solved_by) REFERENCES user (uid),
  FOREIGN KEY (created_by) REFERENCES application (aid)
);

CREATE TABLE history (
  hid      SERIAL,
  title    varchar   NOT NULL,
  message  text      NOT NULL,
  added_at timestamp NOT NULL DEFAULT now(),
  PRIMARY KEY (hid)
);