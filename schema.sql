/*
Dropping old tables
 */

DROP TABLE ports, terminals, seaships, undgs, undgs_labels, undgs_tank_special_provisions, undgs_tankcodes, undgs_descriptions, container_types;

/*
Creating new tables
 */

CREATE TABLE ports (
  pid  serial  NOT NULL,
  name varchar NOT NULL,
  unlo varchar,
  PRIMARY KEY (pid)
);

CREATE TABLE terminals (
  tid           serial  NOT NULL,
  name          varchar NOT NULL,
  terminal_code varchar NOT NULL,
  type          varchar,
  unlo          varchar,
  port_id       integer NOT NULL,
  PRIMARY KEY (tid),
  FOREIGN KEY (port_id) REFERENCES ports (pid)
);

CREATE TABLE seaships (
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
  undgs_tank_special_provisions_id integer,
  collective                       boolean,
  undgs_descriptions_id            integer NOT NULL,
  hazard_no                        varchar,
  undgs_labels_id                  integer,
  not_applicable                   boolean,
  packing_group                    integer,
  station                          varchar,
  undgs_tankcodes_id               integer,
  transport_category               varchar,
  transport_forbidden              boolean,
  tunnel_code                      varchar,
  un_no                            integer,
  vehicleTank_carriage             varchar,
  PRIMARY KEY (uid),
  FOREIGN KEY (undgs_tank_special_provisions_id) REFERENCES undgs_tank_special_provisions (utsid),
  FOREIGN KEY (undgs_descriptions_id) REFERENCES undgs_descriptions (udid),
  FOREIGN KEY (undgs_labels_id) REFERENCES undgs_labels (ulid),
  FOREIGN KEY (undgs_tankcodes_id) REFERENCES undgs_tankcodes (utid)
);

CREATE TABLE undgs_labels (
  ulid     serial  NOT NULL,
  name     varchar NOT NULL,
  undgs_id integer NOT NULL REFERENCES undgs,
  PRIMARY KEY (ulid)
);

CREATE TABLE undgs_tank_special_provisions (
  utsid    serial  NOT NULL,
  name     varchar NOT NULL,
  undgs_id integer NOT NULL REFERENCES undgs,
  PRIMARY KEY (utsid)
);

CREATE TABLE undgs_tankcodes (
  utid     serial  NOT NULL,
  name     varchar NOT NULL,
  undgs_id integer NOT NULL REFERENCES undgs,
  PRIMARY KEY (utid)
);

CREATE TABLE undgs_descriptions (
  udid           serial  NOT NULL,
  undgs_language varchar NOT NULL,
  decription     varchar NOT NULL,
  undgs_id       integer NOT NULL REFERENCES undgs,
  PRIMARY KEY (udid)
);


CREATE TABLE container_types (
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

DROP TABLE users, applications, conflicts, history;

/**
Creating new tables
 */

CREATE TABLE users (
  id                  SERIAL primary key,
  name                varchar NOT NULL,
  email               varchar,
  email_notifications boolean NOT NULL DEFAULT false,
  darkmode            boolean NOT NULL DEFAULT false,
  last_login          timestamp
);

CREATE TABLE applications (
  id      SERIAL primary key,
  name    varchar NOT NULL,
  api_key varchar NOT NULL
);

CREATE TABLE conflicts (
  id          SERIAL primary key,
  created_by  varchar   NOT NULL,
  solved_by   integer REFERENCES users (id),
  table_name  varchar   NOT NULL,
  column_name varchar   NOT NULL,
  value       varchar   NOT NULL,
  added_at    timestamp NOT NULL,
  updated_at  timestamp
);

CREATE TABLE history (
  id       SERIAL primary key,
  title    varchar   NOT NULL,
  message  text      NOT NULL,
  added_at timestamp NOT NULL
);
