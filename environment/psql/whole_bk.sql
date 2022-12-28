--
-- PostgreSQL database cluster dump
--

-- Started on 2022-12-28 18:47:53 +0330

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Debian 12.9-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

-- Started on 2022-12-28 18:47:53 +0330

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2022-12-28 18:47:54 +0330

--
-- PostgreSQL database dump complete
--

--
-- Database "db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Debian 12.9-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

-- Started on 2022-12-28 18:47:54 +0330

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2995 (class 1262 OID 16386)
-- Name: local_db; Type: DATABASE; Schema: -; Owner: dbuser
--

CREATE DATABASE local_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE local_db OWNER TO dbuser;

\connect local_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 16443)
-- Name: Address; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public."Address" (
    id integer NOT NULL,
    address character varying,
    postal_code character(10),
    tel character varying
);


ALTER TABLE public."Address" OWNER TO dbuser;

--
-- TOC entry 202 (class 1259 OID 16435)
-- Name: Customer; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public."Customer" (
    id integer NOT NULL,
    certification_no character(10) NOT NULL,
    name character varying NOT NULL,
    family character varying NOT NULL,
    father_name character varying NOT NULL,
    birth_date character(10) NOT NULL,
    gender boolean NOT NULL,
    identification_no character(10) NOT NULL
);


ALTER TABLE public."Customer" OWNER TO dbuser;

--
-- TOC entry 207 (class 1259 OID 16462)
-- Name: Service; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public."Service" (
    id integer NOT NULL,
    mobile_number character(11) NOT NULL,
    imsi character varying NOT NULL,
    customer_id integer NOT NULL,
    sms boolean NOT NULL,
    data3g boolean NOT NULL,
    data4g boolean NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE public."Service" OWNER TO dbuser;

--
-- TOC entry 206 (class 1259 OID 16460)
-- Name: Service_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public."Service_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Service_id_seq" OWNER TO dbuser;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 206
-- Name: Service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public."Service_id_seq" OWNED BY public."Service".id;


--
-- TOC entry 203 (class 1259 OID 16441)
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_id_seq OWNER TO dbuser;

--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 203
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.people_id_seq OWNED BY public."Customer".id;


--
-- TOC entry 205 (class 1259 OID 16449)
-- Name: postal_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.postal_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.postal_addresses_id_seq OWNER TO dbuser;

--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 205
-- Name: postal_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.postal_addresses_id_seq OWNED BY public."Address".id;


--
-- TOC entry 2843 (class 2604 OID 16452)
-- Name: Address id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Address" ALTER COLUMN id SET DEFAULT nextval('public.postal_addresses_id_seq'::regclass);


--
-- TOC entry 2842 (class 2604 OID 16451)
-- Name: Customer id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Customer" ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- TOC entry 2844 (class 2604 OID 16465)
-- Name: Service id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Service" ALTER COLUMN id SET DEFAULT nextval('public."Service_id_seq"'::regclass);


--
-- TOC entry 2986 (class 0 OID 16443)
-- Dependencies: 204
-- Data for Name: Address; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public."Address" (id, address, postal_code, tel) FROM stdin;
12	1933 Kropf Alley	7163175038	1562289156
\.


--
-- TOC entry 2984 (class 0 OID 16435)
-- Dependencies: 202
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public."Customer" (id, certification_no, name, family, father_name, birth_date, gender, identification_no) FROM stdin;
30	5067      	Else	Livvy	Newham	4752/72/85	f	8205446298
\.


--
-- TOC entry 2989 (class 0 OID 16462)
-- Dependencies: 207
-- Data for Name: Service; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public."Service" (id, mobile_number, imsi, customer_id, sms, data3g, data4g, address_id) FROM stdin;
14	10131155490	878861121092696	30	f	f	f	12
\.


--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 206
-- Name: Service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public."Service_id_seq"', 14, true);


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 203
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.people_id_seq', 30, true);


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 205
-- Name: postal_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.postal_addresses_id_seq', 12, true);


--
-- TOC entry 2846 (class 2606 OID 16509)
-- Name: Customer customer_identification; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT customer_identification UNIQUE (identification_no) INCLUDE (identification_no);


--
-- TOC entry 2852 (class 2606 OID 16470)
-- Name: Service id; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 2848 (class 2606 OID 16454)
-- Name: Customer people_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- TOC entry 2850 (class 2606 OID 16456)
-- Name: Address postal_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Address"
    ADD CONSTRAINT postal_addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 2854 (class 2606 OID 16482)
-- Name: Service unique_mobile_number; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT unique_mobile_number UNIQUE (mobile_number) INCLUDE (mobile_number);


--
-- TOC entry 2856 (class 2606 OID 16532)
-- Name: Service address_foreign; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT address_foreign FOREIGN KEY (address_id) REFERENCES public."Address"(id) NOT VALID;


--
-- TOC entry 2855 (class 2606 OID 16471)
-- Name: Service customer_foreign; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT customer_foreign FOREIGN KEY (customer_id) REFERENCES public."Customer"(id);


--
-- TOC entry 2983 (class 0 OID 16462)
-- Dependencies: 207
-- Name: Service; Type: ROW SECURITY; Schema: public; Owner: dbuser
--

ALTER TABLE public."Service" ENABLE ROW LEVEL SECURITY;

-- Completed on 2022-12-28 18:47:54 +0330

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Debian 12.9-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

-- Started on 2022-12-28 18:47:54 +0330

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2022-12-28 18:47:54 +0330

--
-- PostgreSQL database dump complete
--

--
-- Database "remote_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Debian 12.9-1.pgdg110+1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

-- Started on 2022-12-28 18:47:54 +0330

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2978 (class 1262 OID 16385)
-- Name: remote_db; Type: DATABASE; Schema: -; Owner: dbuser
--

CREATE DATABASE remote_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE remote_db OWNER TO dbuser;

\connect remote_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16411)
-- Name: people; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public.people (
    id integer NOT NULL,
    certification_no character(4) NOT NULL,
    name character varying NOT NULL,
    family character varying NOT NULL,
    father_name character varying NOT NULL,
    birth_date character(10) NOT NULL,
    gender boolean NOT NULL,
    identification_no character(10) NOT NULL
);


ALTER TABLE public.people OWNER TO dbuser;

--
-- TOC entry 203 (class 1259 OID 16417)
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_id_seq OWNER TO dbuser;

--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 203
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- TOC entry 205 (class 1259 OID 16426)
-- Name: postal_addresses; Type: TABLE; Schema: public; Owner: dbuser
--

CREATE TABLE public.postal_addresses (
    id integer NOT NULL,
    address character varying,
    postal_code character(10),
    tel character varying
);


ALTER TABLE public.postal_addresses OWNER TO dbuser;

--
-- TOC entry 204 (class 1259 OID 16424)
-- Name: postal_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: dbuser
--

CREATE SEQUENCE public.postal_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.postal_addresses_id_seq OWNER TO dbuser;

--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 204
-- Name: postal_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dbuser
--

ALTER SEQUENCE public.postal_addresses_id_seq OWNED BY public.postal_addresses.id;


--
-- TOC entry 2835 (class 2604 OID 16419)
-- Name: people id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- TOC entry 2836 (class 2604 OID 16429)
-- Name: postal_addresses id; Type: DEFAULT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.postal_addresses ALTER COLUMN id SET DEFAULT nextval('public.postal_addresses_id_seq'::regclass);


