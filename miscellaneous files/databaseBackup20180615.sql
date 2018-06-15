--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.15
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE docker;
--
-- Name: docker; Type: DATABASE; Schema: -; Owner: docker
--

CREATE DATABASE docker WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE docker OWNER TO docker;

\connect docker

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: cofano; Type: SCHEMA; Schema: -; Owner: docker
--

CREATE SCHEMA cofano;


ALTER SCHEMA cofano OWNER TO docker;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: addapplications(text, text); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.addapplications(name text, api_key text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO application (name, api_key)
VALUES (name, api_key);
END;
$$;


ALTER FUNCTION public.addapplications(name text, api_key text) OWNER TO docker;

--
-- Name: addcontainer_types(text, text, text, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.addcontainer_types(display_name text, iso_code text, description text, c_length integer, c_height integer, reefer boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO container_type(display_name,iso_code,description,c_length,c_height,reefer)
VALUES(display_name,iso_code,description,c_length,c_height,reefer);
END;
$$;


ALTER FUNCTION public.addcontainer_types(display_name text, iso_code text, description text, c_length integer, c_height integer, reefer boolean) OWNER TO docker;

--
-- Name: allapplications(); Type: FUNCTION; Schema: public; Owner: docker
--

CREATE FUNCTION public.allapplications() RETURNS TABLE(aid integer, name character varying, api_key character varying)
    LANGUAGE plpgsql
    AS $$
 BEGIN
     RETURN QUERY
     SELECT *
     FROM application;
 END;
 $$;


ALTER FUNCTION public.allapplications() OWNER TO docker;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: application; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.application (
    aid integer NOT NULL,
    name character varying NOT NULL,
    api_key character varying NOT NULL
);


ALTER TABLE public.application OWNER TO docker;

--
-- Name: applications_aid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.applications_aid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applications_aid_seq OWNER TO docker;

--
-- Name: applications_aid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.applications_aid_seq OWNED BY public.application.aid;


--
-- Name: conflict; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.conflict (
    cid integer NOT NULL,
    created_by integer NOT NULL,
    solved_by integer,
    table_name character varying NOT NULL,
    column_name character varying NOT NULL,
    value character varying NOT NULL,
    added_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.conflict OWNER TO docker;

--
-- Name: conflicts_cid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.conflicts_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conflicts_cid_seq OWNER TO docker;

--
-- Name: conflicts_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.conflicts_cid_seq OWNED BY public.conflict.cid;


--
-- Name: container_type; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.container_type (
    cid integer NOT NULL,
    display_name character varying NOT NULL,
    iso_code character varying,
    description character varying,
    c_length integer NOT NULL,
    c_height integer NOT NULL,
    reefer boolean
);


ALTER TABLE public.container_type OWNER TO docker;

--
-- Name: container_types_cid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.container_types_cid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.container_types_cid_seq OWNER TO docker;

--
-- Name: container_types_cid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.container_types_cid_seq OWNED BY public.container_type.cid;


--
-- Name: history; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.history (
    hid integer NOT NULL,
    title character varying NOT NULL,
    message text NOT NULL,
    added_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.history OWNER TO docker;

--
-- Name: history_hid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.history_hid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.history_hid_seq OWNER TO docker;

--
-- Name: history_hid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.history_hid_seq OWNED BY public.history.hid;


--
-- Name: port; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.port (
    pid integer NOT NULL,
    name character varying NOT NULL,
    unlo character varying
);


ALTER TABLE public.port OWNER TO docker;

--
-- Name: ports_pid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.ports_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ports_pid_seq OWNER TO docker;

--
-- Name: ports_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.ports_pid_seq OWNED BY public.port.pid;


--
-- Name: ship; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.ship (
    sid integer NOT NULL,
    imo character varying NOT NULL,
    name character varying NOT NULL,
    callsign character varying,
    mmsi character(9),
    ship_depth numeric(5,2)
);


ALTER TABLE public.ship OWNER TO docker;

--
-- Name: ships_sid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.ships_sid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ships_sid_seq OWNER TO docker;

--
-- Name: ships_sid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.ships_sid_seq OWNED BY public.ship.sid;


--
-- Name: terminal; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.terminal (
    tid integer NOT NULL,
    name character varying NOT NULL,
    terminal_code character varying NOT NULL,
    type character varying,
    unlo character varying,
    port_id integer NOT NULL
);


ALTER TABLE public.terminal OWNER TO docker;

--
-- Name: terminals_tid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.terminals_tid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.terminals_tid_seq OWNER TO docker;

--
-- Name: terminals_tid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.terminals_tid_seq OWNED BY public.terminal.tid;


--
-- Name: undgs; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs (
    uid integer NOT NULL,
    classification character varying NOT NULL,
    classification_code character varying NOT NULL,
    collective boolean,
    hazard_no character varying,
    not_applicable boolean,
    packing_group integer,
    station character varying,
    transport_category character varying,
    transport_forbidden boolean,
    tunnel_code character varying,
    un_no integer,
    vehicletank_carriage character varying
);


ALTER TABLE public.undgs OWNER TO docker;

--
-- Name: undgs_descriptions; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_descriptions (
    udid integer NOT NULL,
    undgs_language character varying NOT NULL,
    decription character varying NOT NULL,
    undgs_id integer NOT NULL
);


ALTER TABLE public.undgs_descriptions OWNER TO docker;

--
-- Name: undgs_descriptions_udid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.undgs_descriptions_udid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.undgs_descriptions_udid_seq OWNER TO docker;

--
-- Name: undgs_descriptions_udid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.undgs_descriptions_udid_seq OWNED BY public.undgs_descriptions.udid;


--
-- Name: undgs_has_label; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_has_label (
    uid integer NOT NULL,
    ulid integer NOT NULL
);


ALTER TABLE public.undgs_has_label OWNER TO docker;

--
-- Name: undgs_has_tank_special_provision; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_has_tank_special_provision (
    uid integer NOT NULL,
    utsid integer NOT NULL
);


ALTER TABLE public.undgs_has_tank_special_provision OWNER TO docker;

--
-- Name: undgs_has_tankcode; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_has_tankcode (
    uid integer NOT NULL,
    utid integer NOT NULL
);


ALTER TABLE public.undgs_has_tankcode OWNER TO docker;

--
-- Name: undgs_labels; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_labels (
    ulid integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.undgs_labels OWNER TO docker;

--
-- Name: undgs_labels_ulid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.undgs_labels_ulid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.undgs_labels_ulid_seq OWNER TO docker;

--
-- Name: undgs_labels_ulid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.undgs_labels_ulid_seq OWNED BY public.undgs_labels.ulid;


--
-- Name: undgs_tank_special_provisions; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_tank_special_provisions (
    utsid integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.undgs_tank_special_provisions OWNER TO docker;

--
-- Name: undgs_tank_special_provisions_utsid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.undgs_tank_special_provisions_utsid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.undgs_tank_special_provisions_utsid_seq OWNER TO docker;

--
-- Name: undgs_tank_special_provisions_utsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.undgs_tank_special_provisions_utsid_seq OWNED BY public.undgs_tank_special_provisions.utsid;


--
-- Name: undgs_tankcodes; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public.undgs_tankcodes (
    utid integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.undgs_tankcodes OWNER TO docker;

--
-- Name: undgs_tankcodes_utid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.undgs_tankcodes_utid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.undgs_tankcodes_utid_seq OWNER TO docker;

--
-- Name: undgs_tankcodes_utid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.undgs_tankcodes_utid_seq OWNED BY public.undgs_tankcodes.utid;


--
-- Name: undgs_uid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.undgs_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.undgs_uid_seq OWNER TO docker;

--
-- Name: undgs_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.undgs_uid_seq OWNED BY public.undgs.uid;


--
-- Name: user; Type: TABLE; Schema: public; Owner: docker
--

CREATE TABLE public."user" (
    uid integer NOT NULL,
    name character varying NOT NULL,
    email character varying,
    email_notifications boolean DEFAULT false NOT NULL,
    darkmode boolean DEFAULT false NOT NULL,
    last_login timestamp without time zone
);


ALTER TABLE public."user" OWNER TO docker;

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: docker
--

CREATE SEQUENCE public.users_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_uid_seq OWNER TO docker;

--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: docker
--

ALTER SEQUENCE public.users_uid_seq OWNED BY public."user".uid;


--
-- Name: application aid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.application ALTER COLUMN aid SET DEFAULT nextval('public.applications_aid_seq'::regclass);


--
-- Name: conflict cid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.conflict ALTER COLUMN cid SET DEFAULT nextval('public.conflicts_cid_seq'::regclass);


--
-- Name: container_type cid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.container_type ALTER COLUMN cid SET DEFAULT nextval('public.container_types_cid_seq'::regclass);


--
-- Name: history hid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.history ALTER COLUMN hid SET DEFAULT nextval('public.history_hid_seq'::regclass);


--
-- Name: port pid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.port ALTER COLUMN pid SET DEFAULT nextval('public.ports_pid_seq'::regclass);


--
-- Name: ship sid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.ship ALTER COLUMN sid SET DEFAULT nextval('public.ships_sid_seq'::regclass);


--
-- Name: terminal tid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.terminal ALTER COLUMN tid SET DEFAULT nextval('public.terminals_tid_seq'::regclass);


--
-- Name: undgs uid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs ALTER COLUMN uid SET DEFAULT nextval('public.undgs_uid_seq'::regclass);


--
-- Name: undgs_descriptions udid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_descriptions ALTER COLUMN udid SET DEFAULT nextval('public.undgs_descriptions_udid_seq'::regclass);


--
-- Name: undgs_labels ulid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_labels ALTER COLUMN ulid SET DEFAULT nextval('public.undgs_labels_ulid_seq'::regclass);


--
-- Name: undgs_tank_special_provisions utsid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_tank_special_provisions ALTER COLUMN utsid SET DEFAULT nextval('public.undgs_tank_special_provisions_utsid_seq'::regclass);


--
-- Name: undgs_tankcodes utid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_tankcodes ALTER COLUMN utid SET DEFAULT nextval('public.undgs_tankcodes_utid_seq'::regclass);


--
-- Name: user uid; Type: DEFAULT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public."user" ALTER COLUMN uid SET DEFAULT nextval('public.users_uid_seq'::regclass);


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.application (aid, name, api_key) FROM stdin;
3	Test 3	333
4	Test 4	4444
24	test3	test5
27	noi	noi
28	Final	TEt
29	mada	asdfghjk
30	try e	jeff
\.


--
-- Data for Name: conflict; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.conflict (cid, created_by, solved_by, table_name, column_name, value, added_at, updated_at) FROM stdin;
\.


--
-- Data for Name: container_type; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.container_type (cid, display_name, iso_code, description, c_length, c_height, reefer) FROM stdin;
1	23TK		23 ft. Tank container	23	8	f
2	20BC	22B1	20' Bulk 	20	8	f
3	20DV	22G1	20' Dry van	20	8	f
4	20HD	22G1	20' Heavy Duty	20	8	f
5	20FL	22P1	20' Flat rack	20	8	f
6	20RF	22R1	20' Reefer	20	8	t
7	20TK	22T1	20' Bulk tank	20	8	f
8	20OT	22U1	20' Open Top	20	8	f
9	20HC	25G1	20' HC Dry van	20	9	f
10	20RH	25R1	20' HC Reefer	20	9	t
11	40DV	42G1	40' Dry van	40	8	f
12	40RF	42R1	40' Reefer	40	8	t
13	40TK	42T2	40' Bulk tank	40	8	f
14	40OT	42U1	40' Open Top	40	8	f
15	40HC	45G1	40' HC Dry van	40	9	f
16	40FL	45P1	40' Flat rack	40	8	f
17	40RH	45R1	40' HC Reefer	40	9	t
18	40DW	4CG1	40' Dry Wide	40	8	f
19	40PW	4CG1	40' Pallet wide	40	8	f
20	40HW	4EG1	40' HC pallet wide	40	9	f
21	45DV	L2G1	45'Dry Van	45	8	f
22	45FL	L2P1	45' Flat	45	8	f
23	45HC	L5G1	45' High Cube	45	9	f
24	45RH	L5R1	45' Reefer High Cube	45	9	t
25	45PW	LEG1	45' pallet wide	45	8	f
33	my	jeff		0	0	f
34	My name	e 	jeff	0	0	f
35	testests	ts		0	0	f
36	jeff	funy		0	0	t
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.history (hid, title, message, added_at) FROM stdin;
5	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: test3; APIKey: test5	2018-06-07 10:46:49.751
6	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: mahabi ; APIKey: testfunciton	2018-06-08 09:41:24.443
7	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: Mahabi test2; APIKey: pleswork	2018-06-08 09:44:48.677
8	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: MAhabi; APIKey: TEST4	2018-06-08 09:48:25.477
9	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: Final; APIKey: TEt	2018-06-08 09:55:55.902
10	ADD	r.d.banu@student.utwente.nl ADD   Application:  Name: mada; APIKey: asdfghjk	2018-06-08 12:32:27.877
17	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: wy; isoCode: so ; Description: ; Lenght: 2; Height: 0; Refeer: false	2018-06-15 10:21:51.134
18	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: asdasda; isoCode: as; Description: ; Lenght: 0; Height: 0; Refeer: false	2018-06-15 10:24:32.538
19	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: my; isoCode: jeff; Description: ; Lenght: 0; Height: 0; Refeer: false	2018-06-15 10:33:16.33
20	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: my; isoCode: jeff; Description: ; Lenght: 0; Height: 0; Refeer: false	2018-06-15 10:34:05.358
21	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: My name; isoCode: e ; Description: jeff; Lenght: 0; Height: 0; Refeer: false	2018-06-15 10:35:59.035
22	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: testests; isoCode: ts; Description: ; Lenght: 0; Height: 0; Refeer: false	2018-06-15 10:36:57.79
23	ADD	r.d.banu@student.utwente.nl ADD   ContainerType:  displayName: jeff; isoCode: funy; Description: ; Lenght: 0; Height: 0; Refeer: true	2018-06-15 10:37:37.233
\.


--
-- Data for Name: port; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.port (pid, name, unlo) FROM stdin;
2	Krems	\N
3	Linz	\N
4	Wien	\N
6	Avelgem	\N
7	Brussel	\N
8	Deurne	\N
9	Ghlin (Mons)	\N
11	Genk	\N
12	Grimbergen	\N
13	Grobbendonk	\N
14	Herent	\N
15	Houdeng Goegnies	\N
16	Hoboken	\N
17	Luik	\N
18	Meerhout	\N
19	Mol	\N
20	Beringen	\N
21	Wevelgem	\N
22	Wielsbeke	\N
23	Willebroek	\N
25	Zelzate	\N
26	Antwerpen/Zwijndrecht	\N
27	Birsfelden	\N
28	Basel	\N
29	Andernach	\N
30	Aschaffenburg	\N
31	Berlin	\N
32	Bonn	\N
34	K�ln	\N
36	Deggendorf	\N
37	Dormagen	\N
38	D�rpen	\N
39	Dresden	\N
40	Dortmund	\N
41	Duisburg	\N
42	D�sseldorf	\N
43	Emmerich	\N
44	Emmelsum	\N
45	Frankfurt am Main	\N
46	Gelsenkirchen	\N
47	Germersheim	\N
48	Gernsheim	\N
49	Ginsheim-Gustavsburg	\N
51	Heilbronn	\N
52	Karlsruhe	\N
53	Kehl	\N
54	Kelheim	\N
55	Koblenz am Rhein	\N
56	Krefeld	\N
57	Leverkusen	\N
58	Ludwigshafen	\N
59	Mainz	\N
60	Mannheim	\N
61	Nordenham	\N
62	Neuss	\N
63	N�rnberg	\N
64	Orsoy	\N
65	Riesa	\N
66	Senden	\N
67	Stuttgart	\N
68	Torgau	\N
69	Trier	\N
70	Wesel	\N
71	Wesseling	\N
72	Weil am Rhein	\N
73	W�rth am Rhein	\N
74	Worms	\N
75	W�rzburg	\N
76	Anzin	\N
77	B�thune	\N
78	Duinkerken	\N
79	Dourges	\N
80	Halluin	\N
81	Huningue	\N
82	Lille	\N
83	Neuf Brisach	\N
84	Ottmarsheim	\N
85	Prouvy	\N
86	Strasbourg	\N
87	Valenciennes	\N
88	Saint Saulve	\N
89	Budapest	\N
90	Almelo	\N
92	Alphen a.d. Rijn	\N
93	Arhem	\N
95	Born	\N
96	Bergen op Zoom	\N
97	Deventer	\N
98	Delft	\N
102	Delfzijl eemshaven	\N
103	Gorinchem	\N
104	Groningen	\N
106	Hengelo	\N
107	Harderwijk	\N
108	Heerenveen	\N
109	Den Bosch	\N
111	Kampen	\N
112	Lelystad	\N
113	Leeuwarden	\N
114	Meppel	\N
115	Middelburg	\N
117	Maastricht	\N
118	Nijmegen	\N
119	Oosterhout (NB)	\N
120	Oss	\N
121	Papendrecht	\N
122	Ridderkerk	\N
124	Rotterdam-Botlek	\N
126	Stein	\N
127	Tilburg	\N
129	Utrecht	\N
130	Veendam	\N
131	Veghel	\N
133	Venlo	\N
136	Wanssum	\N
137	Wijk bij Duurstede	\N
138	Westerbroek	\N
139	Westdorpe	\N
140	Waalwijk	\N
142	Zutphen	\N
143	Bratislava	\N
1	Enns	\N
145	Al Fujayrah	AEFJR
146	Dubai	AEDXB
147	Jebel Ali	AEJEA
148	Khor al Fakkan	AEKLF
149	Sharjah	AESHJ
150	Durres	ALDRZ
151	Curacao	ANCUR
152	Lobito	AOLOB
153	Luanda	AOLAD
154	Buenos Aires	ARBUE
155	Zarate	ARZAE
156	Pago Pago	ASPPG
157	Adelaide	AUADL
158	Albany	AUALH
159	Bell Bay	AUBEL
160	Brisbane	AUBNE
161	Broome	AUBME
162	Burnie	AUBWT
163	Cairns	AUCNS
164	Darwin	AUDRW
165	Devonport	AUDPO
166	Fremantle	AUFRE
167	Geelong	AUGEX
168	Hobart	AUHBA
169	Launceston	AULST
170	Melbourne	AUMEL
171	Newcastle	AUNTL
172	Port Hedland	AUPHE
173	Sydney	AUSYD
174	Townsville	AUTSV
175	Aruba	AWAUA
176	Bridgetown	BBBGI
177	Chalna	BDCHL
178	Chittagong	BDCGP
179	Mongla	BDMGL
180	Antwerpen	BEANR
181	Gent	BEGNE
182	Zeebrugge	BEZEE
183	Burgas	BGBOJ
184	Varna	BGVAR
185	Bahrain	BHBAH
186	Cotonou	BJCOO
187	Seria	BNSER
188	Fortaleza	BRFOR
189	Itajai	BRITJ
190	Itapoa	BRIOA
191	Itaqui	BRITQ
192	Manaus	BRMAO
193	Navegantes	BRNVT
194	Paranagua	BRPNG
195	Pecem	BRPEC
196	Porto Alegre	BRPOA
197	Recife	BRREC
198	Rio de Janeiro	BRRIO
199	Rio Grande	BRRIG
200	Salvador	BRSSA
201	Santos	BRSSZ
202	Sao Francisco do Sul	BRSFS
203	Sepetiba	BRSPB
204	Suape	BRSUA
205	Vitoria	BRVIX
206	Freeport Grand Bahama	BSFPO
207	Nassau	BSNAS
208	Belize City	BZBZE
209	Halifax	CAHAL
210	Montreal	CAMTR
211	Prince Rupert	CAPRR
212	Quebec	CAQUE
213	St John's	CASJF
214	Toronto	CATOR
215	Vancouver	CAVAN
216	Matadi	CDMAT
217	Abidjan	CIABJ
218	Antofagasta	CLANF
219	Arica	CLARI
220	Coronel	CLCNL
221	Iquique	CLIQQ
222	Lirquen	CLLQN
223	Mejillones	CLMJS
224	San Antonio	CLSAI
225	San Vicente	CLSVE
226	Talcahuano	CLTAL
227	Valparaiso	CLVAP
228	Douala	CMDLA
229	Chiwan	CNCWN
230	Dalian	CNDLC
231	Fangcheng	CNFAN
232	Fuzhou	CNFOC
233	Jingtang (Tangshan)	CNJIN
234	Jinzhou	CNJNZ
235	Lianyungang	CNLYG
236	Longkou	CNLKU
237	Nanjing	CNNKG
238	Nansha	CNNSA
239	Ningbo	CNNGB
240	Qingdao	CNTAO
241	Quanzhou	CNQZJ
242	Shanghai	CNSHA
243	Shantou	CNSWA
244	Shekou	CNSHK
245	Shenzhen	CNSZX
246	Taicang	CNTAG
247	Tanggu	CNTGU
248	Tianjin	CNTSN
249	Weihai	CNWEI
250	Xiamen	CNXMN
251	Xingang	CNXGG
252	Yangshan	CNYAN
253	Yantai	CNYNT
254	Yantian	CNYTN
255	Zhangjiagang	CNZJG
256	Barranquilla	COBAQ
257	Buenaventura	COBUN
258	Cartagena	COCTG
259	Santa Marta	COSMR
260	Caldera	CRCAL
261	Puerto Limon	CRLIO
262	Puerto Moin	CRPMN
263	Puntarenas	CRPAS
264	Habana	CUHAV
265	Famagusta	CYFMG
266	Larnaca	CYLCA
267	Limassol	CYLMS
268	Brake	DEBKE
269	Bremen	DEBRE
270	Bremerhaven	DEBRV
271	Brunsbuttel	DEBRB
272	Cuxhaven	DECUX
273	Emden	DEEME
274	Hamburg	DEHAM
275	Wilhelmshaven	DEWVN
276	Djibouti	DJJIB
277	Aalborg	DKAAL
278	Arhus	DKAAR
279	Esbjerg	DKEBJ
280	Kobenhavn	DKCPH
281	Roseau	DMRSU
282	Caucedo	DOCAU
283	Santo Domingo	DOSDQ
284	Alger (Algiers)	DZALG
285	Annaba (Bone)	DZAAE
286	Bejaia (Bougie)	DZBJA
287	Oran	DZORN
288	Skikda (Philippeville)	DZSKI
289	Esmeraldas	ECESM
290	Guayaquil	ECGYE
291	Muuga	EEMUU
292	Tallinn	EETLL
293	Adabiya	EGADA
294	Damietta	EGDAM
295	El Suweis (Suez)	EGSUZ
296	Port Said	EGPSD
297	Sokhna Port	EGSOK
298	Algeciras	ESALG
299	Barcelona	ESBCN
300	Bilbao	ESBIO
301	Cadiz	ESCAD
302	Ceuta	ESCEU
303	Las Palmas	ESLPA
304	Malaga	ESAGP
305	Palma de Mallorca	ESPMI
306	Santander	ESSDR
307	Sevilla	ESSVQ
308	Valencia	ESVLC
309	Helsinki (Helsingfors)	FIHEL
310	Kotka	FIKTK
311	Rauma (Raumo)	FIRAU
312	Turku (Abo)	FITKU
313	Lautoka	FJLTK
314	Suva	FJSUV
315	Bordeaux	FRBOD
316	Cherbourg	FRCER
317	Dunkerque	FRDKK
318	Fos sur Mer	FRFOS
319	Lavera	FRLAV
320	Le Havre	FRLEH
321	Marseille	FRMRS
322	Montoir de Bretagne	FRMTX
323	Libreville	GALBV
324	Avonmouth	GBAVO
325	Edinburgh	GBEDI
326	Felixstowe	GBFXT
327	Garston	GBGTN
328	Glasgow	GBGLW
329	Grangemouth	GBGRG
330	Hartlepool	GBHTP
331	Harwich	GBHRW
332	Immingham	GBIMM
333	Ipswich	GBIPS
334	Leith	GBLEI
335	Liverpool	GBLIV
336	London	GBLON
337	Manchester	GBMNC
338	Newcastle upon Tyne	GBNCL
339	Portsmouth	GBPME
340	Southampton	GBSOU
341	Teesport	GBTEE
342	Thamesport	GBTHP
343	Tilbury	GBTIL
344	Poti	GEPTI
345	Degrad des Cannes	GFDDC
346	Takoradi	GHTKD
347	Tema	GHTEM
348	Gibraltar	GIGIB
349	Banjul	GMBJL
350	Conakry	GNCKY
351	Pointe a Pitre	GPPTP
352	Athinai	GRATH
353	Piraeus	GRPIR
354	Thessaloniki	GRSKG
355	Puerto Quetzal	GTPRQ
356	San Jose	GTSNJ
357	Guam	GUGUM
358	Bissau	GWOXB
360	Hong Kong	HKHKG
361	Amapala	HNAMP
362	Puerto Cortes	HNPCR
363	San Lorenzo	HNSLO
364	Rijeka	HRRJK
365	Port au Prince	HTPAP
366	Balikpapan	IDBPN
367	Belawan	IDBLW
368	Dumai	IDDUM
369	Jakarta	IDJKT
370	Medan	IDMES
371	Padang (Teluk Bajur)	IDPDG
372	Palembang	IDPLM
373	Pontianak	IDPNK
374	Semarang	IDSRG
375	Surabaya	IDSUB
376	Ujung Pandang	IDUPG
377	Arklow	IEARK
378	Cobh	IECOB
379	Cork	IEORK
380	Drogheda	IEDRO
381	Dublin	IEDUB
382	Dundalk	IEDDK
383	Galway	IEGWY
384	Greenore	IEGRN
385	New Ross	IENRS
386	Waterford	IEWAT
387	Wexford	IEWEX
388	Ashdod	ILASH
389	Elat (Eilath)	ILETH
390	Haifa	ILHFA
391	Chennai (Madras)	INMAA
392	Cochin	INCOK
393	Hazira	INHZR
394	Hazira Port	INHZA
395	Kattupalli	INKAT
396	Kattupalli Port	INKTP
397	Kolkata (Calcutta)	INCCU
398	Krishnapatnam	INKRI
400	Mangalore	INIXE
401	Mumbai (Bombay)	INBOM
402	Mundra	INMUN
403	Nhava Sheva (Jawaharlal Nehru)	INNSA
404	Pipavav (Victor) Port	INPAV
405	Port Jawaharlal Nehru	INJNP
406	Visakhapatnam	INVTZ
407	Basra	IQBSR
408	Bandar Abbas	IRBND
409	Bandar Khomeini	IRBKM
410	Khorramshahr	IRKHO
411	Reykjavik	ISREY
412	Bari	ITBRI
413	Brindisi	ITBDS
414	Cagliari	ITCAG
415	Catania	ITCTA
416	Genoa	ITGOA
417	Gioia Tauro	ITGIT
418	La Spezia	ITSPE
419	Livorno (Leghorn)	ITLIV
420	Messina	ITMSN
421	Napoli	ITNAP
422	Palermo	ITPMO
423	Ravenna	ITRAN
424	Salerno	ITSAL
425	Savona	ITSVN
426	Taranto	ITTAR
427	Trieste	ITTRS
428	Venezia	ITVCE
429	Kingston	JMKIN
430	Aqaba	JOAQB
431	Aioi	JPAIO
432	Akita	JPAXT
433	Chiba	JPCHB
434	Fukuyama Hiroshima	JPFKY
435	Funabashi	JPFNB
436	Fushiki	JPFSK
437	Hachinohe	JPHHE
438	Hakata	JPHKT
439	Hakodate	JPHKD
440	Hamada	JPHMD
441	Hirohata	JPHRH
442	Hiroshima	JPHIJ
443	Hitachinaka	JPHIC
444	Hososhima	JPHSM
445	Imabari	JPIMB
446	Imari	JPIMI
447	Kagoshima	JPKOJ
448	Kanazawa	JPKNZ
449	Kashima Ibaraki	JPKSM
450	Kawasaki	JPKWS
451	Kinuura	JPKNU
452	Kobe	JPUKB
453	Kochi	JPKCZ
454	Moji	JPMOJ
455	Nagasaki	JPNGS
456	Nagoya	JPNGO
457	Naha	JPNAH
458	Osaka	JPOSA
459	Tokyo	JPTYO
460	Yokkaichi	JPYKK
461	Yokohama	JPYOK
462	Mombasa	KEMBA
463	Sihanoukville	KHSHV
464	Tarawa	KITRW
465	Moroni	KMYVA
466	Mutsamudu	KMMUT
467	Chongjin	KPCHO
468	Hungnam	KPHGM
469	Busan (Pusan)	KRPUS
470	Daesan	KRTSN
471	Donghae	KRTGH
472	Inchon	KRINC
473	Kwangyang	KRKAN
474	Ulsan	KRUSN
475	Kuwait	KWKWI
476	Beirut	LBBEY
477	Colombo	LKCMB
478	Trincomalee	LKTRR
479	Monrovia	LRMLW
480	Klaipeda	LTKLJ
481	Riga	LVRIX
482	Ventspils	LVVNT
483	Misurata	LYMRA
484	Tripoli	LYTIP
485	Casablanca	MACAS
486	Rabat	MARBA
487	Tangier	MATNG
488	Majunga (Mahajanga)	MGMJN
489	Tamatave (Toamasina)	MGTMM
490	Toamasina	MGTOA
491	Yangon	MMRGN
492	Macau	MOMFM
493	Fort de France	MQFDF
494	Nouakchott	MRNKC
495	Malta (Valetta)	MTMLA
496	Marsaxlokk	MTMAR
497	Port Louis	MUPLU
498	Acapulco	MXACA
499	Altamira	MXATM
500	Ensenada	MXESE
501	Guaymas	MXGYM
502	Lazaro Cardenas	MXLZC
504	Mazatlan	MXMZT
505	Salina Cruz	MXSCX
506	Tampico	MXTAM
507	Veracruz	MXVER
508	Kuantan (Tanjong Gelang)	MYKUA
509	Pasir Gudang	MYPGU
510	Penang (Georgetown)	MYPEN
511	Port Kelang	MYPKG
512	Sibu Sarawak	MYSBW
513	Tanjong Pelepas	MYTPP
514	Beira	MZBEW
515	Maputo	MZMPM
516	Nacala	MZMNC
517	Walvis Bay	NAWVB
518	Noumea	NCNOU
519	Apapa	NGAPP
520	Calabar	NGCBQ
521	Lagos	NGLOS
522	Onne	NGONN
523	Port Harcourt	NGPHC
524	Tincan Island	NGTIN
525	Warri	NGWAR
526	Corinto	NICIO
527	Amsterdam	NLAMS
528	Beverwijk	NLBEV
529	Botlek	NLBOT
530	Delfzijl	NLDZL
531	Den Helder	NLDHR
532	Dordrecht	NLDOR
533	Eemshaven	NLEEM
534	Europoort	NLEUR
535	Harlingen	NLHAR
536	IJmuiden	NLIJM
537	Moerdijk	NLMOE
538	Pernis	NLPER
539	Rotterdam	NLRTM
540	Rozenburg	NLROZ
541	Sas van Gent	NLSVG
542	Schiedam	NLSCI
543	Spijkenisse	NLSPI
544	Terneuzen	NLTNZ
545	Velsen	NLVEL
546	Vlaardingen	NLVLA
547	Vlissingen	NLVLI
548	Zaandam	NLZAA
549	Zwijndrecht	NLZWI
550	Alesund	NOAES
551	Bergen	NOBGO
552	Drammen	NODRM
553	Fusa	NOFUS
554	Kristiansand	NOKRS
555	Larvik	NOLAR
556	Mo i Rana	NOMQN
557	Moss	NOMSS
558	Odda	NOODD
559	Oslo	NOOSL
560	Porsgrunn	NOPOR
561	Stavanger	NOSVG
562	Nauru Island	NRINU
563	Auckland	NZAKL
564	Bluff	NZBLU
565	Christchurch	NZCHC
566	Dunedin	NZDUD
567	Lyttelton	NZLYT
568	Napier	NZNPE
569	Nelson	NZNSN
570	New Plymouth	NZNPL
571	Otago Harbour	NZORR
572	Port Chalmers	NZPOE
573	Tauranga	NZTRG
574	Timaru	NZTIU
575	Wellington	NZWLG
576	Muscat	OMMCT
577	Salalah	OMSLL
578	Sohar	OMSOH
579	Balboa	PABLB
580	Colon	PAONX
581	Cristobal	PACTB
582	Manzanillo	PAMIT
583	Callao	PECLL
584	Chimbote	PECHM
585	Ilo	PEILQ
586	Matarani	PEMRI
587	Paita	PEPAI
589	Papeete	PFPPT
590	Lae	PGLAE
591	Port Moresby	PGPOM
592	Batangas	PHBTG
593	Cebu	PHCEB
594	Davao	PHDVO
595	Manila	PHMNL
596	Subic Bay	PHSFS
597	Karachi	PKKHI
598	Karachi Container Terminal	PKKCT
599	Port Qasim	PKBQM
600	Gdansk	PLGDN
601	Gdynia	PLGDY
602	San Juan	PRSJU
603	Aveiro	PTAVE
604	Figueira da Foz	PTFDF
605	Leixoes	PTLEI
606	Lisboa	PTLIS
607	Porto	PTOPO
608	Setubal	PTSET
609	Sines	PTSIE
610	Doha	QADOH
611	Qapco	QAQAP
612	Reunion	REREU
613	Braila	ROBRA
614	Constanta	ROCND
615	Kaliningrad	RUKGD
616	Korsakov	RUKOR
617	Nakhodka	RUNJK
618	Novorossiysk	RUNVS
619	St Petersburg (Leningrad)	RULED
620	Ust Luga	RUULU
621	Vladivostok	RUVVO
622	Vostochniy Port	RUVYP
623	Ad Dammam (Damman)	SADMM
624	Jeddah	SAJED
625	Jizan	SAGIZ
626	Jubail	SAJUB
627	King Abdullah City	SAKAC
628	Yanbu al-Bahr	SAYNB
629	Honiara Guadalcanal Is	SBHIR
630	Noro	SBNOR
631	Mahe	SCMAW
632	Port Sudan	SDPZU
633	Gavle	SEGVX
634	Goteborg	SEGOT
635	Halmstad	SEHAD
636	Helsingborg	SEHEL
637	Malmo	SEMMA
638	Stockholm	SESTO
639	Jurong/Singapore	SGJUR
640	Singapore	SGSIN
641	Koper	SIKOP
642	Freetown	SLFNA
643	Dakar	SNDKR
644	Mogadishu	SOMGQ
645	Paramaribo	SRPBM
646	Sao Tome Island	STTMS
647	Acajutla	SVAQJ
648	Latakia	SYLTK
649	Lome	TGLFW
650	Bangkok	THBKK
651	Laem Chabang	THLCH
652	Sahathai Coastal Seaport	THSCS
653	Sfax	TNSFA
654	Sousse	TNSUS
655	Tunis	TNTUN
656	Aliaga	TRALI
657	Ambarli	TRAMB
658	Bandirma	TRBDM
659	Gebze	TRGEB
660	Gemlik	TRGEM
661	Giresun	TRGIR
662	Iskenderun	TRISK
663	Istanbul	TRIST
664	Izmir (Smyrna)	TRIZM
665	Izmit	TRIZT
666	Kumport	TRKMX
667	Mersin	TRMER
668	Samsun	TRSSX
669	Tekirdag	TRTEK
670	Port of Spain	TTPOS
671	Hualien	TWHUN
672	Kaohsiung	TWKHH
673	Keelung (Chilung)	TWKEL
674	Taichung	TWTXG
675	Dar es Salaam	TZDAR
676	Tanga	TZTGT
677	Illichivs'k	UAILK
678	Ilyichevsk	UAILY
679	Odessa	UAODS
680	Yuzhnyy	UAYUZ
681	Anchorage	USANC
682	Baltimore	USBAL
683	Beaumont	USBPT
684	Boston	USBOS
685	Camden	USCDE
686	Charleston	USCHS
687	Chicago	USCHI
688	Dutch Harbor	USDUT
689	Freeport	USFPO
690	Galveston	USGLS
691	Georgetown	USGGE
692	Honolulu	USHNL
693	Jacksonville	USJAX
694	Long Beach	USLGB
695	Los Angeles	USLAX
696	Miami	USMIA
697	Mobile	USMOB
698	New Orleans	USMSY
699	New York	USNYC
700	Newark	USEWR
701	Norfolk	USORF
702	Oakland	USOAK
703	Philadelphia	USPHL
704	Port Everglades	USPVS
705	Portland	USPWM
706	San Francisco	USSFO
707	Savannah	USSAV
708	Seattle	USSEA
709	Tacoma	USTIW
710	Wilmington	USILM
711	Montevideo	UYMVD
712	La Guaira	VELAG
713	Maracaibo	VEMAR
714	Puerto Cabello	VEPBL
715	Da Nang	VNDAD
716	Haiphong	VNHPH
717	Ho Chi Minh City	VNSGN
718	Vung Tau	VNVUT
719	Aden	YEADE
720	Hodeidah	YEHOD
721	Mukalla	YEMKX
722	Sana'a	YESAH
723	Cape Town	ZACPT
724	Coega	ZAZBA
725	Durban	ZADUR
726	East London	ZAELS
727	Port Elizabeth	ZAPLZ
144	Abu Dhabi	AEAUH
\.


--
-- Data for Name: ship; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.ship (sid, imo, name, callsign, mmsi, ship_depth) FROM stdin;
2	T2	McBoat	MB	T22      	2.20
4	9593660	HUA AN CHENG	9V9603	566827000	9.80
5	9275048	NEDLLOYD MARITA	A8DG9	636090707	11.50
6	9526916	MAERSK LETICIA	VRJC9	477628400	12.50
7	8914556	SELFOSS	V2RU	304263000	7.48
8	9481702	ABML EVA	9HA3041	229068000	13.60
9	9380831	MINERVA JULIE	SYNQ	240716000	13.27
10	9179646	DS CROWN	C6QS6	308089000	22.11
11	9287998	SERENITY I	V7KT9	538002678	12.49
12	9323467	JORK ROVER	V2CB4	304970000	7.33
13	9416082	SHAMROCK JUPITER	3FXP2	370999000	9.62
14	9190638	HANNE KNUTSEN	VQEO5	235598000	15.60
15	9036014	KESTREL I	D5EF3	636016061	17.52
16	9333369	VIONA	CQIC	255805552	10.90
17	9591985	CORAL CRYSTAL	3FVW3	373789000	14.33
18	9141118	WEGA	DHEW	211235880	7.43
19	9435844	LEON	D5BH4	636015519	5.60
20	9411915	AFON CADNANT	C4TS2	209895000	3.15
21	9420875	AFON LLIFON	C4ZN2	210628000	3.15
22	9161273	SKS TORRENS	LAJM5	259956000	15.72
23	9313527	GIJON KNUTSEN	MMLG6	235011030	11.50
24	9199323	STOLT TEAL	ZCPT8	319194000	7.51
25	9246918	HANNE THERESA	OUJQ2	220125000	6.09
26	9123623	JIAN QIANG	3FPU6	356913000	11.36
27	9391660	SPIRIT OF HAMBURG	9V2497	564061000	12.40
28	9008500	B GAS LANRICK	9HJA9	249049000	6.00
29	9417335	BLACKCOMB SPIRIT	C6BC4	311000223	15.37
30	9453030	NEVERLAND DREAM	ICPP	247301500	14.90
31	9346457	LUMEN N	3FPC4	355364000	12.52
32	9428205	SAMBA	V2FE3	305649000	7.40
33	9420617	SHAH DENIZ	9HA2528	248821000	14.55
34	9268851	DONAU	V2HS2	305119000	5.74
35	8100636	FRI STAR	C6RZ5	311257000	3.54
36	9357559	HISTRIA AGATA	9HSB8	256359000	10.50
37	9454838	WARNOW	V2DN4	305264000	6.04
38	9566746	STOLT REDSHANK	2EXV5	235089046	5.50
39	9302243	HANSE VISION	C4WN2	212675000	7.30
40	9355460	SPICA J	V2CV3	305115000	7.36
41	9087374	ORTVIKEN	SECN	265412000	6.30
42	9458975	CONMAR BAY	V2GC2	305883000	8.00
43	9031428	LANDY	LAFA7	259743000	6.06
44	7221275	STAR ARUBA	PHUO	246392000	4.50
45	8719097	HAV NES	OZ2088	231099000	6.10
46	9395575	BG ROTTERDAM	CQHC	255805578	7.38
47	8116166	ALTEA II	XXXX	0        	4.54
48	9113214	FRANCISCA	PCGY	246174000	6.35
49	9136096	FAST SUS	ONEO	205482000	4.65
50	9344801	EL ZORRO	V7LV7	538002815	8.71
51	9551911	SD SALVOR	9HA2375	248465000	5.36
52	9305178	MAERSK NORDENHAM	9HNA9	249206000	8.40
53	9419175	STENA BRITANNICA	2DMO6	235080274	6.50
54	9309203	CLIPPER BURGUNDY	9HUK9	249546000	5.40
55	9232486	WILLEKE	PFBN	245377000	3.40
56	9148960	STOLT CORMORANT	ZCSE5	319301000	6.50
57	9444728	SANTA ISABEL	DIJY2	211580000	14.50
58	9475698	HYUNDAI SPEED	SVBY3	241313000	15.50
59	9321550	EUGEN MAERSK	OXOS2	220503000	16.00
60	9293179	MOL CALEDON	A8RL4	636091671	13.50
61	9285665	MSC YOKOHAMA	LXYO	253319000	14.50
62	9516430	COSCO NETHERLANDS	VRMR5	477219900	15.53
63	9225433	VEGA	V7MA3	538090289	11.52
64	9307009	OOCL KAOHSIUNG	9V9830	566389000	14.02
65	9278105	DEVA	A8OK3	636013644	11.00
66	9294836	LONGAVI	A8IZ4	636012906	12.52
67	9373278	BEAUMARIS	PHLR	244908000	5.40
68	9135169	HOPE BAY	PJQK	306303000	8.27
69	9354404	BF EUPHORIA	V2CB7	304975000	8.70
70	9403413	EM SPETSES	A8XP6	636014955	10.90
71	9226918	MSC MELISSA	H9VY	354340000	14.50
72	9437048	SONCHE TRADER	A8TR6	636091852	13.62
73	9232876	AEGEAN FREEDOM	SWZJ	239989000	14.92
74	9578995	HUI AN HAI	3FII9	353389000	10.02
75	9354387	JOANNA BORCHARD	V2CL9	305041000	8.70
76	9449455	INA THERESA	V7UJ2	538004548	8.65
77	9166467	SYLVIA	PEAX	245752000	6.16
78	9556313	FLINTER RIDHI	PCEJ	244790509	6.15
79	8712166	KEY FIGHTER	9HA2671	215211000	6.20
80	9453511	DORIC WARRIOR	A8WQ4	636014806	14.90
81	9350757	JUTLANDIA SWAN	OYIO2	220546000	9.49
82	9277400	OLAND	9HZJ8	256639000	7.47
83	9010943	SARAH WONSILD	ICWE	247006000	5.21
84	9565742	BOCHEM ANTWERP	V7XB8	538004442	9.71
85	9145188	NAVION BRITANNIA	C6XC9	309412000	15.65
86	9126211	DORNBUSCH	DIOD	211234480	6.55
87	9413547	NS ARCTIC	A8SA7	636014189	14.84
88	9298595	FILICUDI M	IBRE	247118800	9.63
89	9039250	MSC JOY	9HA2524	248811000	10.55
90	9511789	SULPHUR GENESIS	9HA2898	256656000	6.67
91	9256729	LADY SHANA	9VJJ4	565053000	5.41
92	9344253	PACHUCA	V2QO8	304824000	7.29
93	9173290	WILSON CAEN	8PRM	314179000	5.67
94	9205158	COASTALWATER	PEDM	244530000	5.27
95	9544932	ABIS BERGEN	PBPY	246399000	5.35
96	9312212	ENSEMBLE	PHES	246255000	7.10
97	9017381	WILSON HUMBER	8PSP	314207000	5.63
98	9279044	EIDSVAAG SIRIUS	LMAA	246113000	4.85
99	8119572	WILSON EXPRESS	8PXI	314336000	6.16
100	9392420	NAVIOS PROSPERITY	3ELA8	372895000	14.40
101	9110559	MARUS	V2AR3	305707000	4.90
102	9007453	SVANEN	C6LA2	308851000	5.00
103	9431903	VIKING	PIHD	245039000	3.75
104	9327047	CRYSTAL TOPAZ	9HA2164	248075000	8.37
105	9322700	BRO NIBE	OXGY2	220495000	8.90
106	9085481	LADY OLGA	PGMB	245332000	5.30
107	9229532	CLIFFWATER	PBFS	244123000	5.26
108	9341184	STEN MOSTER	ZDHG3	236313000	8.89
3	9604093	EVER LEGEND	9V9724	566949000	14.20
109	9178446	WILSON WAAL	8PUR	314262000	4.35
110	9255878	EKFORS	LADX7	259721000	8.62
111	9157014	BELLINI	V2AS2	304070991	4.65
112	9358539	VEGA STOCKHOLM	A8IH4	636090978	7.40
113	9105152	OSTSEE	5BAK4	210920000	5.51
114	9271884	FURE NORD	OZ2099	231772000	9.14
115	9106584	KLAIPEDA	LYSZ	277391000	5.80
116	9419163	STENA HOLLANDICA	PBMM	244758000	6.50
117	9451214	DUMLUPINAR	9HSK9	249453000	8.15
118	9394038	ISA	PISA	244571000	2.50
119	9117117	WILSON EMS	8PUN	314258000	4.06
120	9350886	CORAL LOPHELIA	PHGF	246262000	7.50
121	9327164	RHONE	9HMK8	256281000	5.02
122	9201944	ASHLEY	PEDN	244580000	4.35
123	9665607	THALASSA PATRIS	9V2229	563672000	15.50
124	9354533	VLADIMIR	5BSL2	209777000	9.89
125	9502960	HANJIN GOLD	2GEL2	235096684	15.52
126	9340465	FSL LONDON	9VBQ9	565223000	9.71
127	9290335	AEGEAN DIGNITY	SXVC	240245000	17.07
128	9400069	MAULE	A8SG6	636014208	14.00
129	9215658	FLINTERDIJK	PBAB	244910000	6.37
130	9443487	CSAV LUMACO	VRFB5	477207402	12.60
131	9148142	EEMS CARRIER	PFHD	245257000	4.13
132	9231004	MAHA ROOS	AVFT	419000124	14.00
133	9330410	ORIENTAL FREESIA	ZGCD7	319349000	8.81
134	9216858	OPDR CADIZ	EBWM	224505000	7.40
135	9518799	STOLT GREENSHANK	2GFD9	235096859	5.50
136	9186405	ANTJE RUSS	DARB	211285270	7.09
137	9436305	JOHANNA SCHEPERS	V2QI4	305817000	7.34
138	9507881	E.R. BOSTON	LXFG	253367000	18.20
139	9305611	PROMITHEAS	SYIJ	240547000	15.42
140	9143829	ECL COMMANDER	8PVT	314292000	5.90
141	9322578	SAMSKIP COURIER	V2BT6	304923000	7.33
142	9262895	CHARON J	5BRV3	209883000	7.20
143	9596260	MAREX EXPRESS	9VFV6	566847000	12.31
144	9354466	HELMUT	5BDG2	212157000	8.70
145	9348106	RIO MADEIRA	D5FY9	636092571	13.50
146	9511387	OLYMPIYSKY PROSPECT	A8TH3	636014353	13.60
147	9150535	WILSON TEES	9HKQ5	249910000	5.49
148	9141053	SAN LORENZO RUIZ UNO	DUH3507	0        	7.54
149	9194309	RMS DUISBURG	V2BW2	304928000	3.35
150	9336244	CONTAINERSHIPS VIII	DDAF2	211845000	8.95
151	9482603	PHOENIX ADMIRAL	9V8776	563353000	13.60
152	9337286	HARBOUR KIRA	C6VX4	309702000	8.05
153	9421219	ICDAS-09	9HA2822	256151000	9.85
154	9295438	LISA ESSBERGER	PCQE	245958000	7.40
155	9109081	KHOLMOGORY	UBTE2	273342810	5.92
156	9431020	AZURYTH	5BCA4	212228000	6.29
157	9402653	STAR CURACAO	PHPF	245405000	5.45
158	9227596	NAGATO REEFER	H3QQ	351336000	7.52
159	9287704	LISA	V2FK9	305709000	7.47
160	9355446	BG IRELAND	5BBU3	209719000	7.36
161	9376701	PALATINE	LXPL	253416000	7.05
162	9376713	VESPERTINE	LXVH	253417000	7.05
163	9404041	NADEZHDA	UBAF8	273347820	10.00
164	9262883	CETUS J	5BRS3	210140000	7.30
165	8706349	ANTRACYTH	5BYC2	212137000	6.40
166	8820298	AGATH	5BDX3	209562000	5.47
167	9186637	FLANDRIA SEAWAYS	OZOJ2	219318000	5.70
168	9153020	SUECIA SEAWAYS	OVPB2	220284000	7.50
169	9190315	ALCEDO	PCFL	246419000	4.20
170	9627966	WILPRIDE	LARM7	258703000	12.50
171	9341328	ATLANTIC TWIN	ZDNZ7	236112059	8.50
172	9276389	ARCTIC DISCOVERER	C6UV5	309481000	11.56
173	9520869	FLAGSHIP IVY	V7VZ3	538090428	14.57
174	9511521	MOSKOVSKY PROSPECT	A8TH4	636014354	13.60
175	9539078	SEVERINE	PCMU	246171000	5.46
176	9539066	CAPUCINE	2FZV8	235095629	5.46
177	9121895	BF AURELIA	V2IA2	304246000	6.62
178	9191175	GEORG ESSBERGER	CQSW	255735000	6.79
179	9195559	H&S WISDOM	PCAZ	245339000	3.42
180	9017202	WESTCARRIER	C6UP7	311991000	4.38
181	9268253	CLAUS	ZDGN7	236263000	7.45
182	9346926	CASTEL DELL OVO	ICHT	247226200	6.50
183	8611207	STAD	YJTS3	577229000	4.70
184	9323819	BRO NUUK	OXHP2	220502000	8.90
185	8920529	STOLT TERN	MVRB8	235050795	6.20
186	9524815	BABUZA WISDOM	3EXX5	370749000	8.47
187	9469376	STENA TRANSPORTER	PCIY	246762000	6.30
188	9157284	SELANDIA SEAWAYS	OWLH2	219458000	7.50
189	9208629	PRIDE OF HULL	C6ZQ4	311062900	6.05
190	9148453	STAR BONAIRE	PHHU	246359000	5.15
191	9568328	EEBORG	PCNL	246846000	8.00
192	9518804	STOLT SANDERLING	2GBH7	235095972	5.50
193	9190066	RT MAGIC	PHBR	245464000	3.86
194	9321483	EMMA MAERSK	OYGR2	220417000	16.02
195	9215323	MAERSK KITHIRA	ZNQO3	235267000	13.50
196	9400148	APL QATAR	9VMJ5	563831000	13.52
197	9192428	CMA-CGM MATISSE	5BAD2	212865000	11.00
198	9324837	ANL WARRINGA	V7LF2	538002734	12.60
199	9232084	PHOENIX I	A8CN9	636090671	13.00
200	9434917	MAERSK NIAMEY	VREX7	477197100	11.50
201	9487627	ATHINA L	A8YS8	636015124	12.20
202	9287807	VOHBURG	V2OW7	305773000	7.33
203	9155133	MAERSK CAROLINA	WBDS	369233000	13.50
204	9320726	ALCOR	A8NV3	636013565	16.52
205	9179268	PACIFIC REEFER	D5FE3	636016239	9.70
206	9398448	ZIM ANTWERP	A8SI6	636014220	14.00
207	9393242	REGINE	V2GL7	305984000	9.08
208	9155808	FRONT BRABANT	V7UR8	538004013	17.23
209	9433444	MANFRED	V2DM7	305259000	7.40
210	9110377	MSC SAMANTHA	3EZB4	356249000	14.02
211	9470961	FRISIA BONN	A8TA6	636091807	11.35
212	9212058	ALPHA MILLENNIUM	9HWY9	249655000	17.97
213	9413834	PATROCLUS	9HA2039	249848000	17.15
214	9185073	MAHA JACQUELINE	AVFL	419000116	14.00
215	9176125	DANUBEGAS	DBOM	211280810	6.42
216	9424596	ARGENT GERBERA	V7UC4	538003929	11.41
217	9102095	STOLT CREATIVITY	ZCSP4	319498000	11.91
218	9301964	NAVE ARIADNE	ZCTC4	319768000	14.32
219	9474280	CMB PAULE	VRJF3	477346600	9.80
220	9361108	CRS REBECCA	PBON	245995000	6.10
221	9211169	E.R. PUSAN	LXEP	253202000	14.00
222	9243306	MSC ULSAN	VRKD9	477423900	12.65
223	8603377	ALEKSANDR SIBIRYAKOV	9HXH4	249540000	7.00
224	9549621	BIRYUZA	UBQI7	273358960	6.41
225	9523548	HARBOUR MURAN	OUZF2	219017178	7.50
226	9370329	IVS SHIKRA	3ESY3	370460000	9.70
227	9243875	LADY NONA	PBGO	244998000	4.00
228	9182954	STAR ISTIND	LAMP5	257424000	12.30
229	9297541	BONITA	SYVW	240609000	14.92
230	9424871	AMANDINE	LXAM	253047000	7.40
231	9376725	PEREGRINE	9HA2355	215740000	7.05
232	9511533	PRIMORSKY PROSPECT	A8TH5	636014355	13.60
233	9493145	GOLDENGATE PARK	D5EL2	636016098	9.70
234	9296999	FESCO NAVARIN	UBSL9	273343170	7.36
235	9430193	HERCULES J	5BDG4	212302000	8.50
236	9236987	MAERSK ROSYTH	OWIX2	219119000	11.82
237	9358632	CELSIUS MAYFAIR	V7BU6	538005202	9.63
238	9218533	RMS CUXHAVEN	V2OF8	304109000	3.20
239	9009190	SYMBIO TWO	YFZH	525018390	5.86
240	9174086	MOZART	V2AW8	304117000	4.65
241	9280720	RELUME	C6TR4	311753000	4.50
242	9344320	NARCEA	CQMS	255803560	6.07
243	9208617	PRIDE OF ROTTERDAM	PBAJ	244980000	6.05
244	9488322	PECHORA STAR	9HA2788	215760000	8.70
245	9351567	STEN NORDIC	LAEY6	257667000	8.90
246	9121871	DUBAI ENTERPRISE	ZDGD9	236236000	6.62
247	9460241	STEN FJELL	ZDJF5	236522000	9.27
248	8110851	CORNELIS ZANEN	5BFK2	210574000	8.05
249	9428073	SOLANDO	SDJU	266421000	9.92
250	9469388	STENA TRANSIT	PHJU	244513000	6.30
251	9283710	TORM HORIZON	OYNM2	220566000	12.22
252	9357602	HAFNIA SEAWAYS	2AMH9	235060989	6.80
253	9183817	WOLGASTERN	CQLH	255804950	8.80
254	9365661	AFRICABORG	PHMH	245031000	9.69
255	9197791	SKAGERN	PHHL	246558000	5.30
256	9313632	ALLER	V2BR9	304738000	4.36
257	9113941	AUTEUIL	9V8690	563483000	4.21
258	9360324	ATLANTIC TITAN	VREQ4	477163800	12.21
259	9280641	CMA-CGM STRAUSS	D5CF5	636015685	14.50
260	9360154	CMA-CGM ARISTOTE	MRPN4	235054581	9.36
261	9421972	SCF SAMOTLOR	A8SW7	636014309	17.00
262	7724203	KARMSUND	OZ2093	231758000	4.56
263	9461867	APL CHONGQING	9V9373	566318000	15.52
264	9321536	ELLY MAERSK	OXHY2	220499000	16.00
265	9322554	SLEIPNER	C4FB2	209629000	7.33
266	7038680	TARCO SEA	JXIE3	258243000	3.76
267	9564384	ORANGE STAR	A8WP6	636014800	10.15
268	9369069	UTA	V2CJ9	305024000	7.43
269	9588615	KYDONIA	SVBT2	241259000	14.90
270	9414058	STOLT ISLAND	ZCXG7	319963000	11.87
271	9431587	EEMS SUN	PHMO	245070000	4.26
272	9579573	DELTA MARINER	SVBX6	241297000	16.00
273	9377664	SINGLE	9HBC9	256711000	11.52
274	9010955	MARY WONSILD	ICWC	247002000	5.21
275	9649043	AFRICAN WAGTAIL	C6AU4	311000154	12.65
276	9404091	HENRIKE SCHEPERS	V2HS5	305268000	7.33
277	8502133	PEAK SAUDA	E5U2405	518455000	3.91
278	9404089	KRISTIN SCHEPERS	5BPU2	212037000	7.34
279	9418925	LS ANNE	ZDIR2	236476000	6.29
280	9375800	LADY CLARA	V2CJ2	305015000	5.14
281	9448669	E.R. RIGA	A8UQ9	636091934	8.60
282	9287699	INDIA	9HA3441	229605000	7.47
283	9191656	DUTCH AQUAMARINE	PCHS	246271000	6.45
284	9174098	DONIZETTI	LXDZ	253217000	4.90
285	9172155	CRYSTAL AMARANTO	9HA2160	248071000	7.74
286	9447067	SELENKA	9HVO9	249598000	7.98
287	9237008	ROBERT MAERSK	OXFP2	220208000	11.82
288	9310850	ETERNAL DILIGENCE	3EEB5	371755000	14.36
289	9448671	E.R. TALLINN	A8XS5	636092164	8.60
290	9369007	IRIS BOLTEN	CQHB	255805577	7.36
291	8920268	RMS WANHEIM	V2OZ2	304764000	4.47
292	9312200	ENDURANCE	PBKO	244357000	7.10
293	9113202	LEAH	PCME	246814000	6.35
294	9087350	OBBOLA	SEBR	265411000	6.25
295	9294070	DOKTER WAGEMAKER	PH5436	244030035	4.40
296	9122241	DETTE G	V2BV8	304939000	6.55
297	9527764	BLUE STAR	9HA2785	215691000	7.50
298	9229128	HANSEATIC TRADER	V2BW6	304948000	6.22
299	9125695	KERLI	9HA3660	229849000	5.68
300	9309980	NORD BELL	OVSH2	220513000	11.62
301	9390393	BOMAR MOON	V2QC3	305526000	4.65
302	8918708	PITZTAL	PBEV	246190000	7.22
303	9197284	BOW SUN	9VAL7	563827000	11.99
304	9240744	SAMIRA	PCCG	245015000	3.59
305	8805597	WILSON STAR	SKQJ	265735000	6.05
306	9255282	FUTURA	OJLH	230964000	10.90
307	8505941	FROAN	J8B3679	376317000	5.49
308	9143415	ORION	PHIA	246046000	5.91
309	9302126	TORM TEVERE	OYMY2	220556000	11.22
310	8404496	ANTARES	PCSI	246254000	3.36
311	9450337	NORTHERN JUBILEE	A8SZ6	636091799	14.50
312	9401178	CENTAURUS	V7UO4	538003987	12.00
313	9453559	CMA-CGM CHRISTOPHE COLOMB	FNUY	228315600	15.50
314	9479204	EIBHLIN	HOCB	355568000	18.20
315	9086796	GODAFOSS	V2PM7	304158000	8.97
316	9376036	RUTH	5BEG2	212613000	8.71
317	9484912	ALLEGRO	A8VL3	636014622	12.22
318	9168180	MAERSK PEMBROKE	PDHY	244127000	11.60
319	9013048	FRISIUM	PHYQ	245824000	3.73
320	9476824	HAFNIA LEO	D5FN4	636016317	13.00
321	9467275	CSCL MERCURY	VRIQ7	477229400	15.50
322	9302633	YM UNISON	A8HZ6	636012809	14.52
323	9454242	SONDERBORG STRAIT	V2GD6	305904000	8.60
324	9314844	KRASLAVA	V7LI7	538002755	11.20
325	9288693	DELTA PIONEER	SYIO	240244000	14.60
326	9322566	JORK RIDER	V2BT5	304922000	7.33
327	9341964	CONMAR GULF	2FXW4	235095162	7.40
328	9389318	CARTAGENA	5AWY	642122014	11.00
329	9005481	HAPPY FELLOW	2CIV5	235073614	6.46
330	9321677	KRONVIKEN	LAJB6	258692000	14.90
331	9438860	NANSEN SPIRIT	C6YA9	311027500	15.02
332	9294680	NORDIC MARIANNE	OUPM2	220298000	6.96
333	9323479	SAMSKIP EXPRESS	V2BZ8	304965000	7.33
334	9409742	BARNACLE	5BNK2	212093000	10.40
335	9436214	SAMSKIP INNOVATOR	5BEX3	209361000	7.34
336	8903105	ISARTAL	YJTX3	577273000	5.49
337	9121869	KATHARINA B	V2NA6	304304000	6.62
338	9352195	NORD HUMMOCK	OZHD2	219291000	11.20
339	9222352	JONAS	V2OE5	304170000	6.36
340	9450715	GENCO BAY	A8UY3	636014572	9.90
341	9515010	LINGEDIJK	PCGG	245947000	5.80
342	9118496	CHRISTINA	LIJG3	259372000	7.21
343	9010931	JANNE WONSILD	ICWB	247005000	5.21
344	9353125	CPO RUSSIA	2AJP8	235060249	11.51
345	9584865	KATHARINA SCHEPERS	5BNZ3	210169000	8.00
346	9147681	ANNEMIEKE	V2EM	304080796	7.84
347	8213603	KASHIMA BAY	H3KK	357925000	9.02
348	9328625	ARX	LXXR	253449000	7.29
349	9303651	BOW SANTOS	LAHJ7	259887000	9.43
350	9240251	PARMA	V2OZ9	304239000	5.64
351	9539080	WILHELMINE	LXWH	253023000	5.63
352	9138666	NORWAVE	V2BL9	304864000	6.40
353	9297204	THUN GOLIATH	PBJV	244878000	6.75
354	9306328	CIMBRIA	V2CC7	304981000	6.70
355	9309215	CLIPPER BOURGOGNE	9HUL9	249548000	5.40
356	9384435	RN ARKHANGELSK	5BJQ2	212097000	9.92
357	9172210	DORIS	LAGP5	259896000	8.75
358	9133599	BITLAND	PBHJ	244700000	5.77
359	8504947	ILKA	DIZZ	218179000	4.11
360	8920555	STOLT KITE	ZCMW9	319206000	6.20
361	9404065	DORIS SCHEPERS	V2DS2	305107000	7.34
362	9300154	JOHN RICKMERS	V7JC2	538090194	11.00
363	9256066	LIGOVSKY PROSPECT	A8AP5	636011641	14.82
364	9263605	THUN GENIUS	PBKM	245934000	6.75
365	9255787	HERM	V2BY2	304707000	7.10
366	9428437	NORDIC THERESA	9HGA9	256934000	7.00
367	9138214	BALTIC SAILOR	ZDFP3	236196000	5.02
368	9369526	RICHELIEU	ZDHS7	236354000	5.40
369	9525508	VORTEX	2CVS9	235076195	4.78
370	9122552	ROTTERDAM	PDGS	246167000	8.00
371	9604108	EVER LEARNED	2GNG3	235098885	14.23
372	9399210	CMA-CGM PEGASUS	9HA2126	248013000	15.50
373	9472189	COSCO EXCELLENCE	VRJT8	477135600	15.50
374	9215919	THEKLA SCHULTE	9VPY3	565473000	11.50
375	9301835	SANTOS EXPRESS	VRCF6	477581400	12.60
376	9280603	CMA-CGM CHOPIN	9HA3373	229488000	14.60
377	9295402	JPO CANOPUS	A8GU5	636090860	12.50
378	9565065	VALE SOHAR	V7ZP8	538004888	23.00
379	9504035	WES CARINA	V2FJ9	305697000	8.00
380	9166792	SKAGEN MAERSK	OYOS2	219821000	14.52
381	9484534	ROSA	D5AY3	636015467	12.60
382	9302255	HANSE SPIRIT	C4WP2	212644000	7.30
383	9436197	SUSAN BORCHARD	V2QE6	305445000	7.34
384	9321407	HUDSONBORG	PHGD	246534000	6.01
385	9319868	CANOPUS	V7DF6	538005381	7.29
386	9419280	BEATRIX	PBTQ	246598000	8.19
387	9324215	CHEM VENUS	HOIX	353772000	9.72
388	9255517	SEYCHELLES PIONEER	S7SQ	664288000	11.70
389	9610638	OCEAN SATOKO	3EYY6	373445000	11.00
390	8420804	BERGE STAHL	2EZE5	235089333	23.04
391	9320300	CLIPPER TARGET	C6R2086	308598000	9.70
392	9282508	BRITISH ROBIN	MGSH7	232156000	15.04
393	9313785	WAVE	PHBZ	246264000	5.95
394	9413559	NS ANTARCTIC	A8SA9	636014191	14.84
395	9305556	STENA ARCTICA	2GXH5	235101274	15.42
396	9244207	CONMAR HAWK	VQGH9	235613000	6.99
397	9388314	BOW LIND	9V9234	563760000	12.07
398	9190365	SUSAN	PHPY	244101000	6.19
399	9306005	ARNARFELL	OZ2048	231355000	8.50
400	9625231	HOOGVLIET	PCRO	246458000	5.42
401	9164550	PIONEER BAY	V2NV	304116000	6.65
402	9367243	LYDIAN TRADER	2FPJ5	235093146	6.00
403	9306445	CATALINA D	CQHH	255805583	6.70
404	9418509	AKSAZ C	9HIE9	249018000	6.92
405	9005730	FERRO	8PAJ7	314415000	5.00
406	9624005	DONATA SCHULTE	5BBX4	212274000	8.50
407	9155987	KATRIN	9HA3001	229025000	5.74
408	7810208	WILSON BAR	9HWW6	248937000	6.75
409	9189574	SVEN-D	PBVV	246636000	5.91
410	9020429	ROLAND ESSBERGER	CQZU	255817000	6.14
411	9354478	IDA RAMBOW	DFHR2	218098000	8.71
412	9276573	MINERVA ELEONORA	SWAK	240175000	14.75
413	9215282	BOW SEA	9VJY8	565028000	13.30
414	9236999	RAS MAERSK	OXBL2	220188000	11.82
415	9486207	JULIA	5BHT2	212600000	5.60
416	9375604	GOTLAND ALIYA	C6YU4	311045400	13.48
417	9294692	NORDIC INGE	OVTT2	220384000	7.00
418	8922357	CERVANTES	MKWZ5	232722000	6.66
419	9228801	BALTIC SKY I	9HCD7	215096000	10.85
420	9395343	FIONIA SEAWAYS	2BQZ6	235068575	6.90
421	9424869	OPALINE	9HA2478	248701000	7.40
422	8914142	CARINA	V2UF	304010318	5.08
423	9125085	WILSON CORPACH	V2NA4	304302000	5.67
424	8918734	ZILLERTAL	PBFB	246230000	7.22
425	8906250	SEA BREEZE	8PTW	314241000	4.61
426	9288356	ENERGY CHAMPION	MJUZ7	235009420	12.22
427	8806084	JOBBER	UUAY9	272734000	3.00
428	9226188	PRUDENCE	PBLF	244402000	3.44
429	8904408	MEKHANIK BRILIN	UCOO	273114600	5.05
430	9214989	BUGSIER 21	DPCN	211327660	3.05
431	8920531	STOLT DIPPER	ZCMY3	319036000	6.20
432	9003287	TWAITE	PICD	244922000	3.04
433	9527025	MAERSK LINS	VRKQ5	477938500	12.50
434	9622629	OOCL CHONGQING	VRLZ4	477832400	15.53
435	9454412	CMA-CGM LAPEROUSE	FLTH	228345800	16.00
436	9434943	MAERSK NITEROI	VRFW5	477634900	11.50
437	8914568	BRUARFOSS	V2PS8	304260000	7.48
438	9011985	ERIC HAMMANN	DQFF	218715000	3.55
439	9120982	AQUAGRACE	3FGN5	373888000	18.17
440	9576272	SUPER GRACE	VRJO9	477847200	14.50
441	9448803	COSCO PRINCE RUPERT	VRID6	477351400	14.61
442	9472282	ATHENS	V7UE2	538001529	18.32
443	9264714	RUMBA	ZDNM7	236111978	7.22
444	9428451	KARINA THERESA	OUPL2	220648000	7.60
445	9143740	DISCOVERY BAY	C6OP3	309785000	8.61
446	9380594	STEEL	9HHN9	256995000	11.52
447	9145542	WILSON RUHR	8PTA	314218000	4.35
448	9240732	FIGARO	J8B4640	376083000	3.59
449	9301598	FINNLAND	MLGJ9	235010600	5.70
450	9271963	SAMSKIP AKRAFELL	5BYT3	212201000	6.65
451	9452517	SOCRATIS	V7ZK2	538004843	13.00
452	9126479	SANTA GIOVANNA	DGGH	211651000	11.55
453	9606534	CLEARWATER BAY	VRKP5	477978700	10.03
454	9188506	HANNI	DHMW	211286440	7.09
455	9168922	NAVION HISPANIA	C6XS2	311020100	15.65
456	9238052	SARPEN	C6RZ8	311261000	13.50
457	9216846	OPDR TENERIFE	5BEM3	209283000	7.40
458	9251822	AFRA WILLOW	D5DV2	636015977	14.87
459	9162681	BORUSSIA DORTMUND	C4RW2	210001000	6.69
460	8913485	WILSON MAIN	8PRQ	314182000	4.55
461	9380063	MINERVA EMILY	9HA3057	229084000	12.62
462	9186388	LAPPLAND	DPLG	211284230	7.09
463	9212486	PATRICIA ESSBERGER	DALU	211636000	6.59
464	8416786	ORANESS	OWAB2	220018000	4.68
465	9187394	STENSTRAUM	ZDEN8	236006000	8.45
466	9116022	WILSON HERON	9HJW9	249075000	5.75
467	9120102	NOEST	PHFN	246523000	4.13
468	9087362	OSTRAND	SECG	265413000	6.60
469	9187916	TRANSANDROMEDA	ZDNJ3	236111944	6.31
470	9241695	KEREL	9HXJ7	215681000	11.21
471	9201956	DAAN	PFBH	245271000	4.34
472	9392640	ORAMALIA	ZDNQ4	236112003	7.01
473	9190327	ARDEA	PCHW	246414000	4.27
474	8107177	VOS SYMPATHY	PHDJ	246391000	5.00
475	8503797	PRIDE OF BRUGES	PGJW	244387000	6.08
476	9073220	KORIANGI	3FCR8	351300000	4.22
477	9655511	SIBUR TOBOL	D5CM8	636015737	10.90
478	9327396	BALTIC FREEDOM	C4JZ2	212371000	10.85
479	9439307	WESER	A8PN9	636015914	8.70
480	8818075	ELBETOR	V2OQ9	304655000	5.08
481	9313682	SUDERAU	V2BE1	304797000	5.50
482	9032458	NAUTICA	J8B3260	375156000	3.55
483	8710998	MOSVIK	V2PT9	305203000	4.87
484	8503096	RMS WEDAU	V2BU	304010685	4.21
485	9458078	MAERSK ELBA	V7RT6	538003576	15.50
486	9306079	ADELINA D	MNRP6	235011610	10.20
487	8707771	SYROS WIND	9HGQ9	256959000	5.01
488	9503732	HANJIN GREEN EARTH	2GHI8	235097401	15.52
489	9155121	MAERSK MISSOURI	WAHV	369708000	13.50
490	9188518	CONTAINERSHIPS VI	DABH	211315100	8.94
491	9326952	JOHN LUKAS DEDE	V2BH2	304827000	8.71
492	9624134	DCI DREDGE XXI	AVLK	0        	6.50
493	9379973	CYPRESS GALAXY	3ELY4	356768000	9.48
494	9013660	FRANCES WONSILD	IBFW	247003000	5.20
495	9312078	PATRICIA	9HNM9	249232000	8.40
496	9299769	BAREILLY	A8KG7	636013054	14.92
497	9311024	STOLT STRENGTH	A8XU2	636014974	11.02
498	9553048	ORIENTAL ACACIA	ZGBL2	319014800	8.38
499	9363364	YM VANCOUVER	C4ZL2	212714000	12.60
500	9110535	SEPEHR PAYAM	3FHS4	352922000	4.90
501	9436290	SAMSKIP ENDEAVOUR	5BEY3	209380000	7.34
502	9202077	REYKJAFOSS	ZDNY3	236648000	7.70
503	9191668	DUTCH EMERALD	PCIP	246436000	6.45
504	9581760	SEA TRIUMPH	3EZA9	373802000	18.24
505	9578684	CAPE VALENCIA	3EUE9	373498000	18.24
506	9195858	FLUVIUS TAW	PCNY	244810589	6.20
507	9288710	DELTA CAPTAIN	SYEF	240305000	14.60
508	9229843	NINGBO EXPRESS	DHEB	211382280	14.50
509	9549619	AGATE	UBZE	273333440	6.40
510	9053828	BEATA	5BUN3	210351000	6.16
511	9108063	PIRITA	C4LF2	210716000	7.28
512	9172222	FINNSTRAUM	LAJF5	257409000	8.75
513	9360972	3 OAK	9HA3214	229296000	7.82
514	9207390	MN COLIBRI	FNHO	228057000	5.00
515	9369083	ALEXIA	PJSX	306849000	7.45
516	9265249	STELLA VIRGO	PHKQ	244267000	6.25
517	8001024	CSL ELBE	9HJE8	256038000	8.48
518	9017393	WILSON SKY	P3VJ8	209432000	5.64
519	9617296	RMS ROTTERDAM	5BJP3	209304000	5.55
520	9388534	ELBTRADER	V2DW4	305355000	7.30
521	9184548	FRIO MOGAMI	3FSC9	357735000	7.52
522	9374909	AMADEUS SILVER	PBCM	244810730	5.00
523	7392610	FREYJA	9HCD6	248384000	5.22
524	9438573	KATHARINA	V2DQ5	305305000	7.40
525	9302657	EDITH KIRK	2DST9	235081745	11.21
526	9435753	HHL AMUR	D5CV2	636092457	8.00
527	9008471	DELTAGAS	V2KA5	304270000	6.20
528	9504061	WES GESA	V2FN8	305735000	8.00
529	9148207	OSTEREMS	V2GO8	304032000	5.67
530	9142497	KLIFTRANS	PCDB	245132000	4.64
531	9455674	TUCANA	PBAQ	245050000	5.42
532	9339624	HANDYTANKERS GLORY	C6WH4	309553000	11.79
533	9213715	MARLIN	V2OF7	304108000	3.20
534	9326940	ALIDA	D5AQ6	636092340	8.71
535	9136113	STELLA WEGA	PHHQ	245284000	6.00
536	8920579	STOLT KITTIWAKE	MAIT	235050032	6.20
537	7411375	WILSON SPLIT	8PVU	314293000	6.97
538	9195690	FRI OCEAN	C6VU7	309467000	5.22
539	8002731	ATLANTIC	OZ2060	231015000	5.36
540	8904393	MEKHANIK SEMAKOV	UCOZ	273113800	5.05
541	9691448	OBELIX	OWOZ2	219018969	2.60
542	9153862	MAERSK KALMAR	PDHP	244298000	14.03
543	9622590	OOCL BRUSSELS	VRLJ3	477182300	15.50
544	9321237	MOL CREATION	C6WD9	309046000	14.54
545	9241815	CIELO DI MILANO	IBDS	247095800	11.10
546	6930520	ELEKTRON II	LFWW	258208000	3.02
547	9367176	OOCL KUALA LUMPUR	9V7671	566747000	14.02
548	9444742	SANTA CRUZ	LXCA	253011000	13.80
549	9197442	MARNE	V2OV1	304719000	5.55
550	9461879	APL GWANGYANG	9V9374	566319000	15.53
551	9232577	DUBLIN EXPRESS	DDSB2	218023000	12.50
552	9225421	ARIES	V7MA2	538090288	11.52
553	8613322	MSC MANU	3FFQ2	373162000	14.35
554	9263576	LECKO	PBKR	244063000	5.85
555	9295945	ALLEGORIA	A8IX5	636091048	14.00
556	9428669	BEAUTRITON	PHQC	246215000	6.54
557	9431630	MARFRET MARAJO	FNOP	228349600	9.35
558	9422677	NORDIC MARI	C6YC7	311029600	9.55
559	9448695	E.R. VISBY	D5AT3	636092345	8.60
560	9548304	ABIS CUXHAVEN	PBYB	246670000	6.05
561	9384215	KHUZAMA	A8NA9	636013449	22.50
562	9573634	ATLANTIC	PCIR	246757000	5.82
563	9013658	COSTANZA WONSILD	ICWG	247007000	5.21
564	9375989	NORDIC SOLA	LAIS6	258715000	5.65
565	9431044	BESIKTAS ZEALAND	9HA2216	248163000	9.75
566	9145554	WILSON MAAS	8PSZ	314217000	4.35
567	9186728	HORNISSE	DDPU	211472000	8.36
568	9420057	HOEGH COPENHAGEN	LAIJ7	257368000	10.02
569	9373280	HATHOR	PHIY	244176000	5.42
570	9529190	MOANA	PBOT	246063000	5.64
571	9327205	TROY	9HGQ8	215964000	5.70
572	9244192	CONMAR FJORD	VSZP7	235480000	6.99
573	9299898	PELAGOS	SZSW	240335000	13.60
574	9285201	SUPERIORITY	2GJZ8	235098061	5.89
575	9351414	HELLESPONT PRIDE	V7JO7	538090208	14.52
576	8713809	COPERNICUS	ELYM8	636011343	4.37
577	9197777	NIKAR G	V2OD4	304111000	5.30
578	9380570	STYLE	9HBE9	256715000	11.52
579	9218234	EEMS TRAVELLER	PECH	246498000	4.35
580	9463877	CK PEARL	PCPQ	246807000	4.15
581	8702252	SORMOVSKIY-3064	UIYD	273454300	4.13
582	8815786	DOLFIJN	V2PT6	305198000	4.90
583	9292943	CEPHEUS J	MCKF6	235775000	7.36
584	9006368	CELTIC CRUSADER	2GGS3	235097248	5.47
585	9371335	NAXOS	SVBZ8	241338000	5.57
586	9675963	FENNA B	PCTE	246918000	2.61
587	8215948	HAM 601	PENA	244972000	3.01
588	9619921	MARY MAERSK	OWJE2	219018692	16.03
589	9480186	MSC BARCELONA	A8ZU9	636092269	13.52
590	9337597	GALANI	9HA3640	229821007	10.90
591	9606924	NORWEGIAN GETAWAY	C6ZJ4	311050900	8.60
592	9210086	CELINA STAR	D5GB9	636016415	11.50
593	9497177	EMILIE BULKER	2DNX6	235080614	10.15
594	9275024	NEDLLOYD ADRIANA	A8DG6	636090704	11.50
595	9321512	EVELYN MAERSK	OXHV2	220496000	16.00
596	9467299	CSCL SATURN	VRJS5	477274400	15.52
597	9404675	MSC MELATILDE	3FYE4	357240000	16.03
598	9209130	NAVION OSLO	C6RL5	311092000	15.10
599	9352418	MOL DESTINY	V7PS5	538003278	12.60
600	9608312	DA KANG	VRMA6	477463100	10.52
601	9445980	MORNING LADY	3FKC3	356473000	9.00
602	9322542	JORK RANGER	C4FA2	209696000	7.33
603	7924401	WIEBKE D	V2CN	304010786	3.29
604	9397511	LYSIAS	9HOV9	249294000	13.13
605	9460239	STEN SKAGEN	ZDJD9	236514000	9.27
606	9422275	LIANNE	V2CP4	305067000	4.80
607	9263928	TRANS ADRIATIC	C6YQ3	311041700	8.75
608	9130200	KAJA	9HA3670	229860000	5.68
609	9557393	NORTRADER	V2GF9	0        	4.10
610	9647289	AMELIE	2GFF5	235096881	10.10
611	9161065	GAS GALAXY	C6TD9	311601000	5.50
612	9125645	BOW BRASILIA	LAJQ7	257666000	6.79
613	9348302	BRO AGNES	PHNN	244374000	9.00
614	9387255	EAGLE SAPPORO	3FGO7	351115000	14.98
615	9322097	SICHEM MANILA	9VEZ6	565341000	8.71
616	9465411	BLUE MASTER II	V7ZQ4	538090451	11.00
617	9411836	BIJLBERG	PCPG	246718000	5.05
618	9483358	CONMAR AVENUE	V2GD2	305896000	9.50
619	9172715	NARIVA	C6PW2	309389000	10.02
620	9268277	PAUL E	ZDGV9	236283000	6.72
621	9383651	BOMAR SEDNA	9HHO9	256996000	6.35
622	9144689	NOR FEEDER	ZDHT9	236362000	6.55
623	9148178	MARRY-S	PDGU	246168000	4.95
624	9266554	ANNETTE	V2OL8	304577000	7.84
625	9293478	AMAZONITH	5BXB3	210688000	5.70
626	8404446	FAST JULIA	ONFO	205533000	4.12
627	9507374	WILSON ALICANTE	9HA2539	248835000	5.15
628	9194012	BOZDAG	9HKH8	256074000	9.80
629	9620669	SLOMAN DISCOVERER	V2FO2	305737000	8.00
630	9344497	ARKLOW RAINBOW	EICL	250000040	5.68
631	9423841	CAPEWATER	PBPQ	246346000	6.73
632	9009530	STOLT PUFFIN	ZCFE5	319643000	6.76
633	9401570	GASCHEM RHONE	DCVJ2	218533000	8.10
634	9624823	LADY ANNEKE	PCNQ	246855000	4.90
635	9169615	KAREN KNUTSEN	MDKK2	235808000	16.02
636	9261516	GIOVANNI DP	9HA3395	229545000	9.29
637	9084487	KOPERSAND	SNNB	261516000	4.64
638	9433339	ALESIA	ZDKX5	236111839	6.39
639	9195561	SEE-STERN	V2BF2	304809000	3.43
640	9558957	CHEMICAL MASTER	9VPA8	565014000	8.81
641	9073892	HAV MARLIN	C6XF7	311007600	4.64
642	9209453	CATHERINE	ONFR	205539000	7.80
643	9375824	EDZARD CIRKSENA	V2DE2	305181000	5.14
644	9272747	ELLEN ESSBERGER	CQLS	255805340	7.35
645	9496458	STEMAT SPIRIT	PBSO	246543000	4.92
646	9294393	SAFMARINE NOKWANDA	VRLA4	477552200	14.03
647	9302138	HANNOVER BRIDGE	3EIC8	372104000	14.04
648	9178290	SPIRIT OD CAPE TOWN	9V2504	564105000	11.00
649	9673355	ESNAAD 715	A6E2386	244650204	3.00
650	9290397	UNITED KALAVRYTA	V7EN7	538005501	17.07
651	9267297	JAN	V2HS9	305950000	7.36
652	9314363	ZEELANDIA	HBEI	269076000	8.39
653	9195547	BRAVERY	PCCO	246231000	3.40
654	9354363	ANNABELLA S	D5EY3	636092533	8.70
655	7901590	ZHEN HUA 14	J8B3443	375423000	8.50
656	9224441	SCF CAUCASUS	ELZP4	636011491	17.07
657	9433456	SOPHIA	V2DM8	305260000	7.40
658	9147679	WILMA	V2AB2	304080754	7.84
659	9320398	BUXHAI	9HA3289	229384000	13.50
660	9218789	MARICHRISTINA	9HWT9	249648000	14.12
661	9472139	COSCO DEVELOPMENT	VRIZ9	477950300	15.50
662	9558232	CAPE NORMANDY	HOIS	373954000	18.07
663	9232890	MSC ENGLAND	A8VG3	636091996	12.50
664	9443463	CSAV LEBU	VRGT2	477748400	12.60
665	9527623	MISSISSIPPI STAR	9HA2441	248621000	8.70
666	9201970	WESTEWIND	PBJC	245029000	4.34
667	9313216	FLOTTBEK	A8YI8	636092197	9.00
668	9375977	NORDIC SUND	LAIR6	258714000	5.65
669	9004308	STOLT EGRET	ZCFE4	319633000	6.76
670	9017628	BSLE SUNRISE	3EZY9	373172000	8.53
671	9346500	NORDIC SIRA	LAFX6	257941000	5.65
672	9431018	WILSON NANJING	9HA2627	215061000	7.40
673	9578062	SCHELDE	XXXX	0        	3.83
674	9394026	MEANDER	PHGQ	246547000	2.50
675	8207745	SAKHALIN	V3IU3	312792000	9.84
676	9173513	PUR NAVOLOK	P3TW7	212503000	5.50
677	9212498	CHRISTIAN ESSBERGER	DPPY	211631000	6.59
678	9299707	NS CONCEPT	A8FD8	636012383	14.92
679	9205885	FEDERAL KIVALINA	VRWK5	477762000	10.73
680	9288722	DELTA SAILOR	SXFY	240307000	14.60
681	8922254	STRAMI	C6UN9	311973000	5.45
682	9290438	SEASONG	9HBP8	215811000	14.92
683	9297589	ALANA	CQIH	255805557	8.70
684	8922266	ROMI	C6US6	308874000	5.45
685	9536363	NAVIGATOR GALAXY	D5DQ4	636015946	8.80
686	9268631	ACQUAMARINA	IBJJ	247102500	8.04
687	9256054	NEVSKIY PROSPECT	A8AP4	636011640	14.82
688	9156981	ROSSINI	P3SP8	212947000	4.65
689	8509002	POPRAD	SNBI	261479000	3.72
690	9377949	COOLWATER	PHMQ	245073000	6.74
691	9365477	PATERNA	9HOI9	215734000	8.40
692	9173214	KATI	9HA2779	215663000	5.63
693	7822421	WESTSUND	OUJB2	220124000	4.17
694	9251652	SEALING	DECO	211397660	11.00
695	8920543	STOLT PETREL	MVRC3	235050801	6.20
696	9302009	LS CHRISTINE	ZDHW4	236379000	7.04
697	9077460	APL GARNET	V7ZV9	538004927	13.52
698	9346005	CCNI VALPARAISO	A8PA7	636091524	12.00
699	9595034	ARTVIN	9HA2782	215678000	14.50
700	9168192	MAERSK PENANG	PDHU	244104000	12.50
701	9299927	MAERSK SEVILLE	D5DK9	636092474	14.00
702	9214317	BOW CHAIN	LASW5	257901000	10.71
703	9522972	ORE CHINA	9V9115	566206000	23.00
704	9411941	MINERVA VERA	SVAR9	240915000	17.17
705	9330276	STADT HAMELN	V2CH3	304220000	8.51
706	9396610	SHANTI	V2DL8	305253000	9.50
707	9229116	VOSSBORG	3ETY7	357365000	7.05
708	9483671	NORDIC STANI	5BMB3	209467000	8.00
709	9465291	MSC REGULUS	3EYG3	373068000	15.52
710	8516263	FRIFJORD	C6OQ6	309798000	3.70
711	9404663	MSC SONIA	3EUP7	353160000	16.03
712	7721249	MIKHAIL KUTUZOV	UCAB	273138000	9.88
713	9303247	ROMANTIC	SVGB	240223000	15.30
714	8869543	PYALMA	UIBN	273336400	3.85
715	9605152	MSC ANTALYA	VRME8	477220400	14.50
716	9199256	THESEUS	V2OU	304011027	4.49
717	9190353	BOUGA	ECMO	225328000	6.19
718	9268837	ALTENA	PCBK	245468000	5.80
719	9086801	DETTIFOSS	V2PM8	304159000	8.97
720	9328053	SLIDUR	V2CH4	305001000	7.33
721	9130810	NORDIC NORA	OXMW2	220235000	6.71
722	9344394	CELIA	V2DD5	305176000	5.63
723	9195729	VEDETTE	2DTN5	235081933	5.40
724	9308900	OW PACIFIC	OWNO2	219018272	7.41
725	9285639	MORNING COURIER	C6UI2	311921000	10.00
726	9191785	EPIC ST.JOHN	3FVE8	354133000	5.65
727	9218208	SIRIUS	V2QB3	304995000	6.63
728	9361756	ARKLOW FREEDOM	EIEX9	250001396	5.79
729	9125073	WILSON CARDIFF	V2LA9	304010986	5.67
730	9302671	CAPE BRASILIA	V7JS5	538090337	11.20
731	9313199	EILBEK	A8VH2	636091997	9.00
732	9435313	MASALLI	9HCP9	256791000	6.97
733	9328041	JORK RELIANCE	V2CL2	305033000	7.33
734	9184536	FRIO CHIKUMA	3FWG8	353306000	6.20
735	9113733	ATLANTIC COMET	C4BP2	209506000	6.55
736	9528495	NORDIC ERIKA	PBTX	246606000	5.31
737	9240548	MARGARETHA	V2GH4	305931000	7.46
738	9360441	HAFNIA GREEN	C4VJ2	210670000	11.97
739	9075357	RMS RUHRORT	V2DP6	305294000	4.45
740	9452775	YM MERCURY	9HA2392	248507000	6.65
741	9435557	OSTE	A8PN8	636091580	8.70
742	9201815	LADY CHRISTINA	PFAC	244003000	5.89
743	9522893	ORIENT DELIVERY	5BNY3	209745000	10.90
744	9539092	ADELINE	LXDL	253012000	5.63
745	8416798	PEAK OSLO	E5U2385	314043000	3.91
746	9221267	TERNVIK	OWIS2	219083000	8.70
747	9234305	NESTOR	V2AA8	304011028	4.49
748	9371294	SYROS	A8PW7	636013850	6.01
749	9677947	DUKE II	5BVM3	209855000	4.20
750	9568249	ELBEBORG	PBZJ	245297000	8.00
751	9461439	MSC VALERIA	3FFK4	370341000	16.00
752	9546461	CCNI BILBAO	PCSZ	246912000	9.69
753	9352004	MAERSK STEPNICA	OZDL2	219228000	14.52
754	9301938	MAERSK NEEDHAM	9VEZ2	565222000	11.50
755	9397602	CMA-CGM TOPAZ	A8RV4	636014169	12.62
756	9312808	NYK VESTA	3EJI4	372531000	14.52
757	9280665	CMA-CGM WAGNER	CQIJ	255805559	14.50
758	9504073	WES JANINE	V2FN9	305736000	8.00
759	9314234	CSCL ZEEBRUGGE	VRCS2	477690700	15.00
760	9433614	LILY ATLANTIC	HOWL	354774000	14.43
761	9305867	MINERVA RITA	SVBV9	241285000	13.29
762	9305312	MAERSK MONTANA	WCDP	367759000	13.52
763	9437050	CSAV RECIFE	A8UO3	636091922	13.62
764	9462043	APL BARCELONA	9V9402	566483000	15.50
765	9151096	DON 3	9HRD9	249406000	4.75
766	8700254	ZHEN HUA 26	VREG4	477177900	12.22
767	9406489	CAPE UNITY	3ENK4	355458000	18.17
768	9057123	ORANGE WAVE	ELPX7	636009894	9.32
769	9266267	JO BETULA	LAWQ5	258755000	9.90
770	9297357	BRITISH KESTREL	MGRL4	232160000	14.60
771	9126235	HJORDIS	OJHI	230351000	6.81
772	9298973	VOIDOMATIS	A8FX2	636012508	12.28
773	9688867	DAMEN HARDINXVELD 571712	XXXX	0        	3.20
774	9729257	DAMEN HARDINXVELD 571708	XXXX	0        	3.00
775	9105140	ISARSTERN	DQQC	218649000	8.60
776	9499656	ERACLEA	IITX2	247278500	5.00
777	9645798	STI VILLE	V7BD4	538005120	13.30
778	9113745	GERDA	DPGK	211226860	6.55
779	9215660	CAP TRAFALGAR	ELYX3	636015523	12.50
780	9169782	TERRY	9HJY8	256065000	8.70
781	9312377	ANNA	V2CY3	305143000	5.63
782	9210438	PLATINUM RAY	C6RC2	308726000	10.00
783	9228215	ORIENT SUNRISE	VRCC7	477282800	9.70
784	6605448	CYKLOP	SQLI	261195000	3.30
785	6605503	ZEUS	SQLH	261205000	3.30
786	9198458	WILSON LAHN	8PUO	314259000	4.77
787	9306017	HELGAFELL	OZ2049	231356000	8.50
788	9274800	SPARTO	P3VW9	209055000	13.60
789	9108740	BERGSTRAUM	LHTR3	259319000	7.21
790	9388479	NORDIC TRINE	9HFZ9	256933000	6.85
791	8711837	ZAPADNYY	V3MT6	312786000	5.34
792	9547776	NORTHSEA BETA	9HA2594	248971000	7.80
793	9354571	SICHEM AMETHYST	3EGQ6	372016000	7.77
794	9201774	GRANATO	IBOH	247661000	6.70
795	9425227	NIDA STAR	D5CP9	636092498	8.70
796	9376696	MAZARINE	LXMF	253396000	7.05
797	9433585	PINK STARS	V7RZ7	538003608	15.02
798	9256901	ANICHKOV BRIDGE	UBEL9	273323280	12.50
799	9192612	WILSON CADIZ	8PSY	314216000	5.67
800	9123805	NJORD	PHKY	244735000	7.28
801	9468372	HUNTER	OZLM2	219339000	3.50
802	1132579	STEMAT 71	XXXX	0        	2.40
803	9356610	BRO ALMA	PHNM	244352000	8.40
804	9125841	WILSON SAAR	8PUQ	314261000	4.35
805	9610339	SAN PADRE PIO	HBFI	269305000	7.20
806	8616635	SABINA	OJMJ	230989850	4.50
807	9375812	FOKKO UKENA	9HYA8	256586000	5.14
808	9379478	LS EVA	ZDHU4	236364000	6.10
809	9163697	DONGEBORG	PCGD	245413000	7.11
810	1133438	AMT VENTURER	LG2019	0        	5.70
811	9431719	RUDOLF SCHEPERS	V2DN6	305271000	12.80
812	9526887	MAERSK LIRQUEN	VRKB8	477423500	12.50
813	9627978	OOCL BANGKOK	VRME6	477220200	15.50
814	9295971	CMA-CGM AMERICA	5BNC2	210819000	12.50
815	9327310	GIZEMDENIZ SULTAN	V7AA5	538090457	6.29
816	9484522	LANA	D5BD7	636015503	12.60
817	9463035	MAERSK EUBANK	9V2245	563111000	15.52
818	9354399	SARA BORCHARD	V2BY8	304962000	8.70
819	9227302	SANTA REBECCA	D5GE4	636016435	12.50
820	9152181	SOUTHERN BAY	A8IO7	636091012	8.27
821	9442495	SANTA CRUZ	3FRS3	355821000	14.60
822	8758988	SEAFOX 1	2BZE7	235070675	2.91
823	9312406	SOUTHERN ZEBRA	H9DN	352254000	7.61
824	9287170	MICHELE D'AMATO	ICGY	247218300	14.40
825	9126223	LAURA	OJHH	230350000	6.81
826	9103685	MSC BRIANNA	3FVZ7	353612000	12.98
827	9242118	HS MEDEA	A8JQ9	636091120	14.60
828	9233818	PETROATLANTIC	C6SW7	311517000	14.50
829	9272761	LIESEL ESSBERGER	CQLN	255805250	7.35
830	9351452	HELLESPONT PROTECTOR	A8LD3	636091250	12.20
831	9444716	SANTA CLARA	DAJT	218432000	13.52
832	9020417	LISELOTTE ESSBERGER	CQIO	255805564	6.14
833	9252929	FEHN MIRAGE	ZDFC3	236017000	4.94
834	9267429	INDIGO	D5EH5	636016079	11.00
835	9131096	HAPPY BEAR	2EAA9	235083371	7.61
836	9285196	SENIORITY	2GJZ6	235098058	5.89
837	9393084	BW THAMES	9VNH6	563041000	14.70
838	9610341	SAN PIETRO	HBGM	269013000	7.20
839	9611278	AQUITANIA	9V9349	566097000	10.10
840	9274628	MAERSK ERIN	OUWG2	219410000	10.60
841	9160932	BRO ATLAND	OZFQ2	219245000	8.70
842	9245275	CAPRI	V2ED7	305394000	7.68
843	9010929	ZIRCONE	ICSZ	247278000	7.11
844	9328649	ALEXANDER B	V2FE7	305654000	9.50
845	9555345	CHAROITE	UBAK5	273330940	6.40
846	9289790	NORDERSAND	ZDGO5	236265000	5.74
847	9138185	BALTIC SKIPPER	ZDFD5	236039000	5.30
848	9313864	SKAGENBANK	PHMB	245306000	5.95
849	9121883	MARGARETA B	V2NI	304418000	6.62
850	9014664	RHEINFELS	V2AI4	304010767	5.47
851	9404077	KARIN SCHEPERS	V2HS3	305148000	7.33
852	9267704	SMARAGD	PBKD	244967000	4.64
853	9242730	HEINRICH	ZDFF7	236165000	6.65
854	9379337	ICE POINT	ICIB	247226900	13.27
855	9011519	HAVSTRAUM	LECB3	257222000	7.01
856	9229544	DUTCH PIONEER	PBBK	244153000	2.63
857	8804787	SWIFT	MKZA7	232002165	3.89
858	9356579	JETSTREAM	PBYR	245604000	5.83
859	9195705	GEERT K	PBLT	244462000	5.42
860	9507051	BRENT	PBNY	245931000	4.30
861	9342102	EN AVANT 1	PHDP	246375000	2.15
862	9060687	WILSON MOSEL	9HGJ9	256951000	4.79
863	9507063	GINGER	PBNZ	245932000	4.29
864	9653202	ANNA B	PCRU	246895000	2.39
865	9461491	HANJIN HAMBURG	3EZX3	354840000	14.52
866	9352030	MAERSK SALINA	VRGW2	477770300	13.00
867	9372494	MSC SORAYA	3ESD8	370271000	14.52
868	9604110	EVER LEGION	9V9725	566970000	13.50
869	9282431	CAPE MARIA	V7UC3	538003928	17.77
870	9231494	EM CORFU	P3CF9	209351000	11.50
871	9294381	SAFMARINE NOMAZWE	VRKZ7	477552800	14.03
872	9295268	CHICAGO EXPRESS	DCUJ2	211839000	14.61
873	9333383	JONNI RITSCHER	A8JT7	636091136	10.86
874	9297371	BRITISH EAGLE	MGSM5	232168000	14.90
875	9428657	BEAUTRADER	PHQD	246232000	6.54
876	9301483	MSC PARIS	CQIT	255805569	14.50
877	9443475	CSAV LINGUE	VRGR3	477744200	12.60
878	9210270	NORDKAP	V2GC6	305888000	7.81
879	9003275	TROUT	5BHX2	210583000	3.02
880	9371610	STEN ARNOLD	ZDIB2	236407000	8.89
881	9318149	ORPHEAS	A8LA5	636013157	17.30
882	9250098	CONTAINERSHIPS VII	OJKI	230948000	8.90
883	9160724	LADY RACISCE	V7FC9	538001908	9.51
884	9339038	WMS GRONINGEN	C4NV2	209840000	7.40
885	9188099	STENA SIRITA	C6AG7	311000038	15.73
886	9112882	DUTCH FAITH	PDTM	244281000	5.50
887	9255880	ALFA ITALIA	C6SO8	311416000	14.32
888	9464376	BALTIC SWIFT	5BPF2	212132000	10.85
889	9467603	ORIENT TRIBUNE	5BEQ3	209263000	9.80
890	9656498	ROLLDOCK STAR	PBIK	245732000	5.67
891	9374014	BOMAR VENUS	9HA2648	215135000	6.58
892	9658094	ABIS DUISBURG	PCPT	246872000	6.45
893	9214745	CHEMTRANS RIGA	A8JC4	636013195	11.82
894	9677399	ALICE	PCVA	244790715	6.14
895	9376024	MISTRAL	V2GB9	305880000	8.70
896	9355135	SIGAS SILVIA	S6ES6	565494000	6.16
897	9211066	FRI KARMSUND	5BBW4	210852000	6.36
898	9170597	TRANS IBERIA	9HA2566	248889000	10.08
899	9195406	HELENE G	V2GO2	304021000	5.30
900	9430985	WILSON NEWPORT	9HA2465	248676000	7.40
901	9220550	UNION SAPPHIRE	ORLL	205001000	4.00
902	9086605	LADY KIRSTEN	PCUR	244808000	5.30
903	9167332	TRANSMAR	ZDKA6	236582000	5.69
904	9281956	JOSCO NANJING	VRYY2	477239000	12.05
905	9139335	LEESWIG	V2GF	304010714	6.11
906	9137193	SCOT EXPLORER	VQUR2	235007950	4.25
907	9640774	SANDY M	2FFC5	235090733	3.10
908	9431599	SCHOKLAND	PBWZ	246655000	4.92
909	9321495	ESTELLE MAERSK	OVXO2	220478000	16.50
910	9216470	SICHEM CROISIC	9HYL9	249704000	7.35
911	9354454	ANNA SIRKKA	DDSW2	218031000	8.70
912	9453509	PROTEAS	A8WD7	636014720	14.90
913	9516959	BELMAR	9HA2852	256377000	13.60
914	9389306	OPDR TANGER	5BAH2	212818000	7.40
915	9164445	GLORY PEGASUS	3FIL8	354780000	12.80
916	9440605	ICE RUNNER	V2EF6	305414000	7.40
917	9306380	CASSANDRA	V2OZ3	304767000	6.70
918	8918980	MSC JORDAN	HPMK	355194000	11.98
919	9362334	MARFRET GUYANE	FNMV	226324000	9.36
920	9232072	PRAHA	A8CP5	636090677	13.00
921	9148128	LADY ISABEL	PDGZ	246248000	5.89
922	9377420	MAERSK HIRADO	9V8313	566013000	21.03
923	9194983	COSMIC	SVXX	239738000	16.02
924	9156187	BERIT	ZDHX2	236386000	4.80
925	9321861	GINGA COUGAR	3EAG7	353108000	10.08
926	9258234	MARGRETE	D5FD4	636092543	7.33
927	8866644	KALEVALA	UISV	273333800	3.85
928	8518297	JUMBO	8PAJ8	314416000	4.96
929	9196266	BBS SKY	C6AM4	311000087	4.64
930	9527673	ARKLOW FIELD	EIKQ4	250002286	7.35
931	9117973	RMS RAHM	V2DT9	305335000	4.45
932	9419125	SEVEN ATLANTIC	2CBP2	235071342	8.00
933	9171474	TOUR POMEROL	9V9183	563385000	8.31
934	8703139	DOUWENT	D5EA6	636016022	3.70
935	6809769	CHRISTOPHORUS	PDKQ	245121000	4.10
936	9527776	BLACK STAR	9HA2911	256714000	7.50
937	9215347	JAEGER ARROW	C6RM7	311104000	11.00
938	9308754	ACAVUS	MJCT3	232491000	8.51
939	9374727	FRAKT SUND	5BBD4	210803000	5.80
940	9344435	BRO ANNA	PHNF	245010000	8.99
941	9503524	EEMS SPRING	PHPL	245465000	4.85
942	8904422	MEKHANIK PUSTOSHNYY	UCBM	273114000	5.05
943	9328974	FIONIA SWAN	OVJG2	220441000	8.60
944	9228930	MAIMITI	PBIJ	244312000	4.64
945	9592563	REESTBORG	PCSH	246837000	9.74
946	9356622	EKFJORD	LAJX7	257555000	8.40
947	9234422	EXPANSA	PBBZ	245343000	4.87
948	9251389	MOL EXPEDITOR	VRMQ4	477519700	13.50
949	9454436	CMA-CGM MARCO POLO	2FYD5	235095231	16.00
950	9446635	FRONTIER OASIS	3FLC2	371910000	18.24
951	9314246	XIN BEIJING	VRCS5	477768100	15.03
952	9467251	CSCL VENUS	VRIE8	477266800	15.50
953	9153850	MAERSK KIEL	VRGJ6	477711600	14.03
954	9451044	CHIARA	A8XF4	636014886	14.50
955	9407287	KING DANIEL	V7MU2	538090316	12.20
956	9114751	EDUARD ESSBERGER	CQNT	255803990	6.79
957	9342580	ORANGE SUN	A8HY8	636012804	11.40
958	9182966	STAR ISMENE	LANT5	257532000	12.30
959	9110389	MSC KATYAYNI	3FGK8	351675000	10.00
960	9196711	STOLT VIKING	ZCON9	319515000	10.33
961	9106936	MERLE	UBOK4	273338780	5.50
962	9195468	RMS TWISTEDEN	V2DN	304347000	4.09
963	9261114	STENHEIM	ZDFR8	236202000	8.90
964	9297553	MONTEGO	SYSF	240610000	13.60
965	9150511	WILSON BRAKE	9HJI5	249879000	5.49
966	9315018	ELITE	PHDA	246363000	8.70
967	9234410	FRI MOON	PJDR	306838000	3.70
968	9268875	CORA JO	PJTO	306777000	5.80
969	9173197	MARINDA	PCFS	245182000	4.34
970	9376933	SICHEM DUBAI	9HOJ9	249276000	8.71
971	9319428	AMMON	PBCW	244027000	5.42
972	8820286	AMETYSTH	5BAM3	210320000	5.47
973	9145138	AJOS G.	V2CF	304503000	4.94
974	8919855	PAPER MOON	V2PR2	304010672	4.44
975	8508400	RMS LAAR	V2OB7	304511000	4.21
976	9015436	EILSUM	V2AB8	304010439	4.35
977	9428889	BOMAR MERCURY	9HA2880	256541000	8.00
978	9129990	LARS	PG3786	246859000	2.60
979	9365269	WAPPEN VON FLENSBURG	9HA3642	229823000	7.42
980	9377951	THRESHER	PHGW	246295000	3.66
981	9410753	CMA-CGM CALLISTO	2CKM8	235073571	15.50
982	9665592	THALASSA HELLAS	9V2228	563377000	15.80
983	9431757	APL INDONESIA	V2EC7	305386000	12.60
984	9355393	SOUTHERN ATLAS	3EEG9	371896000	7.61
985	9401142	MSC GAIA	3EXO7	353051000	14.40
986	9462720	YM UPSURGENCE	BLHJ	416465000	13.00
987	9120803	ORE MOATIZE	9V9043	564570009	17.40
988	9147734	CRYSTAL SKYE	9HA2161	248070000	7.55
989	9565754	CHEMROAD HOPE	ZGBZ	319842000	11.37
990	9209116	AGNES	V7DC9	538005368	13.93
991	9213583	MSC MIRA	LXME	253215000	14.00
992	9246267	FEHN CASTLE	V2BV1	304933000	3.69
993	9374739	ESPACE	PBDC	244860000	6.10
994	9299903	DEEP BLUE	SWDU	240350000	14.58
995	9521758	REGALICA	A8ZQ5	636015272	8.25
996	9135901	ALIANCA PEARL	A8II9	636090983	11.14
997	9321158	SUCCESSOR	C4SZ2	212089000	18.20
998	9322712	BRO NORDBY	OXHE2	220498000	8.90
999	9077575	KAPITAN YAKOVLEV	9HER5	249753000	6.70
1000	9251561	BRITISH EXPLORER	VQGB2	235606000	10.85
1001	9336696	ORAHOLM	OYAA2	220442000	6.28
1002	9306316	CINDIA	V2BV6	304946000	6.70
1003	9426726	ATHENA	V7UX4	538004052	12.46
1004	9269374	MARTE	9HA2059	249891000	6.49
1005	9344526	ARKLOW ROGUE	EIGD	250000962	5.68
1006	9171101	NORDICA	ZDFN2	236188000	5.50
1007	9114713	BRIGGA	V2PS	304913000	5.80
1008	9612545	ABIS BRESKENS	PCJN	246778000	5.35
1009	9362580	SUNERGON	PHDF	246374000	5.00
1010	9388015	ENERGY PANTHER	2AVS9	235063333	11.00
1011	9301859	MANILA EXPRESS	VRCX7	477830800	12.73
1012	9215268	BOW SKY	LAFZ7	259787000	11.52
1013	9301469	CMA-CGM L'ETOILE	9HA3184	229263000	11.50
1014	9388352	MOL CONTINUITY	3ESS2	370407000	14.52
1015	9425497	PERSEUS N	A8PR8	636091594	9.80
1016	9434905	MAERSK NIAGARA	VREO9	477170400	11.50
1017	9168221	MAERSK PATRAS	MYSU5	232558000	11.60
1018	9483669	NORDIC PHILIP	5BZH2	212018000	8.00
1019	9156993	PUCCINI	P3SN8	212946000	4.65
1020	9289946	MAERSK SARNIA	D5DK7	636092472	14.10
1021	9283693	RIO TESLIN	A8JS6	636091130	11.50
1022	9399260	NCC NOOR	HZED	403512001	12.50
1023	9654567	FRONT AVON	V7AY7	538005095	13.30
1024	8313221	POLA MED	9HA3160	229222000	10.13
1025	9310276	PANASIATIC	V7CB2	538005231	14.43
1026	9080493	CHAMPION TRUST	LALF7	257681000	12.06
1027	9513139	SUEZ GEORGE	V7DU6	538005435	17.00
1028	9212589	PROSPERO	SLZU	265822000	9.25
1029	9466221	TINA	PBYP	245301000	5.40
1030	9305568	SCF BALTICA	A8IA5	636012813	15.42
1031	9502843	PRETTY LAMB	3EWG7	373656000	10.80
1032	9196448	SICHEM CHALLENGE	9VAA5	565327000	8.56
1033	7382500	WILSON RIGA	8PQT	314159000	6.96
1034	9310159	DHT HAWK	VRDB6	477898400	20.88
1035	9230141	GLORY ONE	A8VW3	636014681	13.93
1036	9268863	EMS	V2DB7	305162000	5.74
1037	8215728	BALTICA HAV	C6QV7	309985000	4.18
1038	9168116	WILSON RHINE	8PUP	314260000	4.35
1039	8918605	VITTA THERESA	9VHR9	565617000	4.36
1040	9425502	TORM GYDA	OWDP2	220638000	11.30
1041	9377030	BOMAR MARS	9HCM9	256784000	6.50
1042	9191943	VIGOROSO	ZDIK3	236451000	6.10
1043	8605478	SWEDICA HAV	C6VU6	309584000	4.22
1044	9502673	CANSU Y	9HVX9	249616000	5.70
1045	9208112	BALTIC COMMANDER I	P3DN9	209901000	11.20
1046	9110975	MSC JAPAN	3ECR5	371443000	11.70
1047	9206774	AUTOSKY	CQQA	255801480	7.35
1048	9624835	LADY ALEXANDRA	PCES	246684000	4.90
1049	9528483	WIDOR	5BSH2	212423000	5.30
1050	9298193	SEASHARK	DEIG	211135000	11.00
1051	9390305	STOC MARCIA	C4XG2	212123000	6.05
1052	9420344	SHOREWAY	5BLH2	210921000	5.70
1053	9362140	THUN GOTHENBURG	PCRW	246257000	6.74
1054	9631981	MOL QUALITY	S6LT7	566882000	15.52
1055	9454424	CMA-CGM MAGELLAN	2DTI4	235081888	15.50
1056	9280627	CMA-CGM PUCCINI	9HA3374	229489000	14.50
1057	9363170	RIKKE THERESA	OVYC2	220515000	5.70
1058	9294824	POHORJE	A8IM4	636015181	12.52
1059	9434371	ANANGEL SEAFARER	9HA2562	248876000	18.20
1060	9508809	SKYLGE	PBVJ	246630000	7.20
1061	9457737	YM MOBILITY	A8XY6	636014997	12.00
1062	9453377	BLUE WAVE	5BGC3	209722000	14.25
1063	9280873	ASTRO PERSEUS	SVMD	240126000	17.10
1064	9266243	JO KASHI	9V2657	564919000	10.52
1065	9282493	BRITISH CORMORANT	MGRX2	232153000	14.90
1066	9465289	MSC CAPELLA	3EUI7	373031000	15.55
1067	9439151	CAROLINE ESSBERGER	PBUD	244024000	7.50
1068	9350771	FEMBRIA	MPTX6	235012220	6.00
1069	9183829	WEICHSELSTERN	CQLI	255804960	8.80
1070	9373321	CLARA K	PHJI	244424000	5.64
1071	9477866	CHESTNUT	5BQT2	212734000	10.40
1072	9480980	JOHANN ESSBERGER	CQKG	255804460	7.00
1073	9376464	PATRON	PHNP	244227000	6.08
1074	9286554	CHEM ANTARES	V7GU2	538002174	9.54
1075	9263382	MAR ELENA I	9HA3469	229634000	9.50
1076	9112466	MN TOUCAN	FNAV	227278000	5.50
1077	9191163	PHILIPP ESSBERGER	CQSJ	255714000	6.79
1078	9322152	TRIPLE A	V7JL6	538002543	8.71
1079	9339806	GRAND HERO	3EKW7	372857000	9.62
1080	9223435	RMS LAGONA	V2OM9	304154000	4.09
1081	9514755	NORDIC HAMBURG	5BXT2	210035000	8.00
1082	9657753	JB 118	C6ZX9	311071600	4.20
1083	9080675	LYRIKA	LYSE	277344000	4.05
1084	9525584	TANA	9HA2992	229015000	6.65
1085	8515283	PALLAS OCEAN	8PVF	314278000	5.27
1086	9215086	TORM RHONE	OYNR2	220559000	11.00
1087	9346512	NORDIC SAGA	LAFY6	257942000	5.65
1088	9201827	LADY CARINA	PFBV	244621000	5.87
1089	9224568	ALAM BUDI	9MEN5	533677000	12.67
1090	8415184	MARSCHENLAND	ONES	205489000	4.31
1091	9308637	MAERSK SOFIA	LXNQ	253298000	13.54
1092	9526942	MAERSK LAGUNA	9V9763	566338000	13.60
1093	9351581	MSC KIM	3EPZ	356205000	12.60
1094	9323015	HS BACH	A8ND8	636091403	12.30
1095	9632002	MOL QUARTZ	S6LT3	566955000	15.52
1096	9595498	EVER LAWFUL	9V9288	566732000	14.50
1097	9122605	MELINA	3FME5	372706000	13.03
1098	9625877	W-SMASH	D5EE3	636016053	14.52
1099	9290804	LOA	A8GI7	636015180	12.50
1100	9309423	MINERVA NOUNOU	SVBH9	241121000	14.82
1101	9227261	HAPPY FALCON	ZINK4	235485000	6.25
1102	9259898	PINK CORAL	9HPY9	249344000	11.00
1103	9102069	STOLT INNOVATION	ZCSP7	319489000	11.90
1104	9224166	ARKLOW VENUS	PIAN	244193000	6.36
1105	9227285	CAP DOUKATO	V7XV4	538004580	12.50
1106	8900969	ATLANTIC TRADER	V3UX	312710000	6.00
1107	9299434	MAERSK BRISTOL	OXPT2	219124000	9.52
1108	9667930	GLAFKOS	SVBR3	241253000	13.05
1109	8616568	OSPREY	LAEL7	259753000	10.10
1110	9461594	STEFAN SIBUM	5BQX3	209792000	8.00
1111	9477610	BALTHASAR SCHULTE	A8XR8	636092159	12.60
1112	8407814	SUMMER MEADOW	C6RN9	311121000	9.50
1113	9325908	PENELOP	C6VD8	309924000	14.80
1114	9431056	MAINLAND	9HSF9	249446000	7.40
1115	9009528	STOLT KESTREL	ZCMR7	319252000	6.40
1116	9433353	CECILIA	V2ED6	305393000	6.39
1117	8602476	BEATE OLDENDORFF	9HA3161	229235000	18.13
1118	9204714	TRANSPORTER	PHAL	245981000	8.20
1119	9318955	TRANSFORTE	ZDGR3	236270000	5.70
1120	9295452	TRANS EMERALD	9HA2565	248888000	7.40
1121	9199696	THEBE	V2OS	304011026	4.49
1122	9260067	CAPE BIRD	V7FA9	538090170	10.05
1123	9344368	FRIDA	V2BH8	304819000	5.63
1124	8403569	CEMFJORD	P3ZG9	209642000	4.35
1125	9341172	KALKVIK	OZ2104	231791000	7.84
1126	9165308	BF VICTORIA	V2CV4	305117000	6.55
1127	9356529	ALANA EVITA	PBRU	246443000	5.05
1128	9313876	STEENBANK	PHDG	246125000	5.95
1129	9220354	TURCHESE	IBLE	247604000	8.03
1130	9035266	OLUWASEUN	5NMC6	657111700	7.51
1131	9138783	ARK FORWARDER	5BQY3	212184000	7.42
1132	9129392	CORAL MILLEPORA	PDMK	246397000	6.97
1133	8203256	ARISTOTE	C6LI2	308289000	3.45
1134	9136101	FAST JEF	ONEE	205465000	4.70
1135	9163623	PS SEA	C6AZ6	311000201	4.70
1136	9006306	SULA	C6ZR9	311064400	5.47
1137	9557367	FEHN CALEDONIA	V2GH5	305936000	4.10
1138	9641235	SAFMARINE HIGHVELD	V7ZU2	538004914	14.00
1139	9337028	JONA	A8KV9	636091219	11.50
1140	9360142	CMA-CGM HERODOTE	MFEP	235051085	9.36
1141	9176644	ANANGEL ETERNITY	SYPZ	237828000	17.66
1142	9504059	WES AMELIE	V2FN7	305734000	8.00
1143	9286920	BALTIA	9HMG9	249174000	13.99
1144	9298686	MAERSK IOWA	KABL	367606000	13.52
1145	9312810	NYK VIRGO	3EKK2	372744000	14.52
1146	9126247	MARJATTA	OJHJ	230352000	6.81
1147	9322011	VORONEZH	5BNG2	212357000	9.85
1148	9409326	PLEIADES SPIRIT	3FYP8	370852000	9.73
1149	9354375	ARA ATLANTIS	ZDIO6	236471000	8.70
1150	9335824	CHEMBULK MINNEAPOLIS	3ELA7	372894000	11.32
1151	9516404	COSCO BELGIUM	VRLT8	477427500	14.50
1152	9312456	STENA PERROS	ZCDU7	310554000	13.02
1153	9430363	SANTA ROSA	A8ZS7	636092266	13.50
1154	9168934	NAVION SCANDIA	C6XS4	311020300	15.65
1155	9314806	BALTIC MERCHANT	C4KB2	212227000	10.85
1156	9259991	BALTIC WAVE	9HDL8	215870000	10.85
1157	9473119	HARBOUR FIRST	CQKM	255804570	8.40
1158	9429223	CORSAR	V2QL4	305872000	8.70
1159	9416109	SONGA WINDS	V7ZP4	538004885	9.63
1160	9491927	BLUE TUNE	V2EU9	305566000	5.79
1161	9430947	WILSON NORTH	9HA2312	248313000	7.40
1162	9319416	BEAUMONT	MRJD2	235050609	5.41
1163	9005338	THEODORA	PHYG	244367000	7.06
1164	9017410	PERU	V2CW	305562000	5.64
1165	9479565	AMADEUS GOLD	PBKU	244810730	4.15
1166	9356878	KOSSAU	V2CV9	305122000	5.50
1167	8505915	SCANLARK	J8B3399	375354000	4.32
1168	9228590	MARIA THERESA	OWOX2	220052000	6.10
1169	9155676	SEA CHARENTE	PECB	246362000	3.70
1170	9390123	NESTOR	V2FB3	305620000	5.50
1171	9250050	LS CONCORDE	ZDHJ7	236329000	6.10
1172	9658276	TERRAMARE 1	5BUG3	209808000	3.20
1173	9384112	VALCADORE	ICIA	247228200	11.52
1174	8139388	HAM 602	PENF	245518000	4.09
1175	9454462	ELISE	V2DC7	305170000	4.76
1176	9162215	MAERSK KARACHI	VRGL4	477728400	14.04
1177	8902577	ATLANTA EXPRESS	ZCEL2	310677000	13.52
1178	9354923	CMA-CGM VELA	DFUM2	218694000	15.50
1179	9604122	EVER LOTUS	3FWH8	352135000	14.23
1180	9579559	ALMI ODYSSEY	D5DH4	636015880	17.02
1181	9307011	OOCL ANTWERP	3EFS3	353889000	14.00
1182	9601302	APL PARIS	9V9403	566704000	15.50
1183	9431824	APL SHANGHAI	A8SN5	636091766	12.60
1184	9215892	OCEAN PROMISE	MVLE2	235056954	11.50
1185	9477311	CSAV LARAQUETE	CQIU	255805570	11.00
1186	9501239	HANJIN SOOHO	2FFG5	235090767	15.52
1187	9267546	MESSINA STRAIT	PJMP	306084000	9.30
1188	9462691	YM UNIFORMITY	BLHQ	416468000	13.00
1189	9389291	OPDR LISBOA	5BAG2	212819000	7.40
1190	9370719	JIPRO ISIS	3ERJ7	370069000	11.32
1191	9250751	BOW FIRDA	S6BK2	565396000	10.72
1192	9412737	ARGENT EYEBRIGHT	3FKM7	372448000	11.32
1193	9372470	MSC KRYSTAL	3EPZ4	356330000	14.50
1194	9655004	BAYAMO	PCMA	245669000	4.45
1195	9295347	BALTIC AMBITION	C4FT2	212130000	10.85
1196	9515022	HUNZEDIJK	PCJB	246765000	5.80
1197	9138123	AMBER LAGOON	V7FS4	538090116	11.40
1198	8512279	TRANSSHELF	PJRR	306704000	8.80
1199	9400356	ALSIA SWAN	9HA2334	248359000	6.29
1200	8603406	IOHANN MAHMASTAL	UCKT	273110100	7.00
1201	9314820	BALTIC MARINER	C4JY2	212380000	10.85
1202	9373541	NICOLE C	2AHU4	235059768	6.30
1203	9381500	INYALA	9V8856	564166000	11.11
1204	9125683	KERTU	9HA3671	229861000	5.68
1205	8412821	MARIAN-V	PDGV	246211000	2.61
1206	1132025	STEMAT 63	XXXX	0        	2.50
1207	8222379	SORMOVSKIY-3052	UISO	273328500	4.24
1208	9237747	BASTOGNE	ONHG	205612000	9.50
1209	9060778	AASLI	ZDKD7	236597000	7.04
1210	9328027	JORK RULER	5BXR2	210008000	7.33
1211	8505939	NATHALIE	V2PJ4	305004000	3.38
1212	9431006	WILSON NEWCASTLE	9HA2628	215062000	7.40
1213	7024550	L'ESPOIR	PFPY	244711000	4.44
1214	8914166	SEA HARMONY	8PMA	314025000	5.03
1215	9254422	BRO SINCERO	OWMM2	219482000	9.80
1216	8411566	TERA	J8B4857	375891000	4.70
1217	9223423	RMS RHENUS	V2OM8	304153000	4.09
1218	9120853	SUSAN MAERSK	OYIK2	219134000	14.53
1219	9321548	EDITH MAERSK	OXOR2	220501000	16.00
1220	9410533	MED ATLANTIC	9HA2711	215371000	10.90
1221	9002776	BING N	A8QJ8	636013945	23.00
1222	9660578	SAINTY VANGUARD	VRLJ5	477030300	14.58
1223	9346665	DAMSTERDIJK	PHKS	244683000	6.22
1224	9489302	CAPE ALEXANDROS	A8UF2	636014481	18.20
1225	9467419	MSC LAURENCE	3FUT9	371582000	15.50
1226	9472622	BRAVO	9HA2746	215503000	15.00
1227	9129885	MSC RAFAELA	3FWG6	354776000	13.27
1228	7610012	MTS VISCOUNT	PCDZ	245221000	4.38
1229	9394519	EMMY SCHULTE	2BSM9	235068963	8.80
1230	9383613	HUSEYN JAVID	9HLZ9	249162000	5.70
1231	9425356	TERNVIND	OWTQ2	219554000	8.15
1232	9040170	HAPPY EAGLE	ZNHT7	235002250	6.46
1233	9409273	LIV KNUTSEN	2CJU3	235073404	8.92
1234	9234317	DELIA	V2AB4	304011029	4.49
1235	9656371	RHONE	XXXX	0        	2.60
1236	9656383	SAONE	XXXX	0        	2.60
1237	9232955	TERNHAV	OWIR2	219082000	9.00
1238	9512757	HIGH PEARL	9V8081	564591000	12.60
1239	9321392	HUMBERBORG	PHFC	246012000	6.01
1240	9333450	ASKO	V2BK1	304841000	5.25
1241	7038642	PANTODYNAMOS	HO4409	353079000	5.49
1242	9247168	SIRI KNUTSEN	MFCZ7	235007690	11.52
1243	9514456	HEATHER	9HA2297	248280000	7.50
1244	9150494	WILSON BRUGGE	9HFR5	249772000	5.49
1245	9123570	NESS	8PQM	314152000	6.10
1246	9157002	VERDI	V2AP4	304070935	4.65
1247	8822612	CEMI	C6TT4	311771000	5.74
1248	9313694	RMS SAIMAA	V2BJ3	304832000	4.47
1249	9333668	CANSU D	9HA2803	215893000	6.29
1250	9368780	HAPPY CONDOR	S6BJ9	565673000	8.80
1251	9414060	STOLT NORLAND	ZCXG8	317377000	11.88
1252	9314375	NEERLANDIA	HBEJ	269077000	8.39
1253	7814254	WEST STREAM	C6QI4	308241000	5.85
1254	9327671	ARIANA	A8IG4	636090973	12.00
1255	9320702	TSINGTAO EXPRESS	DDYL2	218063000	14.61
1256	9168207	MAERSK PALERMO	PDHW	244118000	12.50
1257	9337444	YM UBERTY	A8OR4	636013689	14.50
1258	9480837	ORTHIS	V7XM2	538004514	22.50
1259	9525912	AL RIFFA	9HA2982	229005000	15.52
1260	9309461	MSC TOMOKO	3EEQ7	354315000	15.00
1261	9112272	MSC FORTUNATE	3FLG6	356708000	14.02
1262	9373632	PATEA	9HMT9	249193000	8.90
1263	9427275	SUMMER	V7QA9	538003326	8.70
1264	9261724	MOL ENDEAVOR	HPFX	352987000	13.53
1265	9112870	DUTCH SPIRIT	PDTO	244085000	5.51
1266	9436018	V8 STEALTH	V7SW7	538003737	14.82
1267	8505927	JEROME H	V2AA2	304010444	3.67
1268	9232034	GHETTY BOTTIGLIERI	IBAX	247063100	11.20
1269	9573804	KING CORN	V7VQ5	538004187	9.82
1270	9399404	LOIREBORG	PHPT	245535000	6.50
1271	9165451	BITTEN THERESA	9HA2337	248373000	5.73
1272	9602722	JO REDWOOD	LAPN7	257932000	14.65
1273	9556820	NORTRAMP	V2GH2	305929000	4.10
1274	9552082	GRONA NANSUM	V2FZ8	305862000	6.15
1275	9336701	ORASUND	OXBU2	220514000	6.30
1276	7419200	WILSON ROUGH	9HSL5	248131000	6.96
1277	9204764	SEATURBOT	DDTS	211330520	11.00
1278	9306653	SLOMAN THETIS	V7JQ5	538090211	11.79
1279	9645762	STI LE ROCHER	V7BC9	538005117	13.30
1280	9313644	LEINE	V2BS	304785000	4.36
1281	9299939	MAERSK SHEERNESS	LXSH	253308000	14.00
1282	9622588	NYK HELIOS	VRLJ2	477182200	14.00
1283	9312793	NYK VENUS	3EJG5	372512000	14.52
1284	9488217	WU YI HAI	BQCF	413360000	11.10
1285	9619476	MSC ANTIGUA	VRLC3	477305900	14.52
1286	9426013	HELLENIC G	IBRW	247274800	14.90
1287	9421221	ICDAS-11	9HA2821	256139000	9.00
1288	8131934	VIKTOR TKACHYOV	UCJX	273136400	9.88
1289	9038593	PRIMULA	LAGC6	257751000	10.33
1290	9126900	WILSON BREST	9HSV4	249377000	5.49
1291	9625229	HARINGVLIET	PCRN	246854000	5.42
1292	9290385	UNITED LEADERSHIP	V7EN9	538005502	17.07
1293	9459369	BRASSCHAAT	ONFU	205547000	10.15
1294	9384459	RN PRIVODINO	5BYQ2	212111000	9.90
1295	9358278	BORNHOLM	C4KF2	212521000	7.05
1296	9421611	EEMS SPRINTER	PHIZ	245407000	4.26
1297	9556040	KESTREL FISHER	PCXI	244810490	6.30
1298	9285184	SPECIALITY	2GJY9	235098053	5.89
1299	9301926	MAERSK NORWICH	9VEK9	565213000	11.50
1300	9328314	NORDIC STOCKHOLM	OXIW2	219179000	8.71
1301	9235892	MASTERA	OJKE	230945000	14.50
1302	9142631	ICE STAR	PCAE	244264000	6.90
1303	9191955	FURIOSO	V2CX5	305137000	6.10
1304	9171084	ANTARI	V2FU	304369000	5.50
1305	9366744	COBALTWATER	PHGO	246545000	6.90
1306	9428449	CAROLINE THERESA	OUOZ2	220637000	7.61
1307	9381706	ALPPILA	OJOF	230613000	9.40
1308	9265251	STELLA ORION	PHGX	246553000	6.25
1309	9136694	NAPARIMA	2DJJ7	235079501	10.02
1310	8203543	NATALI	V2VT	304010200	4.50
1311	9449405	MARE PICENUM	ICOP	247293200	17.03
1312	9369514	MUSKETIER	ZDHM6	236334000	5.42
1313	9508316	BBC ODER	V2EX5	305589000	9.70
1314	9385611	CMA-CGM QUARTZ	D5CP4	636015754	12.60
1315	9280598	CMA-CGM BELLINI	C6TH5	311632000	14.50
1316	9290402	FELIXSTOWE BRIDGE	3EER9	352688000	13.65
1317	9635810	BW PUMA	9V2342	563621000	12.85
1318	9534808	AL RIQQA	9KBQ	447143000	22.50
1319	9459412	HANSA EUROPE	DISM2	211627970	12.50
1320	9298698	MAERSK OHIO	KABP	367775000	13.52
1321	9545077	EXPLORER	9HA2941	256825000	9.30
1322	9252371	MARATHA	SWJF	240042000	14.90
1323	9187746	GREAT AMBITION	VRYR5	477294000	13.85
1324	9308998	ARCHANGELOS GABRIEL	SXKH	240284000	12.50
1325	9462029	APL SALALAH	9V9400	566410000	15.50
1326	9204049	FRANK	ZDEF5	236107000	9.20
1327	9256755	MSC METHONI	D5AN2	636015404	14.50
1328	9290361	SEAOATH	9HBO8	215810000	14.92
1329	9556818	FEHN COURAGE	CQNN	255803890	4.10
1330	9577094	SCF PROVIDER	A8YG8	636015051	14.50
1331	9008512	B GAS ETTRICK	9HIZ9	249050000	6.00
1332	8904434	MEKHANIK PYATLIN	UCBP	273118000	5.05
1333	9467172	BANIER	PBRJ	245741000	5.69
1334	9314753	TRANS EXETER	9HA2572	248908000	7.35
1335	9330953	ALREK	V2BW4	304944000	5.92
1336	9356866	JEVENAU	V2CO5	305059000	5.50
1337	9195688	DRAIT	PHPW	244096000	5.22
1338	8920567	SUNDSTRAUM	LIFL3	259360000	6.21
1339	9001849	HAV ZANDER	C6XN5	311014900	4.57
1340	9080687	PASSAAT	PIHW	246276000	4.80
1341	9480992	URSULA ESSBERGER	PCMM	246823000	7.00
1342	8913447	MSC ATLANTIC	HPMQ	355249000	11.98
1343	9534066	ALORA	5BQP2	209524000	5.60
1344	8616087	PERSEUS	LYSS	277372000	3.93
1345	9295103	DP GEZINA	9HA3317	229417000	3.00
1346	9225586	DIEZEBORG	PBBA	245250000	7.09
1347	8418019	EEMS COAST	PEFI	245859000	3.18
1348	8324581	RIVER KING	HO9159	352104000	3.89
1349	9034171	HYDRA ZR.MS.	PAYP	245990000	1.60
1350	9507594	TWISTER	PHTW	245881000	3.30
1351	9295969	CMA-CGM SAMBHAR	5BND2	210481000	12.51
1352	9345996	NORTHERN DEXTERITY	A8NY9	636091449	12.50
1353	9595527	EVER LIVEN	BKIE	416481000	14.23
1354	9320714	RIDGEBURY CAPTAIN DROGIN	V7FF4	538005588	16.52
1355	9504047	PHOENIX J	V2FE2	305648000	9.90
1356	9526928	MAERSK LAVRAS	VRJH6	477535200	13.50
1357	9392391	JOSE PROGRESS	3FPZ2	355209000	11.97
1358	9307231	XIN SHANGHAI	VRCC6	477282900	15.03
1359	9539729	HANJIN ODESSA	3FXS	373103000	14.52
1360	9516416	COSCO FRANCE	VRMC2	477030700	15.52
1361	9489065	UACC MASAFI	V7TO8	538003848	12.15
1362	9649225	INGRID KNUTSEN	2HER5	235103057	15.00
1363	9588366	ALYCIA	9HA2749	215517000	9.80
1364	9591686	DARYA GAYATRI	VRKC8	477765200	14.50
1365	9190781	LUNA MAERSK	OWFT2	220005000	14.02
1366	9143752	EASTERN BAY	A8IO9	636091013	8.29
1367	9441180	CAPE TEES	V7RO4	538003549	14.30
1368	9267170	NIKOLAOS GS	V7BI2	538005146	9.78
1369	9593892	STAR LOFOTEN	LAQL7	258011000	12.60
1370	9290608	CHAMPION EBONY	LAQZ7	258028000	12.26
1371	9167150	MAERSK RAPIER	MZFR9	233816000	11.82
1372	9502661	SIMAY G	TCWA9	271043467	6.90
1373	9430818	BEATRIC	V7HB3	538005795	12.57
1374	9313204	REINBEK	9HA3566	229739000	9.00
1375	9404364	BLUE GARNET	9HA2443	248627000	6.75
1376	9229178	VERITY	MGDL2	235007990	5.20
1377	9521423	CHEMICAL LUNA	3FXN8	370849000	8.81
1378	9122916	ASTRO ARCTURUS	SVIL	237921000	13.52
1379	9371816	CFL PROMISE	PBOH	245959000	6.08
1380	9056026	WILSON GDANSK	8PRZ	314191000	5.52
1381	7610103	WILSON MARIN	9HRL6	248780000	6.88
1382	9511648	EMSLAND	V2QD7	305561000	7.36
1383	9590682	OTTOMAN TENACITY	TCMG8	271042654	16.20
1384	9261102	STEN IDUN	ZDFM5	236184000	8.90
1385	9176929	ANNELEEN KNUTSEN	LAUN5	257983000	11.50
1386	9073581	SUNMI	C6WS3	309937000	5.60
1387	8513314	SUNTIS	DIXS	218005000	3.86
1388	9377092	LEENI	C4LT2	210318000	5.61
1389	9260380	THUN GOTHIA	PBJU	244843000	6.76
1390	1133164	STEMAT 70	XXXX	0        	2.36
1391	9458030	MAERSK EDMONTON	V7VO4	538004171	15.50
1392	9211482	MAERSK KLAIPEDA	VRGL5	477728600	13.50
1393	9502946	HANJIN AMERICA	2FWB2	235094713	15.52
1394	9453365	BELLA SCHULTE	A8XR6	636092157	12.60
1395	9467392	MSC BERYL	3EXV8	357926000	15.50
1396	9472529	BODIL KNUTSEN	2EPZ5	235087214	16.50
1397	9322138	MOJITO	V7IR4	538002436	8.71
1398	9457830	OCEAN	5BXB2	210333000	8.65
1399	9237773	PISCES STAR	A8AO2	636011630	22.52
1400	9584607	GRAN TRADER	DUDQ	548851000	18.30
1401	9166883	EUGENIA B	9HPE7	215445000	11.36
1402	9444730	SANTA CATARINA	A8YJ9	636092199	13.50
1403	9229063	THUN GALAXY	PBDK	244089000	6.75
1404	9122655	DON CARLOS	9V9243	566088000	11.02
1405	9566693	BORINGIA SWAN	OWNY2	219018897	7.09
1406	9585273	ENISEY	UBLH2	273357330	10.00
1407	9365996	FLINTERCROWN	PBOR	246051000	7.30
1408	9004164	CORALWATER	PGAK	245675000	4.99
1409	9246152	XANTHIA	LAUR5	257970000	8.75
1410	9534274	GERTRUD G	V2ES8	305541000	6.03
1411	9534303	NIKLAS G	V2FN6	305733000	6.03
1412	9423671	YVONNE	V2EB5	305376000	5.25
1413	9664457	STRANDWAY	5BZJ3	212396000	5.90
1414	9305855	MINERVA GRACE	SVBN7	241193000	13.29
1415	9566291	SCALI REALI	9HA2486	248730000	6.50
1416	9240847	ARDMORE SEATRADER	V7VK5	538004142	12.66
1417	9154323	STOLT KINGFISHER	2EQD7	235087256	6.79
1418	9519614	LS EVANNE	ZDKW3	236111827	6.75
1419	9126625	HAV STREYM	OZ2144	231251000	5.31
1420	9142655	OOSTVOORNE	V2BZ5	304670000	4.30
1421	9318008	MINERVA VASO	SWQD	240728000	13.28
1422	9034509	B GAS LAURA	9HA2932	256788000	4.96
1423	9363508	EMMA JANNEKE	ZDHK8	236330000	5.70
1424	9125700	OSLO	V2DJ6	304010779	5.72
1425	9549645	MALACHITE	UBDK2	273333650	6.40
1426	9361328	AMBASSADEUR	PHIP	244389000	6.25
1427	7510626	MTS VICTORY	2EGC8	235084806	4.14
1428	9522738	SATIGNY	9HVQ9	249601000	6.90
1429	9612997	ANTWERPEN EXPRESS	DJCE2	218791000	15.80
1430	9454448	CMA-CGM ALEXANDER VON HUMBOLDT	2GEH4	235096647	16.03
1431	9082348	APL TURQUOISE	9V9241	564245000	13.02
1432	9278117	DERBY D	A8MY7	636013437	12.60
1433	9407885	CHOAPA TRADER	A8ST8	636091779	13.62
1434	9333541	AMAZONEBORG	PHIN	246572000	9.69
1435	9501875	PALABORA	V2ES2	305553000	7.80
1436	9392183	SICHEM IRIS	9HND9	249210000	7.45
1437	9466130	PEARY SPIRIT	C6YM3	311027600	15.00
1438	9168946	NAVION OCEANIA	C6XS3	311020200	15.67
1439	9228019	YONG TONG	VRXH9	477944000	13.92
1440	9579743	BLACK PEARL	V7VQ2	538004184	14.58
1441	9187136	SHARON	PHQA	245871000	6.19
1442	9392793	ALPINE MAGIC	VRFR7	477617500	12.21
1443	9564994	ZEYCAN ANA	9HA2489	248737000	8.10
1444	9334789	STI HIGHLANDER	V7UG4	538003945	11.22
1445	9344174	SICHEM RUBY	3EGI7	356826000	7.77
1446	9356488	HYDRA	PBJT	244765000	5.25
1447	9568586	ALCMENE	V7VH7	538004123	14.90
1448	9644225	HAPPY LADY	SVBV3	241281000	12.40
1449	9148582	LIA IEVOLI	IBDX	247346000	7.55
1450	9200081	KAPRIFOL	5BXX2	210445000	5.10
1451	9505326	ROCHEFORT	ZDKD2	236593000	5.30
1452	8816168	AVELONA STAR	C6TJ4	311676000	9.12
1453	9191278	FULDA	V2GL3	304010995	5.67
1454	9292967	ARIADNE	C6UI5	311927000	12.45
1455	9536052	GEERVLIET	PCLI	246803000	5.42
1456	8206961	AGAT	9HUP9	249560000	5.20
1457	9688879	DAMEN HARDINXVELD 571713	XXXX	0        	3.20
1458	8915756	NOVATRANS	PEPL	245219000	5.31
1459	8433459	LOUISE VAN DER WEES	PDGW	244509000	2.20
1460	1134114	NP 421	XXXX	0        	3.00
1461	8906224	NATHALIE	OJLP	230987660	3.39
1462	9146479	SOFIE MAERSK	OZUN2	219776000	15.02
1463	9619907	MAERSK MC-KINNEY MOLLER	OWIZ2	219018271	16.03
1464	9410789	CMA-CGM COLUMBA	2DBC9	235077448	15.50
1465	9351218	OCEAN EMERALD	A8TY3	636091865	9.53
1466	9431812	APL MELBOURNE	A8SN4	636091765	12.60
1467	9434929	MAERSK NIJMEGEN	VRFE9	477261300	11.50
1468	9318539	DONAT	9AA6017	238233000	17.10
1469	9414151	TRITON GANNET	3FOV7	357654000	14.38
1470	8410574	SUMMER WIND	C6RN8	311119000	9.53
1471	9327059	CRYSTAL DIAMOND	9HA2165	248078000	8.37
1472	9252436	STENA CONQUEST	ZCDX7	310558000	12.18
1473	9318228	SCORPIUS	OXGJ2	219178000	8.04
1474	8718873	DANIELLA	PDNN	246468000	7.12
1475	8908844	RAGUVA	LYSH	277350000	8.50
1476	9420045	HOEGH ST.PETERSBURG	LAII7	257366000	9.00
1477	9623984	ZETAGAS	V2FT8	305794000	8.45
1478	9000833	WILSON GARSTON	8PSO	314206000	5.70
1479	9556832	CATANIA	V2GH3	305930000	4.10
1480	9501708	ABIS ALBUFEIRA	PBNK	245825000	5.35
1481	9163635	ARKLOW VIKING	PIAX	244302000	6.36
1482	9519028	MSM DOURO	5BNJ3	209714000	5.88
1483	9243382	MIRO D	9HA3388	229535000	9.29
1484	9164512	EK-SKY	LAMS5	257426000	8.60
1485	9255270	JURMO	OJKT	230952000	10.90
1486	9126273	PRINCESS NAOMI	2DBS5	235077612	10.02
1487	9143257	JANET	9HSL8	256371000	6.17
1488	9411783	HESTIA	PCMO	246827000	5.25
1489	9573684	CARINA	9V8516	565493000	11.00
1490	9448190	SD SEAHORSE	9HIX9	249039000	4.18
1491	9475703	HYUNDAI AMBITION	D5BU6	636015607	15.50
1492	9595436	EVER LAMBENT	2FRE8	235093569	14.50
1493	9343730	KUALA LUMPUR EXPRESS	DFNB2	218284000	14.61
1494	9281152	ASTRO POLARIS	SYCJ	240125000	17.07
1495	9233210	NORDIC MISTRAL	V7TB9	538003776	17.00
1496	9514066	SAN ANTONIO	VRKG4	477413100	12.74
1497	9439412	GOLDEN BEIJING	VRGC6	477655100	18.12
1498	9484481	MSC AURORA	3FAT3	373069000	15.50
1499	9074793	THOR ENDEAVOUR	9V9629	566295000	11.54
1500	9566382	HOUSTON BRIDGE	3FLC7	373485000	14.04
1501	9259903	ALIA	A8AV4	636091488	9.80
1502	9343118	KENT	A8MA5	636013308	10.40
1503	9251705	MSC FLORENTINA	HPFH	352870000	14.50
1504	9289099	MSC BEIJING	9HA3486	229651000	14.50
1505	9005326	KERGI	9HAW6	248346000	6.50
1506	9263112	TIGRIS	SXQG	240138000	12.02
1507	9464417	LOWLANDS QUEEN	3FTU4	370913000	14.10
1508	9177569	NAVIGATOR SATURN	ELYC9	636011289	11.05
1509	9578622	XIN TAI HAI	3EWO7	353912000	18.10
1510	9401312	SAMUS SWAN	9HA2333	248363000	6.29
1511	7382495	WILSON ROSS	9HCC6	248379000	6.96
1512	9407988	STEN BERGEN	ZDIY8	236501000	8.92
1513	9293325	ESHIPS BAINUNAH	ZDIQ7	236475000	6.86
1514	8822600	MAGDALENA	V2PG8	304682000	5.46
1515	9198446	MAXIME	PJMV	306762000	4.78
1516	9313814	VLIELAND	PBFD	244376000	6.09
1517	7920338	MUNGO	5IM552	677045200	3.20
1518	9546497	ADRIATICBORG	PCJT	246302000	9.69
1519	9286786	RIO THOMPSON	A8JS5	636091129	11.50
1520	9143219	BOW CECIL	LAGU5	259928000	10.72
1521	9377652	SILENT	9HBF9	256716000	11.52
1522	9334686	MAERSK TUKANG	9VHE2	565825000	14.50
1523	9321251	MOL CELEBRATION	C6WW7	309901000	14.54
1524	9619426	MSC ALTAMIRA	D5CC7	636015664	14.52
1525	9419230	CATAMARCA	A8QU2	636091644	13.25
1526	9311218	BONANZA YR	3EGI5	356679000	12.20
1527	9228837	KING EVEREST	V7DB8	538090267	11.20
1528	9255983	BATTERSEA PARK	A8ZU3	636015300	9.72
1529	8906951	ZALIV NAKHODKA	UETV	273326750	7.87
1530	9238387	ALDEBARAN	PBCB	245882000	4.64
1531	9041069	MONGOLIA	3EWC3	373130000	16.97
1532	9343778	AZALEA GALAXY	3EEV4	371823000	9.46
1533	9288746	SEABORN	9HZR7	215781000	14.90
1534	9130808	NORDIC NELLY	OXNH2	220234000	6.71
1535	9184225	BERTA	V2BQ6	304586000	6.35
1536	7616224	WILSON TANA	9HVN5	248211000	7.02
1537	9389564	ATHINA	A8MM7	636013375	12.20
1538	9297137	LOTUS	OXLQ2	219165000	6.51
1539	9299446	MAERSK BELFAST	9V6969	566503000	9.50
1540	8918966	MSC MANDY	HPRL	354537000	11.98
1541	9143582	AQUARIUS	LYST	277373000	3.15
1542	1133302	TERRAFERRE 302	XXXX	0        	4.60
1543	7419690	HELLAS	J8B3126	375113000	3.99
1544	9275062	NEDLLOYD VALENTINA	A8EG9	636090736	11.50
1545	9185786	SALANDI	3FEB9	357252000	13.82
1546	9467263	CSCL JUPITER	VRIL4	477213400	15.50
1547	9538892	EIT PALMINA	V2QI3	305788000	7.20
1548	9449120	PAULA SCHULTE	D5AP6	636092338	12.50
1549	9592044	XIAO YU	VRJN2	477091200	14.20
1550	8902541	PORTLAND EXPRESS	ZCEI8	310656000	13.50
1551	9275646	MSC EMMA	V7WY6	538004424	13.50
1552	9351593	MSC ANGELA	3ESB8	370254000	13.00
1553	9237151	MSC DONATA	3EOS8	372491000	12.65
1554	9295335	MARE ACTION	V7LF5	538090264	10.85
1555	9198642	JOHN-PAUL K	PBHY	245181000	5.64
1556	9278428	ATLANTIC BREEZE	MDFD8	235824000	14.03
1557	9141405	KRISTIN KNUTSEN	LAGR5	259898000	8.90
1558	8908791	TORPO	8PAK3	314419000	4.89
1559	9554171	AKTEA R	9HA2309	248303000	9.82
1560	9127083	EMWIKA NAREE	HSPI2	567048000	9.06
1561	9390094	KASTOR	V2FV3	305811000	5.50
1562	9529188	EMUNA	PBOU	246090000	5.64
1563	9102083	STOLT INSPIRATION	ZCSP8	319499000	11.89
1564	9277371	TERNVAG	OWIP2	219081000	9.00
1565	9383493	MCP LINZ	5BHY2	212939000	6.45
1566	9350745	BESIKTAS SCOTLAND	9HYB8	256587000	9.48
1567	9282144	TOISA VOYAGER	C6UM9	311964000	6.10
1568	9194000	GINALDAG	9HKF8	256072000	9.80
1569	9310355	OLYMPUS	OXPL2	219539000	8.12
1570	8913021	HAJO	V2EY6	304010665	6.37
1571	9218222	BBS SURF	C6AM5	311000088	4.64
1572	9398486	WISBY WAVE	SBYU	266317000	6.75
1573	9116802	PARSIVAL	V2MS	304010881	4.95
1574	9255268	PURHA	OJKS	230951000	10.90
1575	9303522	MAERSK STRALSUND	A8KW2	636091220	14.50
1576	9326770	CMA-CGM JAMAICA	5BNA2	212789000	12.75
1577	9131840	CHAMPEL	ZCEF4	310621000	16.50
1578	9293167	SANTA REGINA	A8IX8	636091050	13.50
1579	9526930	MAERSK LEBU	VRJH7	477196800	13.50
1580	9588081	HELSINKI BRIDGE	3FIW4	373119000	14.04
1581	9232565	LIVERPOOL EXPRESS	DDSD2	218025000	12.50
1582	9472153	COSCO PRIDE	VRIV3	477764600	15.52
1583	9465306	MSC RENEE	A8YN5	636092210	15.50
1584	9251377	MOL EXCELLENCE	VRMJ8	477463200	13.50
1585	9390692	SOCRATES	A8OE2	636013615	14.30
1586	9168635	BOW FORTUNE	LAJQ5	257401000	10.72
1587	9297345	BRITISH CYGNET	MGSG6	232157000	15.00
1588	7911856	HEIN	PEPN	244061000	4.97
1589	9447184	COALMAX	5BVR3	210616000	18.37
1590	9425382	SANTA RITA	DIOY2	218670000	13.50
1591	9509475	ARKLOW MOOR	EILM3	250002434	8.48
1592	9231092	RED CEDAR	V7EH4	538090070	11.20
1593	9317951	MINERVA LIBRA	SVAA7	240766000	15.42
1594	9201798	LADY CLAUDIA	PCHE	245772000	5.89
1595	9466570	BLANK	9HA2577	248926000	17.00
1596	9410181	ARIADNI	A8SA3	636014185	17.32
1597	9083122	JUMBO SPIRIT	PFFH	246334000	6.80
1598	9191474	WILD PEONY	3FXS8	357041000	8.72
1599	9479802	EKIN-S	TCMW3	271042836	6.85
1600	9297321	MINERVA ELLIE	SZQI	240435000	13.60
1601	9142318	GAS EVOLUZIONE	V7NF5	538002952	4.51
1602	9491769	WILSON FINNFJORD	8PAH5	314398000	5.51
1603	9318216	KEY FJORD	ZDIJ3	236445000	6.05
1604	9052678	SELVAAGSUND	J8B3801	377134000	4.16
1605	9486178	CHEM LYRA	V7RK3	538003525	8.80
1606	9607954	OVERSEAS REDWOOD	V7ZX2	538004934	14.80
1607	9187538	CRYSTAL ATLANTICA	9HA2163	248074000	9.35
1608	9418937	LS JAMIE	ZDJB7	236507000	6.29
1609	9041320	FORSETI	V2PV4	304010297	5.44
1610	9501344	BASLE EXPRESS	DFGN2	211549000	15.52
1611	9362437	CMA-CGM PLATON	2ACH6	235058584	9.36
1612	9467287	CSCL MARS	VRJG2	477424600	15.50
1613	9360128	ZALIV BAIKAL	A8RM5	636014126	14.92
1614	9579030	STENA SUPERIOR	ZCEF1	310620000	17.00
1615	9604081	EVER LOGIC	BKIF	416482000	14.20
1616	9213909	NOBLE SPIRIT	H3UY	355437000	12.12
1617	9143556	DUSSELDORF EXPRESS	DGDD	211262480	13.63
1618	9341873	PANAMAX STERLING	5BQK3	210119000	14.35
1619	9270907	ACHILLES BULKER	HPOA	355170000	9.50
1620	8309830	STAR FUJI	LAVX4	258972000	11.82
1621	9605853	GLADIATOR	C6YK2	311036200	12.80
1622	9295414	JPO CAPRICORNUS	A8GU6	636090861	12.50
1623	9251690	MSC LUDOVICA	HPAF	351248000	14.50
1624	9234989	AURORA	P3QH9	209627000	8.70
1625	9321873	GINGA JAGUAR	3ECS4	371451000	10.08
1626	9629574	SEAFRIEND	9HA3308	229407000	13.10
1627	9330408	ORIENTAL CLEMATIS	9VJT5	565157000	8.84
1628	9353113	CPO NORWAY	2AJP6	235060247	11.51
1629	9580986	ADFINES SKY	9HA2926	256770000	8.40
1630	9254070	TORM ROSETTA	OYNV2	220557000	12.65
1631	8917716	SOAVE	PBIX	244936000	6.07
1632	9155949	UNIMAR	ZDHE5	236306000	5.70
1633	9635999	ARCADIA	D5AA2	636015333	12.80
1634	9313711	AYR	9HSU9	249467000	5.14
1635	9167344	SOLYMAR	P3WG9	209664000	5.69
1636	9395367	BESIKTAS ICELAND	9HA3503	229668000	6.86
1637	8821797	ANJELIERSGRACHT	PCGQ	244716000	8.50
1638	8421872	DANICA BROWN	OXFY2	219205000	4.50
1639	9298492	NORTHERN OCEAN	V7WG5	538004294	13.27
1640	9214757	RICHARD MAERSK	OYIZ2	219967000	11.82
1641	9492880	MULTRATUG 18	PBRY	246566000	4.85
1642	1137351	ROROPONTON 4	XXXX	0        	3.00
1643	9624847	LADY AMALIA	PCNV	246685000	5.00
1644	9177894	HESTIA	V2AS5	304010996	4.49
1645	9454395	CMA-CGM AMERIGO VESPUCCI	FNVK	228316800	14.00
1646	9231482	EVRIDIKI G	A8QD8	636013898	11.50
1647	9258600	CONCORD	V7VW3	538004226	12.22
1648	9362322	CMA-CGM HOMERE	MQBL6	235052314	9.36
1649	9215311	MAERSK KAMPALA	PFDH	244079000	13.50
1650	9434931	MAERSK NIMES	VRFO7	477559200	11.50
1651	9321524	EBBA MAERSK	OXHW2	220497000	16.00
1652	9502972	HANJIN BLUE OCEAN	2GEX9	235096793	15.52
1653	9306158	PUCON	V7CB7	538005235	14.00
1654	9503926	SHANNON STAR	9HA2409	248553000	8.70
1655	9444534	CAPE CLAUDINE	V7VL5	538004151	18.20
1656	9369291	BEAUTRIUMPH	PHOV	244403000	6.54
1657	9281279	MSC LISA	H3MK	353968000	13.50
1658	9221669	TRANS BORG	9HA3236	229327000	8.65
1659	9438858	AMUNDSEN SPIRIT	C6YM4	311027700	15.00
1660	9481001	ELSA ESSBERGER	CQJA	255805470	7.14
1661	9403827	PURPLE GEM	9HZO9	249749000	8.40
1662	9598866	NEVA-LEADER 6	UBFK8	273334560	4.70
1663	8713811	FRAKT	J8B3003	377707000	4.37
1664	9436446	YASA SCORPION	V7TQ7	538003862	17.03
1665	9497206	MAGSENGER 1	VRHI2	477389700	14.50
1666	9494216	LEMONIA	ZDJJ3	236529000	8.06
1667	9434577	ANMIRO	V2DR9	305322000	5.49
1668	9379313	NAVE PULSAR	V7BM3	538005167	13.27
1669	9158630	AMAZONE	PDAB	245718000	4.45
1670	8315449	LIFANA	PFOC	245815000	3.23
1671	9458391	SEREN	VRLT6	477243300	10.10
1672	9356294	CMA-CGM THALASSA	5BNE2	212151000	15.50
1673	9314258	CSCL LONG BEACH	VRCZ7	477883900	14.50
1674	9615743	CLIFTON BAY	3FOL7	373470000	12.68
1675	9338278	STADT BREMERHAVEN	V7NL4	538090335	8.51
1676	9332846	ZIM LONDON	2ANQ9	235061354	14.00
1677	9477359	JAMILA	A8RO7	636091688	9.50
1678	9287895	PINEHURST KONTOR	V7HG8	538005818	13.50
1679	9180114	SONANGOL GIRASSOL	C6QR8	309282000	17.00
1680	9202039	EPSILONGAS	V2AZ7	304050864	7.45
1681	9522324	SUVOROVSKY PROSPECT	A8TH6	636014356	15.00
1682	9177959	OMEGAGAS	V2KA9	304050840	6.25
1683	9289104	MSC LUCY	3EBC5	371059000	14.50
1684	9138197	BALTIC CARRIER	ZDFD4	236038000	5.02
1685	9298375	MCT BREITHORN	HBHC	269848000	9.78
1686	9071222	C. HARMONY	DSPK3	441154000	17.41
1687	9385087	KARINE BULKER	3EOR8	372223000	9.50
1688	9336969	BAO GUO	3ESG5	370293000	18.23
1689	9413585	BOMAR PLUTO	9HRH9	249403000	5.98
1690	9420253	HANDYTANKERS MAGIC	V7QX7	538003460	11.62
1691	9410909	MINERVA ZEN	SVBN3	241190000	13.50
1692	9591181	MANGAN TRADER III	DUEK	548862000	14.50
1693	9361366	GOTLAND	PHOO	245190000	5.95
1694	8800157	JAGO	J8B4046	377444000	4.37
1695	9016870	STOLT RAZORBILL	2ADO7	235058838	6.78
1696	9344203	GOVIKEN	9HA2718	215389000	6.50
1697	8806163	ARINA	LYRY	277334000	5.88
1698	9325130	LISA LEHMANN	V2GL4	305981000	5.25
1699	9330379	DAVINO D	C6US5	308815000	8.84
1700	9524932	CONSTRUCTOR	ORQC	205599000	6.80
1701	9505297	BONACIEUX	ZDJR2	236553000	5.30
1702	6713283	MIA-B	DHFD	218784000	3.96
1703	9314832	BALTIC MARSHALL	C4KD2	212118000	10.85
1704	8505549	BALDER	V2PI6	304854000	4.58
1705	9259020	SARA	PBWL	244810690	7.16
1706	8415665	PLUTO	MJAB	235050523	4.22
1707	9280615	CMA-CGM MOZART	FZQM	226325000	14.50
1708	9471408	CMA-CGM NEVADA	9HA3474	229639000	15.50
1709	9446104	MAERSK NIENBURG	VRGJ3	477711300	11.51
1710	9472177	COSCO HARMONY	VRJA4	477397800	14.50
1711	9450430	BUDAPEST EXPRESS	DGWE2	218352000	14.61
1712	9399014	MSC BEATRICE	3FUF2	353162000	15.60
1713	9213571	MSC ANTARES	LXAU	253256000	14.00
1714	9271341	OLYMPIC FLAG	SWDF	240168000	17.10
1715	9341081	NS CLIPPER	A8GW6	636012661	14.92
1716	9116187	ANJA	PBMV	245570000	5.95
1717	9508823	KONGO STAR	9HA2367	248439000	8.70
1718	9156498	IERAX	UBZL3	273345680	8.70
1719	9212876	MISTRAL	SVBQ4	241227000	22.70
1720	9122112	NORDIC NADJA	OXNJ2	220236000	6.71
1721	9406063	LILLY BOLTEN	A8TJ5	636091829	9.88
1722	9351153	VICTORIADIEP	PHMM	245054000	7.02
1723	9268370	VOLVOX OLYMPIA	PBJI	244011000	6.56
1724	9312729	VENTURA	V2GM2	305994000	6.14
1725	8303173	CEG COSMOS	ZDID4	236418000	3.30
1726	9536076	HEENVLIET	PBFT	245513000	5.42
1727	9173329	RAGNA	DGOG	211265530	6.55
1728	9147667	GLORIA	V2NG	304080745	7.84
1729	9303534	MAERSK SAIGON	A8KW3	636091221	14.50
1730	9461881	APL LE HAVRE	9V9375	566407000	15.53
1731	9521447	TULIP	5BSP3	210224000	14.80
1732	9506069	BW SHINANO	9VFQ7	563857000	14.70
1733	9160619	LOCH RANNOCH	MYJG2	232829000	15.63
1734	9576789	REINHOLD SCHULTE	9V6035	566572000	9.20
1735	9519298	ALEXANDRIT	CQGF	255805655	12.80
1736	9312080	PATAGONIA	9HNL9	249231000	8.40
1737	9186352	LATANA	LALS5	257374000	8.75
1738	9276597	MINERVA LISA	SVNH	240235000	13.60
1739	9507350	WILSON ALGECIRAS	9HA2471	248689000	5.15
1740	9007063	CEMLUNA	C4BX2	209671000	5.34
1741	9640102	GOLDEN RAY	D5BQ9	636015587	9.71
1742	9313773	FOREST	PBAZ	244864000	5.95
1743	8919843	OLZA	SNBJ	261499000	4.43
1744	9373735	CASTELLO DI GRADARA	IBIU	247272900	6.50
1745	9013062	ANMAR-S	PIFO	246179000	3.90
1746	9445459	SELMA B	V7HT4	538005871	22.52
1747	9563720	BBC CORAL	V2FY6	305853000	9.10
1748	8906212	GERDA	YLCI	275343000	3.39
1749	9540273	LOYA	9HA2452	248646000	5.80
1750	9361378	AMBER	PHPH	245433000	6.24
1751	9643659	BOMMEL	PCCM	245386000	2.45
1752	9424053	LEVANA	ZDJD2	236511000	8.06
1753	9360582	MULTRATUG 4	9HST8	256381000	4.70
1754	9261566	CESKA	CQPF	255801990	6.50
1755	9622617	NYK HERCULES	VRLQ4	477222700	15.53
1756	9324849	ANL WINDARRA	V7LE9	538002733	12.60
1757	9489209	ISTRA	9AA8148	238301000	12.50
1758	9440576	PANTONIO	C4YG2	209478000	7.40
1759	9459400	HANSA ASIA	DFPY2	218504000	12.50
1760	9456721	NORDANA MADELEINE	PBUF	244170000	7.93
1761	9352157	MEHMET DADAYLI-1	TCPM7	271000893	5.80
1762	9346433	ICE BASE	5BCE2	212177000	12.50
1763	9194397	IKARIA ANGEL	3FFZ9	357321000	11.62
1764	9342516	MAERSK ALFIRK	9VBN2	565747000	14.50
1765	9433092	VARKAN EGE	TCSZ3	271002541	5.40
1766	9314064	MINERAL KYOTO	ONFI	205519000	18.17
1767	9410519	NEPTUNUS	OUZC2	219430000	6.77
1768	9557379	FEHN COMPANION	V2GH6	305437000	4.10
1769	9396000	SICHEM HAWK	9HSE9	249445000	10.01
1770	9485356	ORABOTHNIA	ZDNK2	236111951	7.40
1771	8810918	LALANDIA SWAN	OYBT2	219961000	8.40
1772	9442665	ORIENTAL NADESHIKO	3FWN7	371742000	8.77
1773	8817368	SERAFINA	OJPF	230941680	4.95
1774	9298040	VENERE	9HA2108	249969000	6.49
1775	9056868	VLADIMIR RUSANOV	UBIB	273340840	9.82
1776	8810750	MONICA	E5U2831	518884000	5.00
1777	7802952	ANTWERPEN	V7HK4	538002243	11.16
1778	9034523	B GAS LOTTA	9HA2928	256798000	4.96
1779	7625483	EN AVANT 7	PBEB	246131000	2.65
1780	9156101	WILSON CALAIS	8PUK	314255000	5.67
1781	9474993	6619	XXXX	0        	3.40
1782	8918473	WILSON SUND	P3JD8	212795000	6.26
1783	9146467	SVENDBORG MAERSK	OZSK2	219145000	14.52
1784	9215907	MARIANNE SCHULTE	VRCY2	477830500	11.50
1785	9233806	PETRONORDIC	C6SU9	311502000	14.50
1786	9448815	COSCO VIETNAM	VRID5	477266900	14.52
1787	9404209	CSAV LLUTA	A8SN2	636091763	12.80
1788	9489077	UACC MESSILA	V7TO9	538003849	12.15
1789	9512783	EENDRACHT	PBMS	244620052	5.81
1790	9160047	SEA SHANNON	PCEF	245334000	4.05
1791	9371787	SELANDIA SWAN	OYIN2	220545000	9.49
1792	9461623	BODO SCHULTE	A8XR7	636092158	12.60
1793	9638563	NAVE ATROPOS	V7AS4	538005060	12.20
1794	8315554	TERTNES	PGAN	245696000	8.68
1795	7810222	WILSON MERSIN	P3PA6	210072000	6.71
1796	9429261	MORSUM	V2QJ7	305837000	8.70
1797	9176606	ASIAN EMPIRE	D7ML	440114000	10.01
1798	9467196	FIDUCIA	PBSR	244780000	5.30
1799	9323651	DITZUM	ZDHB8	236297000	5.74
1800	9252931	PRIDE	ZDFD7	236166000	4.94
1801	9444508	RHINO	9V8875	564224000	11.60
1802	9476343	ALCMENE	J8B5058	246128000	3.50
1803	9631967	MOL QUEST	S6LT6	566880000	15.52
1804	9294408	MAERSK LAUNCESTON	A8FQ8	636090797	12.20
1805	9592123	ARCHIGETIS	5BGT3	209191000	14.30
1806	9192430	CMA-CGM UTRILLO	5BAA2	212925000	11.00
1807	9526978	MAERSK LABERINTO	VRKJ7	477174800	12.50
1808	9465095	NORTHERN JAVELIN	A8TA2	636091803	14.50
1809	9595462	EVER LEADING	2FRK8	235093619	14.19
1810	9302152	HARBOUR BRIDGE	3EIQ5	372367000	14.04
1811	9531882	BERGE BLANC	2FRS7	235091363	21.40
1812	9073880	HAV DOLPHIN	C6WS4	309938000	4.64
1813	9276171	ACHILLES	V7FT2	538002013	14.12
1814	9356505	HEKLA	PHPD	245281000	5.05
1815	9475686	HYUNDAI SMART	SVBY2	241312000	15.50
1816	7365851	DC MERWESTONE	PFCE	245239000	6.25
1817	9387566	IOANNA	A8MM5	636013373	22.52
1818	9399038	MSC BETTINA	HPFG	352361000	15.60
1819	9430375	SANTA TERESA	D5AH6	636092317	13.50
1820	9123960	LAURA I	A8WB6	636092064	9.41
1821	9140827	LUCY ESSBERGER	PCDJ	246725000	6.79
1822	9431800	CSAV LLANQUIHUE	A8SN3	636091764	12.60
1823	9056064	WILSON GDYNIA	8PSA	314192000	5.52
1824	9570840	ELVIA	9HA3106	229148000	14.90
1825	9564970	GARIP BABA	9HA2544	248843000	8.10
1826	9199141	KRUCKAU	V2LO	304498000	5.49
1827	9349643	FSL TOKYO	9VBR4	565212000	9.77
1828	9063885	KAAMI	C6VO9	308542000	5.60
1829	9367255	IONIAN TRADER	2FPJ6	235093147	6.00
1830	9190262	PARAMAR	P3ZD9	210230000	5.69
1831	9228980	MAINEBORG	PFCT	244166000	7.15
1832	9306691	TUNA	PHBX	244321000	5.85
1833	9358931	STEN HIDRA	LAJX6	258751000	8.90
1834	9465423	GOLDEN KAROO	V7ZQ5	538090452	11.70
1835	9283978	STENBERG	ZDGA3	236222000	8.90
1836	9271896	RAMONA	SFGZ	266129000	9.75
1837	9391658	DEO VOLENTE	PHFJ	246518000	5.81
1838	7727073	ANIEK	V2ZR3	304807000	4.32
1839	8315504	BARENT ZANEN	5BFJ2	212487000	7.60
1840	9197399	EIDER	V2KA	304469000	5.50
1841	9424754	TEMPEST	PHOT	244285000	3.66
1842	9280653	CMA-CGM VERDI	D5CF6	636015686	14.50
1843	9619945	MADISON MAERSK	OWJG2	219018864	16.03
1844	9081203	JADE	9VVD	563791000	13.51
1845	9344708	NORTHERN GENERAL	A8MW8	636091381	12.75
1846	9306433	CHYRA	CQHG	255805582	6.70
1847	9114232	BOW FAITH	LAZM4	259773000	10.72
1848	9399387	LAUWERSBORG	PHLM	244828000	6.50
1849	8501062	DIAMONDE	J8B2878	377552000	4.42
1850	9171503	CARLA MAERSK	OZGB2	219269000	12.21
1851	9200421	SAGA JANDAIA	VRYO9	477398000	11.82
1852	9416800	WINTER	V7QA7	538003324	8.70
1853	9279989	MSC STELLA	H8PA	352983000	14.50
1854	9033878	BONAY	YLBV	275359000	4.20
1855	9438418	YASA SOUTHERN CROSS	V7SS7	538003713	17.03
1856	9453066	ELENA VE	A8WB4	636014709	14.15
1857	9629938	STI TOPAZ	V7XP3	538004534	13.30
1858	9043093	NORDIC LYNX	LAGR6	258781000	10.20
1859	9445992	MORNING LAURA	3FUO	356732000	9.00
1860	9404704	ROLLDOCK SEA	PBPF	246244000	5.67
1861	9331361	LEONIE	PHLE	244772000	5.25
1862	9390769	TORM LENE	OUPE2	220620000	12.91
1863	9186704	LEANDER	DEDP	218731000	8.36
1864	9598878	NEVA-LEADER 7	UFQP	273333880	4.70
1865	9172727	MARACAS BAY	C6QD2	308773000	10.02
1866	9006459	SEA KESTREL	ZCIW7	319922000	4.02
1867	9228588	DAGMAR THERESA	9HA2338	248370000	6.15
1868	9411238	HAMILTON SPIRIT	C6XT3	311021100	17.15
1869	9567972	YUMETAMOU	3FHC9	373118000	18.24
1870	9587312	KAPSALI	A8XV9	636014982	17.00
1871	9297228	BROVIG MARIN	ZDHP4	236342000	5.95
1872	9511442	HAVVA ANA	V7RE3	538003488	7.03
1873	9137038	LADY IRINA	PEVE	246394000	5.89
1874	7721263	KUZMA MININ	UCJB	273133200	9.88
1875	9380271	COSCO NAGOYA	3ESJ8	370320000	11.00
1876	9036454	BERGE BUREYA	3EMR6	371537000	21.32
1877	9558971	CHEMICAL MARINER	9V7965	565544000	8.81
1878	9433810	EAGLE MELBOURNE	9V8483	564047000	12.90
1879	9408645	EN AVANT 20	PCUZ	244790685	4.25
1880	9442914	BESIKTAS HALLAND	9HOO9	249283000	6.86
1881	9136888	EKMEN	9HA2019	249815000	6.92
1882	9237371	BERIT	5BLR3	209177000	8.71
1883	9114763	FJORDSTRAUM	9HST9	249465000	6.79
1884	9183984	CELANDINE	ONDN	205476000	6.50
1885	9410727	CMA-CGM ANDROMEDA	2BSD4	235068857	15.50
1886	9281932	JAG PRANAV	AWEX	419000849	11.00
1887	9491915	BLUE NOTE	V2EU8	305565000	6.13
1888	9502867	HANJIN ASIA	2FHT8	235091397	15.52
1889	9374973	HOLLANDIA	PHKV	244673000	7.90
1890	9595515	EVER LEGACY	9V9290	566853000	14.20
1891	9209996	CHEMICAL DISTRIBUTOR	9HDQ8	215864000	8.56
1892	9447847	MSC FABIOLA	A8VL5	636092019	15.50
1893	9302619	YM UNITY	A8HZ4	636012807	14.48
1894	8511940	RAN	YJTU2	577247000	4.80
1895	8920581	STOLT GUILLEMOT	MAIZ	235050033	6.20
1896	9305685	HYUNDAI SINGAPORE	5BZP3	212351000	14.50
1897	9594133	LENI P	A8XW5	636014986	17.00
1898	9279068	NOORDERLICHT	PHEH	246499000	4.85
1899	9488839	VARKAN AKDENIZ	TCYK2	271041519	8.15
1900	9445966	BOSTON	V7NA5	538002934	18.32
1901	9225043	TRITON	C6RT3	311179000	14.17
1902	9271999	MOYRA	ZDGR4	236271000	9.55
1903	9555333	SERDOLIK	UCLN	273334240	6.40
1904	9618848	RHOGAS	V2FT7	305793000	8.45
1905	9333436	SCF AMUR	UCJW	273340760	12.43
1906	9060675	WILSON ELBE	9HGK9	256953000	4.79
1907	9175767	CHEM ORION	V7GZ9	538002197	7.76
1908	9374387	AMKE	ZDHP8	236344000	5.70
1909	8509820	MAUREEN S	P3FN8	212746000	5.24
1910	8618035	NINA	OJNV	230608000	4.52
1911	9354519	SEVEN EXPRESS	3ENS3	352144000	12.10
1912	9370290	CLARE CHRISTINE	V2DT7	305379000	5.42
1913	9411745	PRISCILLA	PBQY	245223000	5.05
1914	9232840	MARINUS	OXQS2	219132000	6.75
1915	9489479	OPAL	9HA2265	248219000	4.95
1916	9376658	SICHEM MISSISSIPPI	3FZR9	372464000	8.45
1917	9352016	MAERSK SALALAH	OZDM2	219229000	14.52
1918	9426922	CHEM WORLD	3FOX5	357137000	9.40
1919	9585871	MONTESPERANZA	CQKV	255804750	17.00
1920	9466960	NORTHERN JASPER	A8TA3	636091804	14.50
1921	9450442	FRANKFURT EXPRESS	DGZS2	218364000	14.61
1922	9124469	STOLT ACHIEVEMENT	ZCSQ	319446000	11.85
1923	9619438	MSC ALBANY	D5CC8	636015665	14.52
1924	9281267	MSC ORNELLA	H3RF	354202000	13.50
1925	9461271	BESIKTAS KAZAKHSTAN	TCYR3	271042019	17.80
1926	9592264	NISSOS SERIFOS	SVBJ4	241136000	13.60
1927	9334727	DUGI OTOK	9AA6079	238250000	15.00
1928	9178458	WILSON CLYDE	8PRV	314187000	5.67
1929	9088287	WILSON HAMBURG	C4CL2	210446000	5.81
1930	9164093	AMONITH	5BPK3	210745000	6.25
1931	9263930	BITFLOWER	SBJE	266009000	6.70
1932	9140815	FJELLSTRAUM	9HRQ9	249425000	6.79
1933	9400394	BOW TONE	HPAX	352388000	11.32
1934	9488815	FILIA ARIEA	PIET	244662000	4.35
1935	9372652	TARNBRIS	OZDU2	219015298	8.15
1936	9321433	MINITANK FIVE	9HQB8	256275000	7.30
1937	9435129	BBC OHIO	V2DK9	305246000	7.50
1938	9406685	DELTA IOS	SVAK9	240821000	17.17
1939	9461702	HAFNIA PHOENIX	OUNG2	219487000	13.00
1940	9288837	BRITISH SERENITY	MHNO6	232450000	12.40
1941	9327463	ANEMOS I	A8KS4	636013116	12.50
1942	8516964	RESOLVE EARL	YJTN3	577196000	6.50
1943	9559602	EEMS SERVANT	PBTI	246236000	4.26
1944	1132335	OBELIX	XXXX	0        	1.20
1945	1137402	DD-512	XXXX	null     	2.10
1946	1137401	DD-517	XXXX	0        	2.10
1947	9324875	CMA-CGM JADE	V7NX2	538003035	12.61
1948	9271389	LIN JIE	VRGV6	477770100	17.96
1949	9525883	ALULA	9HA2952	256884000	15.53
1950	9595503	EVER LEADER	9V9289	566794000	14.20
1951	9501370	ESSEN EXPRESS	DCQP2	218474000	15.50
1952	9442158	SEARANGER	VREG3	477192100	15.35
1953	9458195	HACI FATMA ANA	TCZJ4	271042478	7.20
1954	9210050	CARLOTTA STAR	A8IU6	636015031	11.50
1955	9113032	PIONER	UBDK9	273337950	6.54
1956	9472165	COSCO HOPE	VRKF2	477598800	15.52
1957	9401271	ILSE WULFF	A8RU5	636091702	14.50
1958	9428085	SOLERO	SFAP	266420000	9.92
1959	9147710	ANNEGRET	V2LL	304081024	7.84
1960	9153642	JUMBO VISION	PBBG	244379000	7.40
1961	9154232	ALFA BRITANNIA	C6PL4	309225000	13.52
1962	9376488	FRAUKE	V2DB9	305164000	9.08
1963	9609249	IKAN PANDAN	3EZZ9	373556000	12.93
1964	9394959	OVERSEAS YOSEMITE	V7QW2	538003450	14.80
1965	9472012	ALTAMAR	5BMF2	209273000	5.10
1966	9209271	FRONTIER ACE	H3CM	352283000	9.56
1967	9235062	SEQUOIA	LAVB5	258611000	10.72
1968	8209731	LIV KRISTIN	ZDHQ5	236347000	4.16
1969	9213600	RMS GOOLE	V2BJ4	304833000	4.47
1970	9411771	ZEELAND	PBYI	244847000	5.05
1971	9143013	SEA-LAND EAGLE	VRMD9	477195300	13.03
1972	9173355	SIR ALBERT	9HA2536	248832000	8.80
1973	8916504	SICHEM CASABLANCA	MFMR8	232107000	6.39
1974	9238399	ARKLOW ROSE	PBDM	244682000	6.30
1975	8324593	RIVER PRIDE	D5CD4	636015669	3.89
1976	8913708	SOLSTRAUM	LDEB3	257136000	7.01
1977	9631369	ONEGO MARINER	PCOV	246867000	7.20
1978	8412417	SNOWLARK	J8B3277	375203000	3.38
1979	8507365	BEN VARREY	MZMY6	232004486	3.90
1980	9356567	ENNIO MARNIX	PCJX	246782000	5.83
1981	9384447	RN MURMANSK	5BQV2	212231000	9.89
1982	1134104	WALRUS II	PCOM	244750814	2.00
1983	9611539	M.P.R. 3	PCKT	246172000	2.70
1984	8803783	ARCO AXE	MKXH8	232001260	6.28
1985	9528316	SMIT BELUGA	PCBJ	246710000	2.72
1986	9306550	MAERSK SEOUL	A8LK3	636091269	14.50
1987	9232589	GLASGOW EXPRESS	DDSC2	218024000	12.50
1988	9397638	MEDAL	EBYI	225370000	5.79
1989	9640097	LINCOLN PARK	2FQX9	235093505	9.71
1990	9467457	MSC KATIE	3FMO6	351848000	15.50
1991	1137251	B 44	XXXX	0        	3.00
1992	1137252	B 45	XXXX	0        	3.00
1993	9463865	HANOI	ZDKA7	236584000	4.15
1994	9131357	ELISABETH KNUTSEN	2BBI9	235064647	15.65
1995	8215730	ATLANTICA HAV	C6RS3	311164000	4.18
1996	9683477	SAINTY VOGUE	V7CK6	538005276	8.05
1997	9216482	MIKHAIL LOMONOSOV	UBTE3	273343810	5.91
1998	9190171	CAPELLA	ZDGT8	236278000	5.67
1999	9556337	SHOALWAY	5BYP2	212115000	6.00
2000	9272670	NICA	V2OV9	304563000	6.70
2001	9431264	KIRSTEN MAERSK	OYDH2	220530000	9.55
2002	9124419	WILSON BLYTH	9HQP4	249311000	5.49
2003	9148958	STOLT SHEARWATER	ZCRD9	319402000	6.53
2004	9255828	WAPPEN VON BAYERN	A8XB6	636092109	7.42
2005	9175743	CHEM VEGA	V7MZ7	538002930	7.76
2006	8730625	GPS NAPIA	ZQWF9	235053693	3.20
2007	1132748	DE ZEVEN PROVINCIEN ZR.MS.	PAEQ	244911000	7.20
2008	8818752	ANGERMANLAND	ZQVN7	235000970	5.77
2009	9439802	RIDGEBURY ROSEMARY E	V7CT4	538005319	13.08
2010	9704946	COASTAL CHARIOT	PCWZ	244770069	2.10
2011	1134129	PAUL	XXXX	0        	3.00
2012	9454450	CMA-CGM JULES VERNE	FIFW	228032900	16.00
2013	8919037	JO SPRUCE	LAJD7	257511000	10.71
2014	9595450	EVER LASTING	2FRK7	235093618	14.19
2015	9224453	SCF KHIBINY	ELZP5	636011492	17.05
2016	9215878	ANNA SCHULTE	VRCX9	477830600	11.52
2017	9395991	AYANE	9HA2516	248791000	8.40
2018	9468308	NYK ALTAIR	3FWO7	354135000	14.04
2019	9469675	AQUADIVA	SVAN4	241014000	18.20
2020	9635652	MAERSK LANGKLOOF	D5DF2	636015860	13.50
2021	9333761	KUMANO	3EHO5	372192000	10.30
2022	9462718	YM UNANIMITY	BLHL	416466000	13.00
2023	9419450	TRUE.	9HA2353	248412000	14.93
2024	9537094	ORALUNA	ZDKZ6	236111857	7.00
2025	9552422	SOUTHERN HARMONY	HOHI	373508000	18.23
2026	9423621	FAIRCHEM SILVER	V7ZV6	538004924	9.64
2027	9539793	UGURS	TCWW2	271040150	6.07
2028	9518220	NOORDVLIET	PBYS	244650165	5.42
2029	9297515	NORDIC SKIER	ZGEB8	319070500	17.05
2030	9306299	CECILIA	V2BE9	304808000	6.65
2031	9036272	JOHN AUGUSTUS ESSBERGER	CQZV	255816000	6.14
2032	9237149	SADAN BAYRAKTAR	TCRB	271000653	7.50
2033	9276585	MINERVA ROXANNE	SWSZ	240198000	14.77
2034	9108415	CASABLANCA	V2AD7	304010477	4.94
2035	8705254	VERONA	V2UN	304011006	5.29
2036	9400849	HIGH BEAM	3FWP2	354070000	12.80
2037	7635309	MARZAMEMI	IFHK	247686000	5.95
2038	9041318	ASTRA	V2PY2	304010285	5.44
2039	9057238	HENDRIKA MARGARETHA	PDRZ	244246000	5.20
2040	9264386	EN AVANT 10	PCPP	246774000	4.80
2041	9547879	DUTCH POWER	PBTZ	246607000	2.80
2042	9656199	SAPURA TOPAZIO	3FCE7	356835000	7.60
2043	8816156	ALMEDA STAR	C6TJ5	311664000	9.12
2044	9398450	ZIM ROTTERDAM	A8SI8	636014222	15.00
2045	9321500	ELEONORA MAERSK	OVXP2	220477000	16.00
2046	9484948	HANJIN GREECE	A8YC3	636015020	15.52
2047	9333852	MOL ENDOWMENT	3EMV4	371836000	13.51
2048	9660657	STENAWECO VENTURE	D5EA2	636016018	13.00
2049	9359947	SCL ANITA	HBEL	269669000	8.40
2050	9408554	PACIFIC SKY	V7RA9	538003470	14.92
2051	9335044	NCC SUDAIR	HZDE	403509001	12.22
2052	9214161	GOLDEN LYDERHORN	VRCH4	477581600	13.82
2053	9164732	BOW PILOT	S6EN	564978000	7.11
2054	9484807	C. PROSPERITY	VRJO5	477091700	18.20
2055	9275842	CLIPPER CUILLIN	C6UN6	311969000	5.75
2056	9349978	BUDE	V7XL2	538004506	6.28
2057	9349459	FEHN LIGHT	V2FE6	305653000	8.23
2058	9378307	NORGAS CONCEPTION	9V8221	563972000	8.30
2059	9356414	THORCO AMBITION	V2BS2	304909000	7.73
2060	9341316	ATLANTIC WIND	ZDNM4	236111974	8.70
2061	9243318	TORM VALBORG	V7FW9	538005671	14.23
2062	9200158	VINGA SAFIR	OZ2136	231141000	5.18
2063	9223851	GENNARO IEVOLI	9HA3007	229031000	10.50
2064	9559626	EEMS SPIRIT	PBTK	246593000	4.26
2065	9196199	FRI PORSGRUNN	ZDGE6	236238000	5.67
2066	9322970	FORTUNE YOUNGIN	D7MC	440225000	8.39
2067	9410791	CMA-CGM GEMINI	2DDO9	235078078	15.52
2068	9591143	AKAKI	5BUD3	210226000	12.70
2069	9245744	CHARLOTTE MAERSK	OWLD2	220059000	15.02
2070	9164184	BERGE ATLANTIC	LAIP5	259958000	17.11
2071	9627980	NYK HYPERION	VRME7	477220100	15.53
2072	9442562	CHEMROUTE BRILLIANT	3FOT4	370754000	9.87
2073	9484443	MSC ARIANE	3FDA3	373355000	16.02
2074	9589164	PINCHAT	ZCEH3	310640000	14.52
2075	9622502	MERI	OJPH	230941700	4.90
2076	9133513	TARANTO	V2AK2	304010614	4.94
2077	9226970	THORNBURY	C6RS7	311168000	13.50
2078	9144079	PACIFIC TRADER	V7ZH4	538004827	14.82
2079	9636125	MENA C OF RHU	2FDG5	235090339	3.50
2080	9019200	KAROLINE	9HSP8	256374000	6.76
2081	9129134	THULE	DQUG	211245180	5.72
2082	9295490	DP GALYNA	9HA3328	229437000	2.70
2083	9643300	BERGEN TRADER II	DUEH	548859000	14.55
2084	9290684	ALESSANDRA LEHMANN	V2OS4	304677000	5.25
2085	9148570	SMERALDO	IBPE	247697000	6.75
2086	9466374	ALASKABORG	PBUX	245634000	9.69
2087	8304816	NORMAND JARL	LCMQ	257140000	5.60
2088	9346718	VEENDIJK	PBQQ	244694000	6.22
2089	9116008	LEHMANN FJORD	PJAW	306528000	5.70
2090	9153214	FURENAS	OZ2085	231734000	8.00
2091	9566150	ZAO GALAXY	V7YK9	538004682	10.03
2092	9298181	SEYCHELLES PROGRESS	S7TQ	664296000	11.70
2093	9126352	LADY MENNA	PFXO	246067000	5.31
2094	7725685	NURAN ANA	ERMN	214181314	8.33
2095	9410765	CMA-CGM CASSIOPEIA	2CRJ3	235075117	15.50
2096	9395159	HAMBURG BRIDGE	3FVW2	372724000	14.04
2097	9038919	PARIS EXPRESS	ZCEK9	310673000	13.50
2098	8814201	CLARITY	J8B4948	375067000	3.66
2099	9393383	SICHEM ORCHID	9HNC9	249213000	7.45
2100	9479242	HYUNDAI ATLANTIC	VRKI3	477413800	18.23
2101	9309382	FAOUET	LXFB	253171000	11.21
2102	9226932	MSC BARBARA	HODU	353775000	14.50
2103	9592721	ALMERIA	A8WA7	636014704	12.80
2104	9281487	MYKOLA BOBROVNYKOV	UUAU	272453000	4.86
2105	9654581	FRONT DEE	V7AX6	538005088	13.30
2106	9421635	RIMINI	PHJC	244218000	4.26
2107	9396335	HISTRIA TIGER	A8PW3	636013848	11.00
2108	8222185	FEHN CARTAGENA	ZDFO9	236194000	4.32
2109	9309435	MINERVA ALICE	SVBK9	241153000	14.82
2110	9192375	LAGUNA D.	PBSH	246580000	8.79
2111	9260495	MAR MARIA	9HA2859	256435000	6.00
2112	9081306	MITIQ	CFN6556	316025029	8.51
2113	9352315	SEACOD	DDPW	218019000	11.00
2114	9462744	AERANDIR	PBUE	244144000	5.42
2115	8912039	SKOG	5BPF3	210488000	5.85
2116	9184029	VICTORINE	ONDO	205509000	6.50
2117	9113599	TULOS	UANJ	352177000	4.22
2118	9163582	KRISTIN-D	C6XA6	311003700	4.30
2119	9190054	RT SPIRIT	PIAE	245685000	6.10
2120	9382463	BALOE	PBGI	245431000	1.95
2121	9595486	EVER LIBRA	BKIC	416475000	14.20
2122	9200811	OAKLAND EXPRESS	VRMU9	477904300	13.55
2123	9339662	MOL COMPETENCE	C6XF5	311007300	14.54
2124	9352028	MAERSK SAVANNAH	OZDQ2	219231000	14.52
2125	9242326	MTM MANILA	9V2086	566915000	11.80
2126	9314222	XIN HONG KONG	VRCH5	477593600	15.03
2127	9466867	CSCL STAR	VRHM7	477963800	15.50
2128	9225665	MSC LAURA	H9UE	354092000	14.50
2129	9446374	MARE DORICUM	IBCQ	247275900	17.05
2130	9453535	SARONIC TRADER	A8XI3	636014899	14.90
2131	9236547	MSC FLORIDA	A8GJ5	636091394	13.20
2132	9149524	STOLT SPAN	ELVQ7	636010915	10.10
2133	9225005	JOHN OLDENDORFF	9HA3181	229262000	17.65
2134	9203588	ASIAN DYNASTY	D7NS	440085000	10.00
2135	9468085	ALINA	V2EL6	305469000	8.00
2136	9310317	LEXUS	OXVC2	219157000	6.51
2137	9664720	STENAWECO GLADYS W	V7AG9	538004994	13.04
2138	9130432	BF FORTALEZA	5BWG2	212723000	6.69
2139	8521127	SIRIUS	YL2844	275445000	3.20
2140	9579456	H&S FAIRNESS	PCML	246822000	4.15
2141	9258624	APATURA	ZDGL7	236260000	9.17
2142	9142514	MEDEMBORG	PJAG	306581000	7.10
2143	1010571	MEGAN	ZGBW2	319039900	2.90
2144	9280639	CMA-CGM ROSSINI	FZQU	635026000	14.50
2145	9334143	CMA-CGM ONYX	9VBM5	565692000	12.61
2146	9612052	KARVOUNIS	C6AA3	311073600	16.40
2147	9472141	COSCO FAITH	VRJL6	477108100	15.52
2148	9304318	SICHEM PALACE	S6AV8	564823000	7.56
2149	9371579	FAIRPLAYER	PHPU	245554000	8.10
2150	9227273	CAP TALBOT	ELZU6	636015524	12.50
2151	9285419	CS VANGUARD	C6S2087	311554000	10.65
2152	9118006	ANNE	C6UH3	311913000	4.27
2153	9147461	BOW BALEARIA	LAJW7	257719000	6.79
2154	9329837	SANTA ELENA	9V8977	564476000	12.57
2155	9447768	FLAGSHIP IRIS	V7ZC2	538004786	13.30
2156	9241803	CIELO DI ROMA	IBCK	247088500	10.50
2157	9576753	REBECCA SCHULTE	9V8577	565015000	9.20
2158	9118135	FEDERAL MAAS	8POB	314079000	10.74
2159	9333814	CHIBERTA	FMLN	635014100	8.89
2160	9370771	YARRAWONGA	3ERJ5	370067000	14.43
2161	8918459	WILSON SKAW	8PAK4	314420000	6.68
2162	9428499	POMORYE	UBLE7	273317180	9.91
2163	9371804	MONA SWAN	9HIK9	249024000	8.00
2164	9642019	STENAWECO SPIRIT	D5BM3	636015556	13.30
2165	9306419	CENTA	V2BV9	304940000	6.70
2166	9288928	CAPE BEALE	V7HF8	538090338	11.20
2167	9498834	TONDA SEA	A8YF8	636015043	14.90
2168	9592575	REGGEBORG	PCYE	244810617	9.72
2169	9521368	FLINTER ROSE	PBUB	246227000	6.15
2170	9527855	ALICANTE	9HA3012	229037000	15.00
2171	9405851	AL-AMERAT	3FRY4	370706000	13.20
2172	9341445	MAERSK BORNEO	9VBU7	565343000	9.50
2173	9467225	DOUWE-S	PBMO	244956000	5.30
2174	9534250	MARIA ELISE	D5HS8	636091859	6.04
2175	8603547	SEA EXPLORER	3EFD2	352384000	6.07
2176	9414034	MARAN SAGITTA	SVAQ6	240892000	15.02
2177	9629055	EVER LUCID	BKIY	416509000	14.50
2178	9642801	DIAMOND OCEAN	VRMF8	477942600	14.47
2179	9461051	HAMBURG EXPRESS	DFKM2	218774000	15.50
2180	9468293	NYK ADONIS	3EUI3	354848000	14.54
2181	9301029	AMBROSIA	C6VK2	309368000	14.28
2182	9221827	BUXCOAST	DQXQ	211425360	14.50
2183	9223916	CHEMBULK SHANGHAI	9VFG9	565718000	9.83
2184	9055709	FEGULUS	E5U2319	518369000	9.07
2185	9184859	HOEGH TREASURE	LAKC6	258782000	10.02
2186	9505338	CONSTANCE	ZDKL7	236622000	5.30
2187	6808090	ALVA	J8B4361	377085000	4.30
2188	9504102	PIONEER	PBWO	246646000	7.80
2189	9014717	WILSON BREMEN	9HJV9	249076000	5.50
2190	9479694	SMIT ANGOLA	ORQP	205634000	5.20
2191	9240718	ROSA TOMASOS	C6ST6	311467000	11.22
2192	9537044	RHOURD EL FARES	7TQJ	605076052	10.42
2193	9333802	CHANTACO	FMLM	228330700	8.89
2194	8917924	FURE SUN	OZ2079	231710000	8.32
2195	9432206	BELTNES	V2EG7	305426000	10.70
2196	8505886	SMITBARGE 2	XXXX	0        	6.15
2197	9155054	NORMAND ATLANTIC	LNNI	259435000	7.79
2198	9143544	KOBE EXPRESS	DGSE	211262460	13.63
2199	9456783	MAERSK ESSEN	V7UQ8	538004007	15.50
2200	9331244	KAMAKSHI PREM	V7PM3	538003256	20.85
2201	9462706	YM UBIQUITY	BLHM	416467000	15.00
2202	9398084	MAERSK HAKONE	9V8312	564531000	21.03
2203	9467407	MSC LAUREN	3FZR5	353428000	15.50
2204	9420710	BOCHEM OSLO	3EWI5	372066000	11.35
2205	9323778	BOW FUJI	3EIG7	372171000	9.79
2206	9194139	HILDEGAARD	C6QU3	308574000	13.52
2207	9460033	NAVIOS POLLUX	3FPO2	370290000	18.20
2208	9179256	ATLANTIC REEFER	D5FE2	636016238	9.70
2209	9502312	GREEN MOUNTAIN	V7ZQ7	538090454	11.70
2210	9300788	NORDIC OSLO	OZDX2	219233000	8.71
2211	9404625	CORAL LEAF	PHNI	244036000	7.50
2212	9313656	RODAU	V2OP3	304628000	5.50
2213	9081291	EEMSGRACHT	PDXQ	245483000	8.50
2214	9142526	SEA EMS	V2BR6	304905000	4.45
2215	9222429	CELINE	PJKC	306766000	4.78
2216	9226700	PANTHERA	V2FA5	304225000	7.25
2217	9361354	BORNHOLM	PHNK	244234000	5.95
2218	9436343	GRAZIA	ICMW	247240100	12.60
2219	9241657	SILVER ROAD	DSRL2	441897000	17.97
2220	9502908	HANJIN EUROPE	2FLR9	235092304	15.52
2221	9193317	ROTTERDAM EXPRESS	DMRX	211335760	13.55
2222	9467445	MSC KATRINA	3EZD3	373404000	15.50
2223	9349813	MSC CARMEN	3EQT	354530000	13.50
2224	9254654	STAR JAPAN	LAZV5	257329000	12.00
2225	9239628	OVERSEAS GOLDMAR	V7HO8	538002278	12.20
2226	9485863	SIVA ROTTERDAM	3EYW9	373474000	9.72
2227	9236511	MERKUR BAY	9HA3250	229341000	11.50
2228	9385879	GRUMANT	UFCK	273318940	9.91
2229	9567477	ZHE HAI 505	BLWN	413442980	10.80
2230	9000613	VITIS	3FKC6	352099000	6.20
2231	9395616	DS AGILITY	A8LD9	636091254	8.50
2232	9520998	ID BLACK SEA	3EUR9	373570000	9.82
2233	9358890	BALKAN	9HYK8	256600000	9.90
2234	9466013	TORM AGNETE	9V2615	564452000	12.60
2235	9566708	HENDA	9HA2977	256992000	7.09
2236	9183570	PHILINE SCHULTE	ZIRO6	235004280	7.74
2237	9367231	BOMAR CERES	9HDE9	256815000	6.36
2238	9125059	WILSON CHATHAM	V2CA5	304195000	5.67
2239	9178068	CHANCE	SXXW	240005700	12.65
2240	9187928	TRANSCAPRICORN	ZDNJ4	236111945	6.31
2241	9250373	DC VLAANDEREN 3000	PBGG	245381000	6.30
2242	9178197	STOLT CONCEPT	ZCSP2	319479000	11.87
2243	9501356	HONG KONG EXPRESS	DJAZ2	218426000	15.50
2244	9301811	LAHORE EXPRESS	VRBY8	477241800	11.00
2245	9302982	GENMAR HARRIET G	A8IT4	636012884	16.01
2246	9619933	MARIE MAERSK	OWJF2	219018765	16.00
2247	9198575	CLIFFORD MAERSK	OYRO2	219840000	14.52
2248	9289116	MSC RITA	3EBW6	371245000	14.50
2249	9460916	UNITED CHALLENGER	9VHC6	565845000	14.43
2250	9436381	ASKHOLMEN	V7RU4	538090388	9.01
2251	9187409	STEN FJORD	ZDGF3	236243000	8.45
2252	9311751	ELBTANK ITALY	A8PR7	636091593	11.21
2253	8230572	VODLA 2	UAKV	273328100	3.86
2254	9164495	NORTHERN OCEAN	OZ2091	231754000	8.53
2255	9242558	LAURA ANN	V2AR8	305600000	8.70
2256	1133498	SB-7020	OVUZ	0        	3.40
2257	9137284	HERTFORDSHIRE	ZDJS5	236563000	4.80
2258	9313802	DAGNA	PHDE	246371000	6.09
2259	1134127	JOHN	XXXX	0        	3.00
2260	8951906	JUMBO	PFFL	244045000	1.59
2261	9302073	GEORGE WASHINGTON BRIDGE	3EES2	371799000	14.02
2262	9173082	SUCCESS ALTAIR XLII	YBLZ	525018427	8.52
2263	9356309	CMA-CGM HYDRA	2BTO8	235069238	15.05
2264	9493133	SILVER RAY	D5DR6	636015953	9.71
2265	9629043	EVER LINKING	2GLI9	235098383	14.20
2266	9323429	KHK VISION	9VDZ4	565394000	22.00
2267	9274094	COMPASS	9V2886	565135000	14.42
2268	9102071	STOLT CONFIDENCE	ZCSP3	319468000	11.90
2269	8906303	VITA	V2TV	304010455	5.46
2270	9539743	UNI WEALTH	VRFV4	477621200	10.06
2271	9466001	TORM ALEXANDRA	9V2614	564458000	12.60
2272	9665554	SENTINEL	D5FA7	636016214	13.30
2273	9325142	SIEGFRIED LEHMANN	V2GL5	305982000	5.25
2274	9491733	WILSON FARSUND	8PAE7	314377000	5.80
2275	9397547	PRISCO ALEXANDRA	5BLR2	212420000	13.16
2276	9001813	HAV SNAPPER	C6XN4	311014800	4.61
2277	9122227	CONGER	V2OO5	304616000	6.55
2278	9431032	NIKE	9HA2013	249803000	6.80
2279	9380477	SEASPRAT	DDSJ	218057000	11.00
2280	9649029	SEVEN WAVES	2GZA5	235101697	7.20
2281	9568615	NEPTUN 10	ZDJQ8	236111629	4.00
2282	9312781	NYK VEGA	3EIJ5	372218000	14.52
2283	9525869	AIN SNAN	9HA2887	256603000	15.52
2284	9330068	MAERSK SURABAYA	DDSX2	218029000	14.50
2285	9344069	EPSON TRADER	DUAH	548801000	14.42
2286	9411020	NS BURGAS	A8TG7	636014349	17.00
2287	9145140	KINE	C6WT4	311117000	4.94
2288	9669653	CIELO DI GAETA	9HA3467	229632000	10.48
2289	8920282	LISTRAUM	LDRY3	257159000	7.01
2290	9066071	SYAM	UICW	273414060	4.22
2291	9015462	DORNUM	V2OZ	304010417	4.35
2292	9195638	YVONNE K	PBLX	244948000	5.42
2293	9322839	STENA ATLANTICA	ZCPR7	319161000	14.94
2294	9306407	CREOLA	V2BP3	304888000	6.60
2295	9637210	AMBER CHAMPION	VRLG7	477243400	13.30
2296	9308546	EVINCO	SFZX	266201000	9.78
2297	9491757	WILSON FEDJE	8PAH4	314397000	5.80
2298	9353046	RUSICH-5	UBHY	273317430	4.34
2299	9378723	STEN SUOMI	LADP7	259768000	8.90
2300	9518256	SARDIUS	PCLD	246798000	6.15
2301	9425980	STOLT MEGAMI	V7PL3	538003254	9.45
2302	9362152	RAMIRA	SBKF	266310000	9.02
2303	9312717	GOMERA	V2GM4	305996000	6.14
2304	9498286	NORTHERN DANCER	ZDJZ8	236588000	10.30
2305	9295775	AMSTELSTROOM	PIAS	246203000	2.85
2306	9398462	TIANJIN	A8SJ2	636014224	15.00
2307	9143568	LONDON EXPRESS	DPLE	211262630	13.63
2308	9261712	MOL ENCORE	HOWM	357249000	13.54
2309	9622631	NYK HERMES	VRLZ3	477832500	15.53
2310	9352559	PHOENIX VANGUARD	9VFL6	565550000	22.47
2311	8709767	DAN FIGHTER	OVUE2	220387000	3.39
2312	9521394	INDIAN FRIENDSHIP	D5EG2	636016068	18.20
2313	9484479	MSC TRIESTE	9HA3459	229622000	16.00
2314	9505986	IVORY RAY	A8YK4	636015074	9.53
2315	9246619	ALITIS	9HHG7	215235000	12.30
2316	8504181	MERMAID I	3FCD7	370845000	4.15
2317	9417787	SARK	A8NW2	636013572	14.80
2318	9301603	SEELAND	MNUN2	235011600	5.70
2319	9366134	OSLO CARRIER 2	9V7736	566838000	7.70
2320	9391127	STRAITVIEW	9HBX9	256765000	5.60
2321	9156199	NINA	C6WA8	311026000	4.80
2322	9345219	TEQUILA	V7MP3	538002883	8.71
2323	9166481	LIAMARE	PBBH	245455000	6.24
2324	9155884	LEHMANN SOUND	V2EM3	305476000	5.70
2325	9577604	INTERLINK VERITY	V7VP5	538004179	10.40
2326	9507582	TYPHOON	PHTY	245889000	3.30
2327	9282510	ELIXIR	V7BO8	538005182	12.80
2328	8521696	JOSEFINE	OJKU	230954000	3.95
2329	9535539	BESIKTAS GALATA	9HA2226	248178000	5.80
2330	9454802	ODER	V2DM9	305261000	6.03
2331	9256078	LITEYNY PROSPECT	A8AP6	636011642	13.50
2332	9421647	EEMS SKY	PHJF	244239000	4.26
2333	9151890	TARNDAL	OWQA2	219514000	7.52
2334	9371426	PICTOR J	5BEE3	209204000	8.70
2335	9534547	FRISIAN SEA	PCLF	244780424	6.10
2336	9361720	ARKLOW FAME	EIXN	250000817	5.84
2337	9591569	COASTAL VANGUARD	PCFH	246743000	3.20
2338	9508794	AMELAND	PBVF	246629000	7.20
2339	9450428	NAGOYA EXPRESS	DGWD2	218350000	14.61
2340	9516428	COSCO ENGLAND	VRML8	477652300	15.50
2341	9202649	MSC DIEGO	3FZP8	357106000	13.00
2342	9462017	APL SOUTHAMPTON	9V9399	566409000	15.50
2343	9526083	ONEGO ST.PETERSBURG	PCJP	245086000	6.54
2344	9539949	DENIZ A	9HA2855	256394000	6.05
2345	9115913	JULIETA	V2QP4	305992000	4.93
2346	9364148	MARIT	PBLH	246127000	6.90
2347	9365984	FLINTERCAPE	PBOQ	246043000	7.72
2348	9172167	IEVOLI SHINE	IBDQ	247326000	7.73
2349	9664445	WORLD SAPPHIRE	LASU7	258996000	6.15
2350	9172870	BETTY KNUTSEN	LAMC5	257392000	11.52
2351	9314179	LORELEI	V7CD3	538005244	14.22
2352	9374686	JOLYN	PJWG	306813000	5.20
2353	9199684	ZEUS	V2OR	304011025	4.49
2354	9184653	VEERSEBORG	V4BY3	341599000	7.05
2355	9006382	SEA MELODY	8PAG7	314391000	5.47
2356	9434589	ANMARE	V2EO3	305493000	5.49
2357	8764315	E 1601	XXXX	0        	2.22
2358	9635676	SAFMARINE BOLAND	V7ZT8	538004912	14.50
2359	9454400	CMA-CGM CORTE REAL	2CXB8	235076499	15.50
2360	9339583	HAMMONIA POMERENIA	A8MG6	636091342	10.10
2361	9393395	SICHEM LILY	9HNE9	249209000	7.45
2362	9330070	MAERSK SEMARANG	LXSR	253146000	14.50
2363	9302176	HENRY HUDSON BRIDGE	3ETK4	370587000	14.04
2364	9290490	KING EDWARD	V7GQ4	538090266	11.22
2365	9348297	PATRAS	9HDA9	256809000	8.39
2366	9214733	LAIDA	EAVE	224509000	6.20
2367	9243928	SCOT VENTURE	VSSO2	235437000	4.92
2368	9442512	YASA H. MULLA	TCMY4	271042868	14.60
2369	9631357	ONEGO NAVIGATOR	PCOU	245237000	7.20
2370	9448152	TONNA	A8RE5	636014083	12.20
2371	9499541	AHMET CIHAN	TCTO6	271002713	6.33
2372	9133082	MAERSK CAITLIN	S6AN4	566504000	12.21
2373	9438937	MONTEMURO	CSYU4	263602560	4.00
2374	9376828	NORD SNOW QUEEN	9V7636	564359000	11.62
2375	9699268	GIAN LORENZO BERNINI	LXPQ	253179000	3.50
2376	9363027	TAMPA	9HHA9	256974000	18.30
2377	9631993	APL VANDA	S6LT8	566954000	15.52
2378	9665619	THALASSA PISTIS	9V2230	564019000	15.80
2379	9143697	CHAMPION EXPRESS	A8QN4	636013969	11.35
2380	9307217	XIN LOS ANGELES	VRBX6	477158700	15.03
2381	9406738	HANJIN UNITED KINGDOM	HOMK	355573000	15.02
2382	9619919	MAJESTIC MAERSK	OWJD2	219018501	14.50
2383	9082336	APL TOURMALINE	9VVP	563858000	13.02
2384	9295361	MSC TOKYO	A8JM6	636091116	14.50
2385	9340128	NORDIC HANNE	A8MR9	636013405	9.55
2386	9459967	YULIA	A8ZJ3	636092253	10.10
2387	9507908	E.R. BEILUN	LXDB	253366000	18.20
2388	9186687	WESER STAHL	P3LS8	212848000	10.50
2389	9321689	SOLVIKEN	LAJC6	258682000	14.90
2390	9195810	ANTONIA	OJOX	230011000	6.28
2391	9433808	SUNSHINE EXPRESS	3FWP5	371294000	12.92
2392	9215256	BOW SPRING	LADW6	257514000	11.52
2393	9617301	RMS BREMEN	5BLX3	210041000	5.55
2394	9343895	ARIS T	SVHY	240626000	14.72
2395	8510295	MARTIN	GGCA	232002159	3.89
2396	9610391	SUPREME ACE	3ETV4	357147000	9.82
2397	9279056	MEREL V	PHDK	246395000	4.85
2398	9528720	GRETA-C	2BTR9	235069271	8.35
2399	9121699	TERNLAND	OWIT2	219084000	8.10
2400	8813051	RIVER TRADER	D5CD5	636015670	3.89
2401	9173161	DELFIN	ZDGT7	236277000	5.65
2402	9525900	MALIK AL ASHTAR	9HA2983	229006000	15.53
2403	9546899	CAPE SUN	VRFM3	477691700	18.25
2404	9226425	NILEDUTCH PALANCA	9HA3481	229646000	11.40
2405	9352042	MAERSK STOCKHOLM	VRGW3	477770200	14.50
2406	9447902	MSC FILLIPPA	A8XT7	636092168	15.50
2407	9275971	MSC MARINA	HPSB	354972000	14.50
2408	9247065	BORAQ	HZZX	403557000	12.00
2409	9299214	OTTOMANA	IBMT	247152100	9.96
2410	9545039	ABIS BORDEAUX	PBQA	246474000	5.35
2411	9348285	HENG SHAN	3EHY4	372287000	18.10
2412	9279111	MTM TOKYO	VRHZ4	477866900	10.03
2413	9147708	GRIETJE	V2LN	304081008	7.84
2414	9006423	FALCON	MPER7	232002153	4.02
2415	9139294	HAPPY RIVER	PCAW	244559000	9.51
2416	9014949	SKY VITA	V2PU8	304768000	5.44
2417	9532812	BEAUFORTE	PCKN	246795000	7.20
2418	9256420	PANDION	SBHP	266005000	7.50
2419	9244180	CONMAR ELBE	5BQU3	209724000	6.99
2420	9479711	LIKYA C	9HA2116	249994000	6.92
2421	9385893	FRISIANA	PCEQ	246602000	6.80
2422	8912508	GREAT STAR	3FEX9	370755000	10.33
2423	9307671	STEN BALTIC	LADY6	257519000	8.40
2424	9137870	LEZHEVO	UAUZ	273336000	5.40
2425	9489534	KELT	PBTL	246594000	5.25
2426	7612498	ARESSA	UBZF2	273334930	4.10
2427	9213703	REMORA	V2OF6	304107000	3.20
2428	9686285	AL BAHAR (HUTA 12)	XXXX	0        	5.00
2429	9594846	EAGLE SAN JUAN	9V9333	566644000	17.22
2430	9307229	CSCL PUSAN	C4NK2	209251000	14.50
2431	9478999	SANTA RITA	3EVQ9	351811000	12.57
2432	9519365	NAUTICAL DREAM	D5FL6	636016304	18.24
2433	9301794	JAKARTA EXPRESS	VRBR5	477105300	12.72
2434	9263540	VARNADIEP	PBIB	244729000	7.05
2435	9505314	ACCUM	ZDKA8	236583000	5.30
2436	9198630	ANTJE K	PBHS	245472000	5.64
2437	9378735	STEN BOTHNIA	LAEF7	259769000	8.90
2438	9546447	HARTURA	ICBM	247285200	7.79
2439	9145059	OKYALOS	5BDZ2	212511000	13.77
2440	9230127	MICHAEL S	9HQZ9	249393000	11.92
2441	9466142	SCOTT SPIRIT	C6YA8	311027400	15.00
2442	9491745	WILSON FLUSHING	8PAH3	314396000	5.80
2443	9261073	HR ENDEAVOUR	D5AY6	636092359	8.00
2444	9255684	MINERVA ZOE	SYBC	240176000	14.92
2445	9291561	KEY BAY	ZDIJ4	236446000	6.00
2446	9005754	WILSON DOVER	8PUH	314251000	5.08
2447	9592288	NISSOS SANTORINI	SVBM4	241164000	15.02
2448	9370276	BLUE BAY	V2CE6	304519000	5.40
2449	9571612	HAYDEE	HP3989	355146000	10.80
2450	7034969	KLEVSTRAND	OWFM6	219128000	3.02
2451	9420332	CRESTWAY	5BLJ2	210912000	5.70
2452	9357494	ISIS	PHLD	244768000	6.09
2453	9520572	FAIRPLAY-27	9HZE9	249735000	4.66
2454	9465318	CMA-CGM MARGRIT	A8YN6	636092211	15.50
2455	9557721	AMT CHALLENGER	XXXX	0        	6.50
2456	9462732	YM UNICORN	BLHI	416464000	15.00
2457	9321249	MOL CHARISMA	C6WN8	308015000	14.54
2458	9308649	MAERSK SINGAPORE	A8LW6	636091305	14.00
2459	9473731	HYUNDAI TOGETHER	D5BF7	636015514	15.50
2460	9295440	WILHELMINE ESSBERGER	PCAS	244961000	7.41
2461	9456680	LAKE DOLPHIN	ONHA	205602000	18.20
2462	9197466	PAULA	V2LK	304010228	7.84
2463	8408870	TROPICAL REEFER	C6FR7	311086000	9.74
2464	9467562	ORIENT TIGER	9HA2768	215617000	9.80
2465	9088328	UR 3	LK5665	0        	4.90
2466	9308596	VEGA POLLUX	V2BK5	304846000	8.80
2467	9513244	EAST	PJHW	0        	3.50
2468	9434864	SOUTH	PJKE	306863000	4.10
2469	9113056	AUDRE	LYJV	277088000	6.40
2470	7800784	ZHEN HUA 8	J8B2817	377488000	8.50
2471	9380647	NORTH	PJUN	306818000	3.50
2472	9539925	ARDMORE SEAVENTURE	V7AD2	538004968	12.90
2473	1133867	LASTDRAGER 19	XXXX	0        	3.60
2474	1012359	COMO	ZGDQ9	319059500	3.00
2475	9466245	COSCO GLORY	VRIR7	477795300	15.50
2476	9497220	MAGSENGER 3	VRIK6	477397100	14.50
2477	9455894	PHOENIX BEAUTY	3FTE3	371971000	17.70
2478	9288734	SEABRAVERY	9HZS7	215782000	14.92
2479	9231119	BRIGHT HORIZON	V7DP7	538090124	11.20
2480	9266140	FIRST BROTHER	9HA3286	229381000	10.02
2481	9390991	GOLFSTRAUM	LAJK6	258849000	7.74
2482	9375903	OHLAU	V2CW2	305123000	5.50
2483	9356921	MATTHEW	CQOT	255802940	6.50
2484	9215050	MAERSK PROSPER	S6CF8	564097000	15.45
2485	8920256	RMS NEUDORF	V2AI5	304010916	4.47
2486	9664706	POLAR ONYX	LAQD7	258768000	7.60
2487	9212412	SEA RIDER	V7MB6	538090294	11.02
2488	8012815	TSM CLARITY	A9D3219	408528000	3.39
2489	9655016	BRISOTE	PCQO	246881000	4.45
2490	9501332	NEW YORK EXPRESS	DIXJ2	218776000	15.50
2491	9621259	FRONTIER WAVE	7JMO	432876000	18.03
2492	9313931	MAERSK BROOKLYN	OZDA2	219215000	13.50
2493	9654579	FRONT CLYDE	V7AY3	538005093	13.30
2494	9314777	AMALIE ESSBERGER	CQLV	255805370	7.35
2495	9228370	ORANGE SKY	ELZU2	636011527	10.42
2496	9408190	GLORYCROWN	V7BH8	538005144	17.00
2497	9328560	NAVIOS NORTHERN STAR	9HA3413	229568000	13.84
2498	9323326	JURKALNE	V7KR7	538002667	12.52
2499	9367774	FRISIAN SPRING	PHII	246571000	6.10
2500	9264271	CAPE BRADLEY	V7FK7	538001963	11.10
2501	9304332	CELSIUS MUMBAI	V7CU2	538005324	9.68
2502	9380582	STONE I	9HHM9	256994000	11.52
2503	9057288	VASILIY SHUKSHIN	V3VP	312047000	4.88
2504	9594054	ORIENTAL LOTUS	ZGBC3	319150000	8.81
2505	9528304	SMIT BUFFALO	PBME	245038000	2.72
2506	9333462	KAISA	9HRF9	249399000	5.25
2507	9130224	TALLIN	V2PA1	304010867	5.72
2508	9119634	REBECCA HAMMANN	DFVI	211230400	4.48
2509	9371725	ENDELO SWAN	OUYR2	219426000	5.96
2510	9224116	VANGUARD	2HBU7	235103520	4.92
2511	8817356	FAUSTINA	J8B2820	377493000	4.95
2512	9576703	KARELIA	3EXN6	370039000	5.82
2513	9281592	AMADEUS	PBJK	244316000	3.78
2514	8419635	SORMOVSKIY-3057	UCVL	273325400	4.25
2515	9142540	MARKBORG	PJDQ	306554000	7.12
2516	9502958	HANJIN HARMONY	2GBC4	235095936	15.52
2517	9200823	HALIFAX EXPRESS	VRMW7	477133700	13.55
2518	9635640	MAERSK ELGIN	D5DE9	636015859	14.50
2519	9466972	NORTHERN JAGUAR	A8TA4	636091805	14.50
2520	9484895	AMORINA	A8YE5	636015036	12.22
2521	9074119	ANANGEL AMBITION	SYAV	239337000	17.52
2522	9290373	BESIKTAS BOSPHORUS	TCOG3	271000817	16.96
2523	9315367	SPYROS	SWXJ	240593000	22.50
2524	9130456	ALPHAGAS	V2KA7	304050635	7.35
2525	9006370	BETTINA K	PBEW	246193000	5.47
2526	9182978	STAR ISFJORD	LAOX5	257615000	12.32
2527	9581007	DUZGIT ENDEAVOUR	TCTW2	271043022	8.85
2528	9549633	LAZURITE	UBLC	273338540	6.41
2529	9380489	SEAMARLIN	DDSL	218085000	11.00
2530	9313759	WILSON ASTAKOS	9HA2370	248448000	5.14
2531	9017379	WILSON HUSUM	8PSQ	314208000	5.63
2532	9601510	VOS SHINE	PCNU	246060000	4.60
2533	9183465	CEMBAY	P3VT7	212542000	6.11
2534	9442184	ELISABETH	VRES3	477173500	5.41
2535	8133827	MTS TAKTOW	MBGN	235050126	2.70
2536	9262742	UNION SOVEREIGN	ORQW	205644000	6.20
2537	1137551	LIMOSA 2	XXXX	null     	2.00
2538	9224958	CMA-CGM MANET	C4ZT2	212236000	11.01
2539	9595448	EVER LADEN	3FXM3	373721000	14.23
2540	9546801	AM PORT CARTIER	3FVJ6	354124000	18.24
2541	9261736	MOL ENDURANCE	HPLT	355109000	13.54
2542	9587362	PERCIVAL	5BDC3	209082000	18.40
2543	9631979	APL RAFFLES	9V5388	566881000	15.52
2544	9462031	APL YANGSHAN	9V9401	566482000	15.50
2545	9399040	MSC IRENE	3EZQ6	355233000	15.50
2546	9386378	LESSOW SWAN	OWML2	219479000	6.74
2547	9518995	DORADODIEP	D5BQ4	636015582	5.97
2548	9351830	SALVICEROY	S6HA6	565337000	5.20
2549	9158616	ASIAN CAPTAIN	3FLH8	356434000	10.01
2550	9051791	COLD STREAM	PJRH	306216000	9.31
2551	9378618	LR2 PIONEER	VREE7	477114400	15.04
2552	9228849	KING ERIC	V7DB9	538090273	11.22
2553	8413019	SUMMER FLOWER	C6RO2	311122000	9.50
2554	9446867	HERO	A8VA8	636091972	18.30
2555	9630729	LINDSAYLOU	V7GK8	538005723	12.95
2556	9418482	STRIDE	9V9026	566907000	14.90
2557	9171072	ATHOS	ZDFN3	236189000	5.50
2558	9448346	HHL TOKYO	V2FH9	305680000	9.50
2559	9501277	BBC VIRGINIA	V2EK8	305463000	7.50
2560	9344540	ARKLOW RAIDER	EIXS	250001268	5.68
2561	9566796	ANNA	ZDKC9	236592000	9.30
2562	9385881	MERIDIAAN	PCBO	246358000	6.80
2563	9256298	MAERSK KALEA	9VHF3	565814000	12.32
2564	8616269	MTS VENGEANCE	MTCK2	235056099	3.18
2565	9618240	REIMERSWAAL	PGZK	244116000	7.10
2566	8611192	BOUNDER	V2AU3	304011009	4.70
2567	9330185	JANA	DFIH	211809000	3.70
2568	9556038	KING FISHER	PCVY	244790950	6.30
2569	9397614	CMA-CGM JASPER	A8SD6	636014200	12.60
2570	8758603	CASTORO SEI	C6DF4	308162000	16.50
2571	9312999	NYK ORION	3EPU6	352822000	14.04
2572	9219800	CHASTINE MAERSK	OZZB2	219933000	14.52
2573	9344796	FAIRMOUNT GLACIER	PBNC	245355000	6.90
2574	9384590	FRONT KATHRINE	V7QX2	538003455	21.50
2575	9278791	FEDERAL NAKAGAWA	VRAT7	477960100	10.73
2576	9268174	ATLANTIS ALVARADO	9HA2203	248145000	5.70
2577	9283459	WISBY VERITY	PCTJ	245291000	7.10
2578	9169861	CLIPPER CHAMPION	C6OH9	309711000	8.20
2579	9483827	ZEYNEP K	V7TK8	538003822	14.45
2580	9310707	CHALLENGE PASSAGE	3EAT3	371005000	12.62
2581	9391957	ZAPPHIRE	9HA2214	248159000	12.60
2582	9197296	BOW STAR	S6BK3	565397000	13.30
2583	9170420	MERSEY FISHER	ZDFY4	236216000	6.02
2584	9210282	BBC NORDLAND	ZDFN4	236187000	7.50
2585	9320063	ASTINA	SHZA	266220000	8.01
2586	9434151	TIM	5BLC2	212571000	5.30
2587	9617698	CORAL ENERGY	PCQG	246878000	7.35
2588	9353137	CPO ITALY	2AJP9	235060251	11.51
2589	9503536	EEMS SPACE	PHPM	245471000	4.26
2590	9559573	MTS VANQUISH	2HFK5	235103213	3.63
2591	9356311	CMA-CGM MUSCA	2CAC8	235070928	15.52
2592	9560144	HUA HAI LONG	BSNK	412036000	7.50
2593	9621481	ENSCO 121	D5AR3	0        	6.70
2594	9501368	SHANGHAI EXPRESS	DJBF2	218427000	15.52
2595	9255294	NESTE	OJLI	230965000	10.90
2596	9207443	ERGINA LUCK	D5EQ9	636016139	13.24
2597	9208459	ANKE EHLER	DFPP	211325530	7.09
2598	9034731	TOUR MARGAUX	9HBW8	215819000	8.00
2599	9376440	CFL PROSPECT	PHLG	244789000	6.08
2600	9223722	AMBASSADOR NORRIS	H9AH	355828000	12.12
2601	9493585	YUAN FU STAR	VRJP6	477135500	18.20
2602	9290074	VICTORIA	V2BQ5	304587000	7.36
2603	9344966	MAGNUS	V2BX5	304953000	5.80
2604	9388704	SICHEM EAGLE	9VNR6	565913000	10.01
2605	9083134	FAIRLOAD	PEBP	246335000	6.79
2606	9001904	GREEN KLIPPER	C6VY9	309165000	7.86
2607	9474539	MARIANNE	VRFM5	477612300	5.41
2608	9525924	AL QIBLA	9KEW	447171000	15.53
2609	9488035	BRATTINGSBORG	9V8924	564425000	8.00
2610	9312975	NYK OCEANUS	3EMR8	351249000	14.04
2611	9275634	MSC ROMANOS	VRJC7	477095900	13.50
2612	9469625	GUO MAY	A8VM6	636014630	18.30
2613	9259329	ENERGY CENTURY	MBEF7	235733000	12.20
2614	8609606	NEDLAND	OJPX	230015000	4.68
2615	9552032	EMSLAKE	V2FL4	305712000	6.16
2616	9570620	ANTJE	V2EZ7	305615000	7.00
2617	9416032	MTM SOUTHPORT	9VFQ5	565677000	9.76
2618	9504126	FLINTER ARCTIC	PCFU	246746000	7.85
2619	9433341	BELIZIA	V2DQ2	305301000	5.70
2620	9427524	SILVER KENNA	PCRP	246893000	5.80
2621	9229166	FRI SEA	C6YB3	311028300	5.21
2622	9541887	SIRIUS	5BCT3	209533000	9.92
2623	9218014	GRAN CANARIA CAR	EBSK	224641000	5.20
2624	8505707	JAN STEEN	PEZV	245421000	4.04
2625	9466312	ARAGONBORG	PCGK	245953000	9.69
2626	9529475	PETALIDI	9HA3011	229036000	17.02
2627	9631955	APL TEMASEK	S6LT9	566796000	15.52
2628	8821929	SZYMANOWSKI	P3EW4	212304000	9.30
2629	9290880	SOUTHERN WISDOM	H8ZG	357780000	17.98
2630	9638056	MAY OLDENDORFF	D5EM9	636016113	18.40
2631	9312597	XIN DAN DONG	BPBY	413153000	12.80
2632	9296872	MTM LONDON	9V9577	566199000	9.71
2633	9389679	ACADIA	V7PI3	538003233	14.80
2634	9378280	NORGAS CREATION	9V8219	563966000	8.30
2635	7625691	FEDOR VARAKSIN	UCKU	273111100	8.69
2636	8512126	CELIA	OJME	230979000	3.39
2637	9365257	WAPPEN VON NURNBERG	D5DZ6	636092495	7.42
2638	9186649	ANGLIA SEAWAYS	OZHV2	219292000	5.40
2639	9284697	STOLT ENDURANCE	D5BW5	636015619	10.73
2640	5153462	HOLLAND	PESK	244879000	3.69
2641	7303281	FALKLAND CEMENT	C6TM8	311701000	5.51
2642	8023527	ORATECA	OZJA2	219675000	4.75
2643	8912481	FRAKTO	J8B2022	375431000	4.37
2644	9319208	RED DOLPHIN	CQOV	255802960	4.84
2645	9529425	DAMEN GORINCHEM 503419	XXXX	0        	2.90
2646	9599810	SHOEI PROSPERITY	3EYI4	373903000	18.24
2647	9410741	CMA-CGM AQUILA	2CBJ6	235071275	15.50
2648	9588093	HANOI BRIDGE	3FHS3	353592000	14.04
2649	9593311	VSC TRITON	D5FH4	636016266	12.74
2650	9622227	CAP SAN LORENZO	LXSQ	253126000	14.50
2651	9284192	ARCTIC LADY	LAGF6	257742000	12.33
2652	9621871	ADFINES SOUTH	9HA2987	229011000	10.40
2653	9480875	MARIA-G	3FMM5	355990000	3.80
2654	9591052	MERCURY ACE	3FNS7	370644000	10.02
2655	9364136	MYRTE	PBII	246110000	7.22
2656	9299771	KANPUR	A8KG8	636013055	14.92
2657	9508108	ATLANTIS ANTIBES	9HYJ9	249702000	6.29
2658	7626748	DORIS T	V2HR	304010102	4.80
2659	1012086	EQUANIMITY	ZGDQ	319059800	4.20
2660	8502145	CHRISTINE Y	8PAF8	314386000	3.33
2661	9561277	GLORIOUS ACE	ZGAL	319409000	9.80
2662	9636644	SEA AUVA	V7AB8	538004959	11.50
2663	9331335	MILA	PHGM	246542000	5.43
2664	9195391	HENDRIK S	PFCP	245529000	5.34
2665	9254202	CHEMICAL PROVIDER	3FMW6	354556000	8.76
2666	7510793	MISKA	PDOC	246355000	3.00
2667	9502910	HANJIN AFRICA	2FQE2	235093327	15.52
2668	9601314	APL DUBLIN	9V9404	566705000	15.50
2669	9332250	APL OAKLAND	ZDNI8	236111941	13.00
2670	9669938	STI DUCHESSA	V7CA3	538005225	13.30
2671	9484467	MSC VANDYA	3FDW4	373005000	15.50
2672	9341093	NS CONSUL	A8GW7	636012662	15.38
2673	9431642	SKANDI CONSTRUCTOR	C6ZH8	311055900	7.90
2674	9291262	MATTERHORN SPIRIT	C6UK6	311816000	14.82
2675	9317949	SEAMAGIC	9HOE9	249266000	15.41
2676	9329423	ATLANTIC DAISY	3EMR9	354449000	10.85
2677	9411331	GEORGE S	A8TJ9	636014372	17.17
2678	9112155	B GAS COMMANDER	9HA2927	256792000	4.80
2679	8502107	INZHENER VESHNYAKOV	UBDJ3	273354480	7.40
2680	8902589	TIDAN	OZ2126	231840000	5.46
2681	9333577	GENERAL HAZI ASLANOV	UEJC	273430870	4.30
2682	9299501	ENERGIZER	PHAS	245088000	7.10
2683	9150509	WILSON LEITH	9HII5	249849000	5.49
2684	9616096	CENGIZ AMCA	D5CU4	636015783	7.81
2685	8506440	BRITANNICA HAV	9HUW8	256451000	3.51
2686	9101156	FREJ	V2AF7	304010515	5.93
2687	9155913	NAMAI	PGAZ	245776000	6.34
2688	9160449	HAM 316	PHBD	244521000	8.04
2689	9155937	KASTEELBORG	PFSO	245068000	7.46
2690	9214006	MARE	PCBR	245834000	4.34
2691	9669940	STI OPERA	V7CJ3	538005269	13.30
2692	9629031	EVER LIVING	9V9791	563143000	14.20
2693	9505998	GREENWICH PARK	A8YZ9	636015164	9.53
2694	9243837	JUMBO JAVELIN	PHEG	246481000	6.50
2695	9272668	JO ACER	LAYS5	258926000	10.95
2696	9358541	SAKURA PRINCESS	D5BI8	636015526	14.81
2697	9620504	TAO HUA HAI	BOUE	414070000	12.20
2698	9150236	WILSON GHENT	9HBK5	249647000	5.49
2699	8201686	MSC HINA	HPFP	355925000	9.82
2700	9325609	STAR MERLIN	3EVX3	357324000	13.03
2701	9126687	WILSON GOOLE	9HSC4	249359000	5.49
2702	9262003	TANGO	V2BG4	304578000	6.65
2703	9057264	VALENTIN PIKUL	9HNV8	256196000	4.88
2704	9114725	KADRI	9HRQ8	256341000	5.63
2705	9341720	MAASBORG	PFRL	244575000	6.25
2706	9540833	UNIQUE INFINITY	VRLY6	477631400	13.10
2707	1137651	DAMEN GORINCHEM 549101	XXXX	246128000	2.00
2708	9196187	WESTGARD	PDBQ	246457000	5.67
2709	9200809	SINGAPORE EXPRESS	VRNE9	477300500	13.55
2710	9602148	SINOKOR SUNRISE	V7WD2	538004269	14.62
2711	9477490	ATLANTIK MIRACLE	9HPX9	249343000	8.15
2712	9642136	DIAMOND QUEEN	3EWM	373383000	13.01
2713	9650872	CANON TRADER II	DUEN	548865000	14.45
2714	9657856	WUCHOW	9VBK9	563650000	10.50
2715	9206671	STENA NATALITA	C6UK4	311814000	15.02
2716	9598816	NEVA-LEADER 1	UBAJ4	273351280	4.70
2717	9153032	BRITANNIA SEAWAYS	OZTS2	219825000	7.50
2718	8817409	KREMPERTOR	V2OS1	304669000	5.08
2719	9085455	FAST SAM	ONEJ	205477000	4.54
2720	9299862	BALTIC ADVANCE	C4FU2	212182000	10.85
2721	9482225	CAPE YAMABUKI	7JGP	432752000	18.23
3049	9646326	KOLGA	PCTR	244790079	7.00
2722	9247376	ALTEREGO II	A8MF5	636013332	16.00
2723	9426300	GINGA CARACAL	3FJT	354283000	10.08
2724	9372482	MSC ORIANE	3EPY8	353289000	14.50
2725	9350939	ANDREA	PHGZ	246140000	4.85
2726	9465435	BRIGHT SKY	V7ZQ6	538090453	11.70
2727	9291717	ARKLOW ROVER	EIPL	250515000	5.68
2728	9220809	CLAMOR SCHULTE	ZNVG3	235308000	8.40
2729	9323156	URAG ELBE	5BZV3	210951000	6.80
2730	9330771	MID FALCON	ZGDT5	319061100	9.64
2731	9276028	PAMIR	9HUC7	215572000	12.18
2732	9166625	VALENTINE	ONDL	205461000	6.50
2733	9375795	RORICHMOOR	V2BV7	304938000	4.36
2734	9266425	THUN GRANITE	PBCH	244734000	6.75
2735	9319480	BOW ARCHITECT	3EBB7	371053000	10.95
2736	9036909	BOSTON EXPRESS	ZCEL3	310676000	13.50
2737	9312987	NYK OLYMPUS	3EOS7	372478000	14.04
2738	9475674	HYUNDAI TENACITY	D5BG7	636015516	15.50
2739	9189500	NEDLLOYD DRAKE	ZQDI9	235020000	14.00
2740	9361249	GENCO AUGUSTUS	VRDD2	477926300	18.17
2741	9290933	AUTHENTIC	SVDM	240276000	16.02
2742	9250165	MTM YANGON	9V2087	566914000	11.88
2743	9142667	WESTVOORNE	V2BZ4	304671000	4.30
2744	9247833	SEABORNE	VRYG4	477336000	14.87
2745	9239989	TOCCATA	A8DH4	636012069	12.18
2746	9401518	BAROCK	3ELS	351070000	14.46
2747	9297333	MINERVA CLARA	SXGT	240480000	13.60
2748	9433365	DAMINA	V2EW2	305578000	6.39
2749	9196216	OSTGARD	PBAW	245180000	5.67
2750	9347516	CLIPPER SUN	LALW7	259712000	12.55
2751	9399105	MIDLAND SKY	3FMT3	352219000	14.38
2752	9397042	SICHEM BEIJING	9VHK4	565585000	8.71
2753	9519030	MSM DOLORES	5BQF3	210047000	5.88
2754	9706011	BAUS	LNZI	257369000	5.20
2755	9247106	AASHEIM	ZDKD8	236598000	6.24
2756	8918564	OFFSHORE BEAVER	PCXR	244820406	2.72
2757	9179361	NEMUNA	V2AR9	304475000	5.71
2758	9351921	IVER PROSPERITY	V7LP8	538002784	11.32
2759	9480368	AMUR STAR	9HA2141	248043000	8.71
2760	9383443	BARBARICA	ICCG	247224200	8.90
2761	8804505	JETSED	PFCX	245443000	1.42
2762	9516442	COSCO SPAIN	VRMX2	477776200	15.50
2763	9461893	APL QINGDAO	9V9376	566408000	15.52
2764	9329708	AL JABRIYAH II	9KEH	447163000	22.52
2765	9301823	RIO GRANDE EXPRESS	VRCE5	477415600	12.60
2766	9410143	HALIT BEY	V7ZY5	538090456	9.70
2767	9362449	RIO CHARLESTON	A8OT3	636091502	13.00
2768	9345881	BSS PRIDE	A8ZG3	636015203	10.22
2769	9544695	AOM JULIA	3FNQ3	355891000	14.14
2770	4907361	URK ZR.MS.	PAEL	0        	2.50
2771	9593969	ORE KOREA	9V9133	566777000	23.00
2772	9388302	BOW ELM	9V9233	563755000	12.07
2773	9169940	STOLT STREAM	ZCSR	319469000	10.10
2774	9017434	WILSON HOOK	P3TW9	210604000	5.64
2775	9055187	VYG	3FBA8	370601000	4.22
2776	1133328	STEMAT 83	XXXX	0        	1.00
2777	9622605	OOCL BERLIN	VRLN5	477203100	14.00
2778	9395214	UBC LONGKOU	9HA3536	229708000	12.49
2779	9036442	BERGE KIBO	2CXE5	235076527	20.53
2780	9425954	STOVE CALDONIA	LAUH7	257533000	12.83
2781	9405033	NORTHERN DIAMOND	A8PB2	636091527	12.00
2782	9249594	GLOBAL AKER	9HHF9	256981000	9.71
2783	9590802	KUMPULA	OJPC	230625000	12.80
2784	9296731	STOLT COURAGE	D5BG8	636015517	10.73
2785	9114969	SAPPHIRE	IBOV	247698000	8.40
2786	9142215	XO TIGER	3EAY8	370234000	11.60
2787	9061198	PRINCE OF TIDES	A8JI4	636091097	6.22
2788	9030515	ARTIC OCEAN	LCVJ	259998000	4.35
2789	9288708	DELTA VICTORY	SZMX	240290000	14.60
2790	9163491	MARVELETTE	9HSQ8	256376000	11.62
2791	9458822	UACC MANAMA	V7FS7	538005654	12.07
2792	7382665	WILSON REEF	9HUY5	248200000	6.94
2793	9513191	VINE 1	V7XY8	538004603	7.77
2794	9354909	ATLANTIC OLIVE	VREF8	477110600	12.21
2795	9234288	KWINTEBANK	PBGT	245864000	8.07
2796	9317016	RUSICH-2	UAQG	273314430	4.34
2797	1134008	SB-8422	OUUX	0        	6.00
2798	9549607	AMETHYST	UBSH3	273358930	6.41
2799	9729506	ARTHUR DION HANNA HMBS	C6BB9	311000220	2.50
2800	9251365	MOL EFFICIENCY	VRML5	477242400	12.00
2801	9461386	MSC GENOVA	A8UX5	636091960	16.00
2802	9266231	JO KIRI	9V2656	564922000	9.62
2803	9677026	MAERSK CERES	D5DG4	636015872	14.52
2804	9286451	HARBOUR LEADER	C6TK4	311656000	8.22
2805	9678472	Q SUE	V7CD6	538005246	13.49
2806	9520716	SHAGANGFIRST POWER	3FDQ6	371922000	18.20
2807	9395290	MAERSK HAYAMA	9V9745	566321000	21.50
2808	9579511	ALMI GLOBE	D5BX2	636015624	17.00
2809	9243320	TORM INGEBORG	V7FW5	538005669	12.00
2810	8914283	ANMI	C6UJ8	311938000	5.45
2811	9235505	LISA	V2GA4	304234000	6.36
2812	9254240	TORM MOSELLE	OYNX2	220563000	11.35
2813	9543770	DESERT MOON	V7XW2	538004585	12.98
2814	9328297	AKERAIOS	A8KS3	636013115	12.52
2815	9566306	SCALI DEL PONTINO	9HA2924	256755000	6.50
2816	8416750	PEAK BERGEN	E5U2406	518456000	4.10
2817	9048287	CEMVALE	C4JW2	212109000	6.10
2818	9167978	NEPTUN	ZDGG7	236247000	4.75
2819	9429235	CONDOR	V2QL5	305873000	8.70
2820	9519638	SVETI DUJAM	9AA7459	238293000	12.35
2821	9619957	MAGLEBY MAERSK	OWJI2	219018986	14.50
2822	9290672	KARMEL	9HA2896	256632000	5.25
2823	9359715	HANJIN CHITTAGONG	3EKB7	372676000	11.28
2824	9535541	BESIKTAS CHAMPION	9HA2741	215477000	5.80
2825	9399480	NORTHIA	V7SL4	538003675	17.00
2826	9551351	GLORIOUS SENTOSA	3FQM7	355440000	9.82
2827	9268241	WILLY	ZDFW5	236213000	7.45
2828	9636591	GUO DIAN 15	BFAX3	414157000	14.20
2829	9562049	JIN HANG	VRIW8	477098700	14.90
2830	9088342	UR 5	LK5931	0        	4.85
2831	9137208	SCOT CARRIER	MGMT3	235008290	4.25
2832	9304291	CHEMICAL MARKETER	9HA2018	249814000	8.80
2833	9393333	THUN GAZELLE	PBQH	246541000	6.75
2834	9436331	BBC CONGO	V2EL3	305466000	9.60
2835	9278337	EEMS DOLLARD	PBLV	245497000	5.40
2836	9368247	RUSICH-10	UBJI9	273359260	4.34
2837	8801125	HOLSTENTOR	V2OR4	304662000	5.08
2838	9594858	EAGLE SAN PEDRO	9V9334	566690000	17.20
2839	9437062	CSAV BRASILIA	A8VK7	636092017	13.62
2840	9565649	BOCHEM GHENT	VRIA8	477351300	11.37
2841	9159464	LIHAI	3FUE8	354188000	11.36
2842	9520845	MADREDEUS	V7EH6	538005471	14.58
2843	9515175	DREAM POWER	3FAD5	355084000	13.40
2844	8113566	TEAL	PJWD	306122000	9.49
2845	9283617	STENA CHRONOS	C6TN6	311707000	12.50
2846	9634830	UNITED WORLD	3FAZ8	352816000	14.43
2847	9274630	MAERSK EDGAR	OUVW2	219397000	10.60
2848	9327384	BALTIC FORCE	C4KC2	212186000	10.85
2849	9363948	LAVENDER ACE	C6XI4	311010500	9.73
2850	9288825	BRITISH COURTESY	MHNL6	232448000	12.42
2851	8919611	LEGIONY POLSKIE	YJZJ5	576062000	14.12
2852	9356490	HELENIC	PHNX	244557000	5.05
2853	9198604	WILSON HULL	P3DQ9	209972000	5.64
2854	9287314	ARKLOW WIND	EIKZ	250506000	8.35
2855	9624550	OCEANIC	PBYH	244918000	5.00
2856	9434876	WEST	PJRI	306004000	3.50
2857	9641481	NERO	PCTM	246925000	2.60
2858	9193290	TOKYO EXPRESS	DGTX	211327410	13.55
2859	9236286	LEYLA KALKAVAN	V7JG9	538090198	7.80
2860	9575589	SONANGOL CABINDA	C6ZU3	311066500	16.00
2861	9318565	STEN AURORA	LAKI6	258953000	8.89
2862	9590694	BLUE MCKINLEY	3FZY9	370445000	18.22
2863	9322279	GENMAR HERCULES	V7BB4	538002001	22.47
2864	9340910	SALINA M	IBCL	247324900	8.39
2865	9456537	UNION DEDE	3FTY2	356582000	12.74
2866	9116814	MARLEY	ONHT	205656000	4.94
2867	9193587	JEIL CRYSTAL	D7NL	440247000	8.77
2868	9660798	HOEGH AMSTERDAM	C6AO4	311000103	10.00
2869	9237864	ELSE MARIE THERESA	OWJL2	220002000	6.09
2870	9467809	MAGURO	V7TL5	538003826	14.30
2871	9448712	NORD GUARDIAN	OZCI2	219289000	12.60
2872	9164108	STOLT AUK	2HLY2	235104739	6.25
2873	9407419	LAGANBORG	PHQB	244297000	6.50
2874	9448877	JOAN	VRFC6	477541400	5.41
2875	9248447	GRENA	C6TB8	311571000	17.02
2876	8611221	TAHSIN	3ETD3	353502000	4.70
2877	7813999	DRAWA	SNBA	261201000	3.80
2878	9407380	HORIZON THETIS	A8RK7	636014119	13.08
2879	9555321	ONIKS	UAZM	273339540	6.40
2880	9632014	APL MERLION	S6NV	563231000	15.52
2881	9629902	MOL COMMITMENT	V7AZ4	538005100	14.53
2882	9617648	JO LOTUS	LAPP7	257937000	10.30
2883	9204697	TRAMPER	PHAA	245867000	8.20
2884	9466996	HHL AMAZON	D5BD3	636092368	8.00
2885	9302889	GRETE MAERSK	OYCY2	220397000	15.00
2886	9608922	JI XIANG SONG	BOEC	413471050	10.20
2887	9409091	LEO FELICITY	3FQG6	354931000	17.99
2888	9356646	ST SARA	FMLH	635013800	6.85
2889	8756148	SEAFOX 4	2BIF7	235066352	5.50
2890	9477529	MTM SINGAPORE	VRHU2	477746800	9.83
2891	9147875	SEMBRIA	V2QG7	304010760	6.63
2892	9419723	ANJA KIRK	2EQV6	235087417	13.14
2893	9387310	CHRISTINA G	V2DO3	305279000	5.41
2894	9507609	FORTUNAGRACHT	PBUU	246621000	8.50
2895	9387322	AVALON	PBSF	246578000	5.42
2896	9103788	SVS VEGA	J8B5065	276123000	4.63
2897	9321287	BREMEN FIGHTER	V2OY1	304742000	6.00
2898	9395276	AURA	OJMS	230601000	4.60
2899	9178202	STOLT EFFORT	ZCSP6	319445000	11.86
2900	1133301	TERRAFERRE 301	XXXX	0        	4.60
2901	9567037	JEWEL	V7YT2	538004727	18.10
2902	9316816	SANTA ISABELLA	3EES8	371806000	12.52
2903	9233765	NORDIC COSMOS	V7EE7	538001786	17.01
2904	9324239	PAQUIS	3EAK9	353018000	13.95
2905	8884830	MTS INDUS	2BPZ8	235068328	2.90
2906	9416056	TRF MIAMI	V7GV7	538005769	9.62
2907	9416795	AUTUMN	V7QA6	538003323	8.71
2908	9171096	WILSON GAETA	8PTS	314237000	5.50
2909	9291729	ARKLOW RACER	EIQM	250016000	5.68
2910	9204776	SEAMULLET	DEBQ	211379750	11.00
2911	9006356	ELISABETH K	PBEO	245712000	5.47
2912	9476006	FAIRPLAY-33	V2QG6	305356000	6.20
2913	9195640	EEMS DART	ZDIK5	236453000	5.42
2914	8104565	AMANDA	OURV2	219002392	3.29
2915	9294202	RAINBOW	VRAH5	477520900	12.26
2916	9349796	MSC MONTEREY	D5BL4	636092391	13.50
2917	4907323	MAKKUM ZR.MS.	PAEH	244025000	2.50
2918	9622241	CAP SAN ANTONIO	D5FI9	636092547	14.02
2919	8521414	FB GLORY	HP3490	356071000	4.21
2920	8903014	KARINA DANICA	OVOB2	219185000	4.96
2921	8906937	STOLT MARKLAND	D5DN3	636015924	10.14
2922	9511246	AP JADRAN	V7ZE2	538004801	14.58
2923	9142629	SNOW STAR	PHQP	245717000	7.00
2924	9146601	XO LION	9HA2838	256301000	11.35
2925	8814275	EENDRACHT	PDVN	244543000	5.10
2926	8433435	CATHARINA 11	PBNT	245494000	2.12
2927	1133697	HEBO P 39	XXXX	0        	2.50
2928	9063299	PINTA	ZDFC8	236180000	4.92
2929	9268239	KEY MARMARA	9HA2567	248891000	6.20
2930	9272735	BOMAR QUEST	V7JX5	538002583	7.11
2931	9481037	NEPTUNE MARINER	ZDIW8	236491000	4.15
2932	9712412	INGE W	PCGS	244810083	3.20
2933	9407392	HORIZON THEANO	A8SS4	636014285	13.08
2934	9337482	YM UNIFORM	A8OR8	636013693	14.50
2935	9211494	MAERSK KYRENIA	VRGM8	477733600	13.50
2936	9480198	MSC MADRID	A8ZV2	636092270	13.50
2937	9414266	ARGENT HIBISCUS	3FQO3	357441000	11.41
2938	9675638	ATLANTIC MARU	H9NF	371630000	18.15
2939	9608386	DA TAI	VRMA5	477592600	9.10
2940	9105114	NINA VICTORY	LANG7	257005000	11.02
2941	9608867	MAGIC VICTORIA	V7YS4	538004722	14.57
2942	9196905	APL EGYPT	A8BZ6	636090618	13.55
2943	9186338	BLUE MARLIN	PJFM	306589000	13.30
2944	8908806	TINNO	8PAK2	314418000	4.96
2945	9271248	ARCTIC PRINCESS	LAGE6	257739000	11.70
2946	9430973	WILSON NANTES	9HA2463	248674000	7.40
2947	9361134	MARIETJE ANDREA	PBWR	246649000	6.97
2948	9487378	CIMIL	LXCI	253437000	6.10
2949	7330052	VISCARIA	LATC4	258897000	4.75
2950	6807591	JAN LEENHEER	PDWU	245569000	3.54
2951	9272137	MATADOR 3	PBHF	246300000	3.35
2952	9166479	NOVA CURA	PCFP	245127000	6.16
2953	9247508	HANS SCHOLL	A8EU8	636091484	11.06
2954	8402668	NINA 1	J8B3047	377764000	3.18
2955	8700498	ZHEN HUA 29	VRFE8	477622000	12.50
2956	9399222	CMA-CGM TITAN	9HA2146	248052000	15.00
2957	9637222	HYUNDAI DREAM	V7DD7	538005371	15.52
2958	9605011	SANTA VITORIA	3FDV3	373059000	13.01
2959	9221918	BW UTAH	3EPE3	352584000	22.00
2960	9182667	DESPINA ANDRIANNA	A8HG4	636090884	14.02
2961	9468786	VENUS HERITAGE	5BDU3	212139000	14.45
2962	9163568	PYTHIA	3FDU8	352033000	6.92
2963	9508433	BBC MONT BLANC	V2FT6	305792000	7.60
2964	9498810	DIMITRA	V7BU4	538005200	14.90
2965	9434175	AMBRA	9HWN8	256526000	9.40
2966	9332418	FRANZ SCHULTE	MNTH2	235011660	8.35
2967	9386433	CFL PROUD	PBUI	246611000	6.08
2968	9317145	ALIANCA ORIENT	3EIC4	372089000	12.02
2969	9414199	LIFTER	V2DD4	305175000	7.10
2970	9572757	HARBOUR PIONEER	CQNZ	255804340	8.40
2971	9374741	FLUVIUS TAMAR	PCWT	244650011	5.80
2972	9342164	EMSCARRIER	V2DE8	305190000	5.25
2973	9671022	DAMEN YN 523605	XXXX	0        	2.50
2974	9642447	DAMEN YN 523952	XXXX	0        	6.20
2975	9662203	DAMEN YN 522702	XXXX	0        	5.00
2976	9671606	DAMEN YN 523912	XXXX	0        	3.00
2977	9642631	DAMEN YN 523908	XXXX	0        	3.00
2978	9671187	DAMEN YN 523704	XXXX	0        	2.50
2979	9671591	DAMEN YN 523911	XXXX	0        	3.80
2980	9321380	STAVFJORD	PBIZ	244140000	6.01
2981	9555357	YASHMA	UEJO	273353680	6.40
2982	8905115	MAIKE	DJLS	218176000	4.19
2983	9656462	LIZ V	PCTW	244790091	2.00
2984	9019107	EDT PROTEA	P3KR9	209255000	6.83
2985	1137751	VETAG 8	DGCK2	211611960	1.40
2986	9654775	FRONT ESK	V7AX7	538005089	12.00
2987	9246906	FRISIAN LADY	PBDX	244017000	5.50
2988	9403774	NAVIGATOR CAPRICORN	D5DP5	636015939	10.90
2989	9335032	NCC RABIGH	HZQA	403575000	12.22
2990	9568562	HARM	A8WG5	636092073	14.90
2991	9340556	FORTUNE IRIS	VRFD7	477218100	14.43
2992	9591753	ANTWERPIA	V7XE4	538004459	14.55
2993	9620138	IVS RAFFLES	S6LP4	566742000	10.15
2994	9148972	STOLT FULMAR	ZCSY9	319541000	6.53
2995	9650822	ORIENTE GLORIA	3FAO2	373981000	13.01
2996	9429194	POLLUX	V2GK9	305979000	8.70
2997	9417311	VALLESINA	IBIZ	247265500	15.35
2998	9535591	THORCO CLAIRVAUX	V2EY4	305598000	7.40
2999	9361330	NORRFURY	PHLU	244576000	5.95
3000	9429558	BUGSIER 9	DFWA2	218197000	4.28
3001	9286877	UNIVERSAL GLORIA	HPYT	356844000	11.42
3002	9478303	ALICE THERESA	OXCZ2	219148000	7.61
3003	9359571	CALAJUNCO M	ICCH	247186800	9.60
3004	9497878	POLA PACIFIC	9HA2505	248770000	9.85
3005	9265732	GEORGIS NIKOLOS	SXPX	240061000	14.02
3006	9409168	MARYCAM SWAN	3EUF5	351180000	8.80
3007	9195470	GEISE	ZDHI5	236325000	5.74
3008	9437153	BBC BERGEN	V2EP8	305511000	7.00
3009	9390173	ELLIE LADY	A8TT3	636014423	14.78
3010	9473913	SONGA OPAL	V7RO5	538003550	9.21
3011	9278519	HAFNIA ATLANTIC	OVPS2	220301000	12.22
3012	9300829	TERNHOLM	OWIM2	219076000	9.00
3013	9575321	GOBUSTAN	9HA2895	256623000	4.60
3014	9644237	ATHINA M	SVBW9	241294000	11.00
3015	9298387	MCT STOCKHORN	HBHD	269817000	9.55
3016	9340439	AS OPHELIA	DYOV	548747000	9.67
3017	9587269	CANCUN	9HA3419	229574000	18.47
3018	9308871	FALCON CONFIDENCE	D5AP3	636015417	18.12
3019	9595278	KONSTANTINOS II	D5EL4	636016100	14.52
3020	9419565	PRINCIMAR COURAGE	V7AJ8	538005013	17.03
3021	9304320	CELSIUS MIAMI	V7CT9	538005323	9.68
3022	9282792	ATALANDI	SVBA	240269000	14.30
3023	9251573	BRITISH ESTEEM	VQIV8	235644000	10.85
3024	9138276	BORKUM TRADER	D5BN7	636092394	11.40
3025	9141649	ONEGO KAMSAR	P3AP8	212634000	6.39
3026	9552068	EMSTIDE	V2FR5	305770000	6.15
3027	9138408	AIGRAN D	PBRK	245196000	7.85
3028	9158551	ALFA GERMANIA	C6PL5	309438000	13.50
3029	8507509	FLORA	9HUL4	249428000	11.18
3030	8766466	H 404	XXXX	0        	5.70
3031	9344265	KEY BREEZE	ZDKS2	236111791	6.20
3032	8411229	MARIABURG	ONFJ	205521000	5.55
3033	8309165	SAIPEM 3000	C6SW6	311516000	6.37
3034	9630250	MULTRATUG 19	PCHZ	0        	4.10
3035	9015046	GLEN	V2BB9	304786000	5.80
3036	9505302	HOHE BANK	ZDJU8	236568000	5.30
3037	9422263	STEMAT 81	XXXX	0        	4.00
3038	9650901	ARCTIC ROCK	PBUW	245058000	5.00
3039	8890592	FORTH CONSTRUCTOR	GXAD	235004217	2.90
3040	9568718	KING PEACE	VRHU4	477213300	14.58
3041	9279771	OCEAN PRINCE	V7RK8	538003529	12.20
3042	9230050	EXCALIBUR	ONCE	205421000	12.10
3043	9390329	LILLO SWAN	9HDO9	256838000	6.05
3044	9359961	SCL ANDISA	HBEN	269927000	8.40
3045	9628300	HILDA KNUTSEN	2HCU5	235102561	15.50
3046	9482574	NAVIGATOR LEO	A8ZD5	636015187	8.70
3047	8757740	THIALF	3EAA4	353979000	13.60
3048	8117471	PRESIDENT HUBERT	ORLD	205067000	6.25
3050	9559092	FULDABORG	PCNZ	245806000	8.19
3051	9377913	MOSELDIJK	PBWK	246644000	6.22
3052	9111620	EAGLE BOSTON	9VHI	564004000	12.82
3053	9537977	CABRERA	9HA2474	248697000	10.10
3054	9285861	MINERVA IRIS	SVCP	240243000	13.60
3055	9635688	DAL KAROO	D5DF3	636015861	14.50
3056	9552070	GRONA MARSUM	V2FZ7	305861000	6.15
3057	9447005	NAVIOS HAPPINESS	9HA2096	249954000	18.22
3058	8418746	ZIEMIA LODZKA	A8DQ4	636012139	9.85
3059	9552044	EMSDOLLART	V2FL3	305711000	6.16
3060	9380350	SKY	9HBD9	256712000	11.52
3061	9525182	MONICA KOSAN	2DGJ6	235078722	5.71
3062	9014705	WILSON BILBAO	9HJX9	249077000	5.50
3063	9167710	CHEM LEO	V7IW9	538002462	8.76
3064	9210892	MAERSK ELIZABETH	S6NY2	566506000	10.50
3065	9175236	RIROIL 1	9HTN7	229744000	5.02
3066	9603465	BULK COSTA RICA	9V9182	566557000	12.68
3067	8613358	IDA	C4CZ2	210319000	3.89
3068	9214018	SANDETTIE	PCCJ	244054000	4.34
3069	9500754	HUBERT FEDRY	3FNB6	373541000	18.07
3070	9302463	PRIVLAKA	9AA4485	238223000	9.61
3071	9322827	STENA ANTARCTICA	ZCPE	319562000	14.94
3072	9300362	CASTILLO DE CATOIRA	C6VI6	308659000	18.20
3073	9547764	NORTHSEA ALPHA	9HA2595	248973000	7.90
3074	9320489	SHANNON FISHER	C6UU7	308539000	6.30
3075	9249831	RMS RATINGEN	V2DK	304346000	4.09
3076	9610810	VIKTOR BAKAEV	D5BN6	636015565	14.62
3077	9479943	ESPRIT	PCKM	246794000	6.23
3078	9194830	EVA MARIA MULLER	V2DF	304488000	5.50
3079	9597721	CHEMBULK ADELAIDE	9V9410	566018000	9.72
3080	8818623	TANJA	V2PM5	305068000	5.28
3081	9427639	MATALA	SVAW8	240973000	17.00
3082	9649196	THARSIS	PBLC	246091000	3.78
3083	9574303	ALIZEE	PBZU	244790369	5.40
3084	9168647	STOLT COMMITMENT	ZGBH8	319025300	10.72
3085	9193305	SEOUL EXPRESS	DHBN	211331640	13.55
3086	9637234	HYUNDAI HOPE	V7EI3	538005474	16.00
3087	9484936	HANJIN ITALY	A8YC2	636015019	15.52
3088	9669665	CIELO DI NEW YORK	9HA3466	229631000	10.48
3089	9244685	CRIMSON SATURN	H9NN	351998000	11.53
3090	9392171	KUROBE	3FKY5	354204000	10.32
3091	9248825	CAPE BAXLEY	V7EQ2	538090158	16.28
3092	9255725	JANA	PJPB	306042000	7.05
3093	9312470	HOEGH DETROIT	LAHE6	257869000	10.00
3094	9066069	KENTO	3EXE6	370417000	4.22
3095	9377925	MEERDIJK	PBYY	245682000	6.22
3096	9478793	ROYAL FAIRNESS	3EWC2	354858000	12.57
3097	8822040	GALA	V2OY9	304752000	5.80
3098	9341770	GERARDA	PHEV	246330000	5.95
3099	8771071	JB 117	C6YI2	311034300	4.20
3100	9421075	LINGEDIEP	A8ZO6	636015262	7.01
3101	9518268	DIAMANT	PCNK	246845000	6.15
3102	9469857	KANARIS	V7SY2	538003746	18.30
3103	9605231	MSC ARBATAX	VRMO6	477519400	14.50
3104	9606754	ANANGEL PROGRESS	SVBU6	241274000	14.50
3105	9312133	EXPLORER	SXFP	240510000	17.02
3106	9306421	CLARA	V2CC9	304983000	6.70
3107	9436460	ORIENT CAVALIER	5BWC2	212091000	14.50
3108	9236743	SEARAMBLER	9HCN7	215107000	11.74
3109	9363819	AS OMARIA	DYTH	548775000	9.67
3110	9347035	BBC EMS	V2BS3	304911000	9.70
3111	9215309	BOW SAGA	LADM7	258960000	13.28
3112	9383106	MORNING LINDA	3ETI	370567000	10.01
3113	9301873	FURE WEST	OZ2100	231775000	9.75
3114	9225328	ASTON 1	3ETM2	0        	11.02
3115	9298765	NAUTILUS	SVOL	240498000	17.02
3116	9565637	BOCHEM MUMBAI	VRHJ8	477932400	11.37
3117	9284295	BIG FISH	V7CC6	538005241	18.00
3118	9245263	ONEGO PONZA	V2ED8	305395000	7.68
3119	9302164	HUMEN BRIDGE	3EKA7	372665000	14.04
3120	9195717	JUERGEN K	PBKV	244329000	5.42
3121	9345506	SMIT BARRACUDA	ORRL	210667000	2.72
3122	9276561	MINERVA HELEN	SVLN	240147000	13.60
3123	8919831	KOMET III	V2DR3	305312000	6.56
3124	9277278	MONTE	V2FS2	305777000	6.04
3125	9278349	BEAUMONDE	PBBI	244573000	5.42
3126	9284726	STAVANGER EAGLE	H9EL	352382000	12.02
3127	9229130	HANSEATIC SCOUT	V2BM2	304867000	5.70
3128	9374703	EMMA	PHLZ	244995000	5.03
3129	9566289	SCALI DEL TEATRO	9HA3541	229713000	6.50
3130	8902565	HOECHST EXPRESS	ZCEK2	310665000	13.50
3131	9359014	GUNDE MAERSK	OUIY2	220594000	15.50
3132	9440332	ANANGEL VIRTUE	SVBO2	241197000	18.20
3133	9232761	CMA-CGM MONTREAL	DIOT	218444000	12.00
3134	9327176	ULUS SKY	UBSH	273319930	4.46
3135	7707839	WILSON MALO	P3ZB4	209810000	6.83
3136	9156175	TOVE	ZDHX3	236387000	4.80
3137	9558490	PHOENIX	LZEL	207137000	8.20
3138	9339026	MARNEDIJK	C4MA2	210122000	7.40
3139	9346550	RUSICH-7	UBUI	273310950	4.34
3140	9249116	ELKA ATHINA	SXHU	240277000	14.07
3141	9263186	HAFNIA RAINIER	P3SF9	210736000	9.85
3142	9595917	FEDERAL SUTTON	V7WS7	538004383	10.50
3143	9210696	GIULIANA	5AYC	642167093	7.22
3144	8817382	HAV SUND	OZ2146	231103000	5.19
3145	9287766	ARKLOW RESOLVE	PBZL	245975000	6.30
3146	9127045	APISARA NAREE	HSAP2	567010000	9.06
3147	9388510	ELBCARRIER	V2DC8	305171000	7.36
3148	9559638	EEMS STREAM	PBTH	245926000	4.26
3149	9146730	GOONYELLA TRADER	ELTS6	636010587	17.62
3150	9386483	CMA-CGM OPAL	A8RV3	636014168	12.62
3151	9405423	SERENEA	SVAC6	240797000	17.05
3152	9249087	HRVATSKA	9AA2364	238212000	17.11
3153	9370769	NORD NAVIGATOR	3EPQ7	355288000	14.40
3154	9379208	JIAOLONG SPIRIT	C6WZ9	309813000	17.32
3155	9528512	CALAMAR	ZDKG6	236061100	5.30
3156	9340300	EEMS TRANSPORTER	PHBC	245017000	4.35
3157	9327401	BALTIC FROST	9HA2868	256495000	10.85
3158	9298741	MELTEMI	SVVR	240458000	15.84
3159	9312341	AMALIYA	9HA2210	248153000	9.77
3160	9131278	SOPHIE	ELXL6	636090564	11.65
3161	9006332	ELKE K	PBES	246180000	5.46
3162	9203538	EM ATHENS	V7US8	538004019	11.40
3163	9249312	FRONT MELODY	A8HH7	636090891	16.13
3164	9117208	WILSON LISTA	8PRW	314188000	5.50
3165	9111058	SITEAM ANJA	V7OW7	538003176	12.02
3166	9361768	ARKLOW FUTURE	EIGD5	250001594	5.79
3167	9414929	COSTANZA	3FAN8	351744000	13.05
3168	9472737	GINGA BOBCAT	3FFZ8	357460000	10.08
3169	9658109	ABIS DUNDEE	PCPU	246873000	6.45
3170	9351579	MSC TAMARA	3EOC	354745000	12.60
3171	9179127	CAPE BLANC	V7SR6	538003709	12.39
3172	9588146	BRIGHTWAY	9V8755	566422000	17.20
3173	9473767	TWINLUCK SW	3FCW3	373558000	9.64
3174	9391945	EMERALD	9HA2135	248033000	12.60
3175	9238038	BRITISH TRADER	ZIPR7	235496000	11.30
3176	9524463	SUEZ HANS	V7WJ8	538004318	17.17
3177	9424223	ZEYNEP A	9HCU9	256801000	7.40
3178	9356672	REECON EMIR	V7PZ4	538003318	8.20
3179	9388649	MAERSK TRANSPORTER	OYGQ2	220589000	7.75
3180	9638769	ARKLOW BANK	PCWW	244810323	7.20
3181	9014676	WITTENBERGEN	V2DA	304341000	5.50
3182	9108439	PAMIR	V2KZ	304010859	4.94
3183	9194282	JENNIFER BENITA	PFBC	244890000	5.60
3184	9407201	ORIENTAL MARGUERITE	3EOL7	356903000	8.81
3185	9534262	CHRISTINA	D5HS9	636091866	6.03
3186	8209717	NORDICA HAV	C6RA7	309473000	4.18
3187	9195664	FRI LAKE	C6VU2	309807000	5.15
3188	9341782	DEPENDENT	PHGP	246546000	6.10
3189	9213595	LUHNAU	V2BU1	304927000	5.50
3190	9442249	LOUISE KNUTSEN	2FOP4	235092964	8.90
3191	9275050	MAERSK NOTTINGHAM	A8DH2	636090708	11.50
3192	9622239	CAP SAN AUGUSTIN	DACG	218552000	14.50
3193	9181041	KONSTANTINOS D	A8PM4	636013799	11.93
3194	9500716	SEEB	9HA2317	248323000	22.50
3195	9176357	REGGANE	ELXO6	636011212	11.62
3196	9285641	MORNING CROWN	C6TM6	311698000	10.00
3197	9142643	TRANSBRILLIANTE	ZDHH4	236318000	6.41
3198	9215141	KAPPAGAS	V2IA5	304050982	7.45
3199	9388613	MAERSK TRACER	OYQW2	219017783	7.75
3200	9612533	ABIS BREMEN	PCJO	246779000	5.35
3201	9330056	STAR FIRST	9V9359	566058000	9.70
3202	9056040	WILSON GRIMSBY	8PSB	314193000	5.52
3203	9158109	WILSON CORINTH	V2BB2	304778000	5.67
3204	9246736	MAERSK HELPER	ZIOI3	235490000	6.60
3205	9352298	SEACONGER	DEJY	211822000	11.00
3206	9506186	ESHIPS DANA	ZDJT6	236566000	8.00
3207	9193288	DALLAS EXPRESS	DGAF	211311970	13.55
3208	9263356	KWK PROVIDENCE	9V2470	564232000	18.12
3209	9422079	GENCO COMMODUS	V7RP7	538003558	17.70
3210	9312705	FRONTERA	V2GM3	305995000	6.14
3211	9318333	TORM THAMES	OYNK2	220555000	11.00
3212	9391373	CONTI BENGUELA	A8PL7	636091569	11.32
3213	8008450	CSL RHINE	9HA2340	248375000	8.48
3214	9416575	FAIRPLAY-31	V2GH8	305940000	5.76
3215	9646716	AMORGOS	V7CI5	538005267	10.10
3216	9255749	GERD	V2BH3	304816000	7.73
3217	9006447	SEA RUBY	ZCIX8	319932000	4.02
3218	9226712	PHANTOM	ZDEH5	236124000	5.44
3219	9488827	FILIA NETTIE	PIPK	244363000	4.35
3220	9231535	NORMAND CUTTER	MESR3	235096351	8.41
3221	9568184	PHOENIX STRENGTH	3FYB5	357845000	15.00
3222	9347748	ERRIA SWAN	9HHJ9	256986000	8.00
3223	7725403	SPARTAN	9HCL7	215102000	4.71
3224	9150327	VENEZIA D.	PBRQ	246347000	7.85
3225	9333371	HELLE RITSCHER	A8IS6	636091030	10.86
3226	9360427	HAFNIA KARAVA	C4RZ2	210348000	9.85
3227	9295323	TORM SAONE	OYMM2	220570000	10.85
3228	1137901	SAND CARRIER 101	XXXX	null     	7.80
3229	8801046	PRINS JOHAN WILLEM FRISO	A8GS4	636012637	6.62
3230	9465241	MSC CRISTINA	D5BU7	636092409	15.50
3231	9005493	GAMMAGAS	V2KA6	304271000	6.46
3232	9220990	ALPHA ERA	9HSY8	256388000	17.97
3233	9034511	B GAS LINDA	9HA2930	256775000	4.96
3234	9308065	STORVIKEN	C6ZT8	311066100	16.42
3235	9361342	TASMAN	ZDKI2	236617000	5.95
3236	9471991	NOVOMAR	5BCT2	210974000	5.10
3237	9276030	ELBRUS	9HUB7	215571000	12.22
3238	9370525	SABAHAT SONAY	TCSL8	271000918	8.24
3239	9305350	ATLANTIS ANTALYA	9HA2286	248252000	5.95
3240	7612620	HERCULES	PHRS	245116000	3.03
3241	9109093	BSLE VIVY	3FJD7	353709000	8.28
3242	9612076	SAMJOHN VISION	SVBI4	241128000	18.57
3243	9620695	LEO SPIRIT	3FAQ	373057000	9.73
3244	9585895	STENA SUPREME	ZCEG9	310643000	17.00
3245	9263590	THUN GEMINI	PBJW	245610000	6.76
3246	9413523	STENA PREMIUM	ZCEE6	310612000	13.02
3247	8912352	HIGHLAND STAR	MNAA4	234235000	4.98
3248	9353101	CPO FINLAND	2AJP7	235060248	11.52
3249	9187837	SYN ZAURA	IBJF	247602000	6.50
3250	9163647	INGE	V2GM8	304001000	5.71
3251	8518340	PLUTO	8PAJ9	314417000	4.99
3252	8418564	SIMA	OUXR2	219017151	4.90
3253	9629067	EVER LUCENT	9V9792	564345000	14.50
3254	9412581	NORDIC VEGA	C6XZ5	311026700	17.50
3255	9370197	UNICORN OCEAN	3EPO5	372193000	14.38
3256	9632026	MOL QUASAR	S6NQ	563234000	15.52
3257	9279965	MSC FABIENNE	H3SF	354415000	13.55
3258	9642215	KANOURA	3FMD6	373537000	13.01
3259	9364007	SEA TRADER	9HA2269	229940000	4.86
3260	9317860	BOW ENGINEER	LASA7	258767000	10.92
3261	8519241	TRINE	V2EN5	305486000	5.35
3262	9123166	MSC ALABAMA	3EDK7	371602000	12.70
3263	8520886	RIZA SONAY	TCFP	271000021	7.44
3264	9443841	TIGRIS	V7SB4	538003615	8.30
3265	9591870	REM COMMANDER	LCOS	259866000	7.00
3266	9383429	MORNING LYNN	3FXS4	370808000	10.01
3267	9377183	NAUTILUS	OUYX2	219425000	6.76
3268	9234616	ADMIRAL	ZDFI5	236175000	9.17
3269	7224899	HUNTER	HP7517	355584000	3.85
3270	9622203	CAP SAN NICOLAS	LXCP	253056000	14.02
3271	9215294	BOW SIRIUS	LACQ7	258910000	13.30
3272	9346160	TUBARAO	C6YB8	311028800	12.54
3273	9256327	SUDEROOG	ZDHC8	236300000	9.90
3274	9459022	NCC NAJEM	HZEJ	403518001	12.40
3275	9595929	TRANSTIME	9V9496	566342000	11.30
3276	9589401	BLUE CHO OYU	3EUZ6	357280000	18.22
3277	9354894	ATLANTIC LILY	VREF6	477110700	12.21
3278	9349215	ASTROSPRINTER	C4RJ2	210167000	7.30
3279	9296810	ESTEEM SPLENDOUR	H3XZ	352755000	14.73
3280	9609237	SAKURA GLORY	3FII4	373281000	12.93
3281	9216688	TAI HEALTH	H9DK	356235000	11.92
3282	9421659	EEMS STAR	PHMP	245072000	4.26
3283	9220548	UNION DIAMOND	ORLK	205349000	4.50
3284	7926409	EDMY	E5U2465	518515000	7.01
3285	9330393	ORIENTAL ROSE	ZGBF5	319024300	8.81
3286	9464572	ORIENT CENTAUR	5BYD2	212060000	14.50
3287	9656187	SAPURA DIAMANTE	3FBU7	355422000	7.60
3288	9423592	ENGIADINA	HBFD	269067000	12.83
3289	9490117	SPRING WARBLER	3EYE8	373066000	14.44
3290	9293105	REA	9HRB7	215528000	12.26
3291	9479577	ANITA	PBAV	244615976	4.15
3292	8910067	FAR SUPERIOR	VSPB4	235003470	4.98
3293	9207508	MISSISSIPPIBORG	PCGZ	244976000	7.12
3294	9017422	PASADENA	V2FA7	304228000	5.64
3295	9305295	PANAGIA	V2OQ5	304610000	7.59
3296	9653692	CHANG HUA	VRKV9	477017700	12.80
3297	9298507	MINERVA ANNA	SVNP	240729000	13.29
3298	7915307	WILSON TYNE	9HWY5	248245000	7.02
3299	9280706	OSTENAU	V2BH6	304817000	5.49
3300	9501162	DABA	V7XU7	538004575	22.63
3301	8874524	AMT TRADER	XXXX	0        	6.90
3302	9341251	CARLO MAGNO	IBYF	247153600	6.20
3303	9617959	HAFNIA LIBRA	OUYK2	219484000	13.00
3304	9123374	ALPHA FRIENDSHIP	SVAV9	240965000	17.52
3305	9299692	NS CONCORD	A8FD7	636012382	15.36
3306	9297113	ULUS PRIME	UHPW	273438680	4.46
3307	9259173	AFRAMAX RIVER	3FCQ6	373722000	14.80
3308	9276391	SKANDI SOTRA	LLYV	259452000	6.10
3309	9613630	ABIS DOVER	PBYV	245547000	6.45
3310	9343780	GINGA PUMA	3EFS5	353992000	10.08
3311	9391000	RYSTRAUM	LAKN6	258858000	7.74
3312	9351464	ARIANE	D5FO5	636092552	14.52
3313	9245299	LAURA-H	ZDHU3	236363000	5.65
3314	9639907	CHIOS SUNRISE	SVBP9	241221000	12.80
3315	9673850	NUNAVIK	V7CK9	538005278	10.20
3316	7052911	BARRACUDA	PGBA	245797000	4.20
3317	8119637	NORTH TRUCK	2FHX8	235091435	4.98
3318	7909712	DINOPOTES	PDQI	244935000	2.25
3319	9264465	MTM FAIRFIELD	9V9680	566292000	9.82
3320	9290323	AEGEAN ANGEL	SXPR	240213000	17.07
3321	9489091	UACC MARAH	V7TP3	538003851	12.17
3322	9160803	SAGA TUCANO	VRVP2	477587000	11.82
3323	9640126	FOREST PARK	2GZD7	235101728	9.71
3324	9373137	KORSARO	IBES	247256400	10.55
3325	9278480	ROSITA	ICRL	247306600	9.50
3326	9567697	EUROVISION	C6AD8	311076800	17.15
3327	9489089	UACC MANSOURIA	V7TP2	538003850	12.15
3328	9284843	JAEGER	V7GM8	538002659	12.00
3329	9356543	STROOMBANK	PBSE	244617000	5.83
3330	9248564	NASSAUBORG	PHDU	246430000	9.38
3331	9579781	NEW HYDRA	HPDA	351785000	18.32
3332	9637088	ARDMORE SEAVANGUARD	V7CE3	538005249	11.00
3333	9163776	BRO JUNO	OZGK2	219254000	9.50
3334	9021083	ONEGO	3FQM4	357468000	3.90
3335	9352365	NOVA K	PHCR	246301000	2.30
3336	1133876	STEMAT 89	PCBG	244750587	2.50
3337	9538165	SUPERBA	C6AR9	311000133	10.50
3338	9597824	DONG-A ETHER	V7XN6	538004522	18.22
3339	9147459	NEKTON	PCSX	244812000	4.83
3340	9385075	EMERALD BAY	2HDO6	235102768	10.02
3341	9179373	VOORNEBORG	PCGI	245491000	7.06
3342	9524205	ZAPOLYARYE	UBEF5	273338310	9.91
3343	9407017	GELIUS 1	UGIA	273357650	4.46
3344	9517238	JOHANNA DESIREE	V2FE5	305652000	5.42
3345	9440590	ICE CRYSTAL	V2EF4	305412000	7.40
3346	9396660	CLIO	A8NV9	636013571	14.82
3347	9134359	WARWICK GAS	3FIH9	353846000	6.63
3348	9388912	FORESIGHT	V2DC5	305168000	7.50
3349	9313797	BELTERWIEDE	PHCM	246252000	6.09
3350	9437165	BBC BANGKOK	V2EP9	305512000	7.00
3351	9133070	MAERSK CATHERINE	S6LY9	566505000	12.21
3352	9214604	KEITUM	V2OO9	304343000	8.38
3353	9418987	HHL VENICE	V2ET4	305545000	9.50
3354	9613006	LEVERKUSEN EXPRESS	DJDS2	218565000	15.52
3355	9295165	CHARLES DICKENS	A8IJ4	636090986	13.50
3356	9336658	NORDIC RIVER	3EKH3	372721000	10.42
3357	9430143	JULIE-C	2CJQ7	235073372	8.10
3358	9391971	TIARE	A8SA8	636014190	14.52
3359	9331555	GENCO TIBERIUS	VRDD3	477926600	17.82
3360	9343883	PRIGIPOS	SZRF	240625000	14.73
3361	9359052	GERDA MAERSK	OUJS2	220598000	15.00
3362	9342205	HOEGH LONDON	LAPY7	258981000	10.00
3363	9454814	NARWA	V2DN2	305262000	6.04
3364	9549657	NEPHRITE	UBAK4	273339840	6.41
3365	9044932	SWE-BULK	C4FJ2	210474000	5.08
3366	9279733	SEA HERMES	9HA3226	229317000	12.00
3367	9163611	PS SAND	C6AZ5	311000200	4.70
3368	9548366	SVITZER THOR	OWDJ2	219015425	5.70
3369	8219463	STANISLAV YUDIN	5BYM2	210334000	8.91
3370	1133960	D2	PDNC	0        	2.20
3371	8943569	GOUWESTROOM	PDGR	246166000	2.05
3372	9665621	THALASSA ELPIDA	9V2231	564388000	15.80
3373	9245768	COLUMBINE MAERSK	OUHC2	220129000	12.20
3374	9278521	AQUAJOY	A8TY6	636014457	17.98
3375	9262584	CHEMBULK NEW YORK	9VFA8	565725000	10.91
3376	9593426	SAN SABA	V7UT8	538004027	17.17
3377	8213885	SMIT ORCA	ORNX	205466000	4.20
3378	9404235	ODERTAL	V2CW4	305125000	5.25
3379	8813972	KEGUMS	LAIR7	257385000	5.06
3380	9312901	MELIORA COGITO	V7JP5	538002554	11.52
3381	8505898	AMT DISCOVERER	2BWU4	235070007	6.20
3382	9195767	BEAUMOTION	PBLE	244271000	5.50
3383	1137951	NP 440	XXXX	0        	4.80
3384	9112117	CHAMPION TIDE	LALX7	259095000	12.06
3385	9542154	MID NATURE	ZGCD8	319249000	9.48
3386	9251884	TOSCA	A8EF7	636012244	12.18
3387	7349807	LORELAY	3EWN4	355827000	11.00
3388	7527849	CEMSTAR	V7FT7	538005655	6.53
3389	9323766	CELSIUS MANHATTAN	V7CN3	538005288	9.79
3390	9261487	UNION MANTA	ORKJ	205340000	6.60
3391	5347221	OOSTERSCHELDE	PGNP	246011000	3.40
3392	9519303	ALMANDIN	A8WQ9	636092089	12.80
3393	9260055	CAPE BON	V7EP3	538090169	11.10
3394	8302076	LASTDRAGER 12	PFNN	0        	2.20
3395	9215115	BLUE MARLIN	A8RB9	636014065	11.02
3396	9658680	LORD STAR	3FUG5	370879000	14.65
3397	9254977	VADERO HIGHLANDER	LAMK7	259737000	4.27
3398	9195901	SWEGARD	OJNF	230998000	6.18
3399	9288887	NORDIC FREEDOM	C6UL7	311817000	16.95
3400	8504272	ARUNDO	J8B3530	375607000	4.67
3401	9514925	SCHELDEDIJK	PBMR	24506000 	6.22
3402	9249441	HIGHLAND BUGLER	ZIWP9	235004450	5.90
3403	9166443	LELIE	PDBN	246449000	5.60
3404	9281499	HEROI STAKHORSKIY	UUCD	272489000	4.86
3405	9369980	NORD LEADER	3EJD8	372483000	12.52
3406	9411939	MINERVA MARINA	SVAP9	240879000	17.15
3407	9518244	KLAVERBANK	PCJI	246134000	6.10
3408	9333670	MIKHAIL ULYANOV	UBAL3	273328440	13.60
3409	9565326	PACIFIC RESOURCE	VRGD5	477661200	18.10
3410	9600633	LIBERTY DESTINY	V7YL3	538004684	12.20
3411	9140970	BELBEK	P3MG8	212857000	6.00
3412	9633458	ODESSA	9HA3043	229070000	16.00
3413	9047518	BOW CLIPPER	LAUU4	258947000	10.72
3414	9296808	AJAX	V7JF9	538002511	14.16
3415	9575383	RAINBOW WARRIOR	PF7197	244163000	2.75
3416	9130236	HELSINKI	V2PM	304010780	5.72
3417	9138769	SCOT RANGER	MZKS5	232004332	5.11
3418	9582867	WILSON LUBECK	V2FD3	305639000	5.49
3419	8404599	ESPERANZA	PD6464	244690000	4.32
3420	9199139	PINNAU	V2LB	304470000	5.50
3421	9423712	KAREN MAERSK	OYDB2	220529000	9.55
3422	9682318	SILVER GINNY	V7EE6	538005462	13.30
3423	9444819	GENCO CLAUDIUS	V7SY6	538003750	17.70
3424	9174397	DS COMMANDER	C6QO5	308278000	22.72
3425	9406075	CLIPPER TALENT	C6YD2	311016300	9.50
3426	9316608	NORD FAST	9V8750	564182000	11.11
3427	9213313	OVERSEAS FRAN	V7CY3	538001577	14.62
3428	8811936	ARTISGRACHT	PCUI	244600000	8.50
3429	8116178	DIOGUE	6WKS	663105000	4.52
3430	7528491	ARION	PFBZ	244699000	3.26
3431	9114476	MARINA K	D5AU5	636015448	9.52
3432	9445265	FPMC B. GUARD	A8XI9	636014905	18.10
3433	9339351	AMBER RAY	D5CV5	636015786	9.67
3434	9368601	RIAD AHMEDOV	9HZR8	256651000	5.06
3435	9308558	EXCELLO	SJMG	266273000	9.75
3436	9318321	ANTWERPEN	VRBK6	477076700	9.50
3437	9419319	FRASERBORG	PCJS	245639000	7.80
3438	9065962	MARGARETHA	V2EO	304010448	5.50
3439	9306639	MAERSK PETREL	9V9741	566329000	15.52
3440	8917728	SERENO	PHMA	244996000	6.07
3441	8224418	ALIDA (SCH 6)	PCLU	244309000	6.10
3442	9458808	UACC DOHA	V7FS5	538005653	12.16
3443	9249075	ALAN VELIKI	9AA2136	238203000	17.19
3444	9330666	WHITE DIAMOND	A8LK6	636013215	12.60
3445	9227687	TIAN HUA FENG	VRWX2	477862000	14.01
3446	9633068	WAKAYAMA MARU	D5DS6	636015960	18.24
3447	9406893	SEMIRIO	V7MN4	538002875	18.12
3448	9152507	STENA ALEXITA	C6AH5	311000046	15.73
3449	9407213	FILYOZ	9HA2636	215090000	6.29
3450	9660061	CS JADEN	C6AS4	311000137	10.54
3451	9441623	HOEGH ANTWERP	C6AO2	311000101	10.00
3452	9406958	ANGELA	PCNW	244790033	7.06
3453	9410662	MED ADRIATIC	9HA3523	229692000	7.20
3454	9198616	BBC HOLLAND	ZDFB2	236034000	5.74
3455	9543990	ATLANTIC ZEUS	9V9847	566593000	8.99
3456	9156113	ULRIKE G	V2BY9	304407000	5.67
3457	8521464	LEONARDO	OJQI	230644000	3.45
3458	9364277	N AMALTHIA	3EIC7	372100000	13.84
3459	9630030	TORILL KNUTSEN	MRVZ8	235102583	15.50
3460	9423920	SKYTHIA	9HA2168	248087000	18.30
3461	9489546	CRISTINA	PBVY	246639000	5.25
3462	9640138	CHEM AMSTERDAM	V7BY2	538005215	9.70
3463	9439321	RED OAK	V7EY8	538005569	8.70
3464	9217333	AMAK SWAN	OWKO2	220016000	6.79
3465	9403906	NORDIC HENRIETTE	9HA3647	229831000	6.29
3466	9614608	GRAND CANYON	3EVR8	370505000	7.50
3467	9593414	TRYSIL SPIRIT	V7UT6	538004025	14.45
3468	9384162	ALESSANDRO DP	C6AT7	311000149	9.30
3469	8954714	VLIELAND	OZJU2	219133000	2.40
3470	9628518	SUNRISE-G	3FKF6	354131000	4.10
3471	9333412	SCF YENISEI	UBUL6	273341570	12.43
3472	9434163	PERNILLE	5BNZ2	212662000	5.30
3473	8801084	STELLA LYRA	PHUJ	244503000	5.71
3474	9352200	STOLT SAGALAND	ZCTV7	319282000	11.89
3475	9520895	STAR VEGA	V7EH8	538005472	14.48
3476	9248497	FRONT PAGE	ELZF3	636011436	21.52
3477	9504786	BBC PEARL	V2FY8	305855000	9.10
3478	9376775	TIWALA	V2DX3	305364000	5.25
3479	9405368	BENTE	PBTG	245870000	5.65
3480	9287297	FAIRCHEM MUSTANG	HPOW	351516000	9.72
3481	9139945	GAS PACU	V7VT8	538004210	6.82
3482	9395355	JUTLANDIA SEAWAYS	2CSU8	235075466	6.80
3483	9584994	AMISOS	9HA2955	256891000	7.60
3484	9260029	BALTIC CHAMPION	9HGN9	256960000	11.20
3485	9473092	HARBOUR FEATURE	CQNX	255804280	8.40
3486	9402926	MARAN POSEIDON	SVAV3	240959000	17.17
3487	9500091	LUSITANIA G	ICSS	247312400	13.02
3488	9489168	RAVNI KOTARI	9AA6971	238262000	9.90
3489	9088316	UR 2	LK5437	0        	4.90
3490	9224776	CSK GLORY	9V2469	563976000	17.83
3491	9323974	RIVER ETERNITY	3EIC3	372078000	14.88
3492	9246786	FAVOLA	IBFH	247069800	11.00
3493	9077587	ZAMOSKVORECHYE	9HPO5	248036000	6.70
3494	9446001	MORNING LENA	3FBV	352960000	10.02
3495	9420631	KARAVAS	3EYL9	355600000	14.58
3496	9306392	CREMONA	V2BE6	304805000	6.70
3497	9288758	BRITISH INTEGRITY	MGGF9	232366000	12.19
3498	7641164	S 600	C6TZ7	0        	8.40
3499	9602928	CAPTAIN X KYRIAKOU	V7AW8	538005083	22.52
3500	7737690	IJSSELDELTA	PIUN	245709000	3.50
3501	9534286	GERHARD G	V2FD5	305641000	6.04
3502	9106924	WILSON BORG	9HNO4	249211000	5.49
3503	9601132	AIDASTELLA	ICUP	247322800	7.20
3504	8902553	DRESDEN EXPRESS	ZCEI9	310658000	13.50
3505	9181900	HAPPY BRIDE	ZIRQ8	235514000	6.29
3506	9153903	DA QIANG	3FWI8	353328000	9.12
3507	9434400	ANANGEL TRUST	SVBO3	241198000	18.20
3508	9479890	SANDRA	V7QQ4	538003419	18.17
3509	9505285	SCHILLPLATE	ZDJJ8	236111603	5.30
3510	9202857	EMERALD	A8IP3	636091015	8.66
3511	9125736	ABERDEEN	C6OL4	309742000	15.50
3512	9409065	CAPE BRITANNIA	HP7836	357929000	18.00
3513	9312913	BRITISH ENSIGN	MMER9	235010980	11.32
3514	9413341	PAGANINI	V2CL8	305040000	5.64
3515	9496692	GANGES STAR	9HA2339	248374000	8.70
3516	9248370	LEIRIA	5BYU3	212202000	4.13
3517	9344514	ARKLOW RIVAL	EIXP	250000772	5.68
3518	8702410	DANICA SUNRISE	OXWB2	219209000	4.48
3519	9263588	LURO	PEAE	244059000	5.85
3520	9247601	SV. APOSTOL ANDREY	UBJI5	273355260	4.34
3521	8419623	SORMOVSKIY-3056	UDBT	273316200	4.25
3522	9352339	FLINTERLAND	PECW	246246000	7.05
3523	9210012	IBERICA HAV	C6YI3	311034400	3.70
3524	8407448	BASEL S5	T8ZF	511005100	5.31
3525	9451252	ANDRE-B	PHON	245188000	3.90
3526	9508469	BBC RUSHMORE	V2GB3	305864000	7.60
3527	9292230	VANCOUVER BRIDGE	H8FE	356413000	13.52
3528	9167930	TARNFORS	OWQG2	219529000	7.50
3529	9295426	ANNELIESE ESSBERGER	PCFK	244889000	7.40
3530	9671474	INDIAN DAWN	PCUU	244790608	5.80
3531	9177480	URANIA	9HA3244	229335000	9.73
3532	9407354	HORIZON ARMONIA	A8QI9	636013938	13.08
3533	9314868	KAZDANGA	V7LI8	538002756	11.20
3534	9303649	CHEMROAD HAYA	HOXT	354801000	11.02
3535	9167356	HAGEN	V2PB3	304010898	5.71
3536	9310202	NURI SONAY	TCPK9	271000876	8.24
3537	3130506	GREENBARGE 2	XXXX	0        	4.84
3538	9263899	PRINS DER NEDERLANDEN	5BGF2	212640000	9.24
3539	9156539	SVEVA	IBEU	247359000	9.08
3540	9005742	WILSON DVINA	8PTC	314220000	5.08
3541	9377705	CALA PINGUINO	3EIX6	372430000	9.52
3542	9584712	ROYAL PRINCESS	ZCEI3	310661000	8.55
3543	9034327	IRENE	SZJX	239464000	13.12
3544	9315068	STAR OSPREY	3FXX8	352797000	13.17
3545	9307243	CSCL LE HAVRE	C4PW2	209979000	14.50
3546	9355812	RIJNBORG	PHFZ	246530000	7.70
3547	9364150	SINE BRES	OXFL2	220487000	5.30
3548	9500819	UNIVERSAL BALTIMORE	9HA2798	215848000	12.80
3549	9376490	ANNE-SOFIE	V2FV6	305814000	9.08
3550	9401257	BEAUMAIDEN	PHOU	244366000	5.42
3551	9167136	CHEMTRANS RHINE	A8FF3	636012392	11.81
3552	9653408	AL FUNTAS	9KFH	447184000	22.52
3553	9317808	VEGADIEP	PBHV	245579000	7.05
3554	9392327	CARONI PLAIN	VREQ2	477163900	10.53
3555	9285940	REDHEAD	VRAK4	477640200	10.75
3556	9652545	SANTA ADRIANA	3EWN	372791000	12.20
3557	9361110	BEAUMERIT	PBMF	245615000	5.68
3558	9667459	COPENSHIP WISDOM	3FCV2	355534000	13.01
3559	9397652	ALBIZ	EASR	225390000	6.22
3560	9528043	DAYTONA	9HA2745	215497000	13.60
3561	9291731	ARKLOW REBEL	EIVG	250000444	5.68
3562	9255488	SEAHAKE	DEEI	211409100	11.00
3563	9260263	CAPE BILLE	V7FA8	538090168	10.05
3564	9313668	MUHLENAU	V2OT1	304690000	5.50
3565	9536064	BIRGIT G	V2QD5	305502000	5.42
3566	9203796	LAKATAMIA	C6UP8	311992000	12.80
3567	9122344	SEIHOLM	LCBV	257467000	1.75
3568	9318137	EVRIDIKI	A8LA4	636013156	17.32
3569	9657478	FAIRCHEM SABRE	3FBY8	355814000	9.70
3570	7710214	HERMOD	H3IA	356707000	28.20
3571	9628908	GALAXY	VRJY2	477902900	14.45
3572	9646314	BYLGIA	PBMQ	244740210	6.00
3573	8766454	H 302	XXXX	0        	5.50
3574	9592070	LONG DAR	VRLR8	477250900	14.45
3575	9191931	NORRBOTTEN	2FTU9	235094204	6.56
3576	9407067	DIAMOND ORCHID	9VNH4	565789000	9.57
3577	9369655	SAGASBANK	PCGU	246061000	5.79
3578	9155896	FLINTERZEE	PCCI	245793000	6.31
3579	9172650	SKS TIETE	LAKU5	257578000	15.72
3580	9183609	DAN EAGLE	OYCU2	220537000	12.21
3581	9287924	MARGRIT RICKMERS	A8HN5	636090921	13.50
3582	9559896	THORCO ASIA	V2FW6	305825000	7.78
3583	9594298	VECTIS FALCON	2FBR7	235089914	8.00
3584	9452218	MICHELLE-C	2CRW6	235075245	8.06
3585	9447029	BASAT	9HNX9	249255000	7.97
3586	9013000	JAN D	V2DO8	305286000	4.94
3587	9064891	WILSON HARRIER	9HJP9	249066000	5.75
3588	8915627	FRI WAVE	PJPA	306834000	5.29
3589	9572006	MULTRATUG 20	PBFX	244790899	4.30
3590	9489118	NAVE CONSTELLATION	V7TP5	538003853	12.15
3591	9409209	CMA-CGM MAUPASSANT	2DSD6	235081604	14.50
3592	9138953	NEW KATERINA	H9ZI	351345000	17.61
3593	9064229	CARIBBEAN MERMAID	A8JH5	636091090	8.80
3594	9552147	WAGENBORG BARGE 9	XXXX	0        	5.50
3595	9365659	AMERICABORG	PHKT	244693000	9.69
3596	9417165	YANG MEI HU	BQCG	413858000	15.45
3597	9363792	ISLAND EXPRESS	VRMJ5	477463900	12.12
3598	5100427	ELBE	PDWN	244532000	5.00
3599	9237072	ASTRO CHALLENGE	SVUL	240169000	20.80
3600	9228655	CAPE BATA	V7EF2	538090162	17.03
3601	9433743	PEGASUS	V2ED2	305389000	5.20
3602	9306677	SLOMAN THEMIS	9HA3701	229899000	11.82
3603	9504152	VESTANHAV	PCMK	246279000	7.66
3604	9212278	JADE	DDUT	211334830	3.56
3605	9088354	UR 6	LK6046	0        	4.90
3606	9190080	ATLANTIC PIONEER	P3MA8	212852000	9.71
3607	1130140	E 1506	PDUU	0        	2.60
3608	9466300	ALBANYBORG	PCEY	246519000	9.69
3609	9593713	VIENNA WOOD N	VRHS6	477051600	12.74
3610	9509956	FLEVOGRACHT	PBUT	246620000	8.52
3611	9439826	EVA SCHULTE	9V8141	564739000	8.80
3612	8600167	AGHIOS MAKARIOS	SYGQ	237952000	12.86
3613	8503979	DANICA RAINBOW	OWQQ2	219207000	4.48
3614	9459618	KAPITAN KONKIN	UEBC	273342920	4.79
3615	9196242	VAASABORG	PDAI	246441000	7.06
3616	7613002	IZMIR BULL	E5U2487	518537000	4.80
3617	8646331	DINA-M	PDQB	245551000	2.38
3618	9021758	NAUTILUS ZR.MS.	PAYO	245989000	1.50
3619	9675391	ORANGE OCEAN	D5DS2	636015956	9.70
3620	8516287	TEMEL DEDE	TCA3204	271043901	4.60
3621	9527609	COLORADO STAR	9HA2189	248127000	8.71
3622	9567776	IMARI	3EZI9	373202000	9.66
3623	9633006	SANTA BARBARA	9V9962	566801000	11.30
3624	9411317	NCC AMAL	HZEE	403513001	12.15
3625	9288071	SAMPOGRACHT	PHDL	246396000	10.74
3626	9393151	BRANT	5BBK2	212372000	10.40
3627	8420787	STAR GRIP	LADQ4	257313000	11.72
3628	9333682	KIRILL LAVROV	UBOL9	273345750	13.80
3629	9549281	NOVAYA ZEMLYA	UFNZ	273334820	9.91
3630	9072173	NAVIOS GEMINI S	3FMN4	353939000	13.29
3631	9138525	DON QUIJOTE	9V8797	564753000	9.50
3632	9304356	SEAPACIS	VRBE2	477999500	14.94
3633	9293961	FUTURA	IBMC	247158200	11.11
3634	9008483	GAS ARCTIC	9HDU8	215867000	6.21
3635	9138202	BALTIC MERCHANT	ZDFP2	236195000	5.02
3636	9391397	CONTI GREENLAND	A8QM9	636091621	11.30
3637	9125372	CELESTINE	ONDJ	205450000	6.52
3638	9382190	PAXOI	A8TU5	636014431	6.00
3639	9231573	PRABHU DAYA	S6EJ3	565054000	12.02
3640	9619969	MARIBO MAERSK	OWJJ2	219019094	16.03
3641	9638484	JOSCO JINZHOU	VRLE3	477444300	12.68
3642	9412098	PHAETHON	SVAM2	240836000	17.15
3643	9207730	PANTELIS	A8UQ6	636014539	13.24
3644	9316244	RADIANT SEA	V7DX2	538005443	14.45
3645	9198654	DANIEL K	PBIR	244336000	5.64
3646	9314870	KRISJANIS VALDEMARS	V7LI9	538002757	11.22
3647	9183611	HELLAS ENDURANCE	SZVO	239644000	12.22
3648	9219264	FRIDA MAERSK	OZGS2	219284000	10.22
3649	9638771	ARKLOW BAY	PBPI	244700336	7.19
3650	9190212	ZEUS	PCIK	246432000	7.45
3651	8128884	ICELANDICA HAV	C6VC3	309175000	4.22
3652	9442548	ARIANE MAKARA	9V7973	563405000	9.77
3653	9505936	JO ILEX	LAOH7	257526000	9.62
3654	9229051	THUN GLOBE	PBCA	245573000	6.75
3655	9405849	MATRAH	3FRL9	370985000	13.15
3656	9235880	TEMPERA	OJKD	230944000	14.50
3657	5301849	RIJNDELTA	PHFR	244618000	6.10
3658	9310680	BRIGHT PACIFIC	H3DB	356393000	12.62
3659	9363182	CLIPPER LANCER	C6VS2	308164000	8.22
3660	9252096	BOX QUEEN	A8ZK6	636015232	13.20
3661	9389083	AGRARI	SVAP7	240875000	14.80
3662	9559872	THOR COMMANDER	V2FP5	305749000	7.78
3663	9340477	OCTADEN	DYPZ	548765000	9.67
3664	9204805	BSS FORCE	A8YK7	636015076	9.23
3665	8213744	SEAHORSE	PCAP	244137000	6.37
3666	9150303	YONG XING	VRYZ5	477450000	9.32
3667	9180877	FLINTERMAAS	PBRR	246410000	6.38
3668	9429560	BUGSIER 10	DFWB2	218321000	6.10
3669	9574999	ALAED	UBRI4	273355170	7.20
3670	9320233	GJERTRUD MAERSK	OYGH2	220414000	15.00
3671	9695523	MERCURIUS	PCYS	244820548	4.25
3672	9695511	SVITZER LONDON	2HHL8	0        	4.25
3673	9294991	HOUSTON EXPRESS	DCCR2	211744000	14.50
3674	9423035	BOX TRADER	A8WO6	636014792	11.00
3675	9398395	ZIM LOS ANGELES	A8SI3	636014217	14.50
3676	9391476	STENA PENGUIN	ZCEC9	310602000	13.00
3677	9433262	HHL ELBE	D5EW4	636092528	8.00
3678	9587192	DOLVIKEN	LADK7	257077000	17.00
3679	8412390	ALTONA I	9HUF6	248861000	5.42
3680	9226994	BRUNHILDE SALAMON	V7HF5	538090155	14.20
3681	9390159	THESEUS	V2FQ9	305761000	5.50
3682	9378151	CLIPPER HERMES	LAIC6	258645000	10.58
3683	9373644	PATANI	9HNS9	249246000	8.90
3684	8822636	PLATO	8PRX	314189000	5.27
3685	9476044	MTS VALIANT	2AVA4	235063155	2.63
3686	9491903	BLUE CARMEL	V2ER5	305527000	6.13
3687	9100126	SWAMI	C6WF8	308218000	5.75
3688	9729518	DURWARD KNOWLES HMBS	C6BE9	0        	2.50
3689	9442718	SAFE VOYAGER	3EMI4	352147000	14.43
3690	9308508	COSCO BEIJING	SVPI	240512000	14.50
3691	9315185	ANTARCTIC	D5BM7	636015560	17.03
3692	9390111	JASON	V2GI6	305949000	5.50
3693	9006394	STEFAN K	PBER	246062000	5.47
3694	9427988	BORCHALI	9HA2150	248058000	8.69
3695	9122966	ASIAN VISION	D8CU	441992000	11.69
3696	9167320	ULTRAMAR	P3WF9	209662000	5.69
3697	9534456	MOTION SCAN	PCNB	245523000	7.90
3698	9525857	UMM SALAL	9HA2682	215237000	15.52
3699	9448176	SD STINGRAY	9HBT9	256758000	3.85
3700	8756617	PARAGON C461	A8BO4	636011816	4.00
3701	9006851	RENATE N	A8NQ8	636013535	20.82
3702	9375941	STELLAE MARE	H9QL	370736000	14.55
3703	8636740	FJORD	PHDZ	246450000	6.09
3704	9136199	RAMBIZ	ORKA	205132000	3.70
3705	9517458	BESIKTAS PERA	9HA2115	249993000	5.80
3706	9337341	YASA GOLDEN MARMARA	V7ME8	538002844	14.98
3707	9181170	ESMERALDA	9HA3564	229737000	8.65
3708	9275660	ENERGY CONQUEROR	MEPE6	235007450	12.22
3709	9438406	YASA POLARIS	V7RY4	538003601	17.03
3710	9259915	AZAHAR	IBEH	247088700	11.02
3711	9405382	SEA GOLF	PBSS	246590000	3.20
3712	9207388	PALMELA	H3AP	351340000	9.62
3713	9534365	CFL PENHAR	PBXQ	246666000	6.08
3714	8801113	BURGTOR	V2OR7	304665000	5.08
3715	9130729	ZEUS	OJHB	230339000	6.72
3716	9622215	CAP SAN MARCO	LXCQ	253346000	14.50
3717	9606053	FEDERAL KIBUNE	3FNJ7	373354000	10.87
3718	9632038	MOL QUINTET	S6LT4	563247000	15.50
3719	9155004	LOPI Z	V7LD7	538002728	13.48
3720	9414149	ULTRA TIGER	3FVR8	355410000	14.55
3721	9310410	AMARANTHA	VRBB3	477995600	14.10
3722	9323168	URAG EMS	5BZX3	210774000	4.20
3723	9088304	VEGA 25	XXXXX	0        	4.90
3724	9313735	WILSON AMSTERDAM	V2EO7	305497000	5.13
3725	9298650	AMALTHEA	SYGJ	240447000	14.52
3726	9278715	GINGA TIGER	HPQG	353491000	10.08
3727	9229049	FLINTERSPIRIT	PFCF	244339000	6.37
3728	9629809	ZUIDVLIET	PBZE	244650317	5.40
3729	9111125	COUNTESS ANNA	V2AE1	304010483	4.79
3730	9400708	CHARLOTTE THERESA	OWBJ2	220625000	8.30
3731	1136151	NP 411	PCQH	0        	5.00
3732	9613018	LUDWIGSHAFEN EXPRESS	DDOR2	218566000	15.50
3733	9221229	CIC CAPTAIN VENIAMIS	SWFB	240673000	17.70
3734	9604744	IVS IBIS	9V9344	566421000	9.82
3735	9378022	WAPPEN VON AUGSBURG	2BSH6	235068896	7.42
3736	9581447	FIDELITY 2	3EUO8	371018000	12.62
3737	9644251	UNIVERSAL DURBAN	9HA3061	229089000	9.80
3738	9050620	ARSLAN 1	V2QP2	305685000	5.19
3739	9330836	NORILSKIY NICKEL	UCDX	273310730	10.00
3740	9682148	OLYMPIC BOA	LFIP3	257224000	7.12
3741	9251391	MOL EXPRESS	VRMQ3	477904700	13.50
3742	9221657	EL JUNIOR PNT	V7SK8	538003673	13.20
3743	9624457	AUSTRALIA MARU	3FDT4	373884000	18.24
3744	9287912	KAETHE C. RICKMERS	V7MB9	538002862	13.50
3745	9534145	BALABAN	TCTR5	271002710	12.82
3746	9681675	GPS AVENGER	2GVV2	235100957	3.00
3747	9386976	WYBELSUM	ZDIN2	236465000	9.90
3748	7508037	MONTALVO	CSDK	263610000	4.43
3749	9184811	CHRISTINA	V2PX5	304010973	6.22
3750	9228813	BALTIC SOUL	9HCP7	215110000	10.85
3751	9423669	ROBIJN	PBEJ	245909000	5.25
3752	7413713	FRIGG	5BHQ2	212390000	3.80
3753	9492555	BKM 333	PBPH	0        	4.36
3754	9413652	HITRA	9HRO9	249421000	5.98
3755	8818958	CORK SAND	5BGU2	0        	3.70
3756	8818960	LONG SAND	5BGS2	210206000	3.23
3757	1133460	STEMAT 78	XXXX	0        	4.00
3758	8912027	ADELE	V2UE	304010160	5.08
3759	1138301	REGENTES	XXXX	0        	6.10
3760	9372872	QUADRIGA	A8RH4	636091657	12.00
3761	9451343	DA TONG YUN	VRJL3	477108600	10.10
3762	9356581	FRAKT FJORD	3YNL	257767000	5.79
3763	9313462	ST. JOHANNIS	VRCG6	477607100	13.15
3764	9565766	BOCHEM CHENNAI	3FCK7	373193000	9.71
3765	9065443	MSC ROSSELLA	9HA3656	229844000	12.11
3766	9427330	ROYAL FLUSH	3EZW8	353280000	12.80
3767	9294276	CHEMBULK ULSAN	9VFA4	565721000	10.01
3768	9015929	EEMS DELTA	PCAT	244630231	4.08
3769	9552355	ROYAL KNIGHT	3FMB9	357928000	12.68
3770	9036284	ANNETTE ESSBERGER	CRXT	255809000	6.14
3771	9539602	HOUSTON	V7SH7	538003656	18.30
3772	9279032	ANNIKA BENITA	PHDB	244482000	4.85
3773	9492517	GOOD LUCK	A8ZS4	636015287	12.20
3774	9143506	HAPPY BEE	ZNBJ6	235192000	7.61
3775	9635858	BW JAGUAR	9V2553	564409000	13.30
3776	9410131	NILUFER SULTAN	V7ZG3	538090448	9.70
3777	9306483	ROSSINI	9HA3643	229824000	11.40
3778	9445045	INDIGO OCEAN	3EQN4	353741000	9.76
3779	9433846	FPMC 26	A8YV5	636015142	12.90
3780	9518969	BERINGDIEP	A8ZL6	636015240	6.20
3781	9014937	KATRE	9HCQ9	256793000	5.45
3782	9149495	STOLT SEA	ZCSQ7	319478000	10.11
3783	9305594	COSCO YANTIAN	SWWC	240513000	14.50
3784	9623312	NOBLE SAM TURNER	D5AJ2	635015378	9.45
3785	9139311	HAPPY RANGER	PCER	245539000	9.51
3786	9601168	MYSTRAS	C6AL5	311000080	13.02
3787	9315173	ARCTIC	A8UJ6	636014506	17.02
3788	9362669	ANJA-C	MMTT9	235011150	6.99
3789	9330381	ORIENTAL PROTEA	3EDE8	371560000	8.81
3790	9165865	FARUK KAAN	V7IX2	538002463	8.06
3791	9313747	WILSON AVONMOUTH	9HA2335	248367000	5.14
3792	9457385	ASTIR LADY	9V8542	563117000	13.05
3793	8902955	TRUSTEE	PJIZ	306009000	16.60
3794	8908545	CORINA	SNDO	261512000	6.95
3795	9374674	FRANK W	V2DX8	305369000	5.25
3796	9128685	GAS PASHA	3FPP5	355775000	5.51
3797	8500898	AASVIK	ZDKD6	236596000	6.57
3798	9222297	CMA-CGM BERLIOZ	5BVA2	209165000	14.27
3799	9318096	SEAVOYAGER	9HUM8	256439000	16.00
3800	9389265	CAESAR	9HA2033	249838000	21.00
3801	9266566	MARIA	V2ON1	304599000	7.84
3802	9292199	BESIKTAS DARDANELLES	TCOG4	271000818	16.00
3803	9307798	TORM VENTURE	LADF7	258938000	14.52
3804	9453236	AS VINCENTIA	A8VV3	636092047	12.80
3805	8010506	TAKLIFT 4	PHWS	244394000	6.00
3806	9316012	ATLANTIS ALDABRA	9HA2517	248792000	5.70
3807	9075668	AQUADONNA	A8TW9	636014449	17.60
3808	9284776	GRAND PAVO	3EAG4	352879000	9.62
3809	9501253	INDUSTRIAL SAILOR	V2EK6	305461000	8.00
3810	9251509	RUBY	ZDJV9	236572000	6.65
3811	9413004	EAGLE SYDNEY	3FUU	352179000	14.78
3812	9449417	RIO DAUPHIN	V7RQ9	538090386	8.65
3813	9280691	STEINAU	V2BT9	304926000	5.50
3814	9558763	AZIZ TORLAK	V7TO4	538003844	7.03
3815	1133959	NP 385	XXXX	0        	3.10
3816	1133227	STEMAT 86	XXXX	0        	4.00
3817	9594884	ABBEY ROAD	D5DU5	636015973	14.20
3818	9627992	OOCL KOREA	VRMX8	477293100	15.50
3819	9102100	STOLT INVENTION	ELSN7	636010378	11.90
3820	9392080	INUYAMA	3FJQ	370423000	9.63
3821	9337925	XIN MEI ZHOU	BPKC	413165000	14.65
3822	9320403	MSC LORENA	3EBO9	371860000	13.50
3823	9517240	TJONGER	PCOX	246869000	5.42
3824	9358046	BBC STEINHOEFT	A8KK6	636091188	8.00
3825	9458066	IMERA	9HA3407	229561000	8.75
3826	8813594	BALTIC PRINCE	J8B4817	375838000	9.05
3827	9327188	ULUS BREEZE	UGTC	273310040	4.46
3828	9470064	CERBA	TCYN9	271041862	14.45
3829	9474450	CEVDET A	9HTW9	249537000	7.40
3830	9444936	MRC EMIRHAN	9HUY9	249567000	6.50
3831	9545027	ABIS BILBAO	PBQB	24649000 	5.35
3832	9349045	MAERSK JUBAIL	VREN8	477143600	12.02
3833	9673795	LYDIA CAFIERO	9V2032	563596000	14.45
3834	9573115	HANJIN ESPERANCE	3EUD6	373219000	18.22
3835	9233349	MOON SAFARI	V7WW5	538004409	14.92
3836	7413725	RIND	5BHR2	210258000	3.80
3837	9105841	SHUYA	UIWD	273417060	5.13
3838	9254575	AMAPOLA	H9YY	354447000	14.14
3839	9064906	WILSON HAWK	8PTD	314222000	5.75
3840	1132736	ZEEVANG	PIXD	0        	3.30
3841	9340427	GLENDEN	DYOE	548736000	9.66
3842	9473341	CONTI SPINELL	A8XY2	636092230	14.20
3843	9547855	SVITZER NABI	9HA3686	229876000	3.93
3844	9547867	SVITZER NARI	9HA3687	229877000	3.93
3845	9435105	BBC LOUISIANA	V2DB6	305161000	8.00
3846	9292888	SVITZER MUIDEN	PBGX	246115000	4.10
3847	9628855	GEO FOCUS	PCOS	246836000	2.00
3848	9466324	ANDESBORG	PCLC	246797000	9.69
3849	9298612	KAPPELN	V2BU3	304619000	7.22
3850	8000915	MERCUR	C6YN9	311039700	10.74
3851	9347102	PRIME ROYAL	9V9737	566328000	8.62
3852	9177868	ARION	V2MX	304010885	4.49
3853	9361483	SICHEM HIROSHIMA	9VJD6	565592000	8.71
3854	9632466	NDURANCE	5BVH3	209851000	4.80
3855	9115975	LADY MATHILDE	PFWF	244114000	5.30
3856	9422005	EMERALD SPIRIT	C6BC3	311000222	15.37
3857	9335147	GULF MIST	C6VP8	309734000	11.32
3858	9316610	BIXBITE	9HA3247	229339000	11.10
3859	9229582	ROTTERDAM	PFCO	245450000	9.08
3860	9084255	DRACO	9HA2246	248205000	9.16
3861	9119579	PERLE	V2GH	305882000	5.64
3862	9117961	PS SPRAY	C6VK8	309914000	4.70
3863	9379234	SIGAS INGRID	VRCQ6	477658800	6.10
3864	9186948	GAS LEGACY	9HA3359	229472000	5.11
3865	5354961	MANU PEKKA	5BJH2	212701000	2.00
3866	9183439	SCHIEHALLION	MWYG6	234448000	20.03
3867	9632040	APL SENTOSA	S6LT5	563251000	15.52
3868	9342528	MAERSK ALGOL	9VFV5	565819000	14.50
3869	9458913	LONE	V2GL6	305983000	9.00
3870	9404027	ZAPOLYARNYY	UGWF	273349820	10.00
3871	9638496	CYGNUS OCEAN	9V9958	566782000	12.68
3872	9353981	ST. VINCENT	S6BB2	565687000	6.11
3873	9135781	SAARGAS	A8LO7	636091285	5.50
3874	8700242	ZHEN HUA 25	VRDX3	477141700	12.22
3875	9143207	BOW FLORA	LAEX5	259927000	10.72
3876	8404991	CONDOCK V	V2DG2	305951000	4.97
3877	9459292	JIPRO NEFTIS	3ECW8	370328000	11.41
3878	9321976	MITERA MARIGO	C6VW3	309185000	14.90
3879	8811699	ATLANTIC NYALA	9HYD9	249692000	10.37
3880	9121053	NORMAND NEPTUN	LNYB	259331000	7.79
3881	9365245	WAPPEN VON DRESDEN	A8XH9	636092141	7.42
3882	8771588	H-542	XXXX	0        	10.00
3883	9470387	GOLDEN DIAMOND	VRMP8	477519500	14.50
3884	9513646	BRIELLE	V2FI9	305689000	7.00
3885	9504140	FLINTER ALAND	PCKY	246699000	7.80
3886	9714575	EDDY 1	PCMS	244670918	4.80
3887	9604146	EVER LENIENT	2HDF9	235102677	14.20
3888	9308510	COSCO HELLAS	SWJG	240511000	14.50
3889	9393187	ROYAL ACCORD	3EUA9	370064000	18.17
3890	9263332	MSC BANU	3ELK7	372972000	12.00
3891	9374715	BERTHOLD K	PBUN	246613000	5.80
3892	9506552	BENTE	9HA2287	248254000	5.80
3893	8414790	GEOPOTES 15	PEHO	244275000	8.10
3894	9311036	FREJA HAFNIA	9V8971	563949000	13.03
3895	9401556	STAV VIKING	LAGZ7	259936000	8.89
3896	9604134	EVER LIVELY	9V9726	563982000	14.50
3897	9218272	TAI PROFIT	H3WU	357071000	13.88
3898	9595137	ATRIA	FICZ	226099000	11.50
3899	9215270	BOW SUMMER	LAGA7	259788000	13.28
3900	9661247	STENAWECO JULIA L	V7AG8	538004993	13.05
3901	9243887	LADY NOVA	PBGP	245727000	5.00
3902	9552410	CAPE AMANDA	3FZB	370572000	18.23
3903	9522740	H-332	XXXX	0        	6.00
3904	9277814	HOEGH AFRICA	C6TD3	311594000	10.00
3905	9331799	RUSICH-4	UBFO	273316430	4.34
3906	9187722	BULK PANGAEA	3FHP9	357381000	13.85
3907	9347827	AQUILA J	V2BY1	304954000	7.70
3908	9408205	FRONT NJORD	VRHE5	477831600	17.00
3909	9252735	WIDUKIND	A8KH9	636091178	12.15
3910	9486192	CHEM NORMA	V7SO9	538003696	8.90
3911	9117296	JAG ARJUN	AUPS	419654000	17.63
3912	9160798	SAGA BEIJA FLOR	VRVN8	477554000	11.82
3913	9391426	ALPINE MIA	VREO7	477163100	12.22
3914	9418793	MRC SEMIRAMIS	9HIN9	249028000	6.50
3915	9015187	HELLAS REEFER	C6KD8	308090000	10.41
3916	9100138	NORDIC CHANTAL	LADS7	258967000	5.71
3917	9333357	ANDREA	ZDIS8	236481000	8.71
3918	9292345	OPAL EXPRESS	V7KB8	538002598	12.62
3919	7423926	DART	OUOV2	219416000	3.32
3920	9698082	FOX FIGHTER	LIUM	257513000	2.20
3921	9613020	ULSAN EXPRESS	DDOQ2	211578000	15.52
3922	9343326	ATHINA	SVBP6	241217000	14.22
3923	9328704	HUNTEBORG	PBDF	244338000	6.01
3924	9225809	NORFOLK	P3HC9	209063000	17.60
3925	8914154	SEA HUNTER	8PUY	314270000	4.98
3926	8411671	MARE	J8B3584	376423000	3.20
3927	9227340	MSC VAISHNAVI R	A8RL2	636016431	12.50
3928	9223289	KANG SHENG KOU	BOKF	412055000	7.50
3929	9231171	ZAGARA	IBBQ	247060900	9.50
3930	9624782	CHEMSTAR JEWEL	3FNI3	373353000	9.71
3931	9189873	POLARLIGHT	D5BR7	636092400	9.06
3932	9107394	THEA II	V2IA3	304247000	4.90
3933	9440241	ARKLOW MANOR	EIHC3	250001723	8.48
3934	9213911	CEMISLE	V2EE4	305399000	6.67
3935	9285859	TROVIKEN	C6ZT9	311066200	14.90
3936	9331452	RUSICH-3	UBEZ	273315430	4.34
3937	9465253	MSC BENEDETTA	LXBJ	253269000	15.50
3938	9515747	HAMMONIA MALTA	A8VH9	636092003	12.80
3939	9593725	ANGELINA THE GREAT N.	VRIN3	477462500	12.74
3940	9439333	CHEMTRANS HAVEL	A8PS8	636013824	8.71
3941	9169627	SALLIE KNUTSEN	MDSK3	235809000	16.02
3942	9030577	HAN ZHANG	VRFZ8	477634500	8.28
3943	9142576	FEHN CAPELLA	V2CS5	305094000	4.45
3944	9406714	SUSANA S	LACF7	259890000	9.55
3945	9553402	KIRKEHOLMEN	3FIV4	355320000	8.90
3946	1138451	HAVEN SEARISER 4	XXXX	0        	2.44
3947	9594822	EAGLE SAN ANTONIO	9V9330	566453000	17.22
3948	9678812	MARTHA OLDENDORFF	D5EN2	636016114	18.40
3949	9405552	KASTOS	SVAX8	240990000	13.32
3950	9379624	AMOREA	SVAC5	240798000	14.90
3951	9344409	KARL-JAKOB K	PIAD	244008000	5.64
3952	9596325	WISDOM OF THE SEA 1	H8BQ	356672000	18.20
3953	9393278	EEMSHORN	PHNY	244703000	6.09
3954	9196175	MAI LEHMANN	V2FU9	305804000	5.70
3955	9401544	STAVFJORD	LAHA7	259888000	8.89
3956	9250414	ARKLOW RALLY	PBEG	244037000	6.31
3957	8904446	MEKHANIK TYULENEV	UFHG	273111000	5.05
3958	9118226	GORA	A8TV6	636014439	8.86
3959	9222273	CMA-CGM BALZAC	DIHN	211378810	14.30
3960	9299678	EURONIKE	SVHX	240416000	17.00
3961	9246279	GRAND LADY	9HA2972	256958000	21.38
3962	9127667	CHAMPION TRADER	A8XY3	636014994	11.07
3963	9363493	BOW HECTOR	DYWK	548799000	11.00
3964	9285938	EIDER	VRAG4	477480600	10.75
3965	9327360	BALTIC FAITH	C4FS2	212065000	10.85
3966	9595955	SSI GLORIOUS	V7XC5	538004446	11.30
3967	9304344	FAIRCHEM COLT	H9ZV	351681000	9.69
3968	9393785	EMSSKY	V2EP7	305507000	5.55
3969	9363821	AS ORELIA	DYTJ	548777000	9.66
3970	9231121	VICENTE	A8VI8	636092006	11.20
3971	9381134	EXQUISITE	ONFX	205551000	12.42
3972	9125047	WILSON CARONTE	V2FA6	304226000	5.67
3973	9233507	GEORGIOS S	SZTU	240668000	13.82
3974	9341160	SUNNANHAV	OZ2103	231790000	7.84
3975	9557666	UP JASPER	3FUI	352874000	6.54
3976	9494228	CAPE PROVIDENCE	3EWQ	372773000	18.22
3977	9248423	NORDIC APOLLO	V7EJ9	538001820	17.03
3978	9197686	BBC CANADA	ZDGL5	236258000	6.40
3979	9466362	AVONBORG	PCOF	246865000	9.69
3980	9155925	KONINGSBORG	PDHI	246388000	7.46
3981	9429211	CERES	V2QC4	305531000	8.70
3982	8419647	SORMOVSKIY-3058	UGYM	273316400	4.25
3983	9014781	LADY STEPHANIE	V2BM9	304874000	5.76
3984	9255696	MINERVA NIKE	SVSA	240185000	14.90
3985	9509968	FLORAGRACHT	PBUS	246619000	8.53
3986	9290658	TORM REPUBLICAN	OYNE2	220560000	11.00
3987	8407931	ORANGE BLOSSOM	ELEI6	636007699	10.04
3988	9411329	NCC SAFA	HZEI	403517001	12.15
3989	9465277	MSC ALTAIR	A8YN2	636015604	15.00
3990	9373345	IDA	V2DO4	305280000	5.63
3991	9270490	CHEMTRANS SEA	A8EL8	636090747	14.02
3992	9292151	HS HUMBOLDT	9HZX7	215771000	13.50
3993	9146027	BSS POWER	A8ST4	636014291	9.27
3994	9401300	ANHOUT SWAN	OWMK2	219473000	6.74
3995	9257503	TANJA JACOB	A8YR7	636092217	12.20
3996	9346914	SYN TURAIS	IBEJ	247325600	6.50
3997	9505584	NBP STEAMER	V2QM8	305714000	8.00
3998	9102112	STOLT EFFICIENCY	ZCSP5	319488000	11.90
3999	9669873	BOW TRAJECTORY	LARX7	257145000	13.20
4000	9665633	THALASSA AVRA	9V2232	564575000	15.80
4001	8752776	PARAGON C20051	A8BM7	636011803	7.50
4002	9205706	ANJA	PJLT	306043000	7.45
4003	9065297	HORST B	V2GL9	305990000	7.10
4004	8618308	MSC CAROLE	3EUN6	352012000	14.35
4005	9296377	PRINCIMAR LOYALTY	A8GO8	636012622	15.97
4006	9407859	AN NING	VREY6	477192700	12.50
4007	9238686	CORONA J	V2BG1	304813000	9.50
4008	9431290	MAERSK KATARINA	9V8526	566141000	9.55
4009	9284685	CHEMROAD ECHO	H8BD	356212000	11.02
4010	9131084	KEOYANG NOBLE	DSAJ6	440121000	11.21
4011	9501174	TAQAH	V7ZI4	538004833	22.52
4012	9383924	ARGOS	V2FS9	305786000	5.50
4013	9482873	CORDULA JACOB	A8XG7	636092138	14.70
4014	8124474	HAV SAND	OZ2121	231834000	4.26
4015	9171060	HEINRICH G	V2OD3	304352000	5.50
4016	9226774	RIDER	PBFP	244252000	5.10
4017	9647277	KYRA PANAGHIA	D5CI9	636015710	13.30
4018	3131608	GREENBARGE 3	LG7125	0        	4.84
4019	9741073	MARINECO STINGRAY	2HGZ5	235103595	1.80
4020	9286229	GODAVARI SPIRIT	9HA2743	215482000	17.07
4021	9513622	BREMEN	V2FC2	305628000	7.00
4022	9505405	SCHILLIG	ZDKV2	236111817	5.30
4023	9431276	MAERSK KATE	9V6044	566582000	9.55
4024	9116010	NORDIC DIANA	PDRF	245196000	5.70
4025	9357561	HISTRIA AZURE	V7MG7	538002852	10.50
4026	9610743	BARROW ISLAND	VRMK7	477767900	12.83
4027	9375147	FIORANO	PHOX	245227000	5.85
4028	9305348	WALNUT EXPRESS	H8DY	351145000	12.12
4029	9390147	TELAMON	V2FQ8	305760000	5.50
4030	9303510	TAI PROSPERITY	3EDC4	371545000	14.10
4031	9507518	E.R. BORNEO	A8SZ4	636091797	18.19
4032	9497086	TANTA T	V7VE4	538004100	10.20
4033	9238741	MSC MARGARITA	A8IX9	636016429	14.00
4034	9461764	GENMAR MANIATE	V7BG4	538002247	17.17
4035	9294678	AMAZON BRILLIANCE	SYMS	240296000	12.01
4036	9422940	MYRSINI	V7CM6	538005284	14.43
4037	9422641	NORDIC AMY	9V2533	564431000	11.50
4038	9287302	ARKLOW WAVE	EIJY	250502000	8.35
4039	9443762	CRISTINA MASAVEU	ECKA	225424000	7.20
4040	9120190	UNION 11	ORKQ	205233000	3.34
4041	8904381	MEKHANIK FOMIN	UCOY	273112800	5.05
4042	1131412	6515	XXXX	0        	2.50
4043	9588445	NORDIC BREEZE	A8WZ6	636014868	17.00
4044	9364320	CAPE FRONTIER	3EFD6	353351000	18.17
4045	9253088	CAPE CENTURY	9VYQ5	563264000	17.81
4046	9403499	GELIUS 3	UBYF5	273339630	4.40
4047	9508720	ECE NUR K	9HA2323	248333000	9.71
4048	9503902	ARDEA	5BWF2	212048000	6.35
4049	9292058	TEATRALNY BRIDGE	A8HA9	636012691	12.20
4050	9640140	CHEM ROTTERDAM	V7EJ3	538005478	9.71
4051	9457749	NAVE POLARIS	V7VQ6	538004188	10.10
4052	9414888	AOM ELENA	3EWM8	371516000	12.80
4053	9003548	CELTIC NAVIGATOR	2AKS8	235060576	5.55
4054	9340489	AS OLIVIA	DYQC	548767000	9.67
4055	9320245	GERD MAERSK	OYGM2	220415000	12.20
4056	4907373	ZIERIKZEE ZR.MS.	PAEM	0        	2.50
4057	9283708	RIO THELON	A8JR6	636091125	11.50
4058	8502119	ERMAK	UFBE	273326150	7.40
4059	9419369	AMFITRITI	A8SA2	636014184	13.60
4060	9491501	AKERDIJK	A8ZG5	636015205	10.50
4061	9551662	GRONA AALSUM	V2FG8	305671000	6.16
4062	9565601	WAWASAN TOPAZ	3EZS5	353840000	9.81
4063	9428047	WATERSTROOM	PCIW	246759000	3.60
4064	7414183	WILSON ROUEN	8PQS	314158000	6.97
4065	9361744	ARKLOW FORTUNE	EIFZ	250000963	5.84
4066	9266475	SILVER LINING	HOWS	357316000	12.02
4067	9595084	SMITBARGE 11	C6YW8	0        	3.50
4068	9414022	MARAN ATLAS	SVAQ7	240891000	13.60
4069	9705706	LEANNE P	2HMX9	235104964	0.00
4070	9324851	CMA-CGM AZURE	9V8055	563747000	11.00
4071	9231846	NEUENFELDE	V2DO9	305287000	8.70
4072	9193599	CHEM SEA	V7FI4	538001946	8.77
4073	9310513	STAR JAVA	LAJS6	258734000	12.30
4074	9497000	SUNROSE E	ICRD	247299300	7.90
4075	9286970	ARGOLIS	V7AT5	538005063	14.03
4076	9393010	ARGENT COSMOS	3FUP2	372988000	11.32
4077	9260017	BALTIC COMMODORE	9HGO9	256957000	10.85
4078	9195925	CEMSEA III	5BZA3	212209000	6.19
4079	9566655	TTM SUCCESS	3ELM9	372390000	12.15
4080	9659103	WAASMUNSTER	ONHS	205655000	10.90
4081	9465265	MSC VEGA	D5BE4	636015506	15.52
4082	9324992	ALIKI	V7MG5	538002850	18.17
4083	9654787	FRONT MERSEY	V7AY5	538005094	13.30
4084	9595840	ALITHIA	9HA2905	256682000	9.30
4085	9172193	TORM GUNHILD	V7FU7	538005660	12.11
4086	9350642	IVER PROGRESS	V7LP7	538002783	11.30
4087	9306304	CARLA	V2BL8	304862000	6.70
4088	9373527	LAUREN C	MTNU5	235056239	6.30
4089	9342138	BOTHNIADIEP	ZDKO3	236111762	5.25
4090	9622916	TONIC SEA	D5AZ8	636015479	14.90
4091	8719114	SUNNA	OZ2147	231837000	6.00
4092	9612806	NORNE	PCJR	245460000	4.05
4093	8404458	FAST WIL	YJUL2	576964000	4.12
4094	8645806	CABLE ENTERPRISE	2FOV9	235077634	3.00
4095	9102904	KEIZERSBORG	PFIA	244582000	7.45
4096	9273260	TORM SARA	S6AA9	564111000	14.02
4097	9539377	SCL BASILISK	HBLG	269021000	8.60
4098	9516454	COSCO ITALY	VRNE4	477845600	15.10
4099	9277711	CAPE ISLAND	P3QT9	212054000	16.50
4100	9492232	CHRISTINA J	V7UE7	538003936	18.20
4101	7721237	ALEKSANDR SUVOROV	UCAD	273139000	9.88
4102	9538177	ATLAS	C6AS2	311000134	10.50
4103	8819213	BALTIC PRIDE	ELWV4	636011106	9.05
4104	9186302	HOEGH TROVE	LAKB6	258774000	10.02
4105	9257046	AFRICAN EAGLE	C6S2065	311249000	9.60
4106	8867246	BRIN-NAVOLOK	UBZE8	273346620	4.10
4107	9368209	RUSICH-8	UBKI3	273351360	4.34
4108	9307982	IVER EXACT	ZDND7	236111894	12.22
4109	9612636	AEOLUS	PCRR	245179000	5.70
4110	9268849	KNARRLAGSUND	C6BE2	311000237	5.74
4111	9640762	MARTINE P	2FIL4	235091541	3.00
4112	9544281	FOUR SKY	ICNE	247287500	15.00
4113	9485849	GT STAR	DUDP	548850000	9.72
4114	9213301	OVERSEAS JOSEFA CAMEJO	V7CP4	538001512	14.62
4115	9456226	TAMAR	V7SQ6	538003703	12.80
4116	9432866	SAPPHIRE-T	3EQL6	353826000	8.16
4117	9534298	JOHANN	D5HS1	636092297	6.03
4118	9543548	TORM ARAWA	9V9636	566253000	12.56
4119	9519004	LIETTA	V7RP9	538003560	12.80
4120	9334430	CLIPPER LEANDER	C6VH3	309356000	8.22
4121	9271858	SNELLIUS ZR.MS.	PAUE	245690000	4.30
4122	9514315	ORIENT LOTUS	9V9800	566380000	12.72
4123	9312896	NS CREATION	A8IK3	636012856	14.92
4124	9447885	MSC FAUSTINA	A8XT6	636092167	15.50
4125	9464596	ORIENT CRUSADER	5BZN2	209038000	14.50
4126	9433901	CPO KOREA	2BWU6	235070011	13.32
4127	9383962	ATLANTIC JUPITER	VREY5	477201400	11.31
4128	9132650	VICTORIA SPIRIT	VRAY9	477993500	9.77
4129	9085895	AMBER	9HXZ8	256585000	8.00
4130	9194048	SWE-CARRIER	5BBR4	212385000	5.74
4131	9684108	FIDELIO	LXFP	253418000	7.45
4132	8988789	FETSY L	PEBV	0        	2.00
4133	9544891	ABIS BELFAST	PBPZ	246403000	5.35
4134	9489950	RT CHAMPION	9HA2234	248186000	6.00
4135	9403619	MOL PROFICIENCY	V7NH8	538002961	14.02
4136	9200366	GENCO LEADER	VRYR8	477132000	13.93
4137	9375850	AVEIRO	9HPW9	249342000	5.14
4138	9669031	MORNING PILOT	V7ER7	538005521	10.52
4139	9275335	ARCTIC VOYAGER	C6VL2	309998000	11.95
4140	7625263	OSLO	PHMG	245028000	3.50
4141	1138501	BREMEN	XXXX	0        	6.50
4142	9486180	CHEM HYDRA	V7RU2	538003579	8.90
4143	9419242	SALTA	A8WC6	636092067	13.25
4144	9373503	SPANACO LOYALTY	MPJC3	235011860	6.30
4145	9469558	AQUAPRINCESS	SVAN5	240981000	18.28
4146	9442500	YASA H. MEHMET	TCMT2	271042805	14.60
4147	9297852	JPO PISCES	A8GU8	636090863	12.50
4148	9478286	ANNELISE THERESA	OWET2	219023000	7.60
4149	9399399	LINGEBORG	PHMK	245046000	6.50
4150	9226803	EMSRACER	PCWF	244810002	5.10
4151	8500068	ARIFE	3FQL4	353213000	6.45
4152	9614878	ZWERVER III	PCLQ	246024000	3.00
4153	8516952	BLIZZARD	PHJR	244495000	6.90
4154	9409170	CMA-CGM CORNEILLE	A8SU4	636091780	14.50
4155	9581019	DUZGIT DIGNITY	TCNZ8	271043776	7.85
4156	9275725	CABO HELLAS	V7HN7	538002269	13.60
4157	9149665	SIGRUN BOLTEN	A8CL2	636090664	10.02
4158	9219032	HEPHAESTUS	ELZW5	636011537	14.01
4159	9154270	ORLA	9HIQ6	248544000	8.55
4160	9629598	LENA RIVER	V7AU9	538005073	12.50
4161	9247625	SVYATITEL ALEKSIY	UBJI8	273358260	4.34
4162	9164524	EK-STAR	LAMT5	257433000	8.60
4163	9621534	SERKEBORG	PBPB	245141000	3.15
4164	9277383	TINA	PBKA	244198000	7.47
4165	9745706	RIX LION	2HOH3	235105282	1.80
4166	9309629	CELSIUS MONACO	V7BF2	538005129	9.42
4167	9406544	BERGE ODEL	3EMK9	352084000	18.11
4168	1135751	WISMAR	DQHB	0        	3.00
4169	9401245	BEAUMARE	PHMW	244819000	5.40
4170	9240550	JANNIE C	VSRD8	235006350	7.36
4171	9202053	MARCHICORA	V2OQ7	304653000	9.73
4172	9624639	GRAND CONCORD	3FCH9	373585000	13.01
4173	9201932	DERK	PCIC	246199000	5.65
4174	9528392	MISS MARIA ROSARIA	9HA2737	215464000	13.15
4175	9291597	YM JUPITER	9HTF8	256398000	8.50
4176	9334301	NORTHSEA LOGIC	9HWC8	249689000	5.74
4177	9466336	AMURBORG	PBRO	246263000	9.69
4178	9273351	ETERNAL SUNSHINE	V7CZ9	538005356	12.02
4179	9195755	JOHN FRIEDRICH K	PBLY	244952000	5.42
4180	9409338	PORGY	3EZS8	351126000	9.63
4181	1132789	STEMAT 76	XXXX	0        	3.00
4182	1137802	B 48	XXXX	0        	3.10
4183	9191723	SIKINOS	SXYK	239720000	16.02
4184	9354911	ATLANTIC ROSE	VREF7	477110500	12.21
4185	9380415	DUZGIT INTEGRITY	9HQS9	249379000	7.97
4186	6726852	FORTH DRUMMER	GYDZ	232004962	2.87
4187	9529463	NORDIC ORION	3FDS9	373437000	14.09
4188	9467433	MSC FLAVIA	3FBD7	373004000	15.50
4189	9622253	CAP SAN RAPHAEL	D5FJ2	636092548	14.31
4190	9277280	HR RECOGNITION	D5AG8	636092311	7.96
4191	9277802	HOEGH AMERICA	C6TD4	311595000	10.00
4192	9219874	FREYA	PECN	244180000	7.10
4193	8870839	LETNIY BEREG	UIBW	273348830	4.08
4194	9407263	KING DUNCAN	V7MT9	538090315	14.51
4195	9440526	MINERVA ELPIDA	9HA3263	229356000	14.80
4196	9305570	COSCO GUANGZHOU	SYIE	240475000	14.52
4197	9280885	ASTRO PHOENIX	SWIQ	240127000	17.05
4198	9640059	SANTA URSULA	3FDB8	373534000	13.01
4199	9668295	INCE EVRENYE	9V2456	563533000	9.82
4200	9458054	SHUSHA	9HA2401	248533000	8.60
4201	9142564	ARNE	V2FI2	305681000	7.10
4202	9236248	MINERVA ZENIA	SYNB	240014000	14.32
4203	9216042	SICHEM COLIBRI	9HHB8	215975000	5.94
4204	9390458	FOX LUNA	SIJK	265610040	6.40
4205	9195676	FRI TIDE	C6VW4	309186000	5.15
4206	9404950	OTTOMAN EQUITY	TCTG7	271002613	17.52
4207	9514913	IJSSELDIJK	PBUY	246626000	5.80
4208	9203203	BB TROLL	LNML	258202000	6.50
4209	9616577	M.P.R. 4	PBZR	246478000	2.40
4210	9186182	NORSKY	PCCC	244341000	6.50
4211	9066045	SEG	UICC	273413060	4.22
4212	9534793	AL SALMI	9KCQ	447097000	22.00
4213	9150614	BRO ANTON	OZFK2	219242000	8.72
4214	9572276	CAPE ENTERPRISE	V7WB4	538090431	15.04
4215	9174220	MARAN REGULUS	SVBX4	241295000	22.52
4216	8702109	BRIGIT P	J8B4851	253439000	1.84
4217	9454515	HANJIN FOS	3FCX8	355280000	18.20
4218	9514327	ORIENT JASMINE	9V9801	566381000	12.72
4219	9254915	PETROVSK	A8AP3	636011639	14.85
4220	9393840	BOSPORUSDIEP	PHOJ	245172000	5.25
4221	9256559	PASCAL	V2LP	304291000	5.64
4222	9250397	FITBURG	V4AF3	341438000	7.73
4223	9053907	GRIMM	5BTE3	209750000	5.05
4224	9452701	OLEG STRASHNOV	5BNL2	212905000	13.84
4225	9657894	MARINECO THUNDERBIRD	2FMX4	235092583	1.75
4226	9310721	JASMINE ACE	YJUX2	576063000	10.02
4227	9371086	POSIDANA	9VBM6	563291000	12.33
4228	9311593	JEAN LD	9HA3378	229524000	18.00
4229	9359038	GUSTAV MAERSK	OUJK2	220596000	15.50
4230	9409194	CMA-CGM LAMARTINE	2DMF2	235080187	14.50
4231	9298363	MCT MONTE ROSA	HBHB	269675000	9.55
4232	9428970	SKS DRIVA	LAIV7	257572000	15.20
4233	9286956	KANISHKA	D5CE4	636015676	14.03
4234	9047506	BOW RIYAD	LAUC4	258928000	10.72
4235	9262522	PUFFIN	6YRJ6	339300490	11.27
4236	9286827	EKEN	LAYM5	258894000	8.60
4237	9211078	FRI KVAM	5BAG4	210935000	6.36
4238	9403918	AZRA-S	TCPN3	271000898	6.30
4239	9199402	TRANSFORZA	ZDNJ2	236111943	4.60
4240	1138608	VEKA 3305	XXXX	0        	5.00
4241	9571208	GRACELAND	ZDKE9	236603000	4.15
4242	9359600	FEN	9VJQ3	565631000	8.71
4243	9586409	M.P.R. 1	PCBX	246713000	2.93
4244	9116589	EVER UNITED	9V7957	563400000	12.73
4245	9216834	LAS PALMAS	CQHP	255805591	7.40
4246	9299458	MAERSK BARRY	OYJE2	219127000	9.52
4247	9597848	DONG-A ARTEMIS	3EWG3	373238000	18.22
4248	9500730	HABRUT	V7XU9	538004577	22.50
4249	9458494	ACHILLEAS	SVBB5	241035000	17.20
4250	9384095	MARE BALTIC	V7ML3	538090364	9.55
4251	9706085	BISON	SFPM	266428000	5.70
4252	9210907	MAERSK ELLEN	OWVP2	219562000	10.50
4253	9201839	ARKLOW VENTURE	PIAV	244067000	6.36
4254	9387592	PEGASUS	V2GK8	305978000	8.70
4255	1138609	WAGENBORG BARGE 10	XXXX	0        	2.50
4256	9647318	ENDURANCE	V2GJ3	305956000	7.01
4257	9346691	VELSERDIJK	PBIC	244865000	5.80
4258	9558244	ATLANTIC ELM	9HA3054	229081000	12.83
4259	9504138	FLINTER ATLANTIC	PCJK	246775000	7.80
4260	9125956	UTRECHT	PCQC	245601000	8.92
4261	9660322	COASTAL VOYAGER	PJJK	306092000	3.20
4262	9487029	SEA BRAVO	PHSB	244468000	3.32
4263	9555292	NORD INNOVATION	3EYC5	370756000	12.60
4264	9729520	LEON LIVINGSTON SMITH HMBS	C6BH7	311000266	2.50
4265	9633939	CAP SAN ARTEMISSIO	9V2238	564387000	14.02
4266	8211863	SKANDI FJORD	C6QW4	308073000	4.75
4267	9454761	ATLANTIC KLIPPER	PCIU	245723000	10.30
4268	9295397	MSC CAROLINA	3ECV5	371475000	14.50
4269	9579547	ALMI EXPLORER	D5DH3	636015879	17.00
4270	9517446	BESIKTAS ORIENT	9HA2100	249959000	5.80
4271	9073062	MSC SOPHIE	3FKP7	351268000	12.11
4272	9194311	RMS BAERL	V2BD2	304791000	3.85
4273	9314284	UNION RUBY	OROD	205416000	4.40
4274	9301445	E.R. CALAIS	A8GA2	636090822	11.50
4275	9452787	SEVEN BOREALIS	C6YG8	311031900	11.50
4276	9314648	AZUR	V7MH4	538002853	14.43
4277	9422445	SCF SURGUT	A8SW8	636014310	16.00
4278	9637428	SAM JAGUAR	VRMI2	477592900	13.00
4279	9261396	BALTIC SEA I	P3PP9	212100000	11.20
4280	9421128	UBC MARIEL	V2QA3	305398000	7.01
4281	9282089	APOLLO LUPUS	V2OX2	304447000	5.56
4282	9015448	PILSUM	V2AH9	304010549	4.35
4283	9662382	TRIPLE S	V2QN7	305948000	6.13
4284	9498937	CMB MISTRAL	VRHG2	477851800	9.50
4285	9323340	TARGALE	V7LN9	538002775	12.50
4286	9083885	PATRIOT	P3SM5	210648000	5.23
4287	9619971	MARSTAL MAERSK	OWJK2	219019139	16.03
4288	9200677	HANJIN AMSTERDAM	DHDH	211350460	14.00
4289	9425825	PILION	8PWL	314312000	12.80
4290	8509363	BERONIKE	E5U2520	518570000	4.47
4291	9301287	HISTRIA PERLA	9HGL8	215958000	11.00
4292	9380398	MINERVA ANTONIA	SVAC2	240787000	12.22
4293	9391361	CONTI AGULHAS	A8PC6	636091531	11.20
4294	9505924	MTM HOUSTON	9V9704	356973001	9.62
4295	8406999	SBS CIRRUS	ZQZF9	235001580	4.96
4296	9171187	ICE CONDOR	9HKD8	256070000	9.77
4297	9108427	POMMERN	V2LD	304010860	4.94
4298	9015450	UTTUM	V2NY	304010302	4.35
4299	9292606	ENERGY CHANCELLOR	MJUY5	235009410	13.67
4300	9492256	BEVER	PDAA	244536000	3.70
4301	9498717	SIBERIAN EXPRESS	ZDKY2	236111844	14.90
4302	9323883	ASTROMAR	SVBV8	241284000	14.14
4303	9272230	CHIPOLBROK SUN	VRZM4	477040800	10.30
4304	9376505	TRINA	V2FV8	305816000	9.10
4305	9404584	CORAL METHANE	PHNJ	244092000	7.15
4306	9388601	MAERSK TACKLER	OYQU2	219017782	7.75
4307	9370305	CALYPSO	PCMI	246816000	5.42
4308	9251664	SEYCHELLES PRIDE	S7SP	664209000	11.00
4309	9358022	BBC MAPLE LOTTA	DDRJ	218793000	8.00
4310	9375848	ANTWERP	9HMU9	249198000	5.14
4311	9401130	MSC EVA	3EVM7	371218000	15.60
4312	9337638	NYK METEOR	3ENA9	354212000	13.52
4313	9688336	STI CHELSEA	V7DS5	538005428	13.30
4314	9179593	ANANGEL DESTINY	SXON	239612000	17.72
4315	9259185	SEANOSTRUM	VRAO6	477760900	14.78
4316	9235361	SAN PABLO	A8VJ4	636092010	11.20
4317	9466946	SERRA-MERT	9HA2537	248833000	6.25
4318	9300908	IBI	3EAR2	354767000	9.63
4319	9375836	LADY MARY	V2DI8	305229000	5.14
4320	9202699	KASPRYBA 3	XXXX	0        	3.80
4321	7616793	VITUS	OYDC2	220392000	2.90
4322	9020285	NAVEN	OZ2107	231794000	5.46
4323	9102124	STOLT CAPABILITY	ELSN9	636010380	11.91
4324	9604160	EVER LIBERAL	2HDG2	235102678	14.23
4325	9450351	NORTHERN JUSTICE	A8SZ8	636091801	14.50
4326	9579042	STENA SUEDE	ZCEF5	310622999	17.00
4327	9593220	ANANGEL NOBILITY	SVBS8	241256000	18.40
4328	9195834	FINGARD	OJNG	230999000	6.20
4329	9422524	DUBAI ANGEL	V7TT6	538003882	14.97
4330	9588469	NORDIC ZENITH	A8WZ7	636014869	17.05
4331	9350783	ALAND	MCRH	235050837	6.00
4332	9635834	BW CHEETAH	9V2345	563877000	13.30
4333	9150482	WILSON LEER	9HEB5	249720000	5.49
4334	9511636	HAREN	V2QD6	305560000	7.36
4335	9251406	ROMOE MAERSK	OXLC2	220209000	11.82
4336	9609639	GARNET EXPRESS	V7BL6	538005163	12.32
4337	9628465	OLYMPIC TAURUS	LDXA	257959000	6.50
4338	9285976	CSCL ASIA	VRAB8	477360800	14.50
4339	9434541	MAGDALENA	VREL3	477115900	5.41
4340	9016662	BALTIC PILGRIM	A8JH8	636016279	9.07
4341	9373333	MARTHA	V2DH2	305212000	5.63
4342	9389813	GOLDEN OPPORTUNITY	VRED6	477102800	14.15
4343	8801072	LIVA GRETA	YLCJ	275344000	3.39
4344	8511146	IZZET REIS	9HBA6	248361000	6.41
4345	9034729	NORDIC GAS	S6BE2	565430000	10.92
4346	8716318	BALTIC MERCUR	9HBL9	256745000	10.36
4347	9353149	CPO ENGLAND	2AJQ2	235060252	11.52
4348	9618381	JOLI L	PCLS	246738000	2.70
4349	9628001	OOCL SINGAPORE	VRMX7	477293200	15.50
4350	9541813	ASIATIC	SVBN4	241189000	13.00
4351	9306782	NS CENTURY	A8IJ8	636012853	14.90
4352	9313709	WILSON AVILES	9HQT9	249380000	5.14
4353	9640114	LUMPHINI PARK	D5BR3	636015589	9.71
4354	9390331	FENNO SWAN	9HLI9	249128000	6.05
4355	9186194	NORSTREAM	PCCD	244396000	6.50
4356	9188946	BARIZO	ECMP	225329000	6.19
4357	9650755	OCEANIC POWER	3FGX3	354297000	14.38
4358	9527049	MAERSK LANCO	VRLI7	477182700	13.52
4359	9456692	BERGE MCCLINTOCK	2GXW7	235101425	16.50
4360	9455703	HIGH SEAS	D5AA6	636015336	13.31
4361	9388716	GUARDIAN LEADER	C6WZ2	311003400	10.00
4362	9442378	FISKARDO	SVBX9	241307000	14.60
4363	9267211	HARVEST PEACE	V7VE7	538004103	13.95
4364	9227338	MSC JULIA R	A8RK9	636091668	12.50
4365	9147863	TOLMIN	V2QD8	305597000	6.63
4366	9421087	LOODIEP	A8ZO7	636015263	7.01
4367	9030149	SWEDISH REEFER	C6KD4	308126000	10.00
4368	9071557	STAR HERDLA	LAVD4	258954000	12.32
4369	9570565	CAROLINE A	IBGF	247353200	5.40
4370	9346407	SIGAS MARGRETHE	3EFY	355122000	6.06
4371	9492347	GOTIA	A8ZW7	636092279	18.32
4372	9286059	BALTIC SUN II	9HAP8	215795000	10.85
4373	9639452	XIA ZHI YUAN 6	BKQC5	414101000	8.60
4374	9521411	UMAR 1	9HA2498	248751000	6.06
4375	9180918	MARINA	SXJE	239651000	13.82
4376	9118159	FORTH FISHER	MWZZ6	234450000	6.20
4377	9562245	CC ATLANTIQUE	XXXX	0        	5.80
4378	9337016	AMOUREUX	A8PR4	636014676	16.02
4379	9333539	ARNEBORG	PHHD	246556000	9.69
4380	9478614	ALPINE LINK	V7SZ7	538003758	12.90
4381	9332872	ZIM HAMBURG	D5EY9	636016199	14.02
4382	9444027	HANJIN SINES	3FID7	351746000	18.22
4383	9557733	AMT COMMANDER	XXXX	0        	6.50
4384	1133000	STEMAT 87	XXXX	0        	4.00
4385	9460459	SONGA DIAMOND	V7PS4	538003277	9.21
4386	7816484	AMARANTH	YJQU6	576321000	6.58
4387	9114775	BOW BRACARIA	LAJV7	259024000	6.79
4388	9292060	TAVRICHESKIY BRIDGE	A8IZ6	636012908	11.00
4389	9444663	SEA ECHO	PHLP	244905000	1.95
4390	9627057	CAPE KENNEDY	5BPP3	212384000	14.57
4391	9607502	MEHMET AKSOY	9HA2991	229014000	14.57
4392	9248526	CAPRI	9HKW9	249111000	17.80
4393	9518402	DMITRY VARVARIN	3FKT3	372139000	5.82
4394	9559688	WESTERN STAVANGER	LALN7	259002000	10.17
4395	9595890	FEDERAL SKEENA	V7WS5	538004381	10.50
4396	9633446	NOVO	9HA3042	229069000	17.00
4397	9521875	INA	A8ZR4	636015279	8.25
4398	9045742	OSTRA	TCPL6	271000884	7.60
4399	9202091	WESTERKADE	V2FB5	305623000	7.70
4400	9373515	SPANACO RELIABILITY	MVOL5	235050665	6.30
4401	9136228	EVOLUTION	PHHV	246386000	8.78
4402	9425813	AETOLIA	8PWK	314311000	12.83
4403	9650779	FRONTIER YOUTH	3FPE	352623000	18.24
4404	9208100	BALTIC CAPTAIN I	P3DP9	209902000	11.20
4405	9498444	AAL KOBE	V7ZF3	538004809	11.20
4406	9469649	PING MAY	A8VM4	636014628	17.00
4407	9385142	PRISCO ELIZAVETA	5BQY2	212218000	13.20
4408	8904458	MEKHANIK KRASKOVSKIY	UFHZ	273116000	5.06
4409	9501710	ABIS ANTWERPEN	PBNL	245827000	5.35
4410	3120908	TRUMPETER HMS	GAAZ	232423562	1.80
4411	9316579	PANTANAL	V2OS2	304639000	7.60
4412	9237618	JAG LATA	AUAW	419488000	13.60
4413	9412725	JBU SAPPHIRE	VRFK3	477399400	9.71
4414	9338917	AEGEAN HARMONY	SZVD	240633000	14.90
4415	9143788	TRANSRISOLUTO	ZDHI4	236323000	5.71
4416	9594743	PECOS	V7UU5	538004032	16.00
4417	8937883	BLAZER HMS	GAAU	0        	1.50
4418	8937900	SMITER HMS	GAAS	235000950	1.80
4419	9430961	WILSON NARVIK	9HA2464	248675000	7.40
4420	8500082	CELTIC FORESTER	MNQF7	235011450	4.95
4421	8937869	PUNCHER HMS	GAAW	0        	1.50
4422	8914295	BIMI	C6UJ9	311939000	5.45
4423	9363869	CHEMSTAR YASU	3ETR3	370646000	9.22
4424	9489962	RT LEADER	9HA2235	248187000	6.00
4425	9173173	RHODANUS	PGBC	245848000	4.34
4426	9552020	GRONA BIESSUM	V2FG9	305672000	6.20
4427	9670670	FLINTER TRADER	V2QJ2	0        	7.00
4428	9418145	NAVIG8 STRENGTH	V7SL8	538003678	13.00
4429	9379959	ARGENT ASTER	3ELI8	372956000	11.32
4430	9406623	CMA-CGM NERVAL	9HA2361	248432000	14.50
4431	9578646	PRINCIMAR HOPE	V7VN3	538004163	17.00
4432	9461697	HAFNIA CRUX	OUNI2	219398000	13.00
4433	9355575	COSCO TAICANG	VREV9	477189300	13.00
4434	9413688	NEVERLAND ANGEL	IBJO	247258200	14.90
4435	9344198	DAVIKEN	9HA2629	215064000	6.50
4436	9528500	DELAMAR	ZDKG5	236610000	5.30
4437	9402689	ORAKAI	ZDNX7	236646000	6.50
4438	9286815	LENA	9HA2109	249972000	7.06
4439	9210725	UAL COBURG	P3CV9	209495000	7.22
4440	9474199	CMB WEIHAI	VRGZ8	477786600	9.80
4441	9335915	BLUE ROSE	V7JR4	538002561	11.60
4442	9589152	PUMA MAX	C6ZD9	311053500	14.50
4443	9063873	IMI	C6VT4	308192000	5.60
4444	9489558	ADAMAS	PBXW	246667000	5.45
4445	9347310	CHALLENGE PACIFIC	9VKP4	565524000	11.30
4446	9363857	EBONY RAY	9V2192	563136000	9.71
4447	9322487	ITAL LIRICA	ICEI	247190800	13.50
4448	9235983	ANTONIO	A8VI7	636092005	11.20
4449	9363273	C.S. OCEAN	3EPH6	352765000	10.02
4450	9689134	HIGH SUN	9HA3555	229728000	13.34
4451	9583237	PORT STAR	3FNZ3	373332000	14.43
4452	9119567	TINSDAL	V2AJ2	305573000	5.64
4453	9255672	ISABELLA	9HSL7	315545000	14.90
4454	9421336	MARLIN TOPAZ	V7ML4	538002869	12.60
4455	9479670	TOLI	9HA2299	248282000	5.70
4456	9112143	B GAS CHAMPION	9HA2929	256805000	6.80
4457	9243851	LADY NORA	PBDN	245739000	4.00
4458	9208497	HAM 317	PCHP	246016000	6.16
4459	9280689	LINNAU	V2BO5	304880000	5.50
4460	9434149	PAIVI	5BGW2	212801000	5.30
4461	9667863	MULTRATUG 26	PCWE	244790985	4.60
4462	9375135	VANQUISH	PHOW	244561000	5.85
4463	8613047	RIO	PHCL	245618000	5.07
4464	9295218	HANJIN YANTIAN	DDYZ2	218060000	14.50
4465	9395147	HAMMERSMITH BRIDGE	3FQE8	354839000	14.04
4466	9439838	EVERHARD SCHULTE	9V8182	564776000	8.80
4467	9273387	CHEMBULK NEW ORLEANS	9VAE5	563952000	10.62
4468	9471654	LONG LUCKY	D5CK2	636015716	10.40
4469	9239458	HARRIETT	A8UZ9	636016419	9.75
4470	9683336	SILVER ESTHER	3EZD7	355511000	13.28
4471	9481453	GOLDEN ENDEAVOUR	VRHM8	477962200	14.62
4472	9540807	HIMALAYA	5BFL3	209460000	11.80
4473	9398539	URANUS	D5CY7	636092459	8.67
4474	9583861	ROCKPIPER	5BML3	209449000	9.50
4475	9197454	BEKAU	V2BJ8	304839000	5.50
4476	9357509	JEANETTE	PBAX	244562000	6.24
4477	9352585	NORTH CONTENDER	V7EO4	538005504	9.62
4478	9325025	MONTECRISTO	9HA2348	248397000	18.17
4479	9302994	GENMAR KARA G	A8KO8	636013098	16.02
4480	9491202	LEFKONIKO	9HA2200	248137000	12.80
4481	9384605	FRONT QUEEN	V7RM7	538003542	21.50
4482	9490442	KING HADLEY	V7WW4	538090441	14.95
4483	9584982	H. CAN	9HA2843	256323000	8.10
4484	8001000	SWAN	PJYI	306036000	9.49
4485	9119995	HARVEST RISING	V7UB9	538003926	11.60
4486	8914776	PARSA	TCA3179	271043873	7.72
4487	9669093	SEAJACKS HYDRA	3FEI3	370239000	6.75
4488	9246449	PORT MOODY	V7DW7	538090269	12.22
4489	9165542	MOSCOW RIVER	ELWE7	636011007	14.75
4490	9246475	PORT SAID	V7EJ7	538090298	11.00
4491	9148180	NORDGARD	PIBU	245157000	5.65
4492	9197806	TOMKE	ZDEC9	236111000	5.30
4493	9141364	NELLI	V2PX6	304010974	6.12
4494	9359935	SCL ANGELA	HBEK	269668000	8.40
4495	9422639	NORDIC AGNETHA	9V2535	564390000	11.52
4496	9542348	UAL HOUSTON	PBDY	246117000	7.00
4497	9607722	SEA JEWEL	3EYU9	353221000	13.60
4498	9647291	NORDIC NANJING	2GIQ7	235097727	10.10
4499	9561289	MERMAID ACE	3FCG3	355139000	9.82
4500	9257149	ELIZABETH I.A.	SZHJ	240165000	20.80
4501	9432505	WES SONJA	V2GN5	304013000	7.06
4502	8918590	AXEL	DMGZ	211266470	4.20
4503	8420086	OSA	SNBD	261362000	4.34
4504	9516674	CORNELIS LELY	PBTC	245496000	4.80
4505	9345362	JOLIE BRISE	PHCA	246044000	5.30
4506	9321940	STAR KESTREL	3EVC2	354190000	13.15
4507	9221839	AGIOS MINAS	A8VP6	636014645	14.52
4508	9520508	FALKENBERG	5BKT2	210724000	6.45
4509	9396127	STAR KIRKENES	LAHR7	257310000	12.34
4510	9389930	PRIVSEA	9HYE8	256592000	12.50
4511	9664873	NAVIOS JOY	3FPT3	357783000	18.24
4512	9390381	PELAGIC EXPRESS	HOSN	372804000	4.65
4513	9614701	SCL TRUDY	HBEH	269075000	8.60
4514	8727848	TYUMEN-2	UGSQ	273398000	4.00
4515	9045730	N. DADAYLI	TCCW7	271000768	7.57
4516	9281786	CIMBRIS	ZDFS3	236205000	5.74
4517	9433511	IMINA	V2FQ6	305758000	5.79
4518	9478298	TINA THERESA	OWEU2	219057000	6.35
4519	9184677	KOSTERBERG	ZDHP7	236343000	4.77
4520	9674921	ZEALAND AMALIA	PCPN	244710882	8.50
4521	9337640	NYK NEBULA	3ENG6	354891000	13.50
4522	9313008	NYK ORPHEUS	7JDN	432657000	14.04
4523	9285990	CSCL AMERICA	P3XP9	209550000	14.50
4524	9302140	HUMBER BRIDGE	3EHZ5	372038000	14.04
4525	9573103	P.S. PALIOS	V7ZZ7	538004949	18.22
4526	8874536	CASTORO XI	C6NB2	0        	6.50
4527	8806149	ERNST HAGEDORN	V2DP7	305295000	5.77
4528	9243863	LADY NOLA	PBFO	244150000	4.40
4529	9349227	ASTRORUNNER	C4RK2	210248000	7.30
4530	9330783	MID OSPREY	ZGDV2	319061700	9.60
4531	9075345	RANDGRID	C6YM8	311038200	15.26
4532	9404780	NAVIGATOR GEMINI	A8RD9	636014077	10.90
4533	9467005	HHL CONGO	V2FH8	305679000	8.00
4534	9580962	ADFINES SEA	9HA2981	229004000	9.00
4535	7424061	DANALITH	OUTR2	219301000	5.12
4536	9523835	RT STAR	DUDN	548847000	10.03
4537	9198094	MINERVA ALEXANDRA	SYUZ	237677000	14.72
4538	9187289	NPS CENTURY	H3BU	351887000	17.72
4539	9326809	AEGEAN NAVIGATOR	SWBI	240634000	16.00
4540	9325221	GRAND RUBY	3EIU3	372399000	9.62
4541	9397640	MUROS	ECNQ	225371000	5.79
4542	9554755	YM MIRANDA	9HA3277	229370000	8.50
4543	9382712	SETO EXPRESS	3EIS8	372383000	12.49
4544	9015216	SCHWEIZ REEFER	C6KD9	308124000	10.02
4545	9373266	BEAUMAGIC	PHKH	244615000	5.40
4546	9388900	FINESSE	V2DC4	305167000	8.00
4547	1012177	Y710	XXXX	0        	4.00
4548	9619983	MATZ MAERSK	OWJM2	219019365	16.03
4549	9325049	SONANGOL NAMIBE	C6VR3	309072000	16.00
4550	9365752	MARBAT	9HMC9	249159000	22.50
4551	9589384	JABAL NAFUSA	9HA2730	215454000	16.50
4552	9250438	ARKLOW RANGER	PBHN	246340000	6.31
4553	9271406	MINERVA CONCERT	SVWC	240110000	14.90
4554	9195535	EEMS EXE	ZDIK4	236452000	5.34
4555	9000211	CEMSKY	P3WL9	212220000	6.10
4556	9150315	SYPRESS	9V2640	564917000	10.73
4557	9362815	ATLAS	V2CD1	304985000	7.03
4558	9401984	OCEAN PROSPERITY	9V8632	563212000	12.11
4559	9281554	MATTHEOS I	P3YV9	209632000	12.01
4560	9453523	DORIC CHAMPION	A8XF5	636014887	14.90
4561	9171357	NOUNOU	SXYT	240423000	12.02
4562	9189249	CAPE TAVOR	A8ET7	636012329	17.81
4563	9588342	AMAPOLA	9HA2676	215226000	9.87
4564	9130468	BETAGAS	V2KA8	304050636	7.35
4565	9686857	STI COMANDANTE	V7DL6	538005397	11.92
4566	9313761	ROSE	A8XX6	636014991	12.10
4567	9101637	CAPTAINYANNIS L	9HOL7	215425000	11.45
4568	9405057	FAIR SEAS	V7PD2	538003211	14.92
4569	9323376	PILTENE	V7LN6	538002773	12.52
4570	9566758	STOLT SANDPIPER	2EYO8	235089284	5.50
4571	9333424	SCF PECHORA	UBUL5	273340570	12.43
4572	9444273	MOL PRESENCE	9V8990	564803000	14.02
4573	9295581	HASSI MESSAOUD 2	A8FD4	636012379	12.10
4574	9214173	HC NADJA-MARIA	V2AV4	304204000	7.39
4575	9176694	TRANS CATALONIA	9VBJ8	564469000	10.09
4576	9682320	SILVER VALERIE	V7EI8	538005476	13.28
4577	9327102	AURELIA	DDNW	211852000	9.10
4578	8918461	WILSON SAGA	P3PD8	212893000	6.69
4579	9507362	WILSON ALMERIA	9HA2502	248764000	5.14
4580	9390551	HAVILA FORTUNE	C6XO5	311017400	6.23
4581	9279070	ELKE W	V2DC3	305166000	5.25
4582	8918485	WILSON STADT	9HQW8	256312000	6.68
4583	9358307	HERCULES	VRBY7	477214900	13.15
4584	9220938	VALLE DI SIVIGLIA	IBTN	247042800	11.11
4585	9124471	STOLT PERSEVERANCE	ZCGE5	319605000	11.70
4586	9302621	YM UTMOST	A8HZ5	636012808	13.00
4587	9567702	EURO	C6AA5	311073800	16.00
4588	9312444	STENA PRESIDENT	ZCDR6	310549000	12.98
4589	9407445	SEAMUSIC	9HZL9	249746000	14.80
4590	9174713	AMBER 1	5BAR2	210607000	6.44
4591	9428152	PALAMAS	9HWA8	256506000	6.28
4592	9473080	HARBOUR FASHION	CQNM	255803880	8.40
4593	1134063	CC BISCAY	PJIB	0        	6.10
4594	1133961	NP 414	XXXX	0        	2.30
4595	3142807	WILCO B	XXXX	235105625	2.80
4596	9340594	MAERSK BEAUFORT	9VAN3	566502000	9.51
4597	9122928	SKS TWEED	C6BB3	311000214	15.72
4598	9397341	AL SADD	V7QG9	538003361	13.60
4599	9454826	NEWA	V2DN3	305263000	6.04
4600	9423724	FAIRCHEM BIRDIE	V7SJ7	538003667	9.89
4601	9126912	WILSON GRIP	9HXV4	249528000	5.49
4602	1133555	BOABARGE 43	LG7539	0        	4.90
4603	9330460	CHEMSTAR SEVEN	3EAC2	357851000	9.61
4604	9458183	HABIP BAYRAK	V7WD7	538004273	7.20
4605	9665645	THALASSA NIKI	9V2233	564728000	15.80
4606	9446568	FRONTIER MIRAGE	3FMZ2	354750000	18.24
4607	9392999	JBU ONYX	3ESU6	370430000	9.70
4608	9633941	CAP SAN MALEAS	9V2239	564573000	14.02
4609	9416733	FRATERNITY	ONGB	205559000	16.00
4610	9249324	FRONT SYMPHONY	A8HH8	636090892	17.12
4611	9252034	HAMRA	3ERE9	370025000	8.20
4612	9622679	ANNA MARIA	SVBN8	241195000	14.55
4613	9171280	HOEGH TRADER	LASK7	258882000	10.00
4614	9557604	SMS SHOALBUSTER	2BYF6	235070418	2.65
4615	1133978	NP 403	XXXX	0        	3.00
4616	9304461	SCL BERN	HBEG	269074000	8.40
4617	9341768	DOGGERSBANK	PHHC	246555000	6.09
4618	9087805	AGHIA MARINA	9HXX9	249684000	9.77
4619	9251456	PORT STEWART	V7GE9	538090300	12.30
4620	9434395	ANANGEL VIGOUR	SVBO4	241196000	18.20
4621	9477220	NBA RUBENS	3FMO	356961000	13.40
4622	8508723	IASOS	TCZO2	271042515	10.55
4623	9141998	CHRYSOULA S	SXLV	237878000	11.66
4624	9015199	NEDERLAND REEFER	C6KD6	308122000	10.00
4625	9612064	SAMJOHN DREAM	SVBI3	241129000	18.57
4626	9425241	CASTEL SANT ELMO	IBPX	247276300	8.65
4627	9307346	LARVIK	C6VC2	308371000	12.26
4628	8019344	GANN	LLNV	258210000	3.67
4629	9255945	GENMAR COMPATRIOT	ZCDK2	310427000	14.39
4630	9629718	NORD STRONG	S6ME8	566740000	13.03
4631	9489106	NAVE UNIVERSE	V7TP4	538003852	12.15
4632	9135743	FRI LANGESUND	ZDKQ8	236111779	5.68
4633	9556909	RT TASMAN	9HA2239	248194000	5.40
4634	9127150	EVA N	A8QJ7	636013944	18.00
4635	9537628	BETIS	A8VN8	636092025	14.58
4636	9233777	CAPE BOWEN	V7EJ8	538090163	17.03
4637	9402902	MARAN PYTHIA	SVAQ5	240893000	17.17
4638	9485772	OSLO BULK 2	9V8767	564237000	7.06
4639	9434204	CPO CHINA	2CRH4	235075102	13.32
4640	9227948	BW UTIK	H9AA	352834000	22.00
4641	8318063	SULEDROTT	J8B4763	376185000	4.34
4642	9632272	BI JIA SHAN	VRJG7	477847500	11.30
4643	9637117	DORIC PIONEER	D5DG8	636015875	13.30
4644	9226396	STONES	V2OG9	304267000	10.49
4645	9223904	ATLANTIC PATRIOT	P3KN9	209141000	9.70
4646	9361615	HIGHLAND LAIRD	MPBX6	235011690	5.85
4647	9736937	SKYLINE BARGE 22	XXXX	0        	3.40
4648	9283875	PHOENIX LEADER	H9NY	354899000	10.00
4649	9412309	UNITED DYNAMIC	SVAW4	240968000	17.02
4650	9337614	NYK DAEDALUS	3EMS	353274000	12.52
4651	9252187	DS PROMOTER	D5BX3	636092413	13.60
4652	9292503	HELGA SPIRIT	C6FZ3	311727000	14.90
4653	8613310	MSC MANDRAKI	SZUH	240265000	13.50
4654	9282479	BRITISH MALLARD	MGPU2	232400000	14.90
4655	9368417	CHAVES	V2GE7	305915000	5.90
4656	9419292	FLEVOBORG	PBMH	245226000	8.30
4657	9178410	SEA LYNX	LNUA	258567000	6.90
4658	9138757	EVERT PRAHM	DQRI	211244230	4.50
4659	9148192	FRI SKIEN	ZDGD3	236232000	5.67
4660	9594755	SABINE	V7UU6	538004033	16.00
4661	9542491	FORTUNE DAISY	VRHV5	477892500	14.13
4662	9326536	NAVIOS GALILEO	9HA3412	229570000	14.14
4663	8906298	KAIE	9HIM8	256016000	5.45
4664	9284647	BIT OKTANIA	PCAN	246694000	9.00
4665	9691682	FREEWAY	5BCX4	0        	6.00
4666	9637246	HYUNDAI DRIVE	V7FN9	538005627	15.52
4667	9679282	TOMORROW	V7BI7	538005148	12.72
4668	9539353	KURUSHIMA	3EUX6	353188000	10.32
4669	9479979	BW STREAM	2HNW9	235105195	9.67
4670	9172208	LOWLANDS BEILUN	9HWB8	256507000	17.65
4671	9408798	MID FIGHTER	ZGCU5	319205000	9.77
4672	8516990	SC NORDIC	OZ2140	231211000	6.70
4673	9246322	PUCCINI	A8BX6	636090616	11.40
4674	9618783	DOCKWISE VANGUARD	PJWC	306039000	11.00
4675	9045936	ATLANTIC MERMAID	A8JJ3	636091102	8.81
4676	9310135	CAPE TRUST	3EIB7	372063000	17.96
4677	9278882	TOPFLIGHT	3ECD7	371316000	12.02
4678	9047491	BOW FLOWER	LAUB4	258925000	10.72
4679	9267560	SUULA	OJKZ	230957000	8.70
4680	9651278	ARISTA	LXAS	253465000	1.80
4681	9379894	BOW KISO	3EPY3	356958000	11.32
4682	9592719	ATHINA CARRAS	SVBL7	241156000	14.52
4683	9424572	HHL HONG KONG	A8XD3	636092120	9.50
4684	9381768	ATLANTIC LEO	VRDX7	477071500	12.22
4685	9393266	DELFBORG	PHMR	245091000	6.25
4686	9638783	ARKLOW BEACH	PCVD	244820165	7.20
4687	9065948	WHEAT TRADER	P3LL5	210502000	5.50
4688	9182485	STOVE CAMPBELL	LAHF5	257359000	11.79
4689	9451537	TRITON	PHOF	244469000	4.30
4690	9130212	FEHN SKY	ZDIH5	236439000	5.68
4691	9688673	MTS VANGUARD	J8B5082	375007000	3.20
4692	9342384	ISABELLA KOSAN	MVNP6	235050284	8.65
4693	1133557	DINA LIFTER	LG3773	0        	4.80
4694	9528299	SMIT BULLDOG	PBWD	246643000	2.72
4695	9705718	TESSA F	2HTI2	235106475	3.00
4696	9478561	TTM DRAGON	3EWE6	351160000	12.74
4697	9391139	STRILEN	3ERL2	370088000	9.41
4698	9639517	MORITZ OLDENDORFF	VRMQ9	477219300	18.20
4699	9512111	ARDMORE CAPELLA	V7WK3	538004321	9.21
4700	9155688	FEHN CALAIS	V2CI3	305009000	4.03
4701	9404039	TALNAKH	UBAF9	273348820	10.00
4702	9322695	BRO NYBORG	OVXR2	220479000	8.90
4703	9673616	LASTDRAGER 28	XXXX	0        	3.00
4704	9688348	STI LEXINGTON	V7DS4	538005427	13.30
4705	9641314	LAGARFOSS	V2QK5	305848000	8.70
4706	9566526	VALE SAHAM	V7ZR9	538004900	23.00
4707	9568172	PHOENIX BEACON	3FZO7	352451000	13.60
4708	9476408	SMIT EBRO	C6XZ2	311026500	4.80
4709	9346677	DINTELDIJK	PHMJ	245044000	5.80
4710	9520649	SUNRISE SKY	3FOA2	373598000	12.83
4711	9406087	CS CAROLINE	C6YD3	311016400	9.50
4712	9369306	BEAUTROPHY	PBNR	245916000	6.50
4713	9575577	SONANGOL PORTO AMBOIM	C6ZB8	311066300	17.20
4714	9629548	SEATREASURE	9HA3207	229289000	13.15
4715	9427641	KAREKARE	SVAZ5	241010000	16.00
4716	9000493	MSC EUGENIA	3EKA5	372662000	13.61
4717	9470131	VALUE	9HA2650	215137000	15.00
4718	9671436	ABIS DUSAVIK	PBDH	244810418	5.80
4719	9276119	MONTENOVO	CSDT	263619000	3.60
4720	9425526	UNIQUE EXPLORER	VRGT8	477786800	12.92
4721	9516234	H-331	XXXX	0        	6.00
4722	9342504	MAERSK ANTARES	9VHK7	565661000	15.00
4723	9389033	GEORGIOS	A8MN7	636013383	21.47
4724	9196709	LADY FELL	TSNU	672564000	10.31
4725	9417177	YANG LI HU	BOGE	413975000	15.50
4726	9484089	CAPE ENDURANCE	V7WB2	538090429	15.36
4727	1133556	NOVADRAGAMAR	J8B5059	376994000	2.50
4728	9516466	COSCO PORTUGAL	VRNI6	477271400	15.52
4729	9222132	AMAZON GLADIATOR	SYZC	239814000	11.75
4730	9259317	FEDOR	V7EV9	538090308	12.20
4731	9301067	GREAT CHALLENGER	VRBN3	477087700	17.84
4732	9313723	ABERDEEN	9HWD9	249622000	5.15
4733	9045728	NOTOS	V2OY2	304743000	7.15
4734	9681431	MORNING PRIDE	V7FM4	538005617	10.52
4735	9396787	ISOLA CELESTE	9HOD9	249263000	13.02
4736	9222704	FANEROMENI A	9HSH9	249447000	12.02
4737	9451329	DA CUI YUN	VRIM3	477213700	10.10
4738	9077563	KAPITAN MIRONOV	9HXJ4	249520000	6.70
4739	9317418	SAGA DISCOVERY	VRBR8	477105200	11.80
4740	9213739	VARNEBANK	PBAH	244171000	7.05
4741	9578050	PINTAIL	5BDT3	209102000	12.80
4742	9588768	CHINA PIONEER	VRKJ4	477598100	16.10
4743	9172868	FRONT TINA	A8HH5	636090889	20.88
4744	9620528	JU HUA HAI	BOUN	412533000	12.20
4745	9117404	COS CHERRY	S6IZ	564148000	11.34
4746	9314600	ARKLOW WILLOW	EIQP	250000144	8.35
4747	8300389	HAPPY BUCCANEER	PEND	244203000	8.25
4748	9202869	ELVIRA	A8IP2	636091014	8.66
4749	9286047	GIANNUTRI	9HVX7	215637000	10.85
4750	9316593	KRONBORG	A8KP2	636013100	11.11
4751	9463449	EDENBORG	PCCW	246716000	7.70
4752	9558012	KARLA C	2DNZ4	235080632	7.00
4753	9325817	AMELIA PACIFIC	V7UB8	538003925	12.02
4754	9015424	RYSUM	V2JO	304010168	4.35
4755	9637258	HYUNDAI VICTORY	V7FO2	538005628	15.52
4756	9371581	JUMBO JUBILEE	PBSA	246309000	8.10
4757	9286774	RIO TAKU	A8JR4	636091123	11.50
4758	9281011	KILIMANJARO SPIRIT	C6FY7	311647000	14.81
4759	9014688	CLAVIGO	V2NQ	304010290	5.50
4760	9087013	BOW CEDAR	LAXV4	259756000	10.72
4761	9339650	SEA PIONEER	V7PC8	538003210	11.79
4762	9479931	ESTIME	PCKL	246793000	5.80
4763	9451733	NINA	ICMG	247239700	11.00
4764	1133754	CONQUEST MB 1	PCTP	0        	5.00
4765	9397559	PRISCO EKATERINA	5BMW2	212085000	13.15
4766	9411769	JADE	PCDI	246724000	5.05
4767	9428815	CARPE DIEM II	V7SD9	538003629	10.10
4768	9582855	NIKLAS	V2GO6	304030000	5.49
4769	9395551	JANA	DFZQ2	218760000	7.40
4770	9586411	ULUSOY-11	TCZU4	271042566	14.62
4771	9598024	OCEAN RAINBOW	HPKG	370867000	10.40
4772	9214305	STOLT FOCUS	ZGBG	319602000	10.72
4773	7915278	FALCON	LAIP6	258633000	13.03
4774	9059248	EGESUND	OWEQ2	219012959	3.05
4775	9224439	SCF ALTAI	ELZP3	636011490	17.07
4776	9293117	CAPE BARI	V7HX2	538090174	16.00
4777	9424730	OLYMPIC HERA	LAPT	257411000	8.00
4778	1138701	BOLLE VIII	SHBN	0        	4.00
4779	9419553	FOUR WIND	IBUN	247275300	15.02
4780	9436410	LARSHOLMEN	V7RU7	538005556	9.01
4781	1133307	STEMAT 82	PBRF	245510000	4.50
4782	9347308	CPO FRANCE	2AJO2	235060233	11.52
4783	9410715	SD SHARK	9HBU9	256759000	5.36
4784	9579509	ALMI GALAXY	D5AO2	636015411	17.20
4785	9325051	NOSTOS S	SVBD6	241066000	14.14
4786	9302308	RUSICH-1	UAAA	273313430	4.34
4787	9384502	ZAGREB	9AA5910	238249000	14.58
4788	9371828	PROGRESS	PBPK	246303000	6.08
4789	9660358	AMAZON VICTORY	SVBW7	241292000	14.50
4790	9394260	NINA BRES	OYIM2	220540000	5.30
4791	9629495	NORD STABILITY	S6ME5	566737000	13.03
4792	9435325	AGDASH	9HDJ9	0        	6.97
4793	9501899	PALAU	9HA3090	229127000	7.40
4794	9337688	NYK DIANA	3EOS4	372319000	13.52
4795	9512173	CHEMROUTE OASIS	3FUW9	372975000	10.02
4796	9539341	SUNLIGHT LILY	3FHB	373522000	10.10
4797	9482237	CAPE CANARY	3FMW3	370258000	18.23
4798	8404238	ELECTRA	J8B4888	376098000	9.42
4799	9419785	PARTICI	A8UF9	636091896	12.00
4800	9394935	EVERGLADES	V7QA3	538003321	14.80
4801	9116955	SKS TYNE	C6BA7	311000210	15.72
4802	9489170	OBROVAC	9AA6986	238263000	9.90
4803	9537381	H-G BUELOW	A8YF5	636092192	12.80
4804	9276250	YELLOW RAY	D5EX9	636016192	9.72
4805	9293131	CAPE BONNY	V7IR5	538090188	17.07
4806	9586631	LYRIC STAR	C6ZG3	311054500	14.50
4807	9508110	ATLANTIS ALHAMBRA	9HA2101	249960000	6.30
4808	8009753	PACIFIC SUN	3FDS8	373747000	9.36
4809	9221970	HS ALCINA	A8JK2	636091105	17.10
4810	9053816	CORAL OBELIA	PDKU	244282000	6.62
4811	9229984	FEDERAL EMS	V7FL2	538005610	11.27
4812	9201906	CORAL CARBONIC	PCFW	245229000	4.00
4813	9667150	THALASSA MANA	9V2234	564730000	15.50
4814	9410959	GENCO TITUS	VRDI7	477968800	18.30
4815	9579585	ALMI VOYAGER	D5DY2	636015999	16.00
4816	9228320	MTM HONG KONG	VRHM5	477959800	11.02
4817	9322255	EXCELERATE	ONDY	205445000	12.32
4818	9150781	AFON GOCH	MWIP7	232002785	2.50
4819	8017085	LEIRO	8PVZ	314298000	4.81
4820	9371402	TONGAN	D5CO5	636092436	8.70
4821	9434436	SAMJOHN LEGACY	SVBA5	241019000	18.20
4822	9650573	STI SAPPHIRE	V7YN3	538004692	13.30
4823	9139309	HAPPY ROVER	PCBZ	245394000	9.51
4824	9577111	SCF PROGRESS	A8YG9	636015052	14.52
4825	9223186	VIRGINIA	V7YK5	538004678	11.93
4826	9346861	MARE AEGEUM	ICDX	247229100	14.95
4827	9598177	BBG BRIGHT	VRLC5	477638900	14.50
4828	9310537	NORD NEPTUNE	OZDR2	219194000	13.99
4829	9340104	NORDIC PIA	9V2534	564517000	9.55
4830	9656503	ROLLDOCK STORM	PCQX	246883000	5.67
4831	7382677	WILSON RYE	8PRC	314168000	6.94
4832	9485368	ORAKATE	ZDOA7	236652000	7.90
4833	9115937	UPHUSEN	V2AN1	304010651	5.86
4834	9418822	MEHMET A	9HA2866	256463000	9.70
4835	9128025	ELENI P	A8SI2	636014216	13.45
4836	9631345	ONEGO ROTTERDAM	V2QO7	305961000	7.21
4837	9587790	CHEM BULLDOG	V7YC9	538004629	9.72
4838	9493846	SHI DAI 21	BPJM	413984000	14.50
4839	9267558	KIISLA	OJKY	230956000	8.70
4840	9510682	MAXWELL BAY	V7PB3	538003201	13.50
4841	9449065	WILLEM VAN ORANJE	5BVU3	210621000	9.05
4842	9417206	FPMC 21	A8RF2	636014088	11.99
4843	9231389	PANAMAX NEREID	5BTC3	210274000	13.93
4844	9162875	AL SALHEIA	9KLR	447041000	22.72
4845	9451410	CHEMSTAR MASA	3FGM7	353456000	9.77
4846	8300262	OPTIMAR	J8B3154	375088000	4.67
4847	9675755	SPRING SKY	3EUP6	370103000	13.01
4848	9437309	HR FREQUENCY	D5AB9	636092298	8.00
4849	9334739	OLIB	9AA6266	238252000	15.00
4850	9518414	IVAN KUDRYAVTSEV	3EXM9	357959000	5.82
4851	9419448	TARGET	9HA2149	248057000	14.90
4852	9512484	FLAGSHIP WILLOW	V7CP7	538005301	14.20
4853	9254953	NORGAS NAPA	9V8461	565194000	8.30
4854	9527685	ARKLOW FOREST	EILN7	250002443	5.79
4855	9425447	CAPE PEONY	3FDX6	373590000	18.17
4856	9304174	CENTURION	V7IP6	538002425	14.12
4857	9224154	VLIEDIEP	A8ZP2	636015266	6.75
4858	9418133	NAVIG8 SUCCESS	V7SL7	538003677	13.20
4859	9433303	LOKHOLMEN	V7RN2	538005550	9.00
4860	9339844	GRAND PEARL	3EPV3	371147000	9.62
4861	9668324	KOBE GLORIA	3FTU5	352396000	9.82
4862	9230880	OVERSEAS MULAN	V7DK3	538001656	22.52
4863	9254551	ANASSA IOANNA	SVBE5	241076000	12.30
4864	9400679	OVERSEAS EVEREST	V7SS6	538003712	21.53
4865	9608958	XING FU SONG	BOEI	413471960	10.20
4866	9660360	AMAZON VIRTUE	SVBW8	241293000	11.75
4867	9302877	GUDRUN MAERSK	OYAU2	220379000	15.00
4868	9414761	ST. ANDREW	C6YQ2	311041600	10.15
4869	9033713	SUN VITA	9HFA8	215913000	5.40
4870	9186326	BLACK MARLIN	PJCK	306587000	10.08
4871	9294525	AS PATRIA	A8JK4	636091107	11.50
4872	9266542	BF LETICIA	V2BQ9	304855000	8.70
4873	8402589	CARISMA	OJMY	230003000	3.99
4874	7942946	SORMOVO 1	UCWS	273315200	3.66
4875	9454383	SYLVIA	V2DP2	305288000	4.74
4876	9469572	CMA-CGM ALASKA	A8XP9	636092147	15.50
4877	9416408	TENACITY	D5DN7	636015928	12.90
4878	9590060	SUNRISE	V2FL2	305710000	18.30
4879	9508079	ATLANTIS ANDAMAN	9HYK9	249701000	6.65
4880	9437672	SPIKE	9HA2419	248571000	14.93
4881	9667875	MULTRATUG 27	PCWB	0        	4.10
4882	9141807	DEUTSCHLAND	DMMC	211274670	5.79
4883	9669885	BOW TRIBUTE	LARU7	258802000	13.22
4884	9429027	DELTA TOLMI	SVBA3	241022000	17.17
4885	9681390	STI VENERE	V7EM4	538005495	13.33
4886	9511258	AP ARGOSY	V7XX2	538004591	14.62
4887	7917874	LIAM	HO9679	353586000	3.70
4888	9385908	DONAU	PBVI	244642000	6.80
4889	9189134	JOHANN JACOB	A8XD7	636092124	14.02
4890	9176395	HOEGH TRANSPORTER	LAKO7	257712000	10.00
4891	9454230	SVENDBORG STRAIT	CQHS	255805594	8.60
4892	9592848	FORTE	PBAN	244994000	9.68
4893	9379519	ARDMORE SEAMARINER	V7CU9	538005329	12.10
4894	9375874	TUPERNA	V2BT7	304924000	5.55
4895	9435026	BBC TENNESSEE	V2DC9	305172000	8.00
4896	9427079	BBC GREENLAND	V2CN2	305048000	7.59
4897	9006318	MARCEL	ONDP	205439000	5.47
4898	9238090	E 3004	XXXX	0        	3.60
4899	9319430	MILADY	ZDHE6	236307000	5.40
4900	8771629	ENSCO 122	D5BM2	636015555	10.00
4901	9197789	MERIT	ZDEB4	236108000	5.30
4902	9162227	MAERSK KIMI	PDHO	244132000	14.30
4903	9597276	BRITISH VANTAGE	2HCH5	235102458	22.52
4904	9333606	BRITISH RUBY	2AKI2	235060453	12.20
4905	9590711	KING GREGORY	SVBP8	241220000	13.30
4906	9433561	EMEK-S	9HTA9	249475000	6.76
4907	9201803	LADY CLARISSA	PDBB	246447000	5.87
4908	9613056	HERMES	A8YE4	636015035	14.20
4909	9510462	SILVER POINT	9HA2668	215182000	13.27
4910	9132973	HELLENIC WIND	A8PX3	636013851	13.87
4911	9121625	STENA SCOTIA	PFSN	245896000	5.40
4912	9129469	ATLANTIC COAST	5BQZ3	210605000	7.28
4913	9196228	ROCKANJE	V2BZ9	304688000	4.30
4914	9291432	NEFELI	C6AW8	311000177	14.22
4915	8501567	SAIPEM 7000	C6NO5	309461000	10.50
4916	9301536	SKS SKEENA	LAIY6	258722000	17.05
4917	9473107	HARBOUR FOUNTAIN	CQKH	255804470	9.00
4918	9642356	TRITON	D5CV9	636015790	14.20
4919	8617926	PACIFIC BREEZE	V7RC6	538003418	9.16
4920	9332157	MINERVA GEORGIA	SXUA	240715000	17.03
4921	9684110	OTHELLO	LXOD	253279000	7.45
4922	8020642	WIND PERFECTION	2FYA5	235095204	5.82
4923	9248796	SEAEXPLORER	9HJI7	215311000	11.12
4924	9134531	NORMAND CARRIER	LAQW7	258025000	6.30
4925	8766480	H 627	XXXX	0        	8.10
4926	9427055	TOISA ENVOY	C6YX7	311048600	7.50
4927	9139323	ADDI L	V2GC5	305887000	6.11
4928	9558048	KITTY-C	2EIQ6	235085464	6.75
4929	9148776	FAIRPLAY-23	V2GP	304020821	4.60
4930	9433652	AZALEA SKY	3EXL7	373416000	14.38
4931	9422225	WORLD NAVIGATOR	9V2133	566932000	12.20
4932	9353395	ALLEGRETTO	V2CQ7	304936000	5.25
4933	8307387	JIMILTA II	9HKN7	215330000	10.99
4934	9210294	SUDKAP	V2OH9	304137000	7.81
4935	9619995	MAYVIEW MAERSK	OWJN2	219578000	16.26
4936	9689160	ST. JACOBI	9V7494	563673000	13.32
4937	9255737	ENFORCER	PBHI	244597000	7.10
4938	9573751	CAPE AGNES	3FCK8	356472000	18.24
4939	9710153	MONTE DA LUZ	CUIM6	263429550	4.00
4940	9355525	SAMOS MAJESTY	C6BG6	311000257	12.30
4941	9625140	CORAL ANTHELIA	PCPB	246272000	7.80
4942	9694165	MCS KAVER	2GMB8	0        	2.00
4943	9338709	MORNING CARINA	3ENP9	351392000	10.02
1	T1	BoatFace	BF	T11      	1.10
\.


--
-- Data for Name: terminal; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.terminal (tid, name, terminal_code, type, unlo, port_id) FROM stdin;
252	Wincanton Frankfurt	RHNFR	UNKNOWN	DEFRA	45
254	Krohmann Container Terminal	00KCT	UNKNOWN	DEGEK	46
255	Siefert Spedition	0SIEF	UNKNOWN	DEGEK	46
266	Contargo Germersheim	CONTA	UNKNOWN	DEGER	47
267	DP World Terminal Germersheim	DPWOR	UNKNOWN	DEGER	47
268	Gernsheim Umschlag  Terminal	00GUT	UNKNOWN	DEGHM	48
269	Ginsheim	GINSH	UNKNOWN	DEGIG	49
270	Heilbronn	HBRON	UNKNOWN	DEHEN	51
271	Wincanton Karlsruhe	KALAG	UNKNOWN	DEKAE	52
272	Euroterminal Kehl	00ETK	UNKNOWN	DEKEH	53
273	Klummp & Mueller	00KLU	UNKNOWN	DEKEH	53
274	Hafenverwaltung	0HAFE	UNKNOWN	DEKEH	53
275	Total	TOTAL	UNKNOWN	DEKEH	53
276	Terminal de B�thune	00BET	UNKNOWN	FRBET	77
277	Avalex afvaloverslag Voltaweg/Schieweg	AVALE	UNKNOWN	NLDFT	98
278	LCG Logistiek Centrum Gorinchem	00LCG	UNKNOWN	NLGOR	103
279	BSCG-Terminal (HCL)	MCSGR	UNKNOWN	NLGRQ	104
280	Hengelo	0HENG	UNKNOWN	NLHGL	106
281	CTT Combi Terminal Twente	COMBI	UNKNOWN	NLHGL	106
282	Containerterminal Ennshafen O� GmbH	0ENNS	UNKNOWN	ATENA	1
283	Kampen	0KAMP	UNKNOWN	NLKAM	111
284	Wiencont Remain Krms	0WIEK	UNKNOWN	ATKRE	2
285	SBL Linz	00SBL	UNKNOWN	ATLNZ	3
286	Wiencont Cont. Term.	0WIEW	UNKNOWN	ATVIE	4
287	Umicore Precious Metals Refining	UMICO	UNKNOWN	BEHBN	16
288	Avelgem Cont. Term.	AVELG	UNKNOWN	BEAVL	6
289	TTB - Trimodal Terminal Brussels	00BRU	UNKNOWN	BEBRU	7
290	Gosselin Container Terminal	00GCT	UNKNOWN	BEDEG	8
291	Hainaut Terminal	000HT	UNKNOWN	BEGHL	9
313	nv Haven Genk Bargeterminal	HAGNK	UNKNOWN	BEGNK	11
314	Cargovil Container Terminal	00CCT	UNKNOWN	BEGRB	12
315	Beverdonk Container Terminal	00BCT	UNKNOWN	BEGBB	13
316	Barge & Terminal Operators	BATOP	UNKNOWN	BEHET	14
317	Garocentre Terminal	GAROC	UNKNOWN	BEHGG	15
318	Container Terminal Harderwijk	00CTH	UNKNOWN	NLHRD	107
319	HCL Heerenveen	00HCL	UNKNOWN	NLHRV	108
320	Cont. Terminal Den Bosch	00CTB	UNKNOWN	NLHTB	109
321	CTL - Container Terminal Lelystad (MCS Lelystad)	MCSLE	UNKNOWN	NLLEY	112
322	Leeuwarden Terminals	00LEE	UNKNOWN	NLLWR	113
323	MCS	MCSME	UNKNOWN	NLMEP	114
324	Middelburg	00MID	UNKNOWN	NLMID	115
325	Maastricht (via Maas)	00MAA	UNKNOWN	NLMST	117
326	Maastricht (via Albertkanaal)	0MAAB	UNKNOWN	NLMST	117
327	Container Terminal Nijmegen	00CTN	UNKNOWN	NLNIJ	118
328	MEO Stuwadoors	00MEO	UNKNOWN	NLVSN	545
329	Oosterhout Container Terminal	00OCT	UNKNOWN	NLOOS	119
330	B.V. Osse Overslag Centrale	0OSSE	UNKNOWN	NLOSS	120
331	Papendrecht	00PAP	UNKNOWN	NLPAP	121
332	Ridderkerk	00RCT	UNKNOWN	NLRID	122
333	Manfred Fichtl	FICHT	UNKNOWN	DEKEM	54
334	Container Terminal Stein BV	CTSTE	UNKNOWN	NLSTI	126
335	Tilburg	VERST	UNKNOWN	NLTLB	127
336	Utrecht	00CTU	UNKNOWN	NLUTC	129
337	Veendam	0VOSV	UNKNOWN	NLVDM	130
338	ROC Veghel - Marconiweg 3-5	0ROCV	UNKNOWN	NLVEG	131
339	TCT Venlo	00ECT	UNKNOWN	NLVEN	133
340	Wanssum Intermodal Terminal	00WIT	UNKNOWN	NLWAS	136
341	ROC Wanssum	0ROCW	UNKNOWN	NLWAS	136
342	Langshaven Wijk bij Duurstede	LANGS	UNKNOWN	NLWBD	137
343	MCS Groningen	00MCS	UNKNOWN	NLWBR	138
344	Multi Purpose Terminal Westdorpe	00WDP	UNKNOWN	NLWDP	139
345	Autriche Haven	AUTRI	UNKNOWN	NLWDP	139
346	ROC Waalwijk	ROCWA	UNKNOWN	NLWLK	140
347	Container Terminal Zutphen	00CTZ	UNKNOWN	NLZUT	142
348	Wiencont Remain International	WIEBR	UNKNOWN	SKBAB	143
349	Contargo Koblenz	CCSKZ	UNKNOWN	DEKOB	55
350	KCT Krefelder Container-Terminal GmbH	00KCT	UNKNOWN	DEKRE	56
351	Bayer Leverkusen	BAYER	UNKNOWN	DELEV	57
352	Contargo Ludwigshafen	TRIPO	UNKNOWN	DELUH	58
353	Frankenbach	00FRB	UNKNOWN	DEMAI	59
354	Wincanton Mainz	RHNMZ	UNKNOWN	DEMAI	59
355	Mannheimer Container Terminal	00MCT	UNKNOWN	DEMHG	60
356	Roll on-roll off	0ROLL	UNKNOWN	DEMHG	60
357	Goliathkraan	GOLIA	UNKNOWN	DEMHG	60
358	Kampffmeyer M�hlen GmbH	KAMPF	UNKNOWN	DEMHG	60
359	Wincanton Mannheim	RHNMA	UNKNOWN	DEMHG	60
360	Rhenus Midgard City Terminal	RHM01	UNKNOWN	DENHA	61
361	Rhenus Midgard Blexen Terminal	RHM02	UNKNOWN	DENHA	61
362	Neuss Intermodal Terminal	00NIT	UNKNOWN	DENSS	62
363	Neuss Trimodal (Neuss Optimodal)	NOTNE	UNKNOWN	DENSS	62
364	Rhenania Neuss	RHNNE	UNKNOWN	DENSS	62
365	Hafen Nuernberg Roth	NURNB	UNKNOWN	DENUE	63
366	Orsoy	ORSOY	UNKNOWN	DEORS	64
367	Hafen Riesa	SBORA	UNKNOWN	DERSA	65
368	Senden	00HSD	UNKNOWN	DESND	66
369	Stuttgart Cont. Terminal	00SCT	UNKNOWN	DESTR	67
370	Wincanton Stuttgart	RHNST	UNKNOWN	DESTR	67
371	Hafen Torgau	SBOTO	UNKNOWN	DETOU	68
372	Trierer Container Terminal	00TCT	UNKNOWN	DETRI	69
373	Wesel	0WESE	UNKNOWN	DEWES	70
374	Wesseling-Godorf	0WESS	UNKNOWN	DEWLG	71
375	Weil am Rhein	0WEIL	UNKNOWN	DEWLR	72
376	Contargo W�rth	UNIKA	UNKNOWN	DEWOE	73
377	Wincanton Worms	RHNWO	UNKNOWN	DEWOR	74
378	W�rzburg	00WZB	UNKNOWN	DEWUE	75
379	Entrepot Logistique FLAG	0FLAG	UNKNOWN	FRANZ	76
380	Trilogiport	00TLP	UNKNOWN	BELGG	17
381	Liege Container terminal	00LCT	UNKNOWN	BELGG	17
382	Euroports Containers Meerhout nv	00ECM	UNKNOWN	BEMEH	18
383	Belgian Logistic Center - Gheys	00BLC	UNKNOWN	BEMLO	19
384	Belgian Logistic Center - Gheys	00BLC	UNKNOWN	BERIN	20
385	Alpro Soya	00ALP	UNKNOWN	BEWEV	21
386	River Terminal Wielsbeke	00RTW	UNKNOWN	BEWIK	22
387	Bergen op Zoom Terminals	00BOZ	UNKNOWN	NLBZM	96
388	Markiezaat Container Terminal	MARCT	UNKNOWN	NLBZM	96
389	Deventer	00DEV	UNKNOWN	NLDEV	97
390	Mierka	00MER	UNKNOWN	ATKRE	2
391	Algemeine Land & Seespedition GmbH	00ALS	UNKNOWN	DEDUI	41
392	D3T Duisburg Trimodal terminal GmbH	00D3T	UNKNOWN	DEDUI	41
393	DeCeTe Duisburg Ruhrort	00DCT	UNKNOWN	DEDUI	41
394	Duisburg Intermodal Terminal	00DIT	UNKNOWN	DEDUI	41
395	Rhein Ruhr Term. Parallelhafen	00RRT	UNKNOWN	DEDUI	41
396	ECT Duisburg	ECTDU	UNKNOWN	DEDUI	41
397	RRT Gateway West	GATEW	UNKNOWN	DEDUI	41
398	Duesseldorfer Container Hafen	00DCH	UNKNOWN	DEDUS	42
399	Unger Depot Dusseldorf	UNGDD	UNKNOWN	DEDUS	42
400	Rhein Waal Terminal	00RWT	UNKNOWN	DEEMM	43
401	Emmelsum	EMMEL	UNKNOWN	DEESU	44
402	FIT - Frankfurt Intermodal terminal	CCSHO	UNKNOWN	DEFRA	45
405	Trimodal Container Terminal	00TCT	UNKNOWN	BEWLB	23
406	Zelzate	00ZEL	UNKNOWN	BEZEL	25
407	Birs Terminal AG	BIRST	UNKNOWN	CHBFL	27
408	Swissterminal Birsfelden	STBFL	UNKNOWN	CHBFL	27
409	Birsfelden-Auhafen S.R.N.	00SRN	UNKNOWN	CHBFL	28
410	Birsfelden-Auhafen-Ultrabrag	ULTRA	UNKNOWN	CHBFL	27
411	Haniel Basel	00HAN	UNKNOWN	CHBSL	28
412	Navis	00NAV	UNKNOWN	CHBSL	28
413	Silag	00SIL	UNKNOWN	CHBSL	28
414	Spedag	00SPE	UNKNOWN	CHBSL	28
415	Satram AG	0SATR	UNKNOWN	CHBSL	28
416	Alpina Container Terminal (ACT) Dach	ACTDA	UNKNOWN	CHBSL	28
417	Contargo terminal Nord	CONNO	UNKNOWN	CHBSL	28
418	Contargo terminal S�d	CONSU	UNKNOWN	CHBSL	28
419	Rhenus Basel	RHEBA	UNKNOWN	CHBSL	28
420	Swissterminal Basel	STBSL	UNKNOWN	CHBSL	28
421	Basel ULTRA-BRAG	ULTRA	UNKNOWN	CHBSL	28
422	Stadtwerke Andernach	ANDER	UNKNOWN	DEAND	29
423	Contargo Aschaffenburg	00CTA	UNKNOWN	DEASC	30
424	BEHALA	BEWHF	UNKNOWN	DEBER	31
425	Am Zehnhof-Soens GmbH	AMZEH	UNKNOWN	DEBON	32
426	CTS Koeln	00CTS	UNKNOWN	DECGN	34
427	Donau-Hafenges. Deggendorf	00DEG	UNKNOWN	DEDEG	36
428	U.C.T. Dormagen	00UCT	UNKNOWN	DEDMG	37
429	Lehnkering-Montan	LEHDO	UNKNOWN	DEDMG	37
430	UPM Nordland Papier	00UPM	UNKNOWN	DEDRP	38
431	Alberthafen Dresden-Friedrichstadt	SBODD	UNKNOWN	DEDRS	39
432	Container Terminal Dortmund	00CTD	UNKNOWN	DEDTM	40
433	Dortmund	0DORT	UNKNOWN	DEDTM	40
434	Lille Dourges Container Terminal	0LDCT	UNKNOWN	FRDRG	79
435	CCES - Dourges	CCESD	UNKNOWN	FRDRG	79
436	Halluin Terminal Conteneurs	00HTC	UNKNOWN	FRHAL	80
437	CTV Huningue	CTVHU	UNKNOWN	FRHUN	81
438	Lille Container Terminal	00LCT	UNKNOWN	FRLLE	82
439	Port de Lille	LILLE	UNKNOWN	FRLLE	82
440	Neuf Brisach	0NEUF	UNKNOWN	FRNEF	83
441	Port Rhenan de Mulhouse-Ottmarsheim	00OTT	UNKNOWN	FROTM	84
442	CCES - Prouvy	CCESP	UNKNOWN	FRPOY	85
443	Terminal Conteneurs Nord	00TCN	UNKNOWN	FRSXB	86
444	Terminal Container S�d	00TCS	UNKNOWN	FRSXB	86
445	Terminal Multimodal Valenciennois	00TMV	UNKNOWN	FRVAL	87
446	CCES - Saint Saulve	CCESS	UNKNOWN	FRZUE	88
447	Budapest Terminals	0BUDA	UNKNOWN	HUBUD	89
448	Almelo	00ALM	UNKNOWN	NLALM	90
449	Alpherium - Alphen	ALPHE	UNKNOWN	NLAPN	92
450	Arnhem	0ARNH	UNKNOWN	NLARN	93
451	Barge Terminal Born	00BTB	UNKNOWN	NLBON	95
1	ACE8	0ACE8	UNKNOWN	BEANR	180
2	Den Helder	0DENH	UNKNOWN	NLDHR	531
3	Katoennatie	1231	UNKNOWN	BEANR	180
4	Vopak Terminal Linkeroever	1313	UNKNOWN	BEANR	180
5	Antwerp Euroterminal nv	1333	UNKNOWN	BEANR	180
6	Katoennatie - Seaport Terminals Kaai 1510	1510	UNKNOWN	BEANR	180
7	GCS - Global Container Services, DP World kaai 1610	1610	UNKNOWN	BEANR	180
8	Antwerp Gateway 1700	1700	UNKNOWN	BEANR	180
9	PSA - Antwerp Deurganckterminal	1742	UNKNOWN	BEANR	180
10	ICTC	0ICTC	UNKNOWN	BEANR	180
11	MCSB Kaai 746	0MCSB	UNKNOWN	BEANR	180
12	PSA - Antwerp Noordzeeterminal	0S913	UNKNOWN	BEANR	180
13	Esso Belgium Antwerp Refinery	447	UNKNOWN	BEANR	180
14	Total Raffinaderij Antwerpen	449	UNKNOWN	BEANR	180
15	ASHCO	ASHCO	UNKNOWN	BEANR	180
16	HANDICO	HANDI	UNKNOWN	BEANR	180
17	INCHAPE	INCHA	UNKNOWN	BEANR	180
18	PROGECO	PROGE	UNKNOWN	BEANR	180
19	De Smedt	SMEDT	UNKNOWN	BEANR	180
20	TEVECO	TEVEC	UNKNOWN	BEANR	180
21	Esso Zwijndrecht	1007	UNKNOWN	BEANR	180
22	Kallo - Antwerp Gas terminal	1183	UNKNOWN	BEANR	180
23	Halterman	1972	UNKNOWN	BEANR	180
24	Hansestadt Bremisches Hafenamt	20210	UNKNOWN	DEBRE	269
25	Kurt A. Becher GmbH	0B101	UNKNOWN	DEBRE	269
26	Renne GmbH	0B104	UNKNOWN	DEBRE	269
27	Bremer Rolandm�hle Erling & Co.	0B105	UNKNOWN	DEBRE	269
28	D. Wandel	0B106	UNKNOWN	DEBRE	269
29	Kellogs Manufacturing	0B108	UNKNOWN	DEBRE	269
30	Dreyer & Hillmann GmbH	0B110	UNKNOWN	DEBRE	269
31	ECL Eurocargo Logistic GmbH	0B111	UNKNOWN	DEBRE	269
32	Egerland Car Terminal GmbH	0B112	UNKNOWN	DEBRE	269
33	Bremenports GmbH	0B113	UNKNOWN	DEBRE	269
34	Bremenports GmbH	0B114	UNKNOWN	DEBRE	269
35	Bremenports GmbH	0B115	UNKNOWN	DEBRE	269
36	Total Tanklager Deutschland GmbH	0B117	UNKNOWN	DEBRE	269
37	Hansa Holz W. Kr�ger GmbH	0B118	UNKNOWN	DEBRE	269
38	HGM Tanklager GmbH	0B122	UNKNOWN	DEBRE	269
39	IVG Logistic GmbH	0B123	UNKNOWN	DEBRE	269
40	J. M�ller GmbH Terminal Bremen	0B124	UNKNOWN	DEBRE	269
41	Bremenports GmbH	0B125	UNKNOWN	DEBRE	269
42	Mibau Baustoffhandel GmbH	0B128	UNKNOWN	DEBRE	269
43	BLG Cargo Logistics GmbH	0B129	UNKNOWN	DEBRE	269
44	Stahlwerke Bremen GmbH	0B132	UNKNOWN	DEBRE	269
45	Bremer Holzwerke	0B133	UNKNOWN	DEBRE	269
46	SWB Gruppe Erzeuger	0B135	UNKNOWN	DEBRE	269
47	Tate & Lyle Europe, Hansa Melasse	0B137	UNKNOWN	DEBRE	269
48	Weserpetrol GmbH, Seehafentanklager	0B142	UNKNOWN	DEBRE	269
49	Weissheimer Malzfabrik	0B143	UNKNOWN	DEBRE	269
50	Weserpetrol GmbH, Tankl�schanlage	0B144	UNKNOWN	DEBRE	269
51	Weserport GmbH, Terminal 1	0B145	UNKNOWN	DEBRE	269
52	Wesertanking	0B146	UNKNOWN	DEBRE	269
53	Addicks & Kreye Container Service GmbH	0B147	UNKNOWN	DEBRE	269
54	Weserport GmbH, Terminal 2	0B148	UNKNOWN	DEBRE	269
55	Weserport GmbH, Terminal 3	0B149	UNKNOWN	DEBRE	269
56	TSR Recycling GmbH	0B155	UNKNOWN	DEBRE	269
57	Fiedrich Tiemann GmbH	0B156	UNKNOWN	DEBRE	269
58	BLG Cargo Logistics GmbH, Neust�dter Hafen	0B162	UNKNOWN	DEBRE	269
59	Polysar - Bayer Polysar	1009	UNKNOWN	BEANR	180
60	Cuxhafen	00CUX	UNKNOWN	DECUX	272
61	Cuxport GmbH	EUR01	UNKNOWN	DECUX	272
62	Cuxport GmbH	EUR02	UNKNOWN	DECUX	272
63	Cuxport GmbH	EUR03	UNKNOWN	DECUX	272
64	Cuxport GmbH	EUR04	UNKNOWN	DECUX	272
65	Cuxport GmbH	HUM01	UNKNOWN	DECUX	272
66	Ineos	1053	UNKNOWN	BEANR	180
67	Buss	81	UNKNOWN	DEHAM	274
68	Cellpap terminal	00CEL	UNKNOWN	DEHAM	274
69	HHLA	00CTA	UNKNOWN	DEHAM	274
70	Eurogate	00EGH	UNKNOWN	DEHAM	274
71	LZU	00LZU	UNKNOWN	DEHAM	274
72	C. Steinweg S�dWestTerminal	00SWT	UNKNOWN	DEHAM	274
73	HHLA	00TCT	UNKNOWN	DEHAM	274
74	Hamburg	0HAMB	UNKNOWN	DEHAM	274
75	United Steved. kade 353-363	359	UNKNOWN	BEANR	180
76	ABES 361 - 363	361	UNKNOWN	BEANR	180
77	Associated Terminal Operators Kade 364 (ATO)	364	UNKNOWN	BEANR	180
78	VVM Betoncentrale	365	UNKNOWN	BEANR	180
79	Vopak Terminal Eurotank	399	UNKNOWN	BEANR	180
80	Sea-Tank Terminal 409	409	UNKNOWN	BEANR	180
81	Sea-Tank Terminal 413	413	UNKNOWN	BEANR	180
82	PSA Antwerp Churchill Terminal	420	UNKNOWN	BEANR	180
83	Progeco Bargeterminal	426	UNKNOWN	BEANR	180
84	DP World Breakbulk 464 - 472	468	UNKNOWN	BEANR	180
85	DP World Breakbulk 480	480	UNKNOWN	BEANR	180
86	NHS Steel	494	UNKNOWN	BEANR	180
87	ACS - Vopak Terminal ACS	503	UNKNOWN	BEANR	180
88	Coil Terminal 504	504	UNKNOWN	BEANR	180
89	Bayer	507	UNKNOWN	BEANR	180
90	Euroports Containers 524 nv	524	UNKNOWN	BEANR	180
91	Rapid Container Serv. kade 534	534	UNKNOWN	BEANR	180
92	Ancon  604-610	604	UNKNOWN	BEANR	180
93	Amsterdam Container Terminals BV	00ACT	UNKNOWN	NLAMS	527
94	Amsterdam Marine Terminals-ACT	00AMT	UNKNOWN	NLAMS	527
95	United Stevedoring Amsterdam	00USA	UNKNOWN	NLAMS	527
96	Verenigde Cargadoors	00VCK	UNKNOWN	NLAMS	527
97	Ter Haak Suezhaven	0THAM	UNKNOWN	NLAMS	527
98	Westpoort terminal	0WESP	UNKNOWN	NLAMS	527
99	CTVrede - Steinweg b.v.	CTVRE	UNKNOWN	NLAMS	527
100	Scandia terminal	SCAND	UNKNOWN	NLAMS	527
101	SCS Multiport bv	SCSMU	UNKNOWN	NLAMS	527
102	Waterland Terminal BV	WTRLA	UNKNOWN	NLAMS	527
103	Container Terminal Beverwijk	00CTB	UNKNOWN	NLBEV	528
104	Dordrecht	00DOR	UNKNOWN	NLDOR	532
105	Van Der Wees Watertransporten BV	0WEES	UNKNOWN	NLDOR	532
106	msc	0ZEEH	UNKNOWN	NLDOR	532
107	Delfzijl	0DELZ	UNKNOWN	NLDZL	530
108	Harlingen	0HARL	UNKNOWN	NLHAR	535
109	Container Stevedoring Ymuiden	00CSY	UNKNOWN	NLIJM	536
110	IJmuiden	00IJM	UNKNOWN	NLIJM	536
111	Cornelis Vrolijk	VROLI	UNKNOWN	NLIJM	536
112	Container Terminal Hollandsdiep	00CTH	UNKNOWN	NLMOE	537
113	Delta Marine Terminal	00DMT	UNKNOWN	NLMOE	537
114	Tank Terminal Omya Beheer BV	0OMYA	UNKNOWN	NLMOE	537
115	Seaport Terminals	0SPMO	UNKNOWN	NLMOE	537
116	Van der Vlist Moerdijk	0VDVL	UNKNOWN	NLMOE	537
117	Combined Cargo Terminals Moerdijk	CCTMO	UNKNOWN	NLMOE	537
118	Transmo	TRAMO	UNKNOWN	NLMOE	537
119	Van Dalen Moerdijk BV	VANDA	UNKNOWN	NLMOE	537
120	ECT Hartelhaven	000LT	UNKNOWN	NLRTM	539
121	Barge Centre Waalhaven	00BCW	UNKNOWN	NLRTM	539
122	ECT City Terminal	00CTY	UNKNOWN	NLRTM	539
123	ECT DBF - Delta Barge Feeder Terminal	00DBF	UNKNOWN	NLRTM	539
124	DCS (Kramer) Amazonehaven	00DCS	UNKNOWN	NLRTM	539
125	ECT Delta Dedicated East	00DDE	UNKNOWN	NLRTM	539
126	ECT Delta Dedicated North	00DDN	UNKNOWN	NLRTM	539
127	ECT Delta Dedicated West	00DDW	UNKNOWN	NLRTM	539
128	Euromax Terminal	00EMX	UNKNOWN	NLRTM	539
129	Uniport Multipurpose Terminals 	00HAN	UNKNOWN	NLRTM	539
130	Hollands Veem	00HVM	UNKNOWN	NLRTM	539
131	MRS Mainport Reefer Services	00MRS	UNKNOWN	NLRTM	539
132	Niek Dijkstra Terminal (Waalhaven)	00NDT	UNKNOWN	NLRTM	539
133	ECT Rail Terminal Oost	00ORT	UNKNOWN	NLRTM	539
134	PCS-SWW	00PCS	UNKNOWN	NLRTM	539
135	CTT Rotterdam	00PCT	UNKNOWN	NLRTM	539
136	RCT Hartelhaven	00RCT	UNKNOWN	NLRTM	539
137	Rail Service Centre	00RSC	UNKNOWN	NLRTM	539
138	ECT Rail Terminal West	00RTW	UNKNOWN	NLRTM	539
139	RWG - Rotterdam World Gateway	00RWG	UNKNOWN	NLRTM	539
140	U.C.T. Eemhaven	00UCT	UNKNOWN	NLRTM	539
141	Van Doorn depot Maasvlakte	00VDM	UNKNOWN	NLRTM	539
142	VOS	00VOS	UNKNOWN	NLRTM	539
143	Waalhaven Botlek Terminal	00WBT	UNKNOWN	NLRTM	539
144	Oosterom & Zoon	2175	UNKNOWN	NLRTM	539
145	Aluchemie Botlek	0ALUB	UNKNOWN	NLRTM	539
146	APM Terminals - Maasvlakte 2	0APMA	UNKNOWN	NLRTM	539
147	APM Terminals	0APME	UNKNOWN	NLRTM	539
148	CDMR Terminal, Merseyweg 70	0CDMR	UNKNOWN	NLRTM	539
149	DFDS Tor Terminal	0DFDS	UNKNOWN	NLRTM	539
150	Fruitterminal	0FRUM	UNKNOWN	NLRTM	539
151	Broekman - Distriport BV	0GEVB	UNKNOWN	NLRTM	539
152	Gevelco Heyplaat	0GEVW	UNKNOWN	NLRTM	539
153	Alconet (Allied Container Network BV)	0HAND	UNKNOWN	NLRTM	539
154	Depot Handico Maasvlakte	0HANM	UNKNOWN	NLRTM	539
155	Kramer Depot Maasvlakte	0KRAD	UNKNOWN	NLRTM	539
156	Kramer Depot Home	0KRAW	UNKNOWN	NLRTM	539
157	Metaal Transport Heyplaat	0MTRW	UNKNOWN	NLRTM	539
158	Ned. Repair Barce Centre	0NRBC	UNKNOWN	NLRTM	539
265	Unikai	48	UNKNOWN	DEHAM	274
159	Overbeek Container Control	0OVBR	UNKNOWN	NLRTM	539
160	PCSBotlek	0PCSB	UNKNOWN	NLRTM	539
161	Rotterdams Haven Bedrijf	0RHBW	UNKNOWN	NLRTM	539
162	Seaport Merwehaven	0SEAM	UNKNOWN	NLRTM	539
163	TOR LINE Brittanniehaven	0TORB	UNKNOWN	NLRTM	539
164	Transmo cont. serv. Botlek	0TRAB	UNKNOWN	NLRTM	539
165	Uniport Pier 6	0UNI6	UNKNOWN	NLRTM	539
166	Uniport Pier 7	0UNIW	UNKNOWN	NLRTM	539
167	VAT Container Service Werkhaven	0VATW	UNKNOWN	NLRTM	539
168	Waalhaven Terminal	0WHTW	UNKNOWN	NLRTM	539
169	Westerstuw	0WHWS	UNKNOWN	NLRTM	539
170	Albatros	ALBDO	UNKNOWN	NLRTM	539
171	Cetem Containers	CETEM	UNKNOWN	NLRTM	539
172	E.C.C. Madroelkade	ECCMA	UNKNOWN	NLRTM	539
173	Eemtrans 1e Eemhaven	EEMTR	UNKNOWN	NLRTM	539
174	Interforest Terminal Rotterdam	INTER	UNKNOWN	NLRTM	539
175	Klapwijk Rapide Pier 1	KLAPW	UNKNOWN	NLRTM	539
176	Maersk depot Maasvlakte	MAERD	UNKNOWN	NLRTM	539
177	Medrepair	MEDRE	UNKNOWN	NLRTM	539
178	J.C.Meijers Heyplaat	MEIJW	UNKNOWN	NLRTM	539
179	Morcon Botlek	MRTBO	UNKNOWN	NLRTM	539
180	Morcon Pier 5	MRTWA	UNKNOWN	NLRTM	539
181	OCC Butaanweg	OCCBU	UNKNOWN	NLRTM	539
182	Progeco Pier 5	P5PRO	UNKNOWN	NLRTM	539
183	Progeco	PROGE	UNKNOWN	NLRTM	539
184	Rhenus Logistics - Lokatie Maasvlakte	RLDTR	UNKNOWN	NLRTM	539
185	RST Noord - Rotterdam Short Sea Terminal	RSTNO	UNKNOWN	NLRTM	539
186	RST Zuid - Rotterdam Short Sea Terminal	RSTZU	UNKNOWN	NLRTM	539
187	Seabrex Merwehaven	SEABM	UNKNOWN	NLRTM	539
188	Rhenus Spoorhaven	SPHW1	UNKNOWN	NLRTM	539
189	Steinweg Beatrixhaven	STEBA	UNKNOWN	NLRTM	539
190	Steinweg Botlek	STEBO	UNKNOWN	NLRTM	539
191	Steinweg Mississippihaven	STEMI	UNKNOWN	NLRTM	539
192	Steinweg Seineterminal	STESE	UNKNOWN	NLRTM	539
193	Steinweg Pier 1 Waalhaven	STEW1	UNKNOWN	NLRTM	539
194	Steinweg Pier 2 Waalhaven	STEW2	UNKNOWN	NLRTM	539
195	DFDS Tor Terminal/Pier 2	TORW2	UNKNOWN	NLRTM	539
196	Van Uden Merwehaven	UDENM	UNKNOWN	NLRTM	539
197	Uniport Stevedoring Comp.	UNISC	UNKNOWN	NLRTM	539
198	Van Bentum Recycling Centrale	VBENT	UNKNOWN	NLRTM	539
199	Vitesse Depot Rotterdam	VITDE	UNKNOWN	NLRTM	539
200	Zwennis	ZWENN	UNKNOWN	NLRTM	539
201	Verbrugge Terneuzen Bulk	00VTB	UNKNOWN	NLTNZ	544
202	Verbrugge Terneuzen Terminals	00VTT	UNKNOWN	NLTNZ	544
203	Zeeland Container Terminal (Katoen Natie)	00ZCT	UNKNOWN	NLTNZ	544
204	Terneuzen	0TERN	UNKNOWN	NLTNZ	544
205	Vlaardingen	00VLA	UNKNOWN	NLVLA	546
206	Pacorini Metal Terminal Vlissingen	00HAT	UNKNOWN	NLVLI	547
207	Kloosterboer Terminal Vlissingen	00KLB	UNKNOWN	NLVLI	547
208	Sealake Terminal Vlissingen	00SEA	UNKNOWN	NLVLI	547
209	Verbrugge Scaldia Terminal	00VST	UNKNOWN	NLVLI	547
210	Vlissingen	0VLIS	UNKNOWN	NLVLI	547
211	Verbrugge Zeeland Terminal	VERBR	UNKNOWN	NLVLI	547
212	De Vreede	00CTV	UNKNOWN	NLZAA	548
213	Bruins Veem	BRUIN	UNKNOWN	NLZAA	548
214	Antwerp for Storage	245	UNKNOWN	BEANR	180
215	Seaport Term. kade 253	253	UNKNOWN	BEANR	180
216	Katoennatie 255	255	UNKNOWN	BEANR	180
217	Sea-Tank Terminal 256	256	UNKNOWN	BEANR	180
218	LBC Tank Terminals	275	UNKNOWN	BEANR	180
219	Antwerp Terminal and Processing Company NV	279	UNKNOWN	BEANR	180
220	Nynas	281	UNKNOWN	BEANR	180
221	Sea Tank Terminal	302	UNKNOWN	BEANR	180
222	Mexico Natie	311	UNKNOWN	BEANR	180
223	Edoco	312	UNKNOWN	BEANR	180
224	Vrije kaai, geen concessie	315	UNKNOWN	BEANR	180
225	Allpack International / ACE	317	UNKNOWN	BEANR	180
226	International Car Operators Benelux	319	UNKNOWN	BEANR	180
227	Cargill	506	UNKNOWN	BEANR	180
228	Holland Reefer Service	00HRS	UNKNOWN	NLRTM	539
229	Delfzijl Eemshaven	0DELE	UNKNOWN	NLEEM	533
230	Steinweg kade 115	115	UNKNOWN	BEANR	180
231	ASI kade 117	117	UNKNOWN	BEANR	180
232	Zuidnatie	118	UNKNOWN	BEANR	180
233	Oiltanking Antwerp	623	UNKNOWN	BEANR	180
234	Vesta terminal Antwerpen Petroleum	643	UNKNOWN	BEANR	180
235	Solvay Chemicals	647	UNKNOWN	BEANR	180
236	Belgian Refining Corporation	663	UNKNOWN	BEANR	180
237	Europa Terminal binnenzijde 667	667	UNKNOWN	BEANR	180
238	Noordzeeterminal binnenzijde703	703	UNKNOWN	BEANR	180
239	BASF	725	UNKNOWN	BEANR	180
240	MSC Home Terminal kade 730	730	UNKNOWN	BEANR	180
241	Zeebrugge International Port	129	UNKNOWN	BEZEE	182
242	Container Handling Zeebrugge (PSA)	206	UNKNOWN	BEZEE	182
243	C2C Shipping Lines nv	00C2C	UNKNOWN	BEZEE	182
244	Zeebrugge	00ZEE	UNKNOWN	BEZEE	182
245	PSA Wielingen Zuid	140	UNKNOWN	BEZEE	182
246	ACE5	0ACE5	UNKNOWN	BEANR	180
247	Gent	00GEN	UNKNOWN	BEGNE	181
248	Intermodal Platform Ghent	00IPG	UNKNOWN	BEGNE	181
249	Lys-Line Belgium	LYSLI	UNKNOWN	BEGNE	181
250	Stora Enso Langerbrugge NV	STORA	UNKNOWN	BEGNE	181
251	Steinweg 127	127	UNKNOWN	BEANR	180
253	MSC Home Terminal kaai 734	734	UNKNOWN	BEANR	180
256	DP World Delwaidedok kaai 742-748	742	UNKNOWN	BEANR	180
257	Antwerp Bulk Terminal � Sea-Invest	750	UNKNOWN	BEANR	180
258	PSA Antwerp Europa Terminal	0S869	UNKNOWN	BEANR	180
259	CCA	00CCA	UNKNOWN	BEANR	180
260	CTR	00CTR	UNKNOWN	BEANR	180
261	GCS	00GCS	UNKNOWN	BEANR	180
262	Euroports kaai 1207	1207	UNKNOWN	BEANR	180
263	Katoennatie	1225	UNKNOWN	BEANR	180
264	APM Terminals	120	UNKNOWN	BEZEE	182
292	Trouw Natie & Stevedoring - TNS	131	UNKNOWN	BEANR	180
293	Scaldes kade 132	132	UNKNOWN	BEANR	180
294	Antroma/Dok 138 bvba	138	UNKNOWN	BEANR	180
295	Moordtgat / Bezemer	140	UNKNOWN	BEANR	180
296	Multi-user	142	UNKNOWN	BEANR	180
297	Euroports Containers Antwerp nv	170	UNKNOWN	BEANR	180
298	BELG. New Fruit warf	190	UNKNOWN	BEANR	180
299	Vollers Belgium NV	201	UNKNOWN	BEANR	180
300	Belgian New Fruit Wharf 206 - 210	208	UNKNOWN	BEANR	180
301	ABT nv 209	209	UNKNOWN	BEANR	180
302	Ziegler	0021A	UNKNOWN	BEANR	180
303	Belgian New Fruit Warf	220	UNKNOWN	BEANR	180
304	Noord Natie Terminals 227	227	UNKNOWN	BEANR	180
305	Nems Benelux	232	UNKNOWN	BEANR	180
306	Independent Maritime Terminal	242	UNKNOWN	BEANR	180
307	Noordnatie kade 243	243	UNKNOWN	BEANR	180
308	ABT nv 320	320	UNKNOWN	BEANR	180
309	Nova & Hesse-Noord Natie Stevedoring  6e Havendok	334	UNKNOWN	BEANR	180
310	Nova & Hesse-Noord Natie Stevedoring 332 t/m 344	342	UNKNOWN	BEANR	180
311	ABES nv Kaai 347	347	UNKNOWN	BEANR	180
312	ABES NV Kaai 349	349	UNKNOWN	BEANR	180
403	Nord France Terminal International	0NFTI	UNKNOWN	FRDKK	317
404	Ghent Containerterminal N.V.	00GCT	UNKNOWN	BEGNE	181
\.


--
-- Data for Name: undgs; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs (uid, classification, classification_code, collective, hazard_no, not_applicable, packing_group, station, transport_category, transport_forbidden, tunnel_code, un_no, vehicletank_carriage) FROM stdin;
\.


--
-- Data for Name: undgs_descriptions; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_descriptions (udid, undgs_language, decription, undgs_id) FROM stdin;
\.


--
-- Data for Name: undgs_has_label; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_has_label (uid, ulid) FROM stdin;
\.


--
-- Data for Name: undgs_has_tank_special_provision; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_has_tank_special_provision (uid, utsid) FROM stdin;
\.


--
-- Data for Name: undgs_has_tankcode; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_has_tankcode (uid, utid) FROM stdin;
\.


--
-- Data for Name: undgs_labels; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_labels (ulid, name) FROM stdin;
\.


--
-- Data for Name: undgs_tank_special_provisions; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_tank_special_provisions (utsid, name) FROM stdin;
\.


--
-- Data for Name: undgs_tankcodes; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public.undgs_tankcodes (utid, name) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: docker
--

COPY public."user" (uid, name, email, email_notifications, darkmode, last_login) FROM stdin;
1	Robert	r.d.banu@student.utwente.nl	f	f	\N
\.


--
-- Name: applications_aid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.applications_aid_seq', 30, true);


--
-- Name: conflicts_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.conflicts_cid_seq', 1, false);


--
-- Name: container_types_cid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.container_types_cid_seq', 36, true);


--
-- Name: history_hid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.history_hid_seq', 23, true);


--
-- Name: ports_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.ports_pid_seq', 727, true);


--
-- Name: ships_sid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.ships_sid_seq', 4943, true);


--
-- Name: terminals_tid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.terminals_tid_seq', 451, true);


--
-- Name: undgs_descriptions_udid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.undgs_descriptions_udid_seq', 1, false);


--
-- Name: undgs_labels_ulid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.undgs_labels_ulid_seq', 1, false);


--
-- Name: undgs_tank_special_provisions_utsid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.undgs_tank_special_provisions_utsid_seq', 1, false);


--
-- Name: undgs_tankcodes_utid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.undgs_tankcodes_utid_seq', 1, false);


--
-- Name: undgs_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.undgs_uid_seq', 1, false);


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: docker
--

SELECT pg_catalog.setval('public.users_uid_seq', 1, true);


--
-- Name: application applications_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT applications_pkey PRIMARY KEY (aid);


--
-- Name: conflict conflicts_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.conflict
    ADD CONSTRAINT conflicts_pkey PRIMARY KEY (cid);


--
-- Name: container_type container_types_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.container_type
    ADD CONSTRAINT container_types_pkey PRIMARY KEY (cid);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (hid);


--
-- Name: port ports_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.port
    ADD CONSTRAINT ports_pkey PRIMARY KEY (pid);


--
-- Name: ship ships_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.ship
    ADD CONSTRAINT ships_pkey PRIMARY KEY (sid);


--
-- Name: terminal terminals_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.terminal
    ADD CONSTRAINT terminals_pkey PRIMARY KEY (tid);


--
-- Name: undgs_descriptions undgs_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_descriptions
    ADD CONSTRAINT undgs_descriptions_pkey PRIMARY KEY (udid);


--
-- Name: undgs_has_label undgs_has_label_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_label
    ADD CONSTRAINT undgs_has_label_pkey PRIMARY KEY (uid, ulid);


--
-- Name: undgs_has_tank_special_provision undgs_has_tank_special_provision_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tank_special_provision
    ADD CONSTRAINT undgs_has_tank_special_provision_pkey PRIMARY KEY (uid, utsid);


--
-- Name: undgs_has_tankcode undgs_has_tankcode_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tankcode
    ADD CONSTRAINT undgs_has_tankcode_pkey PRIMARY KEY (uid, utid);


--
-- Name: undgs_labels undgs_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_labels
    ADD CONSTRAINT undgs_labels_pkey PRIMARY KEY (ulid);


--
-- Name: undgs undgs_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs
    ADD CONSTRAINT undgs_pkey PRIMARY KEY (uid);


--
-- Name: undgs_tank_special_provisions undgs_tank_special_provisions_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_tank_special_provisions
    ADD CONSTRAINT undgs_tank_special_provisions_pkey PRIMARY KEY (utsid);


--
-- Name: undgs_tankcodes undgs_tankcodes_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_tankcodes
    ADD CONSTRAINT undgs_tankcodes_pkey PRIMARY KEY (utid);


--
-- Name: user users_pkey; Type: CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: conflict conflicts_solved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.conflict
    ADD CONSTRAINT conflicts_solved_by_fkey FOREIGN KEY (solved_by) REFERENCES public."user"(uid);


--
-- Name: conflict fk_conflicts_applications; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.conflict
    ADD CONSTRAINT fk_conflicts_applications FOREIGN KEY (created_by) REFERENCES public.application(aid);


--
-- Name: terminal terminals_port_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.terminal
    ADD CONSTRAINT terminals_port_id_fkey FOREIGN KEY (port_id) REFERENCES public.port(pid);


--
-- Name: undgs_descriptions undgs_descriptions_undgs_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_descriptions
    ADD CONSTRAINT undgs_descriptions_undgs_id_fkey FOREIGN KEY (undgs_id) REFERENCES public.undgs(uid);


--
-- Name: undgs_has_label undgs_has_label_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_label
    ADD CONSTRAINT undgs_has_label_uid_fkey FOREIGN KEY (uid) REFERENCES public.undgs(uid);


--
-- Name: undgs_has_label undgs_has_label_ulid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_label
    ADD CONSTRAINT undgs_has_label_ulid_fkey FOREIGN KEY (ulid) REFERENCES public.undgs_labels(ulid);


--
-- Name: undgs_has_tank_special_provision undgs_has_tank_special_provision_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tank_special_provision
    ADD CONSTRAINT undgs_has_tank_special_provision_uid_fkey FOREIGN KEY (uid) REFERENCES public.undgs(uid);


--
-- Name: undgs_has_tank_special_provision undgs_has_tank_special_provision_utsid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tank_special_provision
    ADD CONSTRAINT undgs_has_tank_special_provision_utsid_fkey FOREIGN KEY (utsid) REFERENCES public.undgs_tank_special_provisions(utsid);


--
-- Name: undgs_has_tankcode undgs_has_tankcode_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tankcode
    ADD CONSTRAINT undgs_has_tankcode_uid_fkey FOREIGN KEY (uid) REFERENCES public.undgs(uid);


--
-- Name: undgs_has_tankcode undgs_has_tankcode_utid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: docker
--

ALTER TABLE ONLY public.undgs_has_tankcode
    ADD CONSTRAINT undgs_has_tankcode_utid_fkey FOREIGN KEY (utid) REFERENCES public.undgs_tankcodes(utid);


--
-- PostgreSQL database dump complete
--

