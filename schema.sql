CREATE TABLE ports(
 id integer NOT NULL AUTO_INCREMENT,
 name varchar NOT NULL,
 unlo varchar,
 PRIMARY KEY(id)
);

CREATE TABLE terminals(
 id integer NOT NULL AUTO_INCREMENT,
 name varchar NOT NULL,
 terminal_code varchar NOT NULL,
 type varchar,
 unlo varchar,
 PRIMARY KEY(id)
);

CREATE TABLE seaships(
 id integer NOT NULL AUTO_INCREMENT,
 imo varchar NOT NULL,
 name varchar NOT NULL,
 callsign varchar,
 mmsi character(9),
 ship_depth real,
 PRIMARY KEY(id)
);


CREATE TABLE undgs(
 id integer NOT NULL AUTO_INCREMENT,
 classification varchar NOT NULL,
 classification_code varchar NOT NULL,
 undgs_tank_special_provisions_id integer REFERENCES undgs_tank_special_provisions.id,
 collective boolean,
 undgs_descriptions_id integer NOT NULL REFERENCES undgs_descriptions.id, 
 hazard_no varchar,
 undgs_labels_id integer REFERENCES undgs_labels.id,
 not_applicable boolean, 
 packing_group integer, 
 station varchar,
 undgs_tankcodes_id integer REFERENCES undgs_tankcodes.id
 transport_category varchar,
 transport_forbidden boolean,
 tunnel_code varchar,
 un_no integer,
 vehicleTank_carriage varchar,
 PRIMARY KEY(id)
);

CREATE TABLE undgs_labels(
 name varchar NOT NULL,
 id integer NOT NULL auto_increment,
 undgs_id integer NOT NULL REFERENCES undgs,
 PRIMARY KEY (id)
);

CREATE TABLE undgs_tank_special_provisions(
 name varchar NOT NULL,
 id integer NOT NULL auto_increment,
 undgs_id integer NOT NULL REFERENCES undgs,
 PRIMARY KEY (id)
);

CREATE TABLE undgs_tankcodes(
 name varchar NOT NULL,
 id integer NOT NULL auto_increment,
 undgs_id integer NOT NULL REFERENCES undgs,
 PRIMARY KEY (id)
);

CREATE TABLE undgs_descriptions(
 undgs_language varchar NOT NULL,
 decription varchar NOT NULL,
 id integer auto_increment NOT NULL,
 undgs_id integer NOT NULL REFERENCES undgs,
 PRIMARY KEY (id)
);


CREATE TABLE container_types(
 id integer NOT NULL AUTO_INCREMENT,
 display_name varchar NOT NULL,
 iso_code varchar,
 description varchar,
 c_length integer NOT NULL,
 c_height integer NOT NULL,
 reefer boolean,
 PRIMARY KEY(id)
);



/*
Our stuff
*/

CREATE TABLE users(
 id integer NOT NULL auto_increment,
 name varchar NOT NULL,
 email varchar,
 email_notifications boolean,
 last_login timestamp
);