--
-- TOC entry 2969 (class 0 OID 16411)
-- Dependencies: 202
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public.people (id, certification_no, name, family, father_name, birth_date, gender, identification_no) FROM stdin;
1	5067	Else	Livvy	Newham	4752/72/85	f	8205446298
2	8826	Tracie	Olin	Azema	4415/36/57	t	2831760243
3	418 	Filberte	Dale	Ivory	9535/53/35	t	6597354276
4	7613	Wendell	Brigitte	Danielski	6775/89/61	f	2789277170
5	1052	Timothee	Cheri	Scotchmor	1220/89/61	t	103035760 
6	5736	Cookie	Mignonne	Ferrillo	3913/72/52	t	5987373176
7	356 	Brandais	Maurita	Mellings	0170/88/14	f	9514564123
8	3721	Renae	Cammy	Skala	4563/63/83	f	6714181833
9	1838	Isac	Angil	Korejs	9785/23/15	t	464451098 
10	9603	Aurora	Leigh	Olner	0481/79/02	f	2677085765
11	5504	Tansy	Griselda	Sleep	2439/79/14	f	2804476415
12	7479	Jennette	Willy	Demer	7830/12/12	t	8134284615
13	1677	Karine	Alasdair	Berrycloth	8339/16/49	f	4822418727
14	8678	Teador	Felicdad	Beade	3956/82/70	f	8155564673
15	2258	Ricca	Sara-ann	Schultz	8085/37/23	f	4544059581
16	2853	Eliot	Willem	Gascoine	1796/14/88	t	9744998745
17	7135	Tommy	Issie	Presidey	9731/27/21	f	940562833 
18	6806	Giustina	Ilene	Wands	7164/55/02	t	7824577867
19	6497	Evvy	Kristian	Kayser	4805/23/52	f	2680955597
20	2471	Collin	Lucinda	Levey	5453/74/98	t	9705995129
21	9354	Cory	Bjorn	Khomich	4503/82/75	f	537564518 
22	6852	Reynard	Maurita	Bromage	9903/14/24	f	9919691761
23	1800	Blayne	Leonhard	Lightman	7247/94/36	f	577991246 
24	660 	Evita	Peyter	Allott	1569/18/35	t	7266994416
25	6795	Fletcher	Eugenia	Guiraud	9988/56/96	f	5334681968
26	4720	Yorker	Rutter	Ramel	7354/70/41	t	9224658158
27	1494	Lucho	Donelle	Ioselev	3288/94/07	f	5012675713
28	279 	Devora	Consolata	Chesney	3185/03/20	f	6510813235
29	1274	Hobard	Bordie	Espinet	1817/72/63	t	6423584542
30	6749	Burl	Mikael	Vankin	5096/42/82	t	337896739 
31	493 	Janaya	Bobbye	Elvin	1990/43/53	t	8972048482
32	3380	Waylon	Kathy	Neward	8348/49/03	f	2589886565
33	8704	Sean	Suzanne	Millett	4508/19/63	t	7684128078
34	9050	Beryl	Ardelle	Kentish	4294/39/19	f	4444316219
35	1098	Maribel	Nellie	Lorek	2295/53/18	t	9272803053
36	5001	Duffie	Winifield	Alvaro	1494/79/15	t	9795084922
37	5664	Brier	Serena	Godspede	8121/92/53	f	8005680581
38	7614	Boycey	Hinze	Heddy	4583/26/84	f	6867652466
39	2338	Hilliary	Zsa zsa	Fawdrie	4274/72/43	f	656073892 
40	493 	Therese	Mamie	Ramiro	4308/85/94	t	6724672423
41	5666	Willette	Winny	Victor	2628/00/32	t	825672598 
42	3334	Denney	Phillie	Samett	0842/04/86	f	5596530050
43	69  	Dunstan	Fay	Ten Broek	9541/24/18	f	8352148452
44	5921	Ladonna	Hort	Beckwith	2047/98/48	t	4885827910
45	1445	Herminia	Kally	Lumly	1665/57/41	t	3068841068
46	7032	Karine	Fanechka	Clogg	5187/14/01	t	550546473 
47	9979	Addie	Leora	Caird	5496/35/99	f	9165429330
48	3213	Ilka	Fletcher	Giffaut	3983/20/92	t	3134224473
49	3333	Juana	Juana	Wimmers	6098/22/24	f	8859360509
50	9662	Moise	Patti	Surmeyer	6547/88/14	f	273934637 
51	9693	Koralle	Alejandra	Brittle	0395/17/33	f	9653988236
52	9056	Rabbi	Rickey	Kobieriecki	7876/30/61	f	7769459575
53	7667	Alec	Abagail	McIlroy	6706/86/58	f	2842489537
54	8294	Tully	Rabbi	Sprigging	2618/44/57	f	4307200692
55	7629	Tamar	Marianna	Fancy	8549/43/34	t	9206130537
56	8427	Feodor	Free	Duckerin	9617/40/01	t	3858722453
57	6825	Alina	Windham	Atyeo	3929/14/42	f	4749267895
58	7013	Bennett	Robinetta	Scrauniage	0433/08/88	t	487113688 
59	1413	Tucky	Jean	Kemmish	3694/16/32	t	8790386252
60	4707	Byron	Christan	Silverwood	7329/56/14	f	5385513809
61	9285	Oren	Babita	Milkeham	1770/22/94	f	6135799996
62	2338	Rogers	Giffard	Sanper	0175/62/03	f	8101383744
63	8740	Blaire	Jillene	Retallick	9797/28/36	t	3387044792
64	2697	Hugo	Filberte	Norheny	5720/18/14	t	1802564059
65	7970	Zelda	Kirstyn	Frusher	2358/75/45	f	1612585085
66	3972	Obed	Zebulon	Rainbird	9363/06/61	t	5306446445
67	4816	Anjanette	Lenna	Norgan	5324/13/49	f	2222702590
68	4936	Alissa	Judie	Neathway	6171/22/84	t	5700760856
69	1542	Penelope	Dorolice	Bein	3319/20/55	t	9712499948
70	7724	Dame	Jillane	Mucklo	6313/30/33	t	7262229868
71	6743	Currey	Francisco	Bardnam	6970/48/74	f	6593800456
72	3194	Lazar	Micheal	Hubbold	8177/22/05	f	429574271 
73	4547	Mendy	Kaitlin	McMechan	4947/75/17	f	7800933184
74	8214	Hallie	Fidel	Le Noire	9627/35/86	f	3937583754
75	1922	Penny	Neille	Kinder	9924/25/47	f	8030921952
76	7410	Annalee	Francine	Legendre	2166/58/43	f	9756058394
77	7720	Gregory	Terri-jo	Cargon	5018/71/70	f	6558017318
78	5813	Belinda	Rosmunda	Jonas	5851/35/07	t	9009777972
79	8826	Lia	Ethelyn	Allnatt	9775/59/90	t	8601717343
80	803 	Consalve	Bartholomeo	Otridge	9320/43/88	f	720544898 
81	1353	Griselda	Rozele	Szwandt	6144/93/25	f	8310813826
82	7623	Byram	Lavinia	Skacel	4114/23/48	f	5046980670
83	8410	Mollie	Devlen	Southcott	7430/69/44	f	3185888770
84	3082	Jamil	Laurianne	Shwenn	5833/58/83	f	4176366672
85	1882	Yorgos	Marris	Champneys	5755/57/83	t	2580306371
86	2972	Winni	Norry	Amiss	1839/21/96	f	1484099704
87	6089	Dollie	Gino	Bosward	3629/06/93	t	6365743274
88	6631	Maxy	Melisent	Perryman	9837/98/90	t	3059695308
89	9133	Phylys	Gwenneth	Clissell	8980/86/63	f	3693490921
90	6285	Maegan	Bertram	Molan	2106/23/31	t	1941791962
91	3384	Carmine	Georges	Wonter	4987/08/57	f	4678600868
92	3015	Lidia	Burt	De Domenicis	1321/18/77	f	1341511324
93	7603	Giselbert	Mitzi	Verdie	0678/06/75	t	6164381499
94	1991	Zandra	Barbaraanne	Kupec	3284/42/92	f	9931024459
95	5779	Jamima	Dorita	Peacham	5935/50/34	t	5998785187
96	8336	Neel	Cletis	Burkinshaw	5267/71/17	f	2875332899
97	4224	Sidonnie	Nefen	Leaton	2888/21/63	f	6839979922
98	8993	Merl	Rouvin	Flintuff	6859/28/58	f	2551838780
99	3624	Lombard	Garret	Flag	6258/34/10	f	9771626553
100	9302	Ailene	Alexio	Leynham	1915/51/93	t	2184530279
101	4346	Tabb	Hamid	Petchey	0477/37/64	f	3749946809
102	5366	Adan	Susannah	Skipper	3236/72/97	t	6342835227
103	4953	Shepperd	Harlen	Jonin	1960/14/63	f	2775926620
104	9937	Robin	Thornton	Franckton	7093/54/86	f	1022880341
105	3543	Lewie	Teddy	Ganiford	7348/65/98	t	6201453755
106	2781	Gordie	Gaspar	Matessian	3651/86/76	t	9403978674
107	5136	Barb	Troy	Di Iorio	9085/52/37	t	988369765 
108	5616	Belle	Rancell	MacPake	7743/08/63	t	9468087587
109	8989	Panchito	Kailey	Lipgens	5739/55/94	t	1492983171
110	9511	Christophe	Hobart	Dewhirst	5258/98/44	f	1797386640
111	7961	Tamas	Nana	Folshom	5061/88/37	f	7034572487
112	7573	Boy	Odetta	Stienham	0600/66/91	t	9879187784
113	7209	Darlene	Cherry	Witling	8803/59/28	t	1663925814
114	3918	Borg	Guss	Skule	1720/86/81	f	106192766 
115	655 	Cloe	Waylon	Pollok	3432/07/41	t	4406368205
116	1078	Davy	Hendrick	Dallan	5172/00/03	f	8783813648
117	7796	Darlene	Conchita	Davall	1477/14/69	f	9216687674
118	7082	Kayle	Dorrie	Polino	2832/29/68	t	6402785868
119	5093	Berti	Brook	Catanheira	8733/77/56	t	5979329353
120	9264	Claudina	Tory	Winkworth	4049/81/99	f	2427756100
121	3011	Cull	Bianca	MacAskill	5989/47/40	t	9583522731
122	3321	Eloisa	Foss	Jouaneton	1537/93/34	f	3314689092
123	7330	Jeana	Merrill	Chesterton	7701/57/14	f	7869797000
124	7745	Alvira	Ferrel	Goslin	8129/65/82	f	5571486713
125	8178	Raddie	Idette	Rathe	2286/53/04	f	7917391559
126	7865	Brnaba	Sarah	Andrey	9338/14/17	f	8110414412
127	6579	Dian	Rolland	Piller	0132/36/49	f	9873410152
128	9299	Victoria	Wilbur	Adamsen	2902/17/00	t	6895869   
129	8623	Godfry	Mariejeanne	Avarne	5145/11/99	t	5308617077
130	6245	Berti	Fergus	Fehely	8656/45/19	t	2227856222
131	1596	Jory	Krystyna	Chattelaine	7269/42/41	f	4439483506
132	4635	Delora	Delphine	Marquese	8068/10/01	f	7994126463
133	714 	Bartolemo	Vince	Winham	3041/37/72	t	6290094181
134	4471	Mavra	Oneida	Geal	0325/44/25	f	8976349935
135	2114	Donny	Leonard	Yakovl	8788/64/27	f	1661612561
136	9257	Bartie	Gabbie	Lomasney	7970/63/00	t	7247425626
137	3483	Sondra	Nye	Sweynson	2298/87/66	t	1089301442
138	3665	Candy	Dinah	Barrs	0491/21/23	t	6300530189
139	7407	Shurlock	Hamil	Atkirk	2219/97/58	f	4082219167
140	3134	Tallie	Brenda	Rehn	6918/62/10	f	566591470 
141	8877	Fabien	Shurwood	Massen	8760/48/54	f	7158028406
142	9043	Linnell	Patience	Cristol	8829/50/57	t	3934637013
143	4504	Elfie	Bethina	McDirmid	4320/96/19	t	5196016434
144	5034	Zacharias	Corny	Gino	8122/23/98	f	369316417 
145	2604	Clement	Emmett	Steffan	5241/56/89	f	3718430351
146	6780	Izzy	Minny	Rief	7676/55/02	f	8646902393
147	6423	Carolina	Hetti	Kidd	7439/14/17	f	5576385953
148	8122	Corri	Viviyan	Demare	6900/80/73	t	2835547724
149	9092	Guntar	Betta	Trent	5326/68/09	t	4556097968
150	649 	Brewster	Lotta	Guest	1015/06/38	t	9053643839
151	5451	Janet	Emma	Corse	2483/35/78	t	4092796523
152	97  	Reidar	Norah	Jendrich	0342/74/68	f	8003841445
153	5689	Gradey	Benjamen	Nelligan	0396/90/00	t	8248597955
154	2391	Buckie	Dianna	Radborne	0607/41/76	f	7905126880
155	4591	Minnnie	Rodrigo	Collinwood	7879/67/48	f	9693180153
156	2737	Kerk	Nona	Stowgill	3917/56/32	t	7132129148
157	6941	Mikol	Taryn	McCaffrey	7358/44/81	f	2468070352
158	2305	Sib	Olenka	Miguel	2755/10/32	t	6694569604
159	9050	Molly	Ivie	Bariball	8680/37/62	f	44241355  
160	3361	Grannie	Malina	Sture	7489/99/55	t	7655636715
161	4668	Ulberto	Tisha	Jellis	9055/91/83	t	2326942894
162	2284	Godfrey	Callie	Sibbs	3092/65/43	t	3186467995
163	6735	Natassia	Neal	Matzel	4107/19/26	f	2776958941
164	2666	Germaine	Carlye	Armour	4101/37/63	f	9466810511
165	759 	Veronike	Melinda	Spiller	8967/47/04	f	7653594225
166	4254	Chrystal	Sadye	Zum Felde	5641/52/73	t	1031180228
167	6747	Asa	Gilberte	Gritsaev	4178/66/45	t	4715054451
168	9163	Doralyn	Cari	Tranckle	9943/94/40	t	4960214736
169	934 	Cassaundra	Berthe	Bothwell	7904/21/13	f	7391430927
170	3323	Edd	Shannon	Mayoh	9789/06/21	f	4956447940
171	9585	Sidney	Steffen	Baxstair	7665/50/54	f	3448940964
172	1743	Jordain	Hadria	Merwood	7817/73/34	t	825944560 
173	7020	Vivyan	Teodorico	Gunderson	3664/74/33	t	6797220027
174	8807	Mathew	Kent	Lyptrit	3863/61/77	f	1590669181
175	118 	Winslow	Almira	Vowels	4324/76/34	t	403010904 
176	1085	Brittni	Wat	Monahan	2001/02/59	t	8472342001
177	6291	Dasha	Marrilee	Eynald	5315/81/94	f	7230924506
178	5915	Hana	Ruggiero	Elliot	2527/73/23	f	501294830 
179	5384	Danna	Clementina	Gagen	4479/28/89	t	8012810686
180	9363	Dorolisa	Eziechiele	Demare	1119/57/14	t	9430776066
181	6795	Sadye	Ray	De Blase	7895/07/21	f	8466584812
182	9541	Pattin	Cymbre	Otterwell	1970/08/13	t	3135310901
183	7587	Mel	Morey	Demangeon	3142/14/49	t	5252721389
184	8128	Cybill	Kassia	MacInerney	5875/34/06	t	299207377 
185	813 	Fritz	Carlin	Blumfield	2244/63/32	t	1938317467
186	6880	Mallory	Corine	Carrane	3645/03/74	t	9985200629
187	2676	Annette	Faith	Ferrotti	7057/81/60	f	4787319277
188	5687	Thorstein	Peg	Hearns	8981/96/44	f	2107087263
189	84  	Thelma	Steven	Oliphard	0468/59/02	f	1905814641
190	262 	Vonny	Lauri	Kenefick	5569/94/60	t	7346712986
191	4187	Augie	Edan	Jeandin	1658/43/56	f	4040552403
192	239 	Elmore	Cosme	Andren	1329/81/78	f	1738003090
193	4685	Hephzibah	Casi	Maslen	6802/87/69	t	8664934311
194	310 	Ernie	Jedd	Frye	9201/42/51	f	8475376684
195	3262	Gwenore	Salvidor	Zorzin	9107/64/91	t	8039385205
196	1267	Sarina	Conroy	Mapson	7064/07/47	f	9131555507
197	1594	Theodoric	Reid	McCrie	3863/53/43	f	2439133670
198	1513	Bertrand	Cyndie	Febre	9944/47/23	f	8199371778
199	8299	Alysia	Orrin	Pipes	3896/65/47	f	6944178164
200	8421	Donny	Sidonnie	Whistance	7380/00/50	t	6807530789
201	5385	Othilie	Jedediah	Shermar	4210/78/13	t	6191639217
202	3038	Eleanore	Beverley	Beagin	9988/75/37	f	4714038068
203	8511	Weider	Kissie	Eliet	2465/96/35	t	116120668 
204	1574	Garrik	Eldridge	Akister	2504/92/32	t	2344902122
205	8243	Kristopher	Joline	Dyte	9319/66/65	f	5812490367
206	8025	Eduardo	Cassi	Bulbrook	4759/43/28	f	8445196619
207	8922	Jeffy	Royall	Loughney	7184/07/04	t	6447275129
208	4881	Ddene	Kate	Yukhnin	1323/25/94	t	6229894323
209	8917	Garik	Ailey	Fumagall	7517/67/63	t	5793534775
210	9218	Griz	Hewett	Duchenne	7066/64/30	f	2894082709
211	540 	Armand	Nikolaus	Francisco	8373/34/52	t	6170227303
212	8457	Hermon	Sela	Pietruschka	0764/75/43	f	2435754821
213	4736	Druci	Andreas	Geall	4652/97/09	t	92224552  
214	3834	Weber	Maire	Thorius	7160/81/77	t	7282179726
215	6264	Torrey	Giffard	Bhar	3354/94/95	f	2564992699
216	5042	Garik	Issiah	Aspinall	0658/07/23	f	985367316 
217	1508	Kassey	Angie	Giovannacc@i	7532/52/43	f	6798517294
218	3297	Tatiania	Byran	Gayne	4568/44/47	f	4197535461
219	7354	Barnie	Stephine	Kemet	5729/97/48	f	772726627 
220	9387	Kaitlynn	Maureene	Munson	3876/80/61	f	6621190300
221	2644	Kalvin	Marylou	Merveille	8033/36/92	f	1706091005
222	7636	Tristan	Anni	Radenhurst	4922/49/50	f	8503373271
223	8906	Hewe	Margarita	Tottie	9338/03/74	t	1394716350
224	8989	Kai	Adelle	Wilbraham	5618/78/27	t	635646621 
225	5922	Gallard	Bartie	Gorham	2603/21/17	f	3370557589
226	9362	Christophorus	Liva	MacKonochie	6863/41/64	t	8864901736
227	1998	Justis	Doll	Stanyforth	0687/73/95	t	3711000852
228	2378	Carolus	Helen	Bourke	2774/20/44	f	2067869412
229	2305	Abdel	Jeth	Lovett	7148/80/71	f	5470738875
230	9948	Beniamino	Westleigh	Castro	2086/88/88	f	9137374982
231	135 	Rinaldo	Jessalyn	Flaubert	8494/37/31	t	9058902590
232	3799	Marco	Flo	Walrond	0945/13/14	t	2834046633
233	8438	Torey	Henrie	Aggus	3946/84/44	f	578064578 
234	3044	Monica	Christian	Rawes	4422/33/94	t	5596155538
235	8490	Ernestus	Fred	Smorthit	9348/01/43	f	5122481681
236	4802	Wren	Gaile	Gianasi	0601/82/45	t	3775449033
237	1982	Alexa	Hallsy	Johannes	5591/32/65	f	3362403658
238	226 	Ozzie	Grady	Tapley	4326/20/00	f	8183678481
239	6225	Sophey	Fawn	Follit	0827/99/24	t	211054183 
240	2441	Rudolf	Tremaine	Caesmans	7573/67/02	f	2465190081
241	552 	Carlynne	Fin	Danniell	9777/61/43	t	5377548602
242	1817	Eldridge	Revkah	Ewbank	4456/20/06	f	6756177996
243	2395	Theodor	Kelsy	Andresser	2353/80/24	t	5995379755
244	4064	Yettie	Stearn	Menico	0759/96/38	f	4574096844
245	2062	Gunilla	Myrtie	Postians	0170/51/84	t	2705616384
246	5333	Ingram	Nicol	Moores	7834/18/84	t	4597072858
247	3696	Dev	Nanon	Soar	7442/53/66	f	9044925750
248	5008	Karlis	Brandyn	Peppard	8910/67/84	f	5087426513
249	2216	Lila	Dante	Boakes	8918/02/84	f	7639508605
250	6707	Byran	Belva	Navein	2371/76/56	t	5438948960
251	5879	Taddeo	Hally	Booth	7530/45/20	f	3224984540
252	9798	Egon	Hewet	Rolinson	4308/61/08	t	1447795880
253	1639	Ernestine	Juliana	Stoll	5456/34/25	f	723905309 
254	3354	Dallon	Glori	Scrivinor	6382/64/70	t	2673284912
255	824 	Baudoin	Alvina	Feehely	4874/64/47	t	7930213783
256	4492	Dinnie	Philis	Jeanin	8883/40/43	f	1813075539
257	461 	Gerri	Oren	Colecrough	0655/38/50	t	9337465713
258	594 	Abbe	Dave	MacSweeney	8952/53/66	t	1318959832
259	4801	Zelma	Cristionna	Almon	5812/58/96	f	6570164837
260	4927	Nicko	Shaw	Clemmens	6582/60/77	f	4677906191
261	1615	Kale	Gerald	Keveren	0000/78/26	t	2384285611
262	3161	Shoshanna	Allan	Speenden	2990/37/06	f	3436373723
263	6335	Ryun	Cicily	Cumo	4456/92/74	t	5844061216
264	7845	Karine	Baudoin	Learmont	5268/87/21	f	9275139549
265	1872	Giles	Jamaal	Amiranda	2592/43/79	t	4757734452
266	795 	Charita	Benyamin	Kille	8190/56/44	f	8604322770
267	5407	Charles	Tomkin	Noor	1353/72/49	t	4119773615
268	9576	Portia	Meade	Ellerby	2277/68/17	t	7189682821
269	8291	Karen	Ian	Ivey	9007/16/76	f	5968302665
270	3869	Lorita	Keen	Burbury	4563/16/52	f	7239483919
271	1161	Rivalee	Elroy	Van Arsdall	1813/41/05	t	8057001621
272	254 	Isabel	Thoma	Belward	2601/55/23	t	8608373630
273	1870	Cary	Tadeas	Torrejon	7247/04/16	t	5362724100
274	1369	Brinn	Alverta	McGirr	3799/32/39	t	6154613005
275	1871	Katleen	Adrea	Bayle	7993/10/16	f	8692763699
276	4560	Aubrey	Addy	Jefford	9745/14/62	t	1702236934
277	2175	Ariel	Nicolea	Trencher	5798/03/05	f	1409299930
278	6577	Knox	Zilvia	Gouly	9666/32/57	f	1264607192
279	1855	Jamie	Garth	Mahon	6370/62/74	t	9367587921
280	6   	Demeter	Elnar	Risman	0383/65/56	t	6938486209
281	4464	Izzy	Rouvin	Rayman	5567/53/44	f	4717459850
282	6819	Hilary	Isador	Constable	1674/51/52	t	8513714053
283	1389	Bryant	Georgette	Lewzey	3018/54/68	f	1908014645
284	3829	Randi	Trevor	Boothroyd	6120/66/65	t	5188461502
285	5317	Armand	Jonathan	Goudard	1042/42/14	t	8162137458
286	2855	Yankee	Tana	Castellino	7318/13/11	f	4393975854
287	1220	Deedee	Kania	Sidebotham	3858/58/71	t	2036629378
288	2882	Iolanthe	Fannie	Drohan	8938/34/87	t	8091041541
289	3736	Way	Jarrid	Spilstead	1907/77/86	f	9652140346
290	9775	Rubie	Stoddard	Rainard	9589/95/29	t	4676720191
291	6328	Daphne	Cesare	Broseke	5574/26/49	f	5969373396
292	1509	Jolyn	Livvy	Marciek	6450/58/21	t	5343738527
293	6655	Zitella	Tracie	Dancer	0508/47/05	t	2735809907
294	906 	Katine	Rice	Ridler	4390/01/15	t	7271442672
295	3599	Joane	Burk	Tubbs	7988/72/20	t	8855440060
296	6141	Klaus	Joaquin	Samwayes	0164/27/70	f	1848298657
297	5496	Donnie	Anny	Blose	1647/27/76	f	9341405330
298	880 	Elia	Rheta	Lipyeat	5239/37/39	t	4547200531
299	7514	Thekla	Doug	Fronzek	8163/04/34	f	5744508848
300	5505	Abbey	Onida	Lowson	3484/86/51	f	3055805136
301	325 	Alyda	Veronike	Dolton	7935/03/35	t	2249796941
302	1937	Dee	Genia	Trice	2445/96/20	t	6429690607
303	7091	Korie	Puff	Gebby	6447/73/19	t	6183321287
304	1018	Alexei	Lebbie	Tzar	9252/84/44	t	2363843562
305	4233	Connie	Sisile	Seacroft	3539/10/25	f	1941008580
306	7784	Son	Caz	Souness	8915/23/41	f	2623864295
307	9033	Jacquelyn	Tabbie	Tester	1923/22/91	t	6070755956
308	6599	Loy	West	McNee	0533/91/62	t	5377843036
309	9535	Adoree	Nate	Brazier	9202/10/79	t	8358824158
310	9687	Ailis	Estrella	Lemonnier	3975/80/85	f	6727371441
311	491 	Zebedee	Cletus	Beeston	1772/99/53	f	9089106380
312	5170	Rani	Zebadiah	Tock	6942/52/69	f	6993126670
313	9448	Dael	Desirae	Jedraszczyk	8063/04/32	f	5823064071
314	1668	Alisha	Camille	Deverose	0517/52/49	f	6435420   
315	6660	Isidora	Gwyn	Yarker	7066/44/38	f	8891218839
316	5311	Hedvige	Trev	Mitie	1945/51/82	t	8004480723
317	1267	Karlene	Glad	Hubeaux	1909/66/26	t	9618276560
318	2545	Kaylil	Olympe	Perazzo	0566/74/38	t	7113897559
319	9960	Tara	Colly	Broszkiewicz	5110/33/82	t	1039580777
320	7279	Vinson	Augustin	Mainwaring	8966/09/32	f	8407660733
321	1640	Deva	Wainwright	Monard	7634/38/61	t	7470754843
322	4236	Ware	Lucina	Ardling	7094/73/74	f	2055323239
323	1560	Tatiana	Regan	MacKeever	2271/29/22	t	2112322633
324	5318	Elysha	Valencia	Thewless	0256/05/17	f	6306748225
325	41  	Celestyn	Morganica	Blindmann	7808/70/54	t	8100477891
326	7400	Waring	Agna	de Pinna	2073/77/86	t	3535012160
327	5346	Caro	Dagny	Dayment	7990/21/71	t	5750190535
328	7117	Zaria	Mead	Cockrill	1004/81/64	f	8432813742
329	8328	Amalea	Preston	Wilhelmy	9373/27/68	f	7076274037
330	3634	Levin	Ailee	Robjant	2044/86/86	f	7775096984
331	668 	Rodina	Lotty	Rummin	8555/02/90	t	2113835276
332	4201	Cayla	Elston	La Torre	1790/98/06	f	8349129709
333	1275	Bonita	Eileen	Alecock	3562/76/68	t	1312780007
334	6240	Fleur	Tobi	D'Elia	0108/43/34	t	2755464406
335	9212	Elene	Beale	Remer	4319/29/92	t	355565533 
336	120 	Nora	Elvira	Dimitrescu	8550/37/54	t	5624244803
337	1269	Hashim	Cacilie	Lorence	3325/10/28	t	8233337095
338	8800	Floria	Hort	Spillard	2437/27/54	f	9992541073
339	8739	Talyah	Jsandye	Skehens	3109/26/81	f	9359157352
340	6301	Gregorio	Maryjo	Rizzillo	4742/72/45	t	5609234284
341	7813	Charin	Marlow	Laste	8287/94/41	t	5112074906
342	325 	Tommy	Jeanelle	Riddett	2507/99/20	f	1549697187
343	7427	Joan	Gerta	Joscelyne	2647/21/91	t	8759276921
344	80  	Damon	Patricio	Frostdicke	7543/00/48	t	2358154429
345	827 	Adena	Teodoor	Oolahan	9884/92/43	f	381665627 
346	1891	Boyd	Willetta	Slight	7388/44/78	t	4081568234
347	1136	Cecilio	Kelley	Karlqvist	5249/96/25	f	5653516577
348	750 	Rosina	Ivie	Keenlayside	5703/63/20	f	5645131584
349	5296	Concordia	Alisa	MacCrosson	2099/84/71	f	9582034220
350	4350	Shelbi	Peria	Druce	7093/44/97	t	7371425678
351	539 	Keri	Albina	Beeres	2793/63/16	f	5831454821
352	7458	Susana	Alanna	Challinor	7934/05/69	f	3639493082
353	1572	Clem	Jared	Fabbro	2175/36/21	t	3630877387
354	8047	Trina	Iolande	Boow	5227/18/89	f	8967152555
355	6809	Dion	Velvet	Parry	0847/29/16	t	370633284 
356	122 	Marchall	Lyell	Boldecke	8712/94/18	f	7848895173
357	1609	El	Dew	Enrico	2264/68/72	t	1844355662
358	1611	Bryanty	Sari	Maase	6881/23/80	t	445974135 
359	6555	Marcelo	Guglielmo	Esselin	5192/43/32	f	9408864649
360	424 	Felipe	Christean	Guard	9659/01/11	f	1772294022
361	7727	Lynnell	Adrien	Gillson	6795/67/05	f	9174668347
362	1447	Henderson	Katharine	Brettell	5910/32/43	f	8748322974
363	4698	Reed	Gale	Ginner	9276/02/71	t	5570168127
364	8107	Fredericka	Sandy	Marzelle	2901/03/33	f	4654809034
365	4556	Morgen	Sawyere	O'Duggan	5993/07/13	t	7960225573
366	829 	Buddie	Yoshi	Harg	1318/22/65	t	9733580483
367	2564	Didi	Brigg	Butter	0692/72/65	t	1581742471
368	5847	Theodora	Clarinda	Weigh	2950/59/31	t	3457419884
369	7039	Tersina	Bentley	Brooksby	9426/49/39	f	9233120727
370	3901	Karon	Goldarina	Cregeen	1847/22/59	t	4640876584
371	3670	Brucie	Alicea	Sooper	5500/28/93	t	9669013076
372	9665	Steffie	Panchito	Bernardelli	1733/87/65	t	4558356501
373	4789	Xylina	Leela	Lodge	6997/27/99	f	5500923643
374	1885	Griffin	Glynn	Stanyland	7539/93/22	f	8761735755
375	196 	Guillermo	Corty	Harce	0254/41/89	t	5914890796
376	2003	Matilda	Amberly	De Bruyn	0042/91/48	t	8679146745
377	8885	Yorke	Horst	Gatchel	5491/52/51	f	2193496522
378	8604	Roberto	Ilyse	Lemme	5226/68/60	f	5017971216
379	7038	Danie	Jessalin	Allridge	7508/78/10	t	9672360758
380	9321	Dale	Elysha	Fowlds	1186/01/90	t	4416646026
381	8078	Gael	Romonda	Saltman	1382/67/87	t	3791318349
382	4265	Vance	Terrance	Benfell	3095/96/83	f	4968219682
383	5113	Dex	Sue	Weben	1830/33/44	t	3373026820
384	7167	Nerty	Gunther	Ortells	7393/37/63	t	6935184785
385	1360	Ally	Tommie	Cardow	2287/79/96	f	5178203727
386	9366	Kermy	See	Genese	0899/55/57	f	6666194502
387	3812	Huey	Guthry	Hulle	0186/63/62	f	3549703535
388	7102	Anya	Nerissa	Digges	7095/41/24	t	9389419674
389	6366	Don	Waylen	Lippiello	6084/34/75	t	1202493198
390	4269	Dionisio	Maryl	Kimmins	3187/39/23	t	8225975032
391	9825	Melisande	Nert	Rosensaft	9833/79/75	f	2236037232
392	8026	Lazar	Cedric	Beechcraft	5564/34/59	t	9445509907
393	8229	Glyn	Ronny	Barens	4080/05/74	t	8422706245
394	6777	Jessie	Gibbie	Pardal	2348/75/18	f	2966863767
395	8774	Boothe	Nevin	Jerdein	3178/88/25	t	1380987035
396	9342	Reggie	Brook	Larmuth	8881/03/50	f	8738683547
397	3839	Heda	Ty	Sandes	5262/37/39	f	9959322489
398	3095	Gearard	Wilek	Doxey	1894/93/34	t	5965489203
399	1195	Delbert	Kingston	Spenclay	2444/58/66	t	2087889287
400	162 	Park	Gannie	Dandison	8903/35/34	t	1278607074
401	8546	Feliks	Gardiner	Goodlip	1871/20/32	t	423566219 
402	9743	Kial	Lyon	Goodings	2907/00/68	f	7151196158
403	6929	Vivia	Cecilla	Housley	9231/84/59	t	7156463637
404	3579	Giustina	Bartolemo	Hackett	0501/48/50	t	5379677245
405	614 	Vinita	Emili	Skehens	0014/59/31	t	2419278848
406	6095	Ninon	Blondie	Jaksic	5327/00/77	t	5465850010
407	8442	Obadiah	Raynard	Choke	0263/53/47	f	6755477763
408	8071	Jesse	Karon	Bruckstein	8391/11/95	f	9203958568
409	635 	Gilemette	Guillermo	Spini	2423/66/37	f	7315694643
410	2558	Sterne	Stephani	Mabbs	8167/34/73	f	5016397711
411	1375	Ingamar	Gaultiero	Johnstone	8187/47/96	t	7578066711
412	9063	Krissy	Cob	Le Marquis	6945/97/30	f	842246338 
413	7575	Annnora	Major	Milton-White	0457/68/69	f	8894441378
414	2051	Eddie	Charyl	Blomefield	6665/40/34	t	6437215752
415	6941	Mireielle	Jania	Jedrys	8628/07/84	t	3776567691
416	8345	Lela	Grata	Reynard	1887/48/32	f	3889039061
417	2947	Osborn	Amalee	Storrock	9112/54/67	t	8107071839
418	4552	Cornela	Tremayne	Lorman	2218/39/37	t	5206501019
419	2665	Tamra	Pollyanna	Lahiff	9586/87/99	f	5895887961
420	1666	Charmine	Caspar	McKenna	8170/09/97	t	5375055387
421	3602	Karole	Lindi	Courtois	8777/87/40	f	9995466305
422	9589	Amelina	Gertruda	Coase	0140/43/69	f	1344460152
423	2583	Letta	Bibi	Jimson	8705/28/43	f	4733707682
424	574 	Karlotta	Eugenia	Duke	8494/70/90	f	3191402421
425	5585	Vida	Nappy	Thrush	7090/69/11	t	1273969026
426	4371	Cynthie	Hermione	Burchess	8842/59/56	f	4440469521
427	414 	Gabrila	Elmer	Prazor	6255/72/53	t	9627228189
428	2107	Neilla	Shell	Buckerfield	0758/58/64	f	8653420443
429	7762	Laney	Eadie	McGiffie	5042/20/43	t	3849839192
430	4045	Glenna	Aeriell	Gostage	9112/74/20	f	8499449665
431	7158	Zebulon	Gussi	Gutridge	1823/35/05	f	33208204  
432	2403	Manfred	Linette	Dollin	2513/24/73	f	9658012807
433	2839	Hagan	Kimball	Perkis	6086/17/13	t	763382033 
434	9307	Marabel	Coleman	Odams	7407/97/82	f	8256673111
435	4416	Bevan	Fletcher	Eldred	6455/04/89	f	4690245627
436	7489	Waldemar	Marshall	Whittles	0155/00/82	t	4871071130
437	5928	Burtie	Dale	Nesbitt	5512/02/69	f	5910159239
438	5696	Harley	Denis	Meadus	7714/64/88	f	7764145742
439	3938	Catlin	Julissa	Bromidge	9248/84/18	t	3675982472
440	9504	Brodie	Jobina	Coundley	9653/47/36	t	5512275759
441	8654	Brendan	Maxie	Connow	0892/02/86	t	4850136634
442	4006	Rafaellle	Tanney	Budcock	0363/66/74	t	6114962157
443	2964	Keith	Tallulah	Rostron	4672/02/53	t	4663960107
444	546 	Wenona	Lita	Kidman	3959/34/95	t	7710424517
445	5953	Roselia	Nadya	Syddall	0071/64/37	f	5091399034
446	3726	Eirena	Susy	Izkovitz	8685/89/94	t	144076836 
447	1912	Sidney	Aurie	Stockbridge	6774/99/71	f	226903629 
448	5205	Aleda	Rickert	Rissen	4073/45/66	f	3622231980
449	6522	Myrtie	Cristy	Fleetham	8074/43/01	t	5596585166
450	1599	Trumaine	Shayna	Bakhrushkin	5473/71/00	f	7598745392
451	6297	Raven	Aylmar	Swayland	3715/60/88	t	5062417967
452	2217	Saw	Bobbie	Greenig	9488/09/59	t	3971203857
453	6452	Mayer	Amos	Carr	5126/08/11	f	9841431512
454	2779	Malissa	Erroll	Yarrington	4163/74/19	t	2496387282
455	6302	Mozes	Helga	Bothram	4630/88/08	f	9518783076
456	1682	Phyllys	Ole	Settle	4406/84/97	t	655422034 
457	6125	Gabriellia	Rasia	Stoter	0452/07/29	t	8025604414
458	2051	Erasmus	Merilyn	Twittey	0777/94/86	f	8176896526
459	9798	Jaclyn	Agnes	Misselbrook	3652/61/10	t	3579953324
460	8283	Garrick	Malorie	Gammell	1715/45/31	f	4471137148
461	7831	Karisa	Charissa	Zecchii	9543/20/05	f	7976256175
462	6722	Isadore	Richmound	Badwick	9456/62/46	f	5864562440
463	2822	Claudina	Bearnard	Charette	5954/99/68	f	3174299318
464	3344	Gunner	Chane	Salthouse	8673/62/12	f	4912892119
465	2327	Fanchon	Roxanne	Zimmermeister	0405/10/76	t	6206591194
466	4965	Wally	Nancy	Floyde	9996/59/70	t	268083250 
467	4053	Bertram	Tedie	Di Matteo	2276/28/77	t	3252712037
468	6995	Biddie	Imogen	Capeloff	2504/09/77	f	6529991635
469	2393	Chariot	Wolf	Tester	2916/08/20	t	4860297384
470	4702	Quintin	Belinda	Lumby	4175/70/57	f	3442562633
471	4548	Jolene	Darleen	Burleigh	8069/24/95	f	9999163578
472	295 	Tasia	Hali	Padgham	3170/67/95	f	9981927096
473	3921	Lura	Hertha	Cottesford	4888/82/36	f	4887778827
474	2753	Jarvis	Charmaine	Symms	3152/23/53	t	6616071327
475	5755	Shawn	Huey	Richardsson	6615/99/32	t	8572608820
476	7700	Kevan	Ollie	MacCardle	4180/89/25	f	4123851488
477	9861	Kurt	Melodee	Buttwell	8407/47/21	t	5791742882
478	3734	Dwight	Tessa	Dalgarnowch	6769/48/87	t	4270068583
479	5492	Skye	Traci	Sinisbury	4894/24/91	t	9755719776
480	2366	Harri	Benjie	Bernardoux	3298/54/22	f	758090593 
481	7434	Finlay	Nancee	Gready	2847/04/29	f	1664728494
482	2742	Florence	Ephrayim	Downe	5166/52/94	t	7812219161
483	4531	Chiquita	Ethelyn	Suggate	4648/11/05	f	2963816585
484	130 	Rhett	Brynn	Spraberry	4947/05/63	t	9546154149
485	9572	Michale	Kingston	MacGilmartin	5898/47/48	t	1477261496
486	336 	Hodge	Maje	Jiranek	4148/15/15	f	2859251752
487	9221	Reynard	Fonsie	Stiller	0590/28/09	t	6845755127
488	6323	Homere	Noah	Wickling	4376/28/62	f	4449507645
489	6132	Reg	Hanson	Grece	7520/03/60	f	4385948437
490	3006	Celeste	Owen	Corbyn	7962/14/93	t	2799532097
491	2360	Any	Timi	McGiff	7584/19/79	t	543278699 
492	754 	Giorgia	Felizio	Carnall	4269/18/87	t	8552370316
493	5666	Hi	Licha	Bolan	9889/67/05	f	3933085345
494	8394	Ivonne	Rozanna	O Sullivan	1094/63/40	f	3896729379
495	968 	Gael	Kiley	Yurchenko	2915/60/03	f	8785841126
496	6861	Aylmer	Tobi	Jager	0535/70/98	f	858914755 
497	9763	Richy	Emyle	Zmitrichenko	7371/74/11	f	6664558342
498	332 	Milt	Gardner	McAloren	6838/94/79	f	8721226134
499	6993	Ellerey	Sibeal	Curley	9688/22/95	t	5136855464
500	5009	Alta	Tomi	Sandes	3194/69/11	f	4499643660
501	9997	Keeley	Svend	Ousley	0351/61/59	t	1472662480
502	3035	Joscelin	Elwira	Shinfield	9445/81/36	t	8091668218
503	5370	Katerina	Hercule	Gookes	6233/67/40	t	9648570162
504	5742	Melody	Atlanta	Bellward	9512/47/47	t	4537536353
505	8609	Bertie	Rogers	Pachta	5492/64/27	f	3863773972
506	2684	Adela	Miner	Mundow	2793/97/24	f	763493378 
507	8163	Bear	Hugo	Coulton	6829/20/25	t	3854135105
508	7257	Olimpia	Forrest	Jelkes	7750/37/06	f	195832983 
509	5760	Tobit	Gifford	Zylberdik	4131/13/10	f	8305660766
510	7955	Christiano	Marylinda	Paridge	3510/18/41	t	5737319382
511	5446	Deva	Camilla	Verni	6301/24/58	t	8355328010
512	7866	Stevena	Dom	Cuzen	8605/51/31	f	1832323046
513	3720	Minnaminnie	Andria	Parsons	8615/54/21	t	4512171907
514	6258	Pamela	Chan	Garbett	7285/60/14	t	3313517993
515	7331	Marta	Babbette	Mellenby	1046/09/27	t	3223075951
516	8895	Rois	Ardyth	Topley	2489/98/69	t	5590741326
517	7178	Brion	Jacques	Sore	2572/87/09	t	834207257 
518	1726	Tricia	Stella	Garmanson	7590/58/14	f	1031109385
519	4568	Everard	Tomkin	Kemer	6357/22/32	f	5600452050
520	789 	Jeno	Morganne	Marian	9991/01/23	f	9832941727
521	1428	Lydie	Cesaro	Romand	0163/52/81	t	4308494281
522	134 	Caresa	Timmy	Chessil	3770/10/96	t	1452505500
523	5030	Moina	Kasey	Asbury	1496/88/81	f	1183141961
524	7657	Eugene	Hashim	Boissier	2184/87/97	f	724903240 
525	7179	Flor	Kristan	Simcoe	5818/73/97	t	9440283160
526	1516	Isaak	Norene	Cogswell	7297/72/57	t	6305855054
527	2451	Any	Irma	Bodill	5037/97/11	f	8649969318
528	2566	Eadith	Nichols	Denerley	4277/02/14	t	2965542131
529	4710	Melanie	Culver	Creswell	2896/32/31	t	3319041829
530	4588	Major	Sigmund	Woodnutt	7456/70/59	f	7205304728
531	7073	Jackie	Laraine	Habeshaw	3872/14/31	t	2390939555
532	6534	Maressa	Cynthea	Alywen	4269/64/48	t	9060125961
533	7136	Tabbi	Blakelee	Salomon	2205/46/34	t	669708582 
534	7657	Tarrance	Darin	Cansfield	2843/83/29	t	8212385205
535	8583	Lani	Jarred	Itzcovichch	2227/68/43	t	1899804410
536	7929	Jule	Zacherie	Gayle	9365/08/53	t	7203087793
537	8031	Felicity	Alleyn	Shout	4214/50/77	t	2703753440
538	2088	Pippy	Vachel	Gianneschi	2229/63/87	f	5263539469
539	6020	Garrek	Briny	Gilstin	0486/17/35	t	4296474599
540	3651	Eustace	Dur	MacDermand	7921/37/27	t	4057186565
541	6096	Garrett	Tammy	Hirtzmann	5459/02/47	t	4722139716
542	9841	Micaela	Davidde	Hew	1873/76/66	t	4085352654
543	3882	Clarinda	Eamon	Lace	9576/68/31	f	712116498 
544	7885	Mirna	Sarine	Sillis	1477/30/89	t	3146662862
545	5941	Reynolds	Aubry	Elsey	6152/84/69	f	9537744086
546	3609	Myra	Gabriel	Pomphrey	8165/63/02	t	470425813 
547	1126	Herc	Cordy	Abazi	2329/28/30	f	5097459368
548	6843	Hercules	Shelly	Dennis	6579/36/37	f	3200572160
549	2372	Emma	Dagny	Speedin	2097/67/33	t	1392544151
550	9645	Angelia	Annabel	Gridley	3608/51/39	t	3722161305
551	5452	Marabel	Wadsworth	Aarons	2692/24/84	t	9287921565
552	1931	Carlin	Pietra	Berrycloth	9629/49/14	t	7245004106
553	9507	Carmelia	Christian	Billo	1910/26/04	f	4669702181
554	4285	Byron	Hatti	Newlove	9979/88/41	t	1075477577
555	771 	Cobb	Nadeen	Venediktov	1771/93/00	t	977684497 
556	1545	Teddy	Perkin	Lundbech	2469/32/16	f	829107006 
557	4916	Ardelis	Jilleen	Sarath	4867/10/94	f	5384085961
558	690 	Farley	Ludovico	Silverston	1845/76/20	f	1123092437
559	9650	Bevin	Kaja	Commin	9993/75/02	t	6753579666
560	4282	Gerald	Ardene	Dullard	8477/72/28	t	1887351701
561	6543	Ugo	Joelly	Rushworth	7658/96/37	f	3369729353
562	1122	Dun	Gertrud	Hawkridge	7874/80/47	f	502429733 
563	4268	Chev	Zachery	Munnis	5822/24/56	t	8072565838
564	5512	Kenneth	Jermain	Montrose	5794/15/14	t	7901263199
565	9164	Diarmid	Mercedes	Biggs	8289/49/68	f	7394543298
566	7578	Cobbie	Rees	Kebell	8511/17/81	f	3622017804
567	2661	Timofei	Sher	Rablin	5032/32/99	f	438579779 
568	2234	Marie-jeanne	Trix	Evers	7539/72/32	f	4343539877
569	5384	Justen	Alastair	Lavis	3800/78/82	t	2257755988
570	7783	Smitty	Claudetta	Wing	1629/09/04	f	8275153905
571	1700	Yale	Darrelle	Turri	0666/25/64	t	9025722388
572	7545	Tallie	Brandea	Matejka	0840/77/30	f	7968348166
573	2066	Jacinda	Torrie	Agar	1731/15/76	f	8004326123
574	5871	Nikola	Goldy	Czyz	0108/05/85	t	1120574202
575	8042	Marybelle	Abel	Tregido	1216/90/52	t	7762043183
576	490 	Nicolai	Brooke	Fillgate	8320/80/53	t	193970458 
577	4233	Bing	Bennie	Purple	9573/14/34	f	215342088 
578	8088	Kelcy	Curcio	Nesfield	3837/14/91	t	6468487047
579	5477	Paulina	Trever	Prium	6699/53/08	f	9295466177
580	829 	Michelle	Wildon	Rozenbaum	9498/13/49	t	3405080659
581	3467	Alyse	Lorine	Jolly	5609/97/18	t	5131749825
582	2044	Bernetta	Guillema	Dagnan	3712/89/37	f	1704699681
583	680 	Rodrique	Karrie	Hardie	0620/53/65	f	6156970230
584	7959	Georgia	Erinn	Giacovazzo	9824/63/54	f	8339790959
585	6230	Hestia	Fiona	Phipp	6663/45/90	t	6570047822
586	9531	Alley	Gal	Proom	8129/03/85	f	5697893797
587	695 	Jennette	Earl	Weiss	7962/63/07	t	8898730440
588	8470	Daphna	Viviana	Eales	3672/62/61	t	8944553671
589	6060	Dorry	Jennette	Brinded	6548/73/87	f	4384389214
590	6727	Korie	Ruthann	Fickling	5016/20/51	t	3345276357
591	2945	Cornall	Juliann	Beavis	3519/82/76	t	6486899117
592	5706	Wandie	Ameline	Jouhandeau	2400/95/43	t	2495910331
593	3040	Krystalle	Garik	Dory	7772/95/14	t	9275494013
594	9202	Oralie	Vidovik	Libero	0729/55/79	f	5368022127
595	5217	Emmott	Myrvyn	Tenant	6165/59/72	f	225188673 
596	5301	Ki	Whitby	Wickson	3210/93/56	t	274523999 
597	7351	Ambrosio	Quent	Pymm	9265/64/14	f	9715720899
598	6266	Genni	Itch	Dilon	6481/36/99	f	9774251634
599	9307	Phillipe	Dianemarie	Adam	9061/09/50	f	5242961307
600	7984	Wolfgang	Elbertina	Gelderd	2901/19/63	f	8638077099
601	3646	Worthington	Evaleen	Titta	5042/63/90	f	2887593246
602	7160	Nicol	Dianne	Thrasher	0725/22/43	t	850057492 
603	5299	Jeth	Sada	Alban	0981/74/44	f	2514499289
604	1822	Leeann	Mel	Clutterham	3004/54/21	f	4953130767
605	3392	Margaretta	Laverne	Byas	2247/30/47	f	5221251756
606	8861	Bernete	Othilia	Yetton	8999/75/08	f	3079542638
607	3424	Clarice	Ware	Manville	8059/47/91	f	8817333396
608	3372	Lily	Carlyle	Dunston	4491/18/61	f	6210261330
609	3116	Felice	Denni	Jennison	7894/20/33	t	8231152381
610	1996	Marley	Petr	Cornner	4931/01/01	t	9516638548
611	4981	Milo	Aigneis	Bowkley	3204/96/98	t	7679452708
612	265 	Conny	Angel	McGuire	2447/28/43	f	6271297013
613	2713	Janek	Joni	Stapele	3766/32/49	t	990706959 
614	9335	Jeramey	Carlina	Slane	3011/94/67	f	4936068266
615	2057	Carlie	Elizabet	Chipp	9277/13/72	f	5838198021
616	4282	Jeffry	Burk	Scoyles	1398/60/13	f	4898066038
617	9049	Kippy	Paxton	Seeler	8452/72/61	f	3279977424
618	6592	Rosco	Tanner	Congreve	9799/39/26	f	3205539333
619	2829	Carilyn	Tobi	Macieiczyk	9957/34/36	f	7574573130
620	4561	Emery	Juieta	Danick	7169/74/80	f	2568869976
621	1948	Ogden	Bidget	Steely	3042/60/72	t	6915616896
622	6536	Flor	Sam	Trevers	1558/50/05	f	9575357837
623	6019	Cleopatra	Revkah	Soutter	0291/09/72	t	3655979787
624	2594	Rafi	Doralia	Brockway	5614/67/65	f	9781543961
625	5924	Siffre	Zane	Widdows	1084/85/08	f	5987822535
626	8917	Morly	Vachel	Parsonage	5125/98/24	t	7850614873
627	6856	Audrey	Jorge	Tome	4623/84/59	t	8174149641
628	7886	Blythe	Brietta	Whitcombe	6606/16/41	t	8835964093
629	4752	Foster	Siobhan	Diack	4603/78/13	f	8772094797
630	6212	Jehu	Lara	Toolan	9847/91/08	f	3674862841
631	1528	Cleavland	Ravid	Syseland	4261/47/43	t	7005023303
632	8983	Mathian	Cyndi	Clears	3512/42/27	f	5033853354
633	9700	Randee	Alphonso	McGeagh	5849/28/08	t	6675175822
634	650 	Carola	Tabor	Ossulton	4677/59/42	f	418877268 
635	3674	Mike	Cherry	Winckles	3013/79/36	f	7714751219
636	5417	Rossy	Leslie	Watchorn	1205/66/80	f	8631116093
637	9114	Pepi	Alvin	Bannester	4927/95/34	t	9759632415
638	7502	Irita	Patty	Pandey	3936/25/30	f	599600330 
639	3693	Dulci	Georgeta	Britt	3705/06/57	t	9791847875
640	6468	Joline	Ailsun	Wackett	2960/31/61	f	3465080336
641	4545	Olly	Miguela	O'Carrol	7083/78/90	t	3515600887
642	8293	Melina	Dulcine	Lorenzetti	3457/77/89	f	2404212757
643	1046	Sibel	Marianna	Sedgwick	3209/53/63	t	9176124883
644	205 	Kipp	Marilyn	Proppers	1357/13/43	f	9834679650
645	2641	Tremain	Margeaux	Cusworth	5938/59/02	t	7516673587
646	3944	Roarke	Hadlee	Redbourn	4988/99/96	f	9392384256
647	5062	Perkin	Myrle	Dalgleish	2292/94/47	t	8056379171
648	5674	Nora	Brear	Fellos	4187/69/77	t	2384688192
649	3238	Lucita	Antoni	Petrolli	3892/19/31	t	9357658139
650	7543	Henka	Kial	Scoggins	0639/69/77	f	3515505443
651	5923	Ebeneser	Reyna	Rickerby	5653/24/00	t	6116193742
652	1036	Brena	Claude	Birrell	2230/09/74	f	6473922248
653	8829	Nanon	Link	Dunk	0754/04/33	t	2060043902
654	1127	Hayward	Elias	Geane	0800/78/12	f	6698816102
655	2968	Davidson	Cortie	Oade	0015/24/27	f	2842536689
656	9960	Peggie	Harland	Andreev	6490/60/54	t	5310318629
657	8740	Boniface	Brittan	Duckerin	1837/52/85	f	9785920123
658	6520	Wilow	Delcine	Philippson	6700/13/40	f	9262894618
659	8236	Lionel	Elisha	Sharpe	6302/94/12	t	1662059512
660	8489	Rinaldo	Tarah	Scopyn	7219/25/30	f	4335155283
661	6606	Mart	Chrissie	Millward	9944/65/34	t	7825241058
662	6657	Roxie	Georges	Caselick	4941/84/50	t	2710811572
663	906 	Aleda	Abie	Bjerkan	4844/76/55	t	3744659580
664	530 	Beverlie	Sanford	Rapkins	2442/61/47	t	9164068862
665	5599	Ketti	Anderson	Maffezzoli	3268/00/25	t	3772524546
666	6384	Otes	Emelita	Offener	1300/07/12	f	2794089220
667	886 	Elly	Skipton	Rocco	4140/07/12	t	1587810154
668	5373	Orelie	Kayley	Shotter	6923/92/70	f	5549776582
669	3498	Luca	Karla	Blose	1661/64/35	t	2118511984
670	7976	Leslie	Rozalie	Daunter	6067/75/93	f	7972423262
671	3884	Aloin	Nerti	Giddy	2894/68/43	t	7595718926
672	3079	Boone	Florry	Maylor	6793/12/51	f	2931318581
673	7031	Verena	Dolph	Frise	2494/36/90	f	2798329424
674	5493	Zenia	Agna	Jalland	4044/32/16	t	5152313878
675	1419	Shelbi	Marnie	Landeg	1300/39/59	t	7499265359
676	4629	Paulie	Hyacinth	De Maine	5670/21/00	t	9158713312
677	4091	Robinson	Ronnie	Lewing	9958/12/63	f	6641040932
678	8097	Davida	Fredericka	Clough	1963/65/79	f	8056711435
679	9729	Jacquelynn	Modesta	Mattingly	5271/25/15	f	2379324343
680	5749	Lira	Guthry	Yerill	0934/89/79	t	9419765868
681	1472	Stu	Kandy	Turpey	6256/89/31	f	7920480731
682	5735	Pace	Harrietta	De Benedictis	8189/85/37	f	7292032453
683	841 	Franky	Maisey	Eustis	5276/15/38	f	2772833962
684	4500	Tann	Marty	Aizkovitch	1474/20/24	t	9561077562
685	7106	Cristine	Jammal	Shillabear	6333/83/65	t	8750228301
686	5318	Peterus	Garrek	Grocott	0902/15/89	f	4151023799
687	4811	Neils	Cullie	MacGhee	9920/10/86	f	8427990477
688	365 	Monika	Kasey	Yendle	4120/39/91	f	1544833414
689	3179	Dacie	Antonina	Pigden	7915/69/56	t	3671997982
690	2979	Randy	Benjy	Whetnell	9453/30/05	f	9229077315
691	6626	Stephine	Jessie	Ludwikiewicz	0635/80/81	t	6452910257
692	6047	Jorgan	Christos	Beacroft	8979/43/22	t	2107016778
693	6203	Crawford	Renault	Cannop	3415/39/08	t	6421461322
694	8426	Odella	Elladine	Wilkins	0206/65/59	t	7786429683
695	1198	Susette	Scottie	Christoffels	6017/58/48	f	577943657 
696	7957	Eddy	Jonah	Cranmore	4305/08/42	f	6758534521
697	8294	Edmon	Sari	Laviss	0728/74/79	f	6248674852
698	9759	Esra	Leda	Robottom	0107/99/98	t	5127945017
699	1452	Humphrey	Nathanil	Huebner	5750/40/27	t	2899349533
700	1373	Nevil	Bruno	Claire	0877/79/97	t	1295082019
701	4268	Ragnar	Nikki	Yakebovitch	5050/63/74	f	8210860512
702	4592	Erasmus	Abbott	Weson	8678/76/34	f	9566676356
703	1963	Hamil	Brook	Haylands	6285/78/95	f	2228751710
704	1570	Robbin	Giuditta	Chesshyre	2679/44/95	t	9897335693
705	30  	Bessie	Lainey	Buessen	3675/39/68	t	7665210835
706	5716	Asa	Tina	Boom	2261/40/73	t	9654196065
707	8126	Amargo	Bing	Lawther	9537/88/27	t	1219653136
708	5002	Sada	Donelle	Merner	8115/68/16	t	7633641611
709	6998	Amandy	Olive	Wyeth	5331/38/77	t	4181383465
710	793 	Pearl	Brittney	Hinchon	3635/93/30	t	6739133366
711	6986	Judye	Philipa	Boshell	7760/75/26	t	183223695 
712	7588	Silvano	Leann	Curnokk	9194/89/08	t	8150270223
713	6877	Inger	Damiano	Schachter	0006/50/83	f	3118763470
714	5768	Elsie	Aurelia	Mathias	0176/38/19	t	8323369507
715	4607	Trent	Dewie	Stanlick	0337/46/98	t	6227725939
716	6831	Donny	Wiley	Kiefer	9511/58/75	t	2744308751
717	2162	Holmes	Lemmie	Clewett	2852/39/08	t	9963547550
718	1307	Marcie	Viviyan	Woodwind	1261/50/41	t	3334381868
719	7985	Mel	Maren	Robuchon	7709/14/93	f	4768382600
720	596 	De witt	Ellynn	McKane	6629/95/05	t	4991814359
721	5114	Jonis	Grenville	Bodechon	2463/12/91	t	118253330 
722	1799	Horace	Mignonne	Cheatle	6556/52/46	f	762475804 
723	7584	Desirae	Yancey	Napoleon	1094/03/24	t	6258507453
724	4682	Goldina	Nappie	McGow	9702/88/76	f	683112027 
725	2984	Coleman	Palmer	Sipson	9481/11/37	t	3014640354
726	4709	Aggy	Flint	Mizzi	6055/50/89	f	6958195560
727	7929	Gaile	Babette	Northbridge	7649/95/57	t	4226370143
728	8795	Harald	Filmore	Pistol	9549/69/44	f	7386978547
729	9861	Timothee	Far	Eltune	6171/32/75	f	7377402553
730	4022	Renard	Obadias	Shepheard	0098/41/26	t	675577642 
731	3994	Rubetta	Erika	Lakeman	5541/44/47	t	4347837475
732	7490	Calhoun	Rosetta	Bortolazzi	3033/09/94	t	8655222501
733	8351	Lisle	Crista	Heims	2894/56/23	f	8570112380
734	7548	Aguistin	Thaine	Andrzejowski	8023/95/60	t	8086482002
735	1020	Jonathan	Ernest	Davidovits	5402/96/48	f	6307737892
736	4838	Jeth	Rosanna	McGeechan	8752/43/61	t	1355284900
737	7056	Clarke	Hulda	Riccardi	1122/76/72	t	1178039201
738	906 	Patience	Cloe	Parren	2488/75/40	f	6385248702
739	8083	Munmro	Brigitta	Maulkin	3395/99/05	f	2888610845
740	7238	Rikki	Parry	Lumsdaine	7751/82/96	f	275863543 
741	6424	Willi	Kaine	MacQuaker	1378/91/31	f	7980833739
742	385 	Pauly	Gan	Cocks	4459/69/54	t	5129584992
743	3723	Johna	Jodie	Gossington	2544/57/30	f	9442128231
744	2745	Gardie	Lanna	Sute	4329/97/81	t	7478400979
745	3591	Brantley	Brigitta	Szimoni	0903/61/98	t	5801163166
746	9455	Tricia	Cindra	Mabb	4457/97/90	f	231420686 
747	1738	Marve	Jen	Maciak	7547/25/51	f	4990060143
748	2391	Mildred	Ailey	Woosnam	3842/14/42	f	3954939634
749	4425	Norrie	Franz	Rablen	3621/88/47	f	9308540057
750	3740	Miguel	Berni	Rahl	7594/24/34	t	2067624960
751	9618	Wolf	Margit	Oakes	2751/30/06	f	3379419781
752	1308	Caro	Darrell	Clampin	9646/01/93	t	9025200054
753	7652	Charity	Grier	Lockner	2605/79/63	f	1534265743
754	3825	Rheta	Whit	Troup	1451/90/28	t	9224845392
755	6869	Kirbie	Tiffy	Lanceter	5657/91/93	t	8902639018
756	6360	Alyse	Jacky	Maris	7400/96/33	f	3138832802
757	8546	Joete	Gregorius	Catterick	0096/02/19	f	7419144788
758	5029	Willis	Ericha	Simonnet	8649/65/80	t	58782684  
759	2919	Geri	Nadiya	Espinet	2918/08/99	f	9426421377
760	497 	Dorolisa	Constancia	Fishlock	6546/16/56	t	1768920916
761	2244	Zahara	Blaire	Stevens	6765/58/96	f	9827912390
762	6159	Lauren	Adora	McDirmid	2043/15/97	t	3927450618
763	7425	Gilberta	Stevana	Royans	0330/44/03	t	2800063287
764	3526	Glynnis	Ottilie	Syred	8394/96/45	f	2365410058
765	1954	Merle	Hube	Cossam	0970/01/66	t	3578101130
766	8536	Rollie	Judye	Clulow	2156/12/86	f	5988196478
767	7368	Patten	Modesty	Lockey	5335/98/42	f	1204117665
768	2435	Malissia	Peri	Cowdry	5263/99/34	f	8297245800
769	49  	Mag	Madella	Paolozzi	8037/10/15	f	6470653114
770	6   	Trefor	Effie	Gottelier	1332/75/28	f	9984444675
771	2947	Silvio	Kimmie	Jochens	7372/74/75	t	8302793538
772	7627	Babara	Daniel	Swindon	8820/36/04	t	9358268958
773	6456	Clayton	Timmy	Annakin	4713/76/42	t	3758365841
774	8890	Clair	Glad	Dobble	4858/35/68	t	6828716378
775	5916	Mufinella	Eleanora	Lavell	3801/19/16	t	5326615265
776	8481	Megen	Glen	Lalley	1472/66/40	f	9847649305
777	4578	Morrie	Susie	Cottom	9725/46/07	f	9211470915
778	2258	Arlen	Hanson	Chevolleau	4043/18/55	f	6285449840
779	9143	Wilfrid	Chelsae	Tallman	3811/59/44	f	9119597702
780	9307	Koral	Debbi	Soall	4629/32/83	t	7468361229
781	8043	Gaston	Melly	Mompesson	4043/28/51	t	1074272016
782	4195	Shelden	Bron	Kolczynski	3848/10/06	t	5828389952
783	2926	Bartholomew	Brenn	Hulstrom	0159/98/22	t	6488497487
784	7849	Jami	Clem	Farey	6628/99/51	t	4948252014
785	6845	Trude	Domini	Hovington	8500/27/06	f	9103017392
786	2148	Beitris	Merrilee	Jochen	0827/29/21	f	2012448752
787	4231	Neely	Sher	Hanley	0627/68/59	f	6905562741
788	7275	Barnebas	Herrick	Boog	8635/07/66	t	3208888174
789	8145	Thaxter	Chris	Rhydderch	6641/88/47	t	171127398 
790	1443	Maitilde	Tildie	Tetford	7265/79/46	t	8984351043
791	736 	Georges	Joaquin	Wix	6444/37/08	t	9121765852
792	6411	Kai	Jessi	Swyne	8340/68/28	t	5335737806
793	5969	Eben	Nerty	Cayser	6449/10/13	f	1491730670
794	2231	Linnie	Enrichetta	Labbe	7929/62/35	f	6644298721
795	4041	Robby	Christiana	Cassells	5273/76/77	t	6104392127
796	4468	Finlay	Adrien	Antoniak	7198/32/45	f	8531893942
797	4283	Camellia	Bibi	Arden	5306/91/36	t	6557534359
798	2151	Alvinia	Royce	Cass	9072/53/98	t	3435594602
799	1988	Barbe	Lucho	Gooden	2025/09/12	f	2397929043
800	705 	Haslett	Fredric	Gummow	8775/25/04	t	3216553758
801	2046	Galvin	Huntlee	Clohissy	8021/64/61	t	3476661798
802	6694	Felicle	Ernesta	Flintuff	4027/95/21	t	9179032368
803	6888	Lynn	Calhoun	Antrag	5045/38/59	f	6382903863
804	7525	Lacee	Barry	Morando	1598/74/92	f	2297342400
805	8914	Antoinette	Jaquelin	Collin	5990/63/94	t	1268796026
806	2954	Carny	Bayard	Edward	3738/74/27	f	1532353183
807	8308	Cristy	Rozalin	Dummett	0548/88/70	f	5637995082
808	7268	Margery	Genovera	Fisbey	4123/10/13	t	9183931011
809	6544	Bel	Myrta	Burmaster	5702/49/30	f	8950615629
810	221 	Kynthia	Elysee	Snugg	1076/03/17	f	7467599206
811	8336	Kinna	Linzy	Urian	3248/02/05	f	6111758308
812	7154	Arda	Wilden	Langelaan	2805/03/43	f	3648786991
813	9260	Nadya	Lyon	Willisch	0492/96/22	f	5614139926
814	9804	Ellary	Marsha	Easlea	1523/57/81	t	497606136 
815	8856	Deana	Rhiamon	Bilsland	5863/51/03	f	8083309540
816	850 	Karly	Ninette	Beakes	0738/98/93	t	1793203088
817	5942	Beatriz	Doloritas	Leyninye	4490/50/53	f	2768337233
818	6417	Faunie	Shurlock	Gange	4147/30/19	t	7742748739
819	1472	Kaile	Francisca	Netti	2699/17/04	f	373929971 
820	5606	Enrique	Maryellen	Caddie	9854/46/98	f	9649472940
821	6481	Natty	Elaina	Loveguard	3895/45/97	f	1078329921
822	9067	Theobald	Padraic	Asmus	8661/45/73	f	5398567532
823	6041	Gregg	Kip	Ceaplen	5726/67/07	t	2043097270
824	6616	Sammy	Kimbell	Layburn	7257/58/08	f	3401693788
825	4193	Amabelle	Eberto	Mills	5260/03/99	f	1160356104
826	4706	Dulcy	Mitzi	Darbon	9127/78/21	t	2066130707
827	4450	Ruby	Agnes	Trighton	8059/16/89	t	2122132643
828	1170	Ulrich	Bevan	Pennaman	8036/19/42	f	9868657205
829	6556	Harriett	Darb	Pavis	5447/85/28	f	7629643975
830	619 	Jan	Shea	Carass	4583/30/83	t	3060617940
831	6108	Phyllys	Yancy	Falco	4506/87/43	t	5322208647
832	2432	Lowe	Sandra	Beesley	7545/10/48	t	2696872775
833	5861	Ricky	Elga	Iffe	9513/03/60	t	7982830735
834	1420	Oates	Ephraim	Claasen	0182/95/67	f	3530910213
835	1790	Melisande	Lannie	Whitecross	9392/68/96	t	6538682444
836	2601	Sayre	Basilio	Ambrozik	2050/29/34	t	9661901101
837	1015	Lillis	Ora	Oganian	4106/82/73	t	3294406217
838	1538	Whitby	Kanya	Swetmore	2821/96/21	f	2376265877
839	9151	Dona	Roosevelt	Beever	6972/99/92	t	7460549441
840	5263	Marcelia	Laurette	Gianolini	4075/80/53	t	7321133954
841	9050	Vyky	Caz	Darnborough	4481/95/63	f	5353124482
842	4283	Lauralee	Julian	Pilgrim	6770/39/57	f	4535806005
843	1915	Charleen	Daryl	Gaishson	1902/00/61	t	2547930499
844	9404	Jeannette	Deonne	Oglesbee	2855/52/35	f	6187756991
845	3421	Marillin	Noella	Lestrange	8393/81/29	f	4889339392
846	8081	Dane	Kath	Sandwith	2734/64/79	f	9169622000
847	5803	Blake	Chauncey	Simpkiss	7590/25/84	f	5019684612
848	588 	Reuven	Danita	Forst	2333/39/98	f	2695621640
849	7731	Tandi	Nessi	Levene	0534/48/93	f	6518592995
850	3738	Alvan	Edee	Wadie	8625/35/15	f	8852525895
851	5241	Wolfy	Shir	McGuff	5165/81/34	f	9249166641
852	4606	Thalia	Hedy	Hacon	7179/95/45	f	9500925617
853	2918	Neda	Aguste	Cammell	0929/29/04	t	2999124342
854	2900	Emanuele	Samara	Callear	9452/36/43	f	4256679635
855	5257	Phillie	Yasmeen	Geharke	8576/13/16	f	2927834268
856	331 	Benedikt	Rem	Blomefield	5574/14/48	t	6870881575
857	3994	Rafael	Alexia	Murfin	3082/73/34	t	3359347281
858	4868	Enrica	Tatiania	Smylie	6440/31/60	t	1164212915
859	4605	Gerta	Livvyy	Norton	5521/56/01	t	1819000957
860	1481	Kayne	Uriel	Schwerin	4762/59/16	f	5346452765
861	4765	Vlad	Barbra	Stanlick	1120/02/55	f	6706351996
862	9991	Caddric	Nealson	Sweett	7994/66/66	t	9147462763
863	8285	Katleen	Christina	Greswell	8973/59/10	f	7580549042
864	9970	Elfie	Garrott	Tellwright	6427/94/83	f	6568373263
865	5227	Merna	Giovanni	Aveline	7948/71/98	t	9933291933
866	7112	Chev	Artair	Bemlott	7229/63/10	t	3497707617
867	5431	Tresa	Obadias	Walasik	7880/04/20	t	2062123476
868	9406	Maggie	Edi	Ruggiero	1420/15/72	f	8961306786
869	8905	Karlens	Francklin	Elvy	4882/64/50	t	753029491 
870	7227	Pearl	Melisent	Croley	5545/24/54	t	5074659730
871	6310	Wainwright	Eli	Ramberg	1290/79/05	t	7974669518
872	3443	Nelie	Aloysius	Bengefield	6734/13/43	f	785188602 
873	2519	Kate	Hy	Imorts	9169/79/72	f	7648269704
874	8855	Guy	Gaye	Scanes	3916/80/15	t	6506332205
875	1749	Olag	Andras	Delatour	5883/22/00	f	1003692996
876	3541	Fredric	Erna	Gerriessen	8166/82/92	f	5638550636
877	9446	Gunner	Holly	Lippatt	3069/81/48	f	8283713373
878	2770	Muriel	Yorgo	Edgworth	8956/66/02	t	8412860451
879	7585	Terri	Lorine	Hriinchenko	7894/41/99	f	2652220540
880	1036	Norman	Moll	Selley	2195/30/86	f	6652636944
881	2557	Teddie	Washington	Kirsopp	8065/82/81	t	1689748663
882	5848	Buck	Deane	Geater	1086/21/91	f	3398984150
883	9545	Regine	Giffer	Blindmann	7903/07/72	t	7249712102
884	9163	Brittan	Aylmer	Kinnett	2977/79/05	f	9931861845
885	7685	Martin	Giacopo	Dorrell	5364/99/03	f	2176854094
886	7175	Vlad	Clay	Blackstock	3275/13/90	t	3452502132
887	5854	Oralia	Nonnah	Syddall	9855/58/97	t	3967132227
888	7062	Melamie	Carole	Hugill	3994/91/53	t	9014730468
889	5898	Teena	Omar	Ginley	1057/03/98	t	5927273221
890	2656	Allys	Spence	Halpine	9412/66/19	f	8971039807
891	8204	Aimil	Kermie	Knowler	7013/68/78	f	2336535053
892	6884	Fredrick	Madelina	De Roberto	6537/27/42	f	6562815762
893	2888	Thedric	Mora	Halbeard	5012/12/25	t	7403170311
894	5599	Mariel	Ynes	Pauly	1892/41/69	t	8132342104
895	3060	Hazel	Danice	Schiesterl	2060/05/10	f	8912530437
896	7884	Gabriel	Becca	Temblett	6827/22/07	f	3406763496
897	2817	Ashley	Fayette	Leroy	6042/18/67	f	2079955956
898	3879	Nathaniel	Chadwick	Gallegos	7608/10/77	f	8282371782
899	9490	Julie	Eva	Blackader	9947/90/29	t	9170026509
900	8417	Patrick	Mercie	McGrotty	7108/10/18	f	7967558661
901	2905	Loretta	Othelia	Hanscom	8504/49/54	f	7615174002
902	2007	Sherman	Berky	Januszewicz	5421/43/82	f	5705550214
903	3204	Nadiya	Aubrey	Dunmore	6856/81/65	t	9835902213
904	8785	Thibaut	Audrie	Rockliffe	9176/64/88	f	4110121356
905	2980	Abbye	Gasper	Guite	4285/22/01	f	7715314857
906	6317	Barbabra	Jeni	Domnin	5145/92/08	t	9235823605
907	8352	Sherrie	Kally	McCotter	1776/25/75	f	4605852798
908	911 	Maybelle	Erick	Osgordby	3900/35/97	f	1332295507
909	4916	Bernie	Kelila	Fonte	1468/62/64	t	3199990233
910	5472	Vin	Frederigo	Genty	8927/67/05	f	4827128591
911	8702	Martelle	Agnes	Casewell	1783/24/45	t	1264796588
912	3840	Benson	Marcellus	Padgham	8717/69/70	f	1944411013
913	6285	Joanna	Svend	Acors	2014/51/90	t	9936355027
914	6176	Eloise	Modestine	Prettejohns	0250/23/16	t	9350622273
915	5925	Melvyn	Eleanora	Norway	2187/68/72	t	6435275619
916	1435	Mitchel	Fawnia	Kearn	1195/50/96	t	2211417988
917	5631	Renado	Holly	Stormes	3516/84/14	f	3962752182
918	2436	Tiler	Laura	Wixon	0962/25/45	t	9320130828
919	2681	Ingelbert	Sioux	Tunuy	2178/63/66	f	9467707605
920	8076	Oby	Lydon	Duesbury	8346/18/32	f	6367184713
921	2214	Gabrila	Shaine	Redman	2388/35/83	t	5157485317
922	7887	Nissa	August	Raigatt	9474/80/58	t	2625153234
923	3674	Hermina	Ahmad	Waud	2659/93/76	f	1591588376
924	521 	Abramo	Tedman	Falconer-Taylor	2645/00/41	f	4376029731
925	1150	Margaux	Kynthia	Soles	8616/65/84	t	9860026763
926	9727	Lucius	Denny	Brose	1603/19/50	f	8589665485
927	4567	Alasteir	Svend	Horley	9085/70/42	f	6443832488
928	3576	Roxine	Gerome	Boow	3463/66/78	f	3558390631
929	9469	Therese	Norine	Polleye	2161/14/69	f	7479355615
930	3640	Sosanna	Anabal	Paramore	1309/15/38	f	875202067 
931	4397	Brinna	Alessandro	Eudall	5900/25/95	f	5299936918
932	4059	Kimmi	Nicola	Vinnick	1376/23/91	f	5032594734
933	1985	Lind	Collen	Bleby	5771/39/04	t	7136459265
934	3391	Darcey	Kirbie	McColl	6474/96/67	f	4864502800
935	7765	Tyler	Rebe	Sives	6139/23/77	f	4800093716
936	4874	Armstrong	Melanie	Kaaskooper	8810/71/62	t	72439083  
937	2605	Bailie	Tarrance	Clay	1051/17/98	f	7262686283
938	7744	Arley	Bryant	Hazlewood	5970/37/69	f	4822658210
939	6506	Alasdair	Thorin	Lintin	7570/98/46	f	7979549668
940	7287	Lilly	Nicolas	Strotone	8782/84/05	t	4471561092
941	3488	Teddy	Ahmed	Barkus	5457/02/61	f	8877522012
942	2832	Modesta	Roxane	Langeley	9283/02/08	f	3942364071
943	7562	Aldus	Asia	Vickerman	2794/88/96	t	1729694375
944	1874	Anetta	Jordan	Stelfox	6559/39/41	f	2413631662
945	9653	Rosabel	Jerrome	Bolstridge	6199/34/40	f	7594131430
946	3762	Jeniffer	Towney	Blainey	9821/92/74	t	6107328846
947	6159	Melessa	Stirling	Harnott	7576/64/18	t	6262678540
948	9414	Rogers	Marta	Breming	9233/37/43	t	4283480809
949	2249	Loralyn	Salli	Bonellie	1673/34/16	t	6915042374
950	7764	Kali	Leora	Eteen	3247/30/57	f	5763939652
951	468 	Jessi	Gregoor	Bootman	4530/69/66	f	1705371202
952	6163	Kizzee	Lesli	Pagden	4744/72/49	t	4008632475
953	3616	Pauli	Gae	Christescu	4097/98/82	f	3796259183
954	5082	Ricki	Onfre	Haugeh	0046/38/85	t	6272031029
955	1618	Chrissy	Sherwood	Perl	5427/33/10	t	3629624430
956	5270	Joyce	Elladine	Jovovic	3204/34/23	t	778417640 
957	9036	Benyamin	Vladimir	Wilse	3621/40/90	t	3336869435
958	4481	Carline	Guido	Regina	3308/39/65	t	2994053596
959	2797	Bondon	Persis	Hundy	3843/26/61	f	133699177 
960	8038	Elly	Amalle	Keywood	7019/82/26	f	3461492906
961	7884	Garwin	Thibaut	Manuele	6976/97/62	f	7520405964
962	391 	Geoffrey	Zola	Firks	8557/99/34	f	6188243323
963	6769	Terra	Vivyanne	Myers	3936/35/29	t	6740255853
964	335 	Jaquelin	Dalila	Bythway	5600/21/26	f	6436269559
965	2907	Cecelia	Ayn	Ferriday	4772/84/72	f	1205608422
966	6593	Karita	Ailina	Petrushkevich	9802/98/31	t	4542649467
967	7307	Nickola	Alphard	Solleme	3343/43/01	t	2164282052
968	5529	Cristina	Roanna	Brehault	2132/57/42	f	5943707391
969	4744	Abbye	Angelina	Waller	0015/29/83	t	8624664628
970	5318	Kathie	Lon	Hixson	3649/66/42	t	3716331526
971	9458	El	Wolfie	Osburn	2684/72/21	f	8660400315
972	6446	Kari	Aldrich	Egre	3434/77/94	t	4091311587
973	6551	Gelya	Elspeth	Ceaser	9702/29/19	t	166829264 
974	2903	Brant	Tito	Ikins	2406/76/69	t	1338999130
975	1165	Karol	Broderic	Meineking	7702/16/44	t	1792477890
976	1096	Wolfgang	Lem	Mil	1120/41/61	t	1495266002
977	7423	Lia	Jill	Lavell	7572/09/82	t	4968472739
978	6929	Gerhardt	Tomasine	Nellis	7685/40/47	f	4731333370
979	7606	Chrisse	Ron	Cow	8006/41/36	t	6164617141
980	8540	Elisha	Kerrin	Kimberley	8190/39/38	f	8726886622
981	997 	Lucretia	Nolie	Blackney	5141/04/35	t	2321347550
982	5630	Boote	Agata	Bansal	2144/06/19	f	6975095116
983	5516	Guglielmo	Cassondra	Gatesman	6871/59/51	f	8033638981
984	5425	Teddi	Saunders	Ferrotti	2089/64/30	t	4846867389
985	8100	Livvy	Marcy	Quixley	1915/06/72	t	2280021989
986	6198	Celie	Whitney	Illesley	2990/68/14	f	9568281057
987	3453	Joella	Bea	Robrow	3816/61/26	t	6337889125
988	6942	Matteo	Starlin	Cahey	0434/77/18	f	1968689264
989	9208	Hersh	Claire	Moultrie	3348/66/42	t	3190779572
990	4638	Lila	Pierce	Aimson	4044/70/32	t	4248888308
991	7884	Clemmy	Zacharie	Thome	8957/97/20	t	8221666760
992	9876	Husain	Ricky	Bour	6616/75/03	t	6627810665
993	480 	Clint	Spike	Dohms	2401/92/96	t	6156902241
994	3984	Katheryn	Briggs	Riseborough	1714/76/23	f	5434004246
995	8231	Rubetta	Rosamond	Kemitt	7342/60/99	t	5856424980
996	9104	Raine	Freddie	Armfirld	5287/30/14	f	7390049153
997	6886	Tommie	Joseph	Wetherhead	0844/01/61	t	1424569733
998	7400	Gerrie	Callida	Ekkel	9738/48/96	f	8673596624
999	275 	Krystalle	Tildie	Aseef	4635/78/77	f	9897839774
1000	9392	Gaspar	Roarke	Greggs	8080/41/89	t	51057400  
\.


