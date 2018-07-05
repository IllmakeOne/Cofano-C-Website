create table ship
(
  sid        serial  not null,
  imo        varchar not null,
  name       varchar not null,
  callsign   varchar,
  mmsi       char(9),
  ship_depth numeric(5, 2),
  approved   boolean default true,
  constraint ships_pkey
  primary key (sid)
);

create table "user"
(
  uid                 serial                not null,
  name                varchar               not null,
  email               varchar,
  email_notifications boolean default false not null,
  darkmode            boolean default false not null,
  last_login          timestamp with time zone,
  constraint users_pkey
  primary key (uid)
);

create table application
(
  aid     serial  not null,
  name    varchar not null,
  api_key varchar not null,
  constraint applications_pkey
  primary key (aid)
);

create table history
(
  hid      serial                                 not null,
  title    varchar                                not null,
  message  text                                   not null,
  added_at timestamp with time zone default now() not null,
  type     text,
  approved boolean default false,
  constraint history_pkey
  primary key (hid)
);

create table undgs
(
  uid                  serial  not null,
  classification       varchar not null,
  classification_code  varchar not null,
  collective           boolean,
  hazard_no            varchar,
  not_applicable       boolean,
  packing_group        integer,
  station              varchar,
  transport_category   varchar,
  transport_forbidden  boolean,
  tunnel_code          varchar,
  un_no                integer,
  vehicletank_carriage varchar,
  approved             boolean default true,
  constraint undgs_pkey
  primary key (uid)
);

create table undgs_labels
(
  ulid serial  not null,
  name varchar not null,
  constraint undgs_labels_pkey
  primary key (ulid)
);

create unique index undgs_labels_name_idx
  on undgs_labels (name);

create table undgs_has_label
(
  uid  integer not null,
  ulid integer not null,
  constraint undgs_has_label_pkey
  primary key (uid, ulid),
  constraint undgs_has_label_uid_fkey
  foreign key (uid) references undgs,
  constraint undgs_has_label_ulid_fkey
  foreign key (ulid) references undgs_labels
);

create table undgs_tank_special_provisions
(
  utsid serial  not null,
  name  varchar not null,
  constraint undgs_tank_special_provisions_pkey
  primary key (utsid)
);

create table undgs_has_tank_special_provision
(
  uid   integer not null,
  utsid integer not null,
  constraint undgs_has_tank_special_provision_pkey
  primary key (uid, utsid),
  constraint undgs_has_tank_special_provision_uid_fkey
  foreign key (uid) references undgs,
  constraint undgs_has_tank_special_provision_utsid_fkey
  foreign key (utsid) references undgs_tank_special_provisions
);

create table undgs_tankcodes
(
  utid serial  not null,
  name varchar not null,
  constraint undgs_tankcodes_pkey
  primary key (utid)
);

create table undgs_has_tankcode
(
  uid  integer not null,
  utid integer not null,
  constraint undgs_has_tankcode_pkey
  primary key (uid, utid),
  constraint undgs_has_tankcode_uid_fkey
  foreign key (uid) references undgs,
  constraint undgs_has_tankcode_utid_fkey
  foreign key (utid) references undgs_tankcodes
);

create table port
(
  pid      serial  not null,
  name     varchar not null,
  unlo     varchar,
  approved boolean default true,
  constraint ports_pkey
  primary key (pid)
);

create table terminal
(
  tid           serial  not null,
  name          varchar not null,
  terminal_code varchar not null,
  type          varchar,
  unlo          varchar,
  port_id       integer not null,
  approved      boolean default true,
  constraint terminals_pkey
  primary key (tid),
  constraint terminals_port_id_fkey
  foreign key (port_id) references port
);

create table undgs_descriptions
(
  udid        serial  not null,
  language    varchar,
  description varchar not null,
  undgs_id    integer not null,
  constraint undgs_descriptions_pkey
  primary key (udid),
  constraint undgs_descriptions_undgs_id_fkey
  foreign key (undgs_id) references undgs
);

create table conflict
(
  cid        serial    not null,
  culprit    varchar   not null,
  solver     integer,
  "table"    varchar   not null,
  "with"     integer   not null,
  add_date   timestamp not null,
  solve_date timestamp,
  entry      integer   not null,
  constraint table_name_pkey
  primary key (cid)
);

create unique index table_name_cid_uindex
  on conflict (cid);

create table container_type
(
  cid          serial  not null,
  display_name varchar not null,
  iso_code     varchar,
  description  varchar,
  c_length     integer not null,
  c_height     integer not null,
  reefer       boolean,
  approved     boolean default true,
  constraint container_type_pkey
  primary key (cid)
);

create function addapplications(name text, api_key text)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO application (name, api_key)
  VALUES (name, api_key);
END;
$$;

create function allapplications()
  returns TABLE(aid integer, name character varying, api_key character varying)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  SELECT *
  FROM application;
END;
$$;

