CREATE TABLE ports(
 name varchar NOT NULL,
 unlo varchar,
 p_key integer,
 PRIMARY KEY(p_key)
);

CREATE TABLE terminals(
 name varchar NOT NULL,
 terminal_code pk,
 type varchar NOT NULL,
 unlo varchar NOT NULL,
 PRIMARY KEY(terminal_code)
);

CREATE TABLE seaships(
 imo varchar,
 name varchar NOT NULL,
 callsign varchar,
 mmsi varchar ,
 depth integer,
 s_id integer,
 PRIMARY KEY(s_id)
);


CREATE TABLE undgs(
 hazard_no varchar,
 classification_code varchar,
 station varchar,
 transport_forbidden boolean,
 transport_category varchar,
 collective boolean,
 un_no integer,
 classification varchar,
 packing_group integer ,
 not_applicable boolean,
 vehicleTank_carriage varchar,
 tunnel_code varchar,
 collective boolean,
 undgs_id integer,
 PRIMARY KEY(undgs_id)
);

CREATE TABLE undgs_labels(

)

CREATE TABLE undgs_tank_special_provisions(
name varchar
)

CREATE TABLE undgs_tankcodes(

);

CREATE TABLE undgs_descriptions(
language varchar,

);


CREATE TABLE contianer_types(
 display_name varchar,
 iso_code varchar,
 description varchar,
 length integer,
 height integer,
 reefer boolean,
 c_type integer,
 PRIMARY KEY(c_type)
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
