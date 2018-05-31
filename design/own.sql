/*
Our stuff
*/

CREATE TABLE users(
 id SERIAL primary key,
 name varchar NOT NULL,
 email varchar,
 email_notifications boolean NOT NULL DEFAULT false,
 darkmode boolean NOT NULL DEFAULT false
 last_login timestamp
);

CREATE TABLE applications(
  id SERIAL primary key,
  name varchar NOT NULL,
  api_key varchar NOT NULL
);

CREATE TABLE conflicts(
  id SERIAL primary key,
  created_by varchar NOT NULL,
  solved_by integer REFERENCES users(id),
  table_name varchar NOT NULL,
  column_name varchar NOT NULL,
  value varchar NOT NULL,
  added_at timestamp NOT NULL,
  updated_at timestamp
);

CREATE TABLE history(
  id SERIAL primary key,
  title varchar NOT NULL,
  message text NOT NULL,
  added_at timestamp NOT NULL,
);