create function deleteships(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM ship
  WHERE sid = dsid;
END;
$$;

create function addhistory(title text, message text, add timestamp without time zone)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO history (title, message, added_at)
  VALUES (title, message, add);
END;
$$;

create function updatelastlogin(usr text, last timestamp without time zone)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE "user"
  SET last_login = last
  WHERE email = usr;
END;
$$;

create function addhistory(title text, message text, add timestamp without time zone, type text)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO history (title, message, added_at, type)
  VALUES (title, message, add, type);
END;
$$;

create function deleteapplications(daid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM application
  WHERE aid = daid;
END;
$$;

create function deletecontainer_types(dcid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM container_type
  WHERE cid = dcid;
END;
$$;

create function deletehistory(dhid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM history
  WHERE hid = dhid;
END;
$$;

create function deleteundgs(duid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM undgs
  WHERE uid = duid;
END;
$$;

create function appsconflict(nme text, apikey text)
  returns TABLE(aid integer, name character varying, api_key character varying)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select a.*
  from application a
  where a.name = nme and a.name notnull
        OR a.api_key = apikey;
END;
$$;

create function specificapp(id integer)
  returns TABLE(name character varying, api_key character varying)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select a.*
  from application a
  where a.aid = id;
END;
$$;

create function editundgs(duid                               integer, newclassification text,
                          newclassification_code             text, newundgs_tank_special_provision_id integer,
                          newcollective                      boolean, newundgs_description_id integer,
                          newhazard_no                       text, newundgs_labels_id integer,
                          newnot_applicable                  boolean, newpacking_group integer, newstation text,
                          newundgs_taankcodes_id             integer, newtransport_category text,
                          newtransport_forbidden             boolean, newtunnel_code text, newun_no integer,
                          newvehicletank_carriage            text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE undgs
  SET classification                = newclassification, classification_code = newclassification_code,
    undgs_tank_special_provision_id = newundgs_tank_special_provision_id, collective = newcollective,
    undgs_description_id            = newundgs_description_id, hazard_no = newhazard_no,
    undgs_labels_id                 = newundgs_labels_id, not_applicable = newnot_applicable,
    packing_group                   = newpacking_group, station = newstation,
    undgs_tankcodes_id              = newundgs_taankcodes_id, transport_category = newtransport_category,
    transport_forbidden             = newtransport_forbidden, tunnel_code = newtunnel_code, un_no = newun_no,
    vehicleTank_carriage            = newvehicleTank_carriage
  WHERE uid = duid;
END;
$$;

create function editapplications(daid integer, newname text, newapi_key text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE application
  SET name = newname, api_key = newapi_key
  WHERE aid = daid;
END;
$$;

create function editundgs_description(dudid integer, newundgs_language text, newdescription text, newundgs_id integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE undgs_descriptions
  SET undgs_language = newundgs_language, description = newdescription, undgs_id = newundgs_id
  WHERE udid = dudid;
END;
$$;

create function editundgs_tankcodes(dutid integer, newname text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE undgs_tankcodes
  SET name = newname
  WHERE utid = dutid;
END;
$$;

create function editundgs_tank_special_provisions(dutsid integer, newname text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE undgs_tank_special_provision
  SET name = newname
  WHERE utsid = dutsid;
END;
$$;

create function editundgs_labels(dulid integer, newname text, newundgs_id integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE undgs_labels
  SET name = newname, undgs_id = newundgs_id
  WHERE ulid = dulid;
END;
$$;

create function editconflicts(dcid           integer, newcreated_by integer, newsolved_by integer, newtable_name text,
                              newcolumn_name text, newvalue text, newadded_at timestamp without time zone,
                              newupdated_at  timestamp without time zone)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE conflict
  SET created_by = newcreated_by, solved_by = newsolved_by, table_name = newtable_name, column_name = newcolumn_name,
    value        = newvalue, added_at = newadded_at, updated_at = newupdated_at
  WHERE cid = dcid;
END;
$$;

create function addhistory(title text, message text, type text)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO history (title, message, added_at, type)
  VALUES (title, message, localtimestamp, type);
END;
$$;

create function updatelastlogin(usr text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE "user"
  SET last_login = localtimestamp
  WHERE email = usr;
END;
$$;

create function testrequest(requester text)
  returns TABLE(id integer, name character varying)
language plpgsql
as $$
BEGIN
  return query
  select
    application.aid,
    application.name
  from application
  where api_key = requester;
END;
$$;

create function addhistory(title text, message text, type text, appr boolean)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO history (title, message, added_at, type, approved)
  VALUES (title, message, localtimestamp, type, appr);
END;
$$;

create function addconflict(cuprit text, tabl text, entr integer, wit integer)
  returns void
language plpgsql
as $$
BEGIN
  INSERT INTO conflict (culprit, "table", entry, "with", add_date)
  VALUES (cuprit, tabl, entr, wit, localtimestamp);
END;
$$;

create function getexactport(nae text, unl text)
  returns integer
language plpgsql
as $$
BEGIN
  RETURN (
    select p.pid
    from port p
    where p.name = nae AND p.unlo = unl);
END;
$$;

create function addport(name text, unlo text, app boolean)
  returns integer
language plpgsql
as $$
declare result int;
BEGIN
  INSERT INTO port (name, unlo, approved)
  VALUES (name, unlo, app)
  returning pid
    INTO result;

  return result;
END;
$$;

create function addships(imo text, name text, callsign text, mmsi text, ship_depth numeric, app boolean)
  returns integer
language plpgsql
as $$
declare result int;
BEGIN
  INSERT INTO ship (imo, name, callsign, mmsi, ship_depth, approved)
  VALUES (imo, name, callsign, mmsi, ship_depth, app)
  returning sid
    INTO result;

  return result;
END;
$$;

create function portconflict(anme text, olnu text)
  returns TABLE(pid integer, name character varying, unlo character varying)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select
    p.pid,
    p.name,
    p.unlo
  from port p
  where p.approved = true and (p.name = anme and p.name notnull or p.unlo = olnu and p.unlo notnull);
END;
$$;

create function addcontainer_type(diplay text, iso text, des text, lenght integer, height integer, reefer boolean,
                                  app    boolean)
  returns integer
language plpgsql
as $$
declare result int;
BEGIN
  INSERT INTO container_type (display_name, iso_code, description, c_length, c_height, reefer, approved)
  VALUES (diplay, iso, des, lenght, height, reefer, app)

  returning cid
    INTO result;

  return result;
END;
$$;

create function addterminal(name text, terminal_code text, type text, unlo text, port_id integer, app boolean)
  returns integer
language plpgsql
as $$
declare result int;
BEGIN
  INSERT INTO terminal (name, terminal_code, type, unlo, port_id, approved)
  VALUES (name, terminal_code, type, unlo, port_id, app)

  returning tid
    INTO result;

  return result;
END;
$$;

create function containerconflict(displa text, iso text)
  returns TABLE(cid integer, display_name character varying, iso_code character varying, description character varying, c_length integer, c_height integer, reefer boolean, approved boolean)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select c.*
  from container_type c
  where c.approved = true and (c.display_name = displa AND c.display_name notnull OR c.iso_code = iso and iso notnull);
END;
$$;

create function editterminals(dtid integer, newname text, newterminal_code text, newtype text, newunlo text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE terminal
  SET name = newname, terminal_code = newterminal_code, type = newtype, unlo = newunlo, approved = false
  WHERE tid = dtid;
END;
$$;

create function deleteterminal(daid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM terminal
  WHERE tid = daid;
END;
$$;

create function editcontainer_types(dcid        integer, newdisplay_name text, newiso_code text, newdescription text,
                                    newc_height integer, newlen integer, newreefer boolean)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE container_type
  SET display_name = newdisplay_name, iso_code = newiso_code, description = newdescription, c_height = newc_height,
    c_length       = newlen, reefer = newreefer, approved = false
  WHERE cid = dcid;
END;
$$;

create function editships(dsid          integer, newimo text, newname text, newcallsign text, newmmsi text,
                          newship_depth numeric)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE ship
  SET imo = newimo, name = newname, callsign = newcallsign, mmsi = newmmsi, ship_depth = newship_depth, approved = false
  WHERE sid = dsid;
END;
$$;

create function approveship(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE ship
  SET approved = true
  WHERE sid = dsid;
END;
$$;

create function approveport(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE port
  SET approved = true
  WHERE pid = dsid;
END;
$$;

create function approveterminal(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE terminal
  SET approved = true
  WHERE tid = dsid;
END;
$$;

create function approvecontainer(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE container_type
  SET approved = true
  WHERE cid = dsid;
END;
$$;

create function resolveconflict(dsid integer, sol integer)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE conflict
  SET solver = sol, solve_date = localtimestamp
  WHERE cid = dsid;
END;
$$;

create function deleteport(dsid integer)
  returns void
language plpgsql
as $$
BEGIN
  DELETE FROM terminal
  WHERE port_id = dsid;
  DELETE FROM port
  WHERE pid = dsid;
END;
$$;

create function shipconflict(im text, callsig text, mms text)
  returns TABLE(sid integer, imo character varying, name character varying, callsign character varying, mmsi character, ship_depth numeric, appr boolean)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select s.*
  from ship s
  where s.imo = im and s.imo notnull
        OR s.callsign = callsig and s.callsign notnull
        OR s.mmsi = mms and s.mmsi notnull;
END;
$$;

create function terminalconflict(anme text, tcode text)
  returns TABLE(tid integer, name character varying, terminal_code character varying, type character varying, unlo character varying, port_id integer, appp boolean)
language plpgsql
as $$
BEGIN
  RETURN QUERY
  select t.*
  from terminal t
  where t.approved = true and (t.name = anme and t.name notnull
                               OR t.terminal_code = tcode and t.terminal_code notnull);
END;
$$;

create function editports(dpid integer, newname text, newunlo text)
  returns void
language plpgsql
as $$
BEGIN
  UPDATE port
  SET name = newname, unlo = newunlo, approved = false
  WHERE pid = dpid;
END;
$$;