--
-- TOC entry 2972 (class 0 OID 16426)
-- Dependencies: 205
-- Data for Name: postal_addresses; Type: TABLE DATA; Schema: public; Owner: dbuser
--

COPY public.postal_addresses (id, address, postal_code, tel) FROM stdin;
1	1933 Kropf Alley	7163175038	1562289156
2	74 Hoard Park	3127934719	5367451892
3	19 Mendota Way	1092356074	3221905931
4	846 Shasta Plaza	9916618743	7753497068
5	8374 Rusk Court	427272349 	5769682905
6	8 Myrtle Junction	7544791418	3778841172
7	72 Commercial Park	3124389388	9561332280
8	70702 Eastlawn Avenue	6009959478	2642728199
9	456 Warbler Court	6246191454	2706014263
10	91933 Straubel Trail	4944964330	3949493244
11	1660 Center Way	4014148349	3828212529
12	69232 Kings Road	9441854670	9479624431
13	763 Park Meadow Lane	769417890 	6081353590
14	351 Oak Valley Junction	3010684927	5364674555
15	655 Farwell Place	3231465657	1557807922
16	5 Lindbergh Circle	410601018 	3341789481
17	20 Nelson Way	2208951472	9713193389
18	2759 Bonner Crossing	3315485359	1948915211
19	519 Columbus Parkway	5375320287	6805525895
20	75313 Paget Avenue	5862378475	6542021227
21	882 Raven Crossing	7669043544	1528863308
22	82 Superior Pass	922776435 	1658629004
23	0610 Kinsman Junction	4752933992	7931069417
24	67 Nancy Drive	807287182 	2659428808
25	8319 Esch Park	663532744 	2438541967
26	3397 Derek Hill	9645301410	8593900423
27	88 Annamark Road	7482729176	1435360834
28	0540 Marcy Park	2993981426	4838945223
29	89 Utah Circle	1101337819	1912632659
30	26 Longview Terrace	6800493809	7986577549
31	590 Springview Road	5294586427	3118614315
32	8 Florence Plaza	1494243059	4739260168
33	94227 Judy Pass	8568627917	5419229192
34	0930 Hanover Circle	4132842709	4057470795
35	8 Arrowood Hill	287352347 	5136978265
36	595 Montana Point	9585860011	1512772988
37	04 Almo Point	2674716247	9703962288
38	6 La Follette Way	6026675051	8907168191
39	146 Kedzie Hill	524605904 	4717928475
40	44 Ohio Parkway	2710677423	4093454913
41	7970 Karstens Lane	8205881401	2192646429
42	39 Emmet Crossing	5175541695	5506603147
43	6142 Holmberg Lane	5078799994	8172305091
44	7476 Stephen Trail	57829204  	2172292841
45	0953 Pearson Circle	4792532550	5274005731
46	7 Gulseth Court	9360437488	6111362652
47	410 Union Junction	8902825091	6463321594
48	10 Onsgard Terrace	5179863876	5502506707
49	1 Drewry Road	9910647301	1208739984
50	9918 Burning Wood Crossing	5200595285	8698203915
51	9964 Cherokee Trail	4789549667	6538101168
52	3 Mitchell Lane	9628106676	1068147808
53	788 Schurz Parkway	9285726014	3668746008
54	93044 Carioca Place	2469574459	6204331587
55	785 Sundown Crossing	5846909665	8141598140
56	12492 Rutledge Lane	6366301398	8855685075
57	806 Calypso Alley	3386060940	1936486067
58	93 Columbus Crossing	8522192221	3196022821
59	8 Merchant Junction	9310713739	2445713313
60	9112 Eagan Crossing	182346698 	7648814064
61	0 Bartillon Place	8648240151	3533288284
62	972 Dawn Street	3810400015	3052077094
63	37 Dottie Junction	1447630749	4869009058
64	12 Algoma Street	2804784280	1856903418
65	009 Bartelt Plaza	5491212900	8444402930
66	0 Northwestern Terrace	6494299329	5669632163
67	42 Tennessee Parkway	3085186764	7221708870
68	94 Novick Parkway	2572833475	4843396056
69	75938 Cascade Park	2124408662	5894255746
70	138 Glendale Crossing	6463125805	6252240127
71	0 Vidon Parkway	9846501968	1966363844
72	6477 Fremont Crossing	7975820383	7487641298
73	46 Tony Street	1761122041	1309903173
74	9 Sunbrook Court	9593625962	3511883133
75	49 Bunting Trail	5176911866	3149448180
76	5727 Claremont Court	6222401435	7574026295
77	55 Columbus Center	8075827444	7706048755
78	8482 Grim Plaza	7419542001	7872797606
79	76 Paget Street	1817930841	8365434697
80	5161 Garrison Drive	1361669798	8513523091
81	13 Hagan Road	2240294157	5721680658
82	86 Monica Hill	4634801079	6755354216
83	9 Maywood Way	9052262374	4444924822
84	528 Algoma Place	3859702393	2137308190
85	781 Donald Terrace	5656419991	8574094551
86	5 Farragut Road	8219898786	6349017293
87	350 Blackbird Crossing	2899510371	9545130986
88	4 Dakota Street	5702167316	3125630893
89	2580 Lakewood Parkway	6162779455	4505209560
90	7 Delaware Lane	6469720803	4614744074
91	3 Sugar Point	3547972104	2539041652
92	1 Kipling Park	1679477847	3245202893
93	040 Autumn Leaf Crossing	7715892332	3179233412
94	80 Colorado Alley	5935205505	5155230023
95	944 Eastlawn Circle	1910650329	6494378391
96	2283 Caliangt Drive	1860268136	8766154542
97	9410 Almo Center	3487989073	7078099973
98	1 Carioca Alley	3700285612	4212411032
99	3443 Magdeline Court	6800151145	4012495613
100	850 Oakridge Alley	8148487010	9372388899
101	1491 Michigan Hill	3935880561	7557783339
102	0396 Schlimgen Point	1596709220	3756802114
103	82608 Hayes Parkway	6611074286	7407185273
104	0180 Old Gate Terrace	4967225379	7389712900
105	19 North Alley	5437980983	7778004249
106	90345 Mallard Park	8560931713	4026782367
107	6605 Brentwood Point	6820732726	6038980136
108	4877 Hagan Junction	7819776006	6169671112
109	3078 Alpine Parkway	5782916653	4196328993
110	79 Bobwhite Lane	2881927391	6188339687
111	634 Michigan Avenue	3172715771	9436700970
112	283 Glendale Crossing	566259913 	2072149611
113	4 Burrows Road	6045680293	2373040455
114	828 Holy Cross Court	6936809520	4993024781
115	0979 Karstens Hill	8329355030	8064422252
116	4 Mosinee Point	5889699888	3672354175
117	5 Nevada Plaza	9967106782	9808176688
118	0 Dorton Place	8759507155	5293160966
119	5633 Utah Plaza	4235382812	4669659752
120	0600 Everett Junction	6118652511	7466042278
121	236 Nova Avenue	8722964644	1647923808
122	76 Buhler Circle	4063876130	6047604502
123	70067 Blue Bill Park Way	1791228148	9983030747
124	7774 Lyons Center	3530746960	5937290489
125	8611 Londonderry Place	9106254942	6434465269
126	48 Doe Crossing Terrace	9797017855	2585352741
127	9798 Reindahl Court	4021433400	9994907844
128	86657 Kim Hill	9249325569	5469630681
129	99 Erie Alley	9640337383	9349665495
130	427 Heath Junction	63428020  	7242862273
131	08561 Northview Center	6805247992	8881749329
132	7693 Del Sol Avenue	4709717640	3979106150
133	3873 Heath Crossing	1086950760	6906362226
134	1 Southridge Point	9300757423	2898387110
135	680 Morning Avenue	9773214564	5847420756
136	8976 Ilene Point	4745070308	6036703438
137	8521 Graceland Lane	2417635599	2708063517
138	0289 Lawn Place	861777229 	1337250712
139	129 Roth Plaza	3947681068	7516004907
140	8618 Donald Center	9630947546	4537223621
141	9676 East Street	1102503139	1568564706
142	7 Huxley Trail	1242527639	8344342039
143	660 Longview Hill	4401495639	3403464789
144	271 Katie Street	6476286218	2065757656
145	24 Nelson Plaza	2433839580	7694776458
146	3 Carey Hill	4593596517	7429941575
147	911 Annamark Pass	8186828671	7049611476
148	001 Sloan Lane	7855766938	4405763079
149	796 Westridge Pass	5379348447	5845948324
150	900 Fisk Place	3698522937	9367574131
151	6 Marcy Trail	1305885685	4462596915
152	2919 Village Pass	8569884712	8442336455
153	5 Buell Terrace	6180914445	3315924819
154	4067 Gulseth Pass	9681267215	5397271459
155	2 Granby Pass	2446026003	7161655969
156	70957 Parkside Street	823488546 	6771726534
157	7568 American Lane	5351228607	9318489703
158	09650 Bultman Point	5795128832	2297924795
159	0966 Prentice Hill	2659937944	8582806226
160	981 Bellgrove Drive	2040627594	8547909720
161	745 Sachs Junction	7945864253	1338781295
162	310 Bunting Trail	7622775991	1925703024
163	267 Fremont Crossing	944318833 	8881734678
164	87 Sunbrook Hill	6132461617	9911304889
165	39 Petterle Road	1610523611	9972455806
166	32 Reindahl Avenue	6203928130	3079709986
167	2938 Eggendart Court	6561918504	2919608508
168	77 Pearson Center	9434012490	5472239096
169	57 High Crossing Circle	2171608353	1883329280
170	7233 Lien Avenue	135825269 	5122575538
171	288 Onsgard Center	2995655808	4651481419
172	71 Montana Street	9007688372	7822012120
173	9170 Butternut Point	9868043112	3183485245
174	27475 Schiller Place	3644371068	2806334272
175	38 Graedel Alley	4094494568	7661881898
176	8655 Upham Alley	3743320949	2625705679
177	4574 Prairieview Plaza	7251751350	1209746074
178	03547 Hudson Road	4442113185	1892237058
179	59 Westridge Terrace	3243358723	8725113914
180	11353 Karstens Plaza	1312176000	2062190651
181	24 Pennsylvania Terrace	1467650462	4755828752
182	52 Spaight Parkway	2562287618	3141500011
183	37922 Burrows Road	5485034470	4594704036
184	4131 Golf Trail	4641340329	7712822425
185	673 Havey Alley	7892075905	6533555327
186	2 Autumn Leaf Court	2643409337	4092702363
187	94553 Pankratz Junction	9433298177	1082221120
188	1860 Sunbrook Center	8656622792	9505309250
189	82569 Stoughton Place	9960458273	6015438609
190	2019 Corry Way	3661426041	9852280550
191	43 Bultman Street	9245875871	5143495195
192	36260 Bellgrove Alley	4914001918	1135964310
193	4799 Heath Circle	1127363879	2658843369
194	54 Donald Hill	1733120694	8326823724
195	4118 Knutson Place	1607573051	7764549402
196	4 Marquette Pass	3807273265	3516070601
197	2 Eagle Crest Street	2077857118	4388574804
198	01526 Waywood Road	5981902719	2532779014
199	220 Novick Circle	3156201045	5049774064
200	674 Memorial Place	5333627153	2358839150
201	77013 Starling Plaza	8170706179	2951358868
202	3122 Prentice Drive	3007415320	5872023351
203	79980 Bultman Way	6424827961	6412486246
204	68173 Shelley Avenue	4716370989	5336125705
205	3887 Susan Park	2094513373	4812087453
206	854 Ridgeway Drive	8869393919	3676255369
207	214 North Road	3319780426	5875255277
208	1353 Moose Court	6559059112	7716836559
209	09 Mcguire Junction	7069094737	7738317877
210	125 Darwin Parkway	9397182029	8189302037
211	11619 Rockefeller Hill	3381027410	6153985681
212	5856 Ludington Street	4057080888	4242205945
213	6 Vernon Way	7637393889	5579022972
214	6115 Dovetail Parkway	7151551797	2259173306
215	1456 Monica Avenue	4867671228	5902259067
216	928 Bonner Court	6683650762	9861427882
217	6219 Lakewood Avenue	7706600019	3649553782
218	53345 Michigan Center	5504934447	2263001537
219	0 Fisk Lane	982548627 	5372080067
220	63572 Texas Point	1169260725	8334513809
221	955 Spaight Alley	7707309343	7111592330
222	717 Steensland Point	5683322474	6828792406
223	586 Claremont Trail	6076560277	8569837492
224	298 Hazelcrest Terrace	1396482356	1293566132
225	93 Clemons Park	9716733135	2789952545
226	2386 Sauthoff Terrace	1656920952	1914130312
227	05 Gulseth Street	9052416277	3507182192
228	278 Manley Crossing	8806913638	2829103321
229	09683 Killdeer Alley	6975408183	2458537383
230	43 East Center	3656393943	6461373858
231	7936 Sachs Alley	1632142600	4676671689
232	7 5th Alley	5591962695	8192572676
233	39 Delaware Drive	226144668 	8097330006
234	83165 Village Green Street	377138419 	2491615792
235	6372 Birchwood Parkway	6732641849	8735200397
236	03245 Armistice Plaza	4881955466	4695368720
237	27 Springs Court	1347300192	7447950718
238	987 Petterle Trail	1369554192	2207613334
239	5353 Pearson Junction	986708354 	7021329195
240	21 Holy Cross Parkway	4249437540	3441410170
241	22411 Kings Terrace	9438198117	4303427342
242	253 Oxford Center	5996685539	6667533530
243	757 Village Green Circle	3127423309	7844963681
244	9613 Kensington Circle	6068216363	6278364139
245	862 Florence Way	3351888033	6258517949
246	249 Norway Maple Plaza	1025701802	6085784883
247	75219 Acker Avenue	9726590374	9461091912
248	07 Bashford Road	2929623123	7989751080
249	43 Roxbury Junction	2156196305	4018173601
250	8461 Jay Junction	4235196329	9934730148
251	4 Kinsman Place	6191633123	5401666772
252	7 Bobwhite Terrace	5286808706	9994143030
253	69 Loeprich Junction	8069854908	1189806356
254	4087 Dottie Drive	8657360265	8108450624
255	3 Muir Hill	5122682698	8525754344
256	381 Montana Place	8507691146	1092605413
257	3051 Nevada Parkway	6616709992	2966944630
258	223 Donald Plaza	9598810957	8383917843
259	611 Clemons Court	5408777201	3861095646
260	44 Fulton Hill	2133996244	8679095238
261	82323 Dwight Avenue	9939084392	3342036335
262	195 Tennyson Circle	1120203429	8937421420
263	80105 Sunbrook Alley	5125349895	1397222371
264	1292 Red Cloud Crossing	6951541482	5246757359
265	7680 Valley Edge Place	2786465051	2153793071
266	9779 East Circle	9684587787	3916092452
267	9 Bartillon Junction	6192972597	4095780388
268	867 Helena Alley	3615844317	3959851711
269	7 Victoria Point	6867168699	1685361716
270	78 Independence Pass	3664565396	9612486406
271	776 Columbus Pass	2081571409	2519803225
272	3 Buena Vista Circle	4997189243	6936822237
273	8 Logan Way	1919525579	4451331127
274	0825 Manitowish Drive	4321142501	9813584664
275	2735 Clove Circle	6632005462	5808870552
276	68 Melrose Place	5264995456	4284125564
277	49793 Arizona Junction	9923134584	6637025372
278	0245 Northwestern Way	3621551299	6609369188
279	4 Nevada Place	254264428 	3326456221
280	56284 Sauthoff Circle	5361835488	9399477661
281	208 Bayside Street	733959816 	5446662634
282	77 Briar Crest Parkway	7928510788	4283549041
283	753 Del Mar Parkway	3742274074	8123722603
284	4 Westport Plaza	302920846 	3491309514
285	73453 Del Mar Place	9042321696	5789531204
286	75 Dovetail Junction	9534246082	6626302998
287	61556 Arapahoe Junction	8031858821	3512970259
288	0 Golf Road	7201841883	7187111930
289	67 Ridgeway Point	8319167195	8012294373
290	6912 Maple Street	3196320455	3398503421
291	1 Blaine Street	1506757610	4932804960
292	538 Garrison Crossing	1606180848	3361937422
293	8 Kennedy Crossing	68647231  	4949662096
294	485 Old Gate Alley	7877647952	2918900441
295	763 Sommers Drive	146567054 	9608829043
296	22947 Little Fleur Circle	5949410182	2831934016
297	1 Grim Center	917662819 	9146964747
298	9977 Lunder Road	1727890266	4008871033
299	4 Waywood Crossing	416307165 	6107930320
300	4 Fremont Place	7245078305	8277333034
301	16992 Gina Trail	993902106 	2094212247
302	43 Coolidge Road	7290137555	9279189970
303	59832 Manley Road	175493097 	2414795182
304	970 Northland Center	3788742715	3669513924
305	35 Prairieview Parkway	5913545431	8305611335
306	78 Kim Crossing	4114730447	1427993353
307	69 Esker Circle	5072746657	5315666595
308	8782 Aberg Hill	5347178134	3829647640
309	82038 Northridge Pass	56567869  	7658484509
310	2 Pearson Parkway	4918312043	9505139503
311	42256 Fieldstone Crossing	9479421441	5703714116
312	784 Gateway Road	1847645375	7758920187
313	280 Upham Place	6156660642	6899749224
314	232 Crownhardt Pass	8594581888	4642472847
315	66 Clemons Pass	2633827212	1802073965
316	3 Springs Trail	6062544577	6199195262
317	5378 Fisk Way	3020444838	8974775708
318	64488 Marquette Drive	3284890424	9913053456
319	715 Pawling Lane	920895306 	1906968205
320	21185 Brentwood Terrace	5870580059	9496921937
321	11275 Fairfield Circle	8635649001	6878049689
322	76083 Briar Crest Terrace	2603297116	6563243705
323	20663 Westend Center	5992804662	2775534230
324	427 Anthes Park	4646012194	9172785503
325	60464 Golden Leaf Center	9298704111	6844713349
326	9752 Thompson Avenue	7957088980	2461914626
327	08 Talmadge Lane	4536278965	6379822513
328	05657 Prairie Rose Parkway	8213356886	1884582194
329	5 Holy Cross Road	8391309410	3269045372
330	627 Messerschmidt Place	8547952310	4912328384
331	9 Morningstar Alley	4644007389	2961221439
332	49758 High Crossing Junction	3335029421	1643362273
333	9833 Eagan Trail	1929781737	1918659756
334	24167 Jana Parkway	8155104938	5903387273
335	6 Grim Road	1821569343	7526123679
336	78 Bluestem Lane	6084214410	2977575182
337	39539 Gina Point	6734768891	7253720038
338	263 Goodland Junction	8547229783	7682431882
339	9 Anhalt Avenue	549218389 	7866637563
340	41239 Buhler Hill	2148416074	6767271426
341	520 Daystar Parkway	8503995522	8874523740
342	9181 Elmside Road	851726422 	2237063810
343	07 Pine View Center	2789768255	3022472368
344	1 Gina Place	8849378691	9888490829
345	5 4th Drive	5010664825	1011755740
346	345 Mayfield Parkway	7320486213	7035541706
347	56 Sunbrook Way	7122791320	8878237305
348	3 Stang Crossing	5499695070	7369117906
349	048 Bultman Street	5301396027	6464060505
350	0 Welch Lane	6165506939	1989757988
351	12197 Farmco Place	8085240658	4293318983
352	9 Elgar Drive	4489007999	9073155268
353	9219 Hollow Ridge Junction	3526362020	2236051503
354	9 Hayes Lane	7403746862	9779873809
355	156 Orin Crossing	953968059 	3524885665
356	774 Bonner Plaza	8357555383	6668639999
357	730 Jackson Parkway	1932649847	7807422686
358	43 Ridgeview Park	896738712 	3124200777
359	54 Morningstar Parkway	6791862932	9375162423
360	3607 Eliot Point	6620464446	3628743326
361	05 Continental Way	5420266574	4285733328
362	88352 Brickson Park Park	9995947112	1645447582
363	400 Homewood Circle	3711354209	9867418667
364	813 Manitowish Hill	3762545705	2078714992
365	83005 Birchwood Drive	7908205819	6942262085
366	3 Scofield Drive	3023934582	9276027644
367	3755 David Park	3292978399	5643404304
368	89779 Kinsman Point	8527149330	8337556587
369	9042 Transport Court	5917942192	3894742096
370	664 Hayes Parkway	5230457652	9419077867
371	21 Kensington Way	6553143245	6736213638
372	421 Sutteridge Lane	91989888  	8895341722
373	40 Blue Bill Park Way	2711800264	3908597036
374	12 Park Meadow Park	9403011246	2381560708
375	152 Bartillon Circle	5803225170	5799186282
376	76206 Mendota Park	1651430479	4234544294
377	13469 Superior Avenue	7328525451	8702081813
378	8580 Loftsgordon Terrace	5192669061	9291392118
379	440 Eastlawn Court	4827754381	6949737335
380	27 Comanche Alley	6195801517	9205495621
381	49 Troy Junction	9747723353	6117996012
382	7 Dexter Park	631810870 	1142542812
383	0147 Scott Road	7665737412	2041922986
384	9 Bartillon Circle	4552501518	2148867880
385	93 Marquette Court	715529729 	7245635301
386	9 Larry Hill	853053975 	6061765524
387	2602 Hanson Point	7950493274	5858695488
388	24 Birchwood Way	487921651 	3186720086
389	895 Warner Way	69654645  	3056779059
390	7 Brentwood Hill	8013036240	3957637077
391	4334 Hudson Park	1665059976	4258800386
392	261 Golden Leaf Court	7730752266	9937813596
393	4 Thierer Lane	1123141781	2498696041
394	518 Milwaukee Alley	323444878 	2467008388
395	2 Glacier Hill Road	2661179841	1535554177
396	223 Brickson Park Way	271856385 	8889141164
397	13561 Randy Court	1891903192	6998325433
398	27 Namekagon Park	1534379801	9372468435
399	2867 Fallview Alley	1543464143	3187206212
400	7 8th Pass	6923221892	8151521775
401	6 Duke Center	1892164200	8621702282
402	1885 Canary Place	3398324768	9824255479
403	0390 Express Hill	4141057186	7891351439
404	7 Talmadge Parkway	3736776620	1871797221
405	607 Delladonna Road	9667816955	6783837069
406	4 Boyd Place	6054651557	3602910935
407	31140 Cottonwood Trail	2680903368	2144659066
408	484 Northland Pass	9556982020	8696719014
409	852 Portage Parkway	9962308748	6417828467
410	1820 Ryan Avenue	6153237019	5333733393
411	88 Thackeray Hill	5358550883	6936718031
412	8 Sheridan Way	7964585693	2189950906
413	20006 Columbus Center	2408015043	3714751944
414	8 Anzinger Drive	2514860557	2493896227
415	2 Graceland Hill	29156097  	9895402620
416	321 Beilfuss Avenue	7126769459	5627777536
417	3926 Grasskamp Trail	1405011186	5149937403
418	36 Florence Point	2758096780	1958253466
419	864 1st Junction	9055680238	3707790658
420	0 Farmco Street	6793071715	5353334088
421	45 Ridge Oak Center	3733471995	1821962506
422	38 Carey Pass	6141710719	3876451439
423	53 New Castle Terrace	1084140149	5716717399
424	7556 Lien Circle	1798646724	4551677766
425	2397 Waywood Trail	3068477297	1858772455
426	767 Glendale Point	3509971834	9119566974
427	73840 Donald Lane	2825728811	6925438116
428	971 Roxbury Drive	6749398142	6986087791
429	4616 Gerald Plaza	6872270967	5673046428
430	3 Randy Lane	7104664436	7742031315
431	9837 Bay Road	3027447859	7221364596
432	86217 Fairview Drive	3070211302	3132270090
433	62 Sundown Plaza	309945493 	9831348166
434	0 Nelson Junction	2219233397	8952509542
435	43 Village Point	2484833818	6976059778
436	022 Warner Avenue	4753441289	1309399305
437	962 Eliot Hill	4768655404	4344122602
438	4677 Lukken Alley	9282256715	2754350851
439	73 High Crossing Way	7944385684	4356576605
440	90769 Vera Street	7762967266	9243990987
441	39 Main Parkway	801112410 	4546048669
442	624 Ilene Crossing	3444771121	5821497104
443	63 Heath Hill	3083177149	6484028979
444	38 Old Shore Drive	4396985353	9661646955
445	7 Pennsylvania Place	4961659151	9083176968
446	6 Loomis Alley	624991504 	4053526187
447	7 Sunnyside Way	6080099852	3013927883
448	54713 Jackson Point	4892769689	3601887299
449	4490 Buhler Street	2211599092	6063260001
450	78553 Messerschmidt Road	778769559 	1596728875
451	1560 Sommers Way	1028103573	3872676000
452	0937 Ramsey Hill	2891708761	5127949144
453	67 Twin Pines Drive	5909497241	9127638447
454	1 Lien Road	470796604 	2902166962
455	76 Swallow Drive	4550994152	1827749406
456	9 6th Avenue	6260598966	4806764158
457	6850 Heffernan Center	4458129217	4418180015
458	54 Heath Plaza	7732154203	4873853624
459	2 Mandrake Junction	6452302691	7581650430
460	1435 Garrison Circle	741021003 	4217220604
461	4048 Oneill Crossing	7505313823	9041208892
462	85 Towne Way	2214140419	4553130691
463	202 Mccormick Center	491999754 	8512165253
464	76567 Spohn Trail	1836103140	5165721200
465	5 Hermina Terrace	6856231184	9683796793
466	12646 Columbus Court	9787212593	3573178941
467	60161 Morrow Point	1619717350	3834915411
468	843 Corry Road	4545881301	8267845903
469	4 Gina Way	3830956078	2022615952
470	5 Lakewood Gardens Hill	5138329845	8197313470
471	4541 Forest Run Lane	5851185323	8718100117
472	21887 Londonderry Pass	7581445177	4482440192
473	81 Becker Junction	422858281 	6809277357
474	0096 Little Fleur Parkway	5398601519	9221603378
475	2306 Paget Lane	457979874 	1158100946
476	31553 Montana Point	1184255394	1457162746
477	016 Westend Place	1938132562	4829331720
478	02 Brickson Park Way	9485912594	1459691808
479	81 Red Cloud Avenue	6638185863	6274116209
480	52867 Kensington Alley	6685024867	3966411435
481	6726 Gale Way	2021473272	1292723027
482	776 Utah Road	309179798 	8963631173
483	1 Pine View Circle	3880106403	1647848023
484	96229 Waywood Avenue	3248206286	2912802693
485	625 Transport Avenue	7018460136	9713907117
486	4 Forest Dale Road	2070680836	9533003133
487	669 Summit Point	2664339247	8732887455
488	8011 Hanover Park	581213652 	4493374273
489	61638 Dunning Place	2859818083	4154286411
490	6988 Springs Lane	2739069636	2511174664
491	6 Doe Crossing Lane	7502815739	4862452681
492	13 Shasta Drive	9465352687	2727514907
493	93948 Stang Terrace	1452988290	5287327807
494	9954 Judy Junction	8156656054	7471885243
495	029 Moulton Pass	9900123888	9285305007
496	9 Bellgrove Alley	1569016395	7082533055
497	460 Vidon Terrace	1854951359	4997583384
498	4 Mesta Lane	3817357459	2374124112
499	5234 Tennessee Pass	1607396335	4178862930
500	90 Stephen Circle	7827696997	6851117776
501	86208 Kipling Court	3045497279	5935605224
502	42832 Towne Center	1902537136	4121278494
503	322 Canary Plaza	9035231293	3257050553
504	3 Hayes Center	287241323 	5358985443
505	86806 Golden Leaf Alley	693458770 	4817828749
506	911 Schlimgen Circle	6992224393	9112094283
507	846 Boyd Terrace	7952092260	1129425294
508	4157 Scofield Junction	9591756071	2686481393
509	8314 Jay Avenue	6499685779	7282757945
510	6 Mayfield Trail	7496481817	4892384829
511	94 Nevada Street	897819284 	7681009473
512	97149 Ridge Oak Parkway	7992119902	9087731682
513	2 Arapahoe Plaza	1577616026	4543781912
514	07 Bonner Lane	647526714 	9426324726
515	4 Talisman Circle	2026571691	7787454927
516	8004 Stoughton Drive	1048810374	3761217288
517	607 Mallory Alley	6657930271	3994684567
518	8241 Fallview Circle	2697477840	4981518668
519	78766 Gateway Park	5824063175	9655873459
520	1 Ramsey Junction	7783183150	7468229807
521	9 Golden Leaf Avenue	4695106192	8169093900
522	1138 Birchwood Pass	6930699428	4453694475
523	8109 Warrior Alley	6356227044	2695054621
524	619 Knutson Point	4721672852	3442452995
525	3523 Nobel Avenue	1836927247	6738314495
526	71 Roxbury Way	7879527482	2336836267
527	4 Weeping Birch Parkway	120678985 	8442884001
528	76 Heffernan Center	1065962992	8332014156
529	43 Boyd Pass	51621586  	8496717426
530	9662 Service Pass	7246620282	6793403362
531	0374 Iowa Drive	7678243854	3148459969
532	7813 Eastwood Place	4059351086	9975549722
533	8 Red Cloud Parkway	7705693030	3896383422
534	791 Talmadge Street	5584801958	5398743237
535	74752 Grasskamp Road	7896538481	9829803492
536	0 Brentwood Crossing	4909235785	3472691939
537	9966 Meadow Vale Court	8175876593	7965894980
538	6256 Sutteridge Lane	4621220493	8052672055
539	2 Granby Plaza	8174845591	2514797534
540	745 Buhler Lane	4151894840	5132307483
541	4 Canary Pass	8894808557	2673974228
542	9379 Lotheville Junction	595116376 	3292672165
543	06 Lakewood Gardens Parkway	8546093361	8499052701
544	8470 Meadow Ridge Street	9262534231	9492826620
545	270 Sugar Junction	4934951293	6429442168
546	0 Del Sol Park	4841653761	5055328362
547	43492 Sommers Hill	6938251875	6938050916
548	3004 Bonner Circle	9857604115	1113101269
549	523 Michigan Plaza	2840868778	3105275945
550	23672 Lukken Lane	9144952511	1775370476
551	8551 Oneill Terrace	8002730530	7455924965
552	9302 Kennedy Avenue	1431267435	5348165724
553	13517 Sachtjen Avenue	6975590324	8127292849
554	01 Hallows Street	2180750250	3076689564
555	9453 Brentwood Center	8700968353	6624548450
556	3 Vidon Alley	5616201363	4958764678
557	16 Di Loreto Trail	2156315426	1887335990
558	73 Lukken Junction	2337134522	1957075585
559	460 Lighthouse Bay Point	7910372831	4329311784
560	1 Saint Paul Way	2486661749	4219393458
561	1 Orin Crossing	9802105073	3398284540
562	4 Grim Parkway	3703435634	3775786849
563	65246 Utah Hill	3879329361	6757594899
564	4566 Garrison Park	8326016630	7239076515
565	2 Carey Avenue	7771639484	1335746132
566	7861 Dakota Way	245684170 	5421955520
567	045 Monica Junction	4915023037	4914138816
568	87762 Darwin Parkway	1748843838	2135146196
569	02759 Waywood Pass	2930324264	5341263530
570	85 Arkansas Court	7988323323	4746586379
571	64 Bluestem Place	5039109996	2318347200
572	882 5th Hill	5982591645	4077944700
573	214 Bellgrove Circle	566899952 	6999668718
574	2 Melvin Park	97779169  	2952288957
575	24 Banding Court	6411181987	7436522498
576	705 Springview Junction	8034534941	5847463975
577	75136 7th Avenue	544219534 	8567395593
578	714 Arkansas Avenue	2092144489	7784094979
579	31 Kipling Junction	8737203425	8593725536
580	762 Crescent Oaks Center	3539088291	5371914104
581	2144 Donald Parkway	5438072172	7426393338
582	9 Thierer Place	1347506413	2498288970
583	23 Elmside Crossing	1237028201	6089815292
584	905 Katie Crossing	226704227 	6234728482
585	71732 Shelley Terrace	2696060134	5653644860
586	923 Atwood Junction	2411541052	5251020592
587	3474 Stephen Avenue	4780691040	1982046863
588	1503 Dawn Circle	4764320306	3529358825
589	280 Schurz Lane	8256539883	3175457802
590	8 Mockingbird Pass	1175168999	5192281985
591	3 Gateway Terrace	8704751057	7732229847
592	11719 Raven Court	8469056224	8695735218
593	6813 Talisman Trail	1838758406	3775912153
594	92 Grasskamp Circle	9216294201	5891255660
595	0 Fordem Point	5592355567	8746017577
596	3023 Myrtle Alley	6795587146	8593849794
597	8764 Loomis Hill	5747572528	5784606174
598	6 Carpenter Hill	8725347873	5459743165
599	6 Mifflin Crossing	432211759 	9159021764
600	382 Bultman Parkway	3969166741	1393779970
601	2728 Kropf Hill	561649404 	1566574498
602	99 Derek Crossing	5360439244	7759932490
603	99446 Weeping Birch Point	752933398 	6879644067
604	8 Sherman Center	5260864511	1532118238
605	98 Cascade Plaza	844674252 	2927691353
606	34 Chinook Parkway	1065206346	3398088375
607	810 Sundown Avenue	8765906182	2658184025
608	5354 Lunder Crossing	4746541637	5997032590
609	31964 Sheridan Avenue	1848830400	1669300232
610	59225 Ruskin Terrace	85869817  	1823858831
611	4 Schlimgen Crossing	4199515074	8665828232
612	89900 Crescent Oaks Place	7412029584	3536822812
613	5 Clyde Gallagher Hill	7607117371	1969838171
614	373 Swallow Lane	1141596046	7873520348
615	79 Ohio Point	6876732274	8952867655
616	5 Towne Alley	9625214668	5458329227
617	698 Linden Circle	6796131648	1657329363
618	753 Fieldstone Junction	2683377002	6314013277
619	4865 Orin Alley	2506463921	8158843264
620	38 Magdeline Avenue	3879114860	3176645147
621	831 Mariners Cove Circle	3644534147	4825317961
622	67 Melrose Crossing	4521903500	3285833533
623	1201 Tennessee Terrace	9476963222	2884666099
624	9903 Gina Road	7096290055	5719863636
625	345 Meadow Valley Point	1804002473	8967799006
626	447 Tony Trail	1501656628	3349358802
627	84387 Lighthouse Bay Hill	4041660104	1233013315
628	69 Anhalt Parkway	4573634925	7758446023
629	19 Pierstorff Avenue	7895434695	6982865015
630	6 Corscot Parkway	5883688440	1612947575
631	8 Scott Park	3045469055	5856808019
632	1 Warrior Junction	3185055656	7575832532
633	48619 Cody Road	3022460417	7756130167
634	94358 Hanover Alley	7792231280	7418862416
635	167 Nancy Pass	6933576327	7918466866
636	3 Sachs Place	2465954582	1707537741
637	90663 Redwing Terrace	6718981322	5135316973
638	2 Bellgrove Plaza	1859736406	4594625012
639	346 Acker Alley	1222737680	2886289128
640	27982 Bluejay Trail	1887453355	3672332951
641	008 Ilene Road	3439287896	8015349304
642	383 Barby Way	3073560129	9353308052
643	279 Delladonna Street	8974964291	2643358829
644	8291 Browning Circle	2269022292	3018265112
645	6725 American Plaza	3113380930	4579922348
646	28838 Golden Leaf Street	3842942550	4941028860
647	987 Havey Junction	3472507692	5904239492
648	5010 New Castle Street	5535631047	7511182897
649	741 Grayhawk Park	9202604782	6193806675
650	0448 Dahle Hill	6251320940	9031939112
651	9353 Dovetail Alley	7608166819	9738295271
652	2 Glacier Hill Drive	231259232 	4741512115
653	097 Springview Street	3289011201	9678786596
654	32 Jay Street	5731219434	1744090298
655	71618 Westridge Street	9881308861	9534138099
656	17975 Clove Hill	6265332267	6091301072
657	68107 Kings Way	4750212305	6869413907
658	4 Jackson Pass	2397939332	1843134373
659	82548 Sauthoff Crossing	5768056895	5455946791
660	31 Sage Park	4020351407	9854363088
661	8703 Talmadge Road	5495309886	9314345983
662	2182 Mifflin Center	5407941406	8999014502
663	81 Fair Oaks Pass	1460973128	7734988348
664	70 Sommers Parkway	3458478619	8921133666
665	1347 Brentwood Center	4225844505	7044705025
666	93 Spaight Lane	7554757944	7217906320
667	50 Quincy Place	5799285423	7287549868
668	23 Utah Park	7638554259	4394399961
669	65147 Anniversary Alley	808213381 	2596627419
670	95618 Canary Park	1987432540	1614918307
671	650 Fremont Trail	8464026163	7053977296
672	0945 Ohio Terrace	5412264784	6217295469
673	71258 Luster Trail	2292409402	1004940172
674	174 Bultman Circle	5935113521	9513534752
675	0164 Lyons Point	7389255171	7783260234
676	255 Canary Center	2331722843	5161957891
677	063 Donald Terrace	338092140 	9983450958
678	56669 Moose Hill	5396521125	7554270623
679	258 Monterey Crossing	3477554473	4318778755
680	54072 Weeping Birch Park	9338932739	9437626298
681	7434 Mandrake Court	8760890390	7239638806
682	05006 Manitowish Lane	7708890459	8619889385
683	7 Melby Court	6362570514	8744963538
684	46 Shopko Hill	5831821822	3412291619
685	4601 Shelley Center	7346689570	1332892380
686	9686 5th Parkway	5605593945	1315213548
687	7486 Derek Park	942851152 	8851951315
688	0 Glendale Hill	7303201601	5959240828
689	948 Debra Center	8494894189	4408176783
690	9447 Bunting Alley	3059765850	9529748790
691	14847 Forest Dale Trail	1104051885	5259171043
692	2279 Spaight Parkway	5929409136	2038695783
693	2 Green Ridge Junction	9420162513	6357553739
694	4 Hollow Ridge Junction	7260566087	2437181679
695	03153 Kropf Drive	6908610257	5428623692
696	59778 Farmco Parkway	1217928897	4503854706
697	83730 Oriole Plaza	3026100500	1661251366
698	565 Huxley Way	3996353665	8962332882
699	0 Shelley Terrace	3481291147	4324649856
700	80081 Farwell Plaza	5367691059	6151168281
701	9 Prentice Road	3504917226	6815801343
702	011 Village Street	6557226406	6523082293
703	405 4th Way	4519661473	5206530301
704	13 Steensland Lane	5961697816	9877916859
705	8842 Duke Circle	3607209258	8008051379
706	33 Hanson Junction	2715193656	7085479431
707	78256 Algoma Road	9763708552	1532121971
708	6122 Esker Park	2647897442	5458396187
709	5916 Michigan Parkway	4126861510	9504629264
710	70 Merry Street	3532789167	1629569719
711	5313 Spenser Court	4970854962	4692601155
712	4494 Aberg Trail	1750714969	2487631851
713	74725 Forster Terrace	3243562721	5231851668
714	6351 Morrow Circle	32036030  	7914187980
715	2 Crownhardt Point	7970474677	4201354461
716	1 Moose Road	9576402809	2047395819
717	70 David Lane	3713975607	8527749320
718	1 Dwight Place	9667344827	7405673779
719	72425 Dovetail Point	5161791014	2588906542
720	772 Grasskamp Parkway	6064128179	6274237335
721	2 Ridgeway Circle	3741824567	3764145536
722	27 Westport Place	9426896817	3072836812
723	3 Clove Pass	9574836463	2907449739
724	950 East Junction	953643719 	8356629748
725	453 Spenser Hill	9427136934	1382969866
726	8971 Schmedeman Way	2509982257	7908062238
727	366 Marquette Road	250422858 	6693124321
728	1170 School Circle	3214535416	3995716469
729	7632 Clove Point	412730675 	2169902430
730	7 Arizona Trail	6313171011	3491453882
731	561 Fair Oaks Pass	4174157989	1718580312
732	4696 Milwaukee Parkway	7242199816	8638925700
733	4 Elgar Avenue	4581156772	3898130931
734	08 Calypso Trail	4269562452	1687052304
735	9777 6th Point	1688493056	2677481607
736	275 Cardinal Trail	6323592085	9115673951
737	28 Southridge Point	2990536226	2588230958
738	75 Granby Street	5844785141	3071973414
739	5 Novick Point	7910687655	2271554605
740	8 Walton Alley	1432202211	3419325699
741	0019 Farmco Street	8187547938	5381551249
742	9 Fairview Place	6111520211	2436900349
743	7 Hovde Avenue	6137183908	2594101377
744	20150 Loomis Crossing	4004092049	5757256631
745	13922 Evergreen Crossing	4459609571	7429632373
746	650 Golf Junction	1280283884	9077383131
747	37 Logan Place	829387360 	9588107467
748	13216 Vera Center	9125986374	3783725449
749	65 Golf Road	9734418825	3926266373
750	81 Stuart Place	1777859722	8526156218
751	222 Granby Junction	3664038945	5634725712
752	15563 Basil Road	3050147188	3591511995
753	6 Rigney Road	5713158994	5164248637
754	181 Randy Trail	4966971790	5798121574
755	616 Ilene Drive	5916693963	7304471260
756	394 Roth Park	6571965230	8034819865
757	69980 Surrey Terrace	7080049894	2499865132
758	984 Marcy Street	9418439080	9713481152
759	4113 New Castle Parkway	809637192 	4276416427
760	09011 Bunting Street	3604984589	3906842485
761	60 Bobwhite Drive	4348785323	9198506743
762	73 Hollow Ridge Lane	815273725 	9344457182
763	0122 Talmadge Parkway	47170677  	4761819168
764	09 Schiller Trail	9923349831	5538088711
765	2979 School Terrace	3687372071	7952203530
766	93822 Shasta Street	3102642498	9948236220
767	050 Cambridge Junction	1782804717	8841353478
768	689 Shoshone Lane	4746937586	1162451731
769	636 Kropf Junction	8872174895	6124762686
770	3632 Division Pass	7507909130	5247017478
771	549 Ilene Pass	3146821868	4091841684
772	867 Twin Pines Crossing	1054516240	8528387848
773	01 Oak Parkway	2147348000	3216625487
774	179 Moland Point	3118748896	7272869698
775	75 7th Parkway	9633255761	5288615028
776	418 Everett Place	4753821767	5054810623
777	9781 Northridge Crossing	9339173933	2934734298
778	358 Jenifer Way	9421471299	4194879709
779	3 Fairfield Road	9051308662	2134350562
780	796 Londonderry Parkway	6029941408	7772640800
781	0841 Montana Point	3552047730	5163440521
782	360 Jenifer Way	9204960791	2695119972
783	6 Roth Trail	8820009345	2825633335
784	2134 Thompson Parkway	9578713662	3838055884
785	7 Carey Place	1790754281	2847174333
786	3469 Morning Avenue	4645177291	3255661050
787	21 Messerschmidt Road	9251533708	3866436591
788	6 Crowley Hill	3041625304	4765152994
789	51568 Oakridge Hill	9004002111	6463827087
790	68 Dennis Road	9620265940	3368284765
791	92506 Goodland Crossing	3980936620	6206307822
792	4 Graceland Road	5720360743	2601745090
793	963 Gerald Pass	9334282043	7712650630
794	2 Fallview Court	1552631071	1747305358
795	71 Crescent Oaks Hill	8700638945	6742404456
796	9 Dayton Court	8505442013	8758291149
797	85992 Claremont Park	7091966960	3538522360
798	23 Goodland Crossing	7213936057	7011138138
799	3 Hollow Ridge Street	5151730375	4189338478
800	73053 Division Avenue	459946270 	9874467506
801	28564 American Ash Drive	358135559 	9462026163
802	8 Veith Circle	8841671877	3384525447
803	638 Dahle Way	2963643561	2093715617
804	57706 Charing Cross Junction	3481811888	6235175066
805	0 Dottie Avenue	4929548972	6901979141
806	07 Northfield Crossing	6212842169	5396044559
807	70 International Trail	7982398298	2384164343
808	04 Union Crossing	1823644954	6838691798
809	58382 Meadow Vale Circle	7912722621	7066410575
810	5 Mallory Road	2299449502	1642064554
811	7 Talisman Junction	8446184473	8776990618
812	75 Garrison Circle	6002440741	9827450103
813	0436 Continental Parkway	8541579507	9597138619
814	9 Amoth Terrace	7329525056	8666647605
815	7 Quincy Lane	9734195727	5416575043
816	59 Milwaukee Drive	4899542717	1775201316
817	06196 Muir Park	986657343 	5131685654
818	4850 Welch Alley	5328057271	7367178782
819	374 Blaine Plaza	2880333432	1529912226
820	7800 Stang Trail	7943882772	7317668291
821	93666 Debs Center	3011711735	8396228473
822	83728 Annamark Place	5541581521	1014883866
823	81 Annamark Junction	4579252978	4613364630
824	6 Truax Avenue	5540977512	9161138988
825	6 Toban Pass	7811118172	6802501029
826	046 Sachs Hill	1240476917	6761657842
827	7182 Texas Center	6381454515	8523613198
828	383 Merry Trail	3953922073	9018349981
829	5043 Morning Street	920205914 	8058506706
830	1 Pond Terrace	7981915194	8835468615
831	5492 Lawn Junction	1415562961	9267640381
832	9 Kennedy Point	5850493284	9299273762
833	7 Bonner Hill	5485626624	2269312818
834	56617 Westend Center	2272316205	2442978171
835	6 Fordem Alley	129424791 	4289676778
836	273 Arizona Alley	4823037448	8829758626
837	97302 1st Parkway	9549135098	4939986688
838	09908 Fisk Circle	5212218366	1154683905
839	85 Ruskin Lane	7232592542	7709311925
840	0 Oneill Court	1569325794	7845904157
841	4 Raven Avenue	9505358757	9786153483
842	9 Menomonie Hill	9240319523	9458977978
843	63957 Ridge Oak Center	275808492 	4762242829
844	869 Springview Park	5251654368	2445450374
845	843 Amoth Street	5358758319	6983808150
846	9 Jana Park	4541071897	5517548365
847	960 Spaight Terrace	372842463 	2883086374
848	8684 Moulton Park	3316126187	8623684916
849	64711 Green Ridge Plaza	5599314109	8992133280
850	423 Heffernan Alley	2607216476	4198169907
851	8327 Packers Street	9381593946	8594345738
852	194 Oxford Hill	9308014257	9581796960
853	117 Scoville Park	7262963946	7043337260
854	270 Twin Pines Court	4323047236	9428181036
855	9916 Loftsgordon Way	9287602611	6334010520
856	4142 Lake View Circle	2381899581	9123281668
857	340 Fisk Junction	3652105359	3133449183
858	1366 Rowland Parkway	2573985700	7319241293
859	5370 Anniversary Road	8269145123	7041042257
860	18201 Lake View Center	7614661841	7239492692
861	75 Grasskamp Point	6023266593	2379071648
862	4 Spaight Street	7411703574	1404850964
863	1336 Pawling Terrace	73541085  	4914726933
864	69 Coleman Road	1088582897	1117390925
865	7406 Farwell Junction	565992316 	4724334882
866	300 Graceland Center	8246320403	6667389674
867	57 Dayton Place	2201478212	7092556235
868	1 Norway Maple Parkway	6939303410	1352494470
869	9 Bunting Junction	5436935714	7402035820
870	76284 Old Gate Way	3266038432	7022066379
871	1 Declaration Trail	9368075346	1928740794
872	128 Sommers Parkway	6449032218	9444902368
873	5495 8th Plaza	1908853882	3424978306
874	9986 Vidon Road	6493788351	2892084615
875	055 Kingsford Drive	2906374453	5277997275
876	875 Elgar Alley	2969841245	1133882763
877	287 Birchwood Point	248379489 	1651348155
878	74614 Burning Wood Trail	4864758056	4455849323
879	4 Goodland Pass	7657671164	3216967713
880	038 Reinke Center	8423667472	6083323004
881	1665 Gerald Center	1184060231	9016406489
882	26492 Hallows Trail	3954688139	5827641289
883	7 Harbort Pass	1593309148	2908795108
884	460 Trailsway Drive	6580467169	2044364278
885	664 Luster Plaza	2686757862	2333973115
886	6 Kenwood Road	3019332175	6173345874
887	56483 Pepper Wood Alley	5301660349	5047364719
888	96 Sachs Trail	4337442428	1254559484
889	0 Coleman Street	8334480621	2055945934
890	3495 Eliot Crossing	2962191454	4198088279
891	7 Debra Road	7937083543	9583763465
892	78 Ramsey Pass	7016358221	6121115483
893	48689 Mcguire Trail	2273794317	1786020851
894	49771 Sage Terrace	8354425082	8838941939
895	19 Sundown Lane	519006790 	2008504777
896	1991 Mallard Parkway	6567768291	4257006648
897	948 Scofield Drive	9858661863	4985054905
898	456 Prentice Court	370220886 	4227480131
899	41 Veith Avenue	4747398602	1328373691
900	3 Heath Plaza	2516093146	8957339480
901	8 Doe Crossing Point	6627009798	7722092611
902	43250 Superior Road	2829686671	3029283184
903	63238 Lien Avenue	3571961083	9518480092
904	01 Meadow Ridge Park	312109412 	7112468997
905	0443 Milwaukee Pass	2646651893	5719733549
906	949 Upham Center	1909607525	3743969026
907	2 Brown Hill	6730412768	7995772747
908	2 Magdeline Park	7614742147	2317421440
909	99 Melody Drive	8491584204	4726016488
910	474 Stuart Alley	1517787380	8451305832
911	07554 Lerdahl Crossing	6664291231	2253452567
912	2193 Arrowood Circle	5929993759	8138979692
913	45286 Moose Alley	3648499148	2988862833
914	9 Knutson Center	7462157402	5741950244
915	84551 Sherman Street	5838950222	1629919575
916	6 Redwing Terrace	3787360159	8138261254
917	78928 Kensington Junction	1228588862	4944066526
918	0 Comanche Place	5242904834	2415188482
919	2 Forster Park	9455371703	3302466356
920	40 Anhalt Hill	304106105 	4878760388
921	5583 Orin Junction	6384286602	7295009301
922	313 Namekagon Court	9269338731	3077940057
923	21 Granby Hill	2560745599	5103792830
924	96900 Surrey Alley	8443029369	2682736166
925	8 Pawling Crossing	1460234220	8661453167
926	1 Mallard Avenue	5901180126	4889879853
927	9 Annamark Hill	8116534888	9914744293
928	97591 Barby Junction	4799421678	1239807249
929	85 Cottonwood Crossing	3819625008	5401574232
930	82 Melrose Alley	8473691457	1076191808
931	38 Center Alley	8069914621	4069573214
932	05762 Onsgard Pass	9983659152	6031590275
933	17521 2nd Way	5046791856	9462433264
934	83 Butternut Trail	7258392991	4496582932
935	14973 Springs Place	9222422590	6643572651
936	46438 Marquette Center	5032513963	6677395419
937	06603 Ohio Street	331047267 	9486338702
938	03 Dakota Center	8084290375	2907792341
939	2 Lindbergh Center	2763419068	1993006119
940	7859 Rockefeller Circle	6849609416	3479592535
941	1239 Sugar Junction	6873708355	5754057846
942	4 Comanche Alley	8462756813	2563663570
943	7 Maple Wood Park	7201258291	8366130328
944	912 Hooker Avenue	8863592354	4351931107
945	812 Burrows Circle	6266563113	5571499269
946	6 2nd Center	6812400193	1766385262
947	30516 Chinook Trail	2502938912	9109489473
948	4930 American Ash Pass	8101156475	7736982678
949	9043 Leroy Junction	6418029768	2643785882
950	3278 Del Mar Court	1223831792	4418405935
951	69 Kingsford Pass	8024995084	7118207771
952	1 Division Plaza	1373955530	7554366954
953	9 Kropf Circle	2118332886	9101127636
954	621 Bluestem Junction	412121880 	2979409164
955	3 Kinsman Terrace	5929691321	5784373477
956	240 Lakewood Trail	4733534218	2181763537
957	408 Armistice Hill	6310855336	9752978115
958	8 Brentwood Place	4534776678	4101704780
959	39 West Avenue	8280923476	7584641210
960	9697 Nova Drive	1221133344	3828759166
961	44433 Donald Circle	6656852383	4587485147
962	5 Gateway Point	9789006665	5872279185
963	59548 Shopko Alley	7997748625	9025240792
964	84 Goodland Lane	5761232297	7787258788
965	27474 Montana Junction	609790856 	2046323662
966	47078 Randy Court	5530413261	5452611201
967	032 Starling Terrace	1024071319	2836157207
968	2206 Merry Road	9032338299	8243982064
969	00884 Bay Way	7633802073	1221428663
970	293 Westport Way	2035827350	4671727910
971	522 Twin Pines Parkway	8537437916	4403167084
972	58210 Arapahoe Park	4143130132	7941237872
973	6 Chinook Road	2435313923	9572242068
974	55 Esker Street	9492783803	9104746007
975	0769 Manitowish Circle	3465640787	7837727342
976	63935 Riverside Center	2403816627	5065659152
977	572 La Follette Alley	9889274129	4555547031
978	53 Hollow Ridge Point	1280179333	6914363081
979	82 8th Plaza	2840619836	5479443107
980	50 Brown Avenue	5871656876	6823184215
981	35330 Eliot Point	601085975 	7606415521
982	9443 Green Ridge Avenue	3340824481	9978921262
983	68 Gulseth Drive	301072410 	3324905596
984	7086 Fairview Plaza	6414055753	7627257853
985	6 Moulton Avenue	3686266172	1099016674
986	0510 Chinook Avenue	2153810036	7241239819
987	410 Esch Circle	2327548896	9789831609
988	48 Larry Alley	6439796027	8005206521
989	0 Brentwood Park	749120210 	5738030497
990	06 Reinke Crossing	2433273035	7548988789
991	7 Mariners Cove Park	802809998 	2836188402
992	0 Arapahoe Court	4753214145	4051210131
993	50981 Marquette Park	6761320115	6822423547
994	816 Lawn Pass	1751813483	8064844321
995	27 Hansons Hill	6845172198	9452063494
996	47947 Roxbury Place	1122809662	1616266182
997	95 Sunbrook Road	7090572556	9729733053
998	85138 Montana Street	7804191830	5467163302
999	87895 Westridge Terrace	9911670418	5152878590
1000	9632 Cardinal Avenue	8811805183	6508873882
\.


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 203
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.people_id_seq', 2000, true);


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 204
-- Name: postal_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--

SELECT pg_catalog.setval('public.postal_addresses_id_seq', 1000, true);


--
-- TOC entry 2838 (class 2606 OID 16421)
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- TOC entry 2842 (class 2606 OID 16434)
-- Name: postal_addresses postal_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.postal_addresses
    ADD CONSTRAINT postal_addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 2840 (class 2606 OID 16516)
-- Name: people uniq_identification_no; Type: CONSTRAINT; Schema: public; Owner: dbuser
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT uniq_identification_no UNIQUE (identification_no);


-- Completed on 2022-12-28 18:47:54 +0330

--
-- PostgreSQL database dump complete
--

-- Completed on 2022-12-28 18:47:54 +0330

--
-- PostgreSQL database cluster dump complete
--

