ADD Functions

CREATE OR REPLACE FUNCTION addships(imo text,name text,callsign text,mmsi text,ship_depth boolean)
RETURNS text AS'
BEGIN
INSERT INTO ships(imo,name,callsign,mmsi,ship_depth)
VALUES(imo,name,callsign,mmsi,ship_depth);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addterminals(name text, terminal_code text,type text,unlo text)
RETURNS text AS'
BEGIN
INSERT INTO terminals(name,terminal_code,type,unlo)
VALUES(name,terminal_code,type,unlo);
END;
'
LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION addports(name text,unlo text)
RETURNS text AS'
BEGIN
INSERT INTO ports(name,unlo)
VALUES(name,unlo);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addundgs(classification text,classification_code text,undgs_tank_special_provisions_id integer,collective boolean,undgs_description_id integer,hazard_no text,undgs_labels_id integer,not_applicable boolean,packing_group integer,station text,undgs_tankcodes_id integer,transport_category text,transport_forbidden boolean,tunnel_code text,un_no integer,vehicleTank_carriage text)
RETURNS integer AS'
BEGIN
INSERT INTO undgs(classification,classification_code,undgs_tank_special_provisions_id,collective,undgs_description_id,hazard_no,undgs_labels_id,not_applicable,packing_group,station,undgs_tankcodes_id,transport_category,transport_forbidden,tunnel_code,un_no,vehicleTank_carriage)
VALUES(classification,classification_code,undgs_tank_special_provisions_id,collective,undgs_description_id,hazard_no,undgs_labels_id,not_applicable,packing_group,station,undgs_tankcodes_id,transport_category,transport_forbidden,tunnel_code,un_no,vehicleTank_carriage);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addundgs_labels(name text,undgs_id integer)
RETURNS integer AS'
BEGIN
INSERT INTO undgs_labels(name,undgs_id)
VALUES(name,undgs_id);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addundgs_tank_special_provisions(name text,undgs_id integer)
RETURNS integer AS'
BEGIN
INSERT INTO undgs_tank_special_provisions(name,undgs_id)
VALUES(name,undgs_id);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addundgs_tankcodes(name text)
RETURNS text AS'
BEGIN
INSERT INTO undgs_tankcodes(name)
VALUES(name);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addundgs_description(undgs_language text,description text)
RETURNS text AS'
BEGIN
INSERT INTO undgs_description(undgs_language,description)
VALUES(undgs_language,description);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addcontainer_types(display_name text,iso_code text,description text,c_length integer,c_height integer,reefer boolean)
RETURNS integer AS'
BEGIN
INSERT INTO container_types(display_name,iso_code,description,c_length,c_height,reefer)
VALUES(display_name,iso_code,description,c_length,c_height,reefer);
END;
'
LANGUAGE 'plpgsql'


CREATE OR REPLACE FUNCTION adduser(name text,email text,email_notifications boolean,darkmode boolean,last_login timestamp)
RETURNS text AS'
BEGIN
INSERT INTO users(name,email,email_notifications,darkmode,last_login)
VALUES(name,email,email_notifications,darkmode,last_login);
END;
'
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION addapplications(name text,api_key text)
RETURNS text AS'
BEGIN
INSERT INTO applications(name,api_key)
VALUES(name,api_key);
END;
'
LANGUAGE 'plpgsql'



CREATE OR REPLACE FUNCTIONS addconflicts(created_by text,table_name integer,column_name text,value text,added_at timestamp,updated_at timestamp)
RETURNS integer AS'
BEGIN
INSERT INTO conflicts(created_by,table_name,column_name,value,added_at,updated_at)
VALUES(created_by,table_name,column_name,value,added_at,updated_at);
END;
'
LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION addhistory(title text,message text,added_at timestamp)
RETURNS text AS'
BEGIN
INSERT INTO history(title,message,added_at)
VALUES(title,message,added_at);
END; 
'
LANGUAGE 'plpgsql';



























