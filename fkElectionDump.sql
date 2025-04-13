--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-13 04:54:44 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 230 (class 1259 OID 17634)
-- Name: blood_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood_type (
    blood_type_id integer NOT NULL,
    blood_type_name character varying(10) NOT NULL
);


ALTER TABLE public.blood_type OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17633)
-- Name: blood_type_blood_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_type_blood_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blood_type_blood_type_id_seq OWNER TO postgres;

--
-- TOC entry 3883 (class 0 OID 0)
-- Dependencies: 229
-- Name: blood_type_blood_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_type_blood_type_id_seq OWNED BY public.blood_type.blood_type_id;


--
-- TOC entry 246 (class 1259 OID 17729)
-- Name: citizen_attrib; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citizen_attrib (
    citizen_attrib_id integer NOT NULL,
    citizens_gov_id integer,
    blood_type_id integer,
    marital_status_id integer,
    national_id_number character varying(50) NOT NULL,
    mobile_number character varying(20) NOT NULL,
    alternative_mobile_number character varying(20),
    email_address character varying(100) NOT NULL,
    education_level_id integer,
    job_title character varying(100),
    belong_2_syndicate boolean DEFAULT false,
    address_id integer,
    profile_picture text,
    support_status_id integer,
    mukh_id integer,
    building_number character varying(100),
    street character varying(100),
    floor_number character varying(50),
    apt_number character varying(50),
    municipality_id integer,
    district_id integer,
    governorate_id integer,
    additional_info text,
    CONSTRAINT citizen_attrib_email_address_check CHECK (((email_address)::text ~~ '%@%'::text)),
    CONSTRAINT citizen_attrib_profile_picture_check CHECK ((profile_picture ~* '^https?:\/\/.*$'::text))
);


ALTER TABLE public.citizen_attrib OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17728)
-- Name: citizen_attrib_citizen_attrib_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citizen_attrib_citizen_attrib_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citizen_attrib_citizen_attrib_id_seq OWNER TO postgres;

--
-- TOC entry 3884 (class 0 OID 0)
-- Dependencies: 245
-- Name: citizen_attrib_citizen_attrib_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citizen_attrib_citizen_attrib_id_seq OWNED BY public.citizen_attrib.citizen_attrib_id;


--
-- TOC entry 258 (class 1259 OID 17890)
-- Name: citizen_vote_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citizen_vote_preference (
    vote_preference_id integer NOT NULL,
    citizen_id integer,
    election_year_id integer,
    election_type_id integer,
    election_district_id integer,
    municipality_id integer,
    list_id integer,
    fav1_candidate_id integer,
    fav2_candidate_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.citizen_vote_preference OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17889)
-- Name: citizen_vote_preference_vote_preference_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citizen_vote_preference_vote_preference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citizen_vote_preference_vote_preference_id_seq OWNER TO postgres;

--
-- TOC entry 3885 (class 0 OID 0)
-- Dependencies: 257
-- Name: citizen_vote_preference_vote_preference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citizen_vote_preference_vote_preference_id_seq OWNED BY public.citizen_vote_preference.vote_preference_id;


--
-- TOC entry 244 (class 1259 OID 17711)
-- Name: citizens_gov; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citizens_gov (
    citizens_gov_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    father_name character varying(100),
    mother_name character varying(100),
    dob date NOT NULL,
    personal_doctrine character varying(100),
    gender character varying(50) NOT NULL,
    reg_number character varying(50) NOT NULL,
    doctrine character varying(100),
    municipality_id integer,
    CONSTRAINT citizens_gov_dob_check CHECK ((dob < CURRENT_DATE)),
    CONSTRAINT citizens_gov_gender_check CHECK (((gender)::text = ANY ((ARRAY['Male'::character varying, 'Female'::character varying, 'Other'::character varying])::text[])))
);


ALTER TABLE public.citizens_gov OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17710)
-- Name: citizens_gov_citizens_gov_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citizens_gov_citizens_gov_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citizens_gov_citizens_gov_id_seq OWNER TO postgres;

--
-- TOC entry 3886 (class 0 OID 0)
-- Dependencies: 243
-- Name: citizens_gov_citizens_gov_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citizens_gov_citizens_gov_id_seq OWNED BY public.citizens_gov.citizens_gov_id;


--
-- TOC entry 256 (class 1259 OID 17870)
-- Name: citizens_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citizens_services (
    citizens_services_id integer NOT NULL,
    citizens_gov_id integer,
    relative_service boolean DEFAULT false,
    relatives_details_id integer,
    service_type_id integer,
    service_status_id integer,
    service_description text
);


ALTER TABLE public.citizens_services OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17869)
-- Name: citizens_services_citizens_services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citizens_services_citizens_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citizens_services_citizens_services_id_seq OWNER TO postgres;

--
-- TOC entry 3887 (class 0 OID 0)
-- Dependencies: 255
-- Name: citizens_services_citizens_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citizens_services_citizens_services_id_seq OWNED BY public.citizens_services.citizens_services_id;


--
-- TOC entry 220 (class 1259 OID 17578)
-- Name: district; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.district (
    district_id integer NOT NULL,
    district_name character varying(100) NOT NULL,
    governorate_id integer
);


ALTER TABLE public.district OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17577)
-- Name: district_district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.district_district_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.district_district_id_seq OWNER TO postgres;

--
-- TOC entry 3888 (class 0 OID 0)
-- Dependencies: 219
-- Name: district_district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.district_district_id_seq OWNED BY public.district.district_id;


--
-- TOC entry 234 (class 1259 OID 17652)
-- Name: education_level; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_level (
    education_level_id integer NOT NULL,
    level_name character varying(100) NOT NULL
);


ALTER TABLE public.education_level OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17651)
-- Name: education_level_education_level_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_level_education_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_level_education_level_id_seq OWNER TO postgres;

--
-- TOC entry 3889 (class 0 OID 0)
-- Dependencies: 233
-- Name: education_level_education_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_level_education_level_id_seq OWNED BY public.education_level.education_level_id;


--
-- TOC entry 228 (class 1259 OID 17625)
-- Name: election_district; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.election_district (
    election_district_id integer NOT NULL,
    district_name character varying(100) NOT NULL
);


ALTER TABLE public.election_district OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17624)
-- Name: election_district_election_district_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.election_district_election_district_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.election_district_election_district_id_seq OWNER TO postgres;

--
-- TOC entry 3890 (class 0 OID 0)
-- Dependencies: 227
-- Name: election_district_election_district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.election_district_election_district_id_seq OWNED BY public.election_district.election_district_id;


--
-- TOC entry 226 (class 1259 OID 17616)
-- Name: election_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.election_type (
    election_type_id integer NOT NULL,
    type_name character varying(100) NOT NULL
);


ALTER TABLE public.election_type OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17615)
-- Name: election_type_election_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.election_type_election_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.election_type_election_type_id_seq OWNER TO postgres;

--
-- TOC entry 3891 (class 0 OID 0)
-- Dependencies: 225
-- Name: election_type_election_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.election_type_election_type_id_seq OWNED BY public.election_type.election_type_id;


--
-- TOC entry 224 (class 1259 OID 17606)
-- Name: election_year; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.election_year (
    election_year_id integer NOT NULL,
    year integer NOT NULL,
    CONSTRAINT election_year_year_check CHECK (((year >= 1900) AND ((year)::numeric <= (EXTRACT(year FROM CURRENT_DATE) + (10)::numeric))))
);


ALTER TABLE public.election_year OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17605)
-- Name: election_year_election_year_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.election_year_election_year_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.election_year_election_year_id_seq OWNER TO postgres;

--
-- TOC entry 3892 (class 0 OID 0)
-- Dependencies: 223
-- Name: election_year_election_year_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.election_year_election_year_id_seq OWNED BY public.election_year.election_year_id;


--
-- TOC entry 218 (class 1259 OID 17569)
-- Name: governorate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.governorate (
    governorate_id integer NOT NULL,
    governorate_name character varying(100) NOT NULL
);


ALTER TABLE public.governorate OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17568)
-- Name: governorate_governorate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.governorate_governorate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.governorate_governorate_id_seq OWNER TO postgres;

--
-- TOC entry 3893 (class 0 OID 0)
-- Dependencies: 217
-- Name: governorate_governorate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.governorate_governorate_id_seq OWNED BY public.governorate.governorate_id;


--
-- TOC entry 252 (class 1259 OID 17832)
-- Name: leader_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leader_reference (
    leader_reference_id integer NOT NULL,
    citizen_id integer,
    is_voter boolean DEFAULT false,
    description text
);


ALTER TABLE public.leader_reference OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17831)
-- Name: leader_reference_leader_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leader_reference_leader_reference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leader_reference_leader_reference_id_seq OWNER TO postgres;

--
-- TOC entry 3894 (class 0 OID 0)
-- Dependencies: 251
-- Name: leader_reference_leader_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leader_reference_leader_reference_id_seq OWNED BY public.leader_reference.leader_reference_id;


--
-- TOC entry 238 (class 1259 OID 17679)
-- Name: list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list (
    list_id integer NOT NULL,
    list_name character varying(100) NOT NULL
);


ALTER TABLE public.list OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17688)
-- Name: list_candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.list_candidates (
    list_candidate_id integer NOT NULL,
    list_id integer,
    candidate_id integer NOT NULL,
    candidate_name character varying(100) NOT NULL
);


ALTER TABLE public.list_candidates OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17687)
-- Name: list_candidates_list_candidate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_candidates_list_candidate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.list_candidates_list_candidate_id_seq OWNER TO postgres;

--
-- TOC entry 3895 (class 0 OID 0)
-- Dependencies: 239
-- Name: list_candidates_list_candidate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_candidates_list_candidate_id_seq OWNED BY public.list_candidates.list_candidate_id;


--
-- TOC entry 237 (class 1259 OID 17678)
-- Name: list_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.list_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.list_list_id_seq OWNER TO postgres;

--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 237
-- Name: list_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.list_list_id_seq OWNED BY public.list.list_id;


--
-- TOC entry 232 (class 1259 OID 17643)
-- Name: marital_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marital_status (
    marital_status_id integer NOT NULL,
    status_name character varying(50) NOT NULL
);


ALTER TABLE public.marital_status OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17642)
-- Name: marital_status_marital_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marital_status_marital_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marital_status_marital_status_id_seq OWNER TO postgres;

--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 231
-- Name: marital_status_marital_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marital_status_marital_status_id_seq OWNED BY public.marital_status.marital_status_id;


--
-- TOC entry 242 (class 1259 OID 17702)
-- Name: mukhtar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mukhtar (
    mukh_id integer NOT NULL,
    mukh_name character varying(100) NOT NULL
);


ALTER TABLE public.mukhtar OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17701)
-- Name: mukhtar_mukh_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mukhtar_mukh_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mukhtar_mukh_id_seq OWNER TO postgres;

--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 241
-- Name: mukhtar_mukh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mukhtar_mukh_id_seq OWNED BY public.mukhtar.mukh_id;


--
-- TOC entry 222 (class 1259 OID 17592)
-- Name: municipality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipality (
    municipality_id integer NOT NULL,
    municipality_name character varying(100) NOT NULL,
    district_id integer
);


ALTER TABLE public.municipality OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17591)
-- Name: municipality_municipality_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.municipality_municipality_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.municipality_municipality_id_seq OWNER TO postgres;

--
-- TOC entry 3899 (class 0 OID 0)
-- Dependencies: 221
-- Name: municipality_municipality_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.municipality_municipality_id_seq OWNED BY public.municipality.municipality_id;


--
-- TOC entry 254 (class 1259 OID 17847)
-- Name: relatives_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.relatives_details (
    relatives_details_id integer NOT NULL,
    citizens_gov_id integer,
    full_name character varying(200),
    relationship_type character varying(100),
    r_dob date,
    address_id integer,
    marital_status_id integer,
    related_citizen_id integer,
    is_eligible_voter boolean DEFAULT false,
    CONSTRAINT relatives_details_r_dob_check CHECK ((r_dob < CURRENT_DATE))
);


ALTER TABLE public.relatives_details OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17846)
-- Name: relatives_details_relatives_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.relatives_details_relatives_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.relatives_details_relatives_details_id_seq OWNER TO postgres;

--
-- TOC entry 3900 (class 0 OID 0)
-- Dependencies: 253
-- Name: relatives_details_relatives_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.relatives_details_relatives_details_id_seq OWNED BY public.relatives_details.relatives_details_id;


--
-- TOC entry 262 (class 1259 OID 17969)
-- Name: service_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_status (
    service_status_id integer NOT NULL,
    status_name character varying(100) NOT NULL
);


ALTER TABLE public.service_status OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17968)
-- Name: service_status_service_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_status_service_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_status_service_status_id_seq OWNER TO postgres;

--
-- TOC entry 3901 (class 0 OID 0)
-- Dependencies: 261
-- Name: service_status_service_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_status_service_status_id_seq OWNED BY public.service_status.service_status_id;


--
-- TOC entry 260 (class 1259 OID 17960)
-- Name: service_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_type (
    service_type_id integer NOT NULL,
    type_name character varying(100) NOT NULL
);


ALTER TABLE public.service_type OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17959)
-- Name: service_type_service_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_type_service_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_type_service_type_id_seq OWNER TO postgres;

--
-- TOC entry 3902 (class 0 OID 0)
-- Dependencies: 259
-- Name: service_type_service_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_type_service_type_id_seq OWNED BY public.service_type.service_type_id;


--
-- TOC entry 236 (class 1259 OID 17661)
-- Name: support_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_status (
    support_status_id integer NOT NULL,
    status_name character varying(100) NOT NULL
);


ALTER TABLE public.support_status OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17660)
-- Name: support_status_support_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_status_support_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_status_support_status_id_seq OWNER TO postgres;

--
-- TOC entry 3903 (class 0 OID 0)
-- Dependencies: 235
-- Name: support_status_support_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_status_support_status_id_seq OWNED BY public.support_status.support_status_id;


--
-- TOC entry 248 (class 1259 OID 17782)
-- Name: system_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.system_users (
    user_id integer NOT NULL,
    citizen_id integer,
    user_name character varying(100) NOT NULL,
    user_email character varying(150) NOT NULL,
    password text NOT NULL,
    phone_number character varying(20) NOT NULL,
    role character varying(50) DEFAULT 'delegate'::character varying NOT NULL,
    CONSTRAINT system_users_user_email_check CHECK (((user_email)::text ~~ '%@%'::text))
);


ALTER TABLE public.system_users OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17781)
-- Name: system_users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.system_users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3904 (class 0 OID 0)
-- Dependencies: 247
-- Name: system_users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.system_users_user_id_seq OWNED BY public.system_users.user_id;


--
-- TOC entry 250 (class 1259 OID 17804)
-- Name: volunteer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteer (
    volunteer_id integer NOT NULL,
    citizen_id integer,
    is_voter boolean DEFAULT false,
    volunteer_role character varying(100),
    active_in_project boolean DEFAULT true,
    notes text
);


ALTER TABLE public.volunteer OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17994)
-- Name: volunteer_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volunteer_assignments (
    assignment_id integer NOT NULL,
    volunteer_id integer,
    assigned_citizen_id integer,
    task_description text,
    pickup_location text,
    status character varying(50) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.volunteer_assignments OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17993)
-- Name: volunteer_assignments_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volunteer_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.volunteer_assignments_assignment_id_seq OWNER TO postgres;

--
-- TOC entry 3905 (class 0 OID 0)
-- Dependencies: 263
-- Name: volunteer_assignments_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volunteer_assignments_assignment_id_seq OWNED BY public.volunteer_assignments.assignment_id;


--
-- TOC entry 249 (class 1259 OID 17803)
-- Name: volunteer_volunteer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.volunteer_volunteer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.volunteer_volunteer_id_seq OWNER TO postgres;

--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 249
-- Name: volunteer_volunteer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.volunteer_volunteer_id_seq OWNED BY public.volunteer.volunteer_id;


--
-- TOC entry 3571 (class 2604 OID 17637)
-- Name: blood_type blood_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_type ALTER COLUMN blood_type_id SET DEFAULT nextval('public.blood_type_blood_type_id_seq'::regclass);


--
-- TOC entry 3579 (class 2604 OID 17732)
-- Name: citizen_attrib citizen_attrib_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib ALTER COLUMN citizen_attrib_id SET DEFAULT nextval('public.citizen_attrib_citizen_attrib_id_seq'::regclass);


--
-- TOC entry 3592 (class 2604 OID 17893)
-- Name: citizen_vote_preference vote_preference_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference ALTER COLUMN vote_preference_id SET DEFAULT nextval('public.citizen_vote_preference_vote_preference_id_seq'::regclass);


--
-- TOC entry 3578 (class 2604 OID 17714)
-- Name: citizens_gov citizens_gov_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_gov ALTER COLUMN citizens_gov_id SET DEFAULT nextval('public.citizens_gov_citizens_gov_id_seq'::regclass);


--
-- TOC entry 3590 (class 2604 OID 17873)
-- Name: citizens_services citizens_services_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services ALTER COLUMN citizens_services_id SET DEFAULT nextval('public.citizens_services_citizens_services_id_seq'::regclass);


--
-- TOC entry 3566 (class 2604 OID 17581)
-- Name: district district_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district ALTER COLUMN district_id SET DEFAULT nextval('public.district_district_id_seq'::regclass);


--
-- TOC entry 3573 (class 2604 OID 17655)
-- Name: education_level education_level_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_level ALTER COLUMN education_level_id SET DEFAULT nextval('public.education_level_education_level_id_seq'::regclass);


--
-- TOC entry 3570 (class 2604 OID 17628)
-- Name: election_district election_district_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_district ALTER COLUMN election_district_id SET DEFAULT nextval('public.election_district_election_district_id_seq'::regclass);


--
-- TOC entry 3569 (class 2604 OID 17619)
-- Name: election_type election_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_type ALTER COLUMN election_type_id SET DEFAULT nextval('public.election_type_election_type_id_seq'::regclass);


--
-- TOC entry 3568 (class 2604 OID 17609)
-- Name: election_year election_year_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_year ALTER COLUMN election_year_id SET DEFAULT nextval('public.election_year_election_year_id_seq'::regclass);


--
-- TOC entry 3565 (class 2604 OID 17572)
-- Name: governorate governorate_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.governorate ALTER COLUMN governorate_id SET DEFAULT nextval('public.governorate_governorate_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 17835)
-- Name: leader_reference leader_reference_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leader_reference ALTER COLUMN leader_reference_id SET DEFAULT nextval('public.leader_reference_leader_reference_id_seq'::regclass);


--
-- TOC entry 3575 (class 2604 OID 17682)
-- Name: list list_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list ALTER COLUMN list_id SET DEFAULT nextval('public.list_list_id_seq'::regclass);


--
-- TOC entry 3576 (class 2604 OID 17691)
-- Name: list_candidates list_candidate_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_candidates ALTER COLUMN list_candidate_id SET DEFAULT nextval('public.list_candidates_list_candidate_id_seq'::regclass);


--
-- TOC entry 3572 (class 2604 OID 17646)
-- Name: marital_status marital_status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marital_status ALTER COLUMN marital_status_id SET DEFAULT nextval('public.marital_status_marital_status_id_seq'::regclass);


--
-- TOC entry 3577 (class 2604 OID 17705)
-- Name: mukhtar mukh_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mukhtar ALTER COLUMN mukh_id SET DEFAULT nextval('public.mukhtar_mukh_id_seq'::regclass);


--
-- TOC entry 3567 (class 2604 OID 17595)
-- Name: municipality municipality_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipality ALTER COLUMN municipality_id SET DEFAULT nextval('public.municipality_municipality_id_seq'::regclass);


--
-- TOC entry 3588 (class 2604 OID 17850)
-- Name: relatives_details relatives_details_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatives_details ALTER COLUMN relatives_details_id SET DEFAULT nextval('public.relatives_details_relatives_details_id_seq'::regclass);


--
-- TOC entry 3595 (class 2604 OID 17972)
-- Name: service_status service_status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_status ALTER COLUMN service_status_id SET DEFAULT nextval('public.service_status_service_status_id_seq'::regclass);


--
-- TOC entry 3594 (class 2604 OID 17963)
-- Name: service_type service_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type ALTER COLUMN service_type_id SET DEFAULT nextval('public.service_type_service_type_id_seq'::regclass);


--
-- TOC entry 3574 (class 2604 OID 17664)
-- Name: support_status support_status_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_status ALTER COLUMN support_status_id SET DEFAULT nextval('public.support_status_support_status_id_seq'::regclass);


--
-- TOC entry 3581 (class 2604 OID 17785)
-- Name: system_users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users ALTER COLUMN user_id SET DEFAULT nextval('public.system_users_user_id_seq'::regclass);


--
-- TOC entry 3583 (class 2604 OID 17807)
-- Name: volunteer volunteer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer ALTER COLUMN volunteer_id SET DEFAULT nextval('public.volunteer_volunteer_id_seq'::regclass);


--
-- TOC entry 3596 (class 2604 OID 17997)
-- Name: volunteer_assignments assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.volunteer_assignments_assignment_id_seq'::regclass);


--
-- TOC entry 3631 (class 2606 OID 17641)
-- Name: blood_type blood_type_blood_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_type
    ADD CONSTRAINT blood_type_blood_type_name_key UNIQUE (blood_type_name);


--
-- TOC entry 3633 (class 2606 OID 17639)
-- Name: blood_type blood_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_type
    ADD CONSTRAINT blood_type_pkey PRIMARY KEY (blood_type_id);


--
-- TOC entry 3663 (class 2606 OID 17745)
-- Name: citizen_attrib citizen_attrib_email_address_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_email_address_key UNIQUE (email_address);


--
-- TOC entry 3665 (class 2606 OID 17743)
-- Name: citizen_attrib citizen_attrib_mobile_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_mobile_number_key UNIQUE (mobile_number);


--
-- TOC entry 3667 (class 2606 OID 17741)
-- Name: citizen_attrib citizen_attrib_national_id_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_national_id_number_key UNIQUE (national_id_number);


--
-- TOC entry 3669 (class 2606 OID 17739)
-- Name: citizen_attrib citizen_attrib_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_pkey PRIMARY KEY (citizen_attrib_id);


--
-- TOC entry 3689 (class 2606 OID 17896)
-- Name: citizen_vote_preference citizen_vote_preference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_pkey PRIMARY KEY (vote_preference_id);


--
-- TOC entry 3659 (class 2606 OID 17720)
-- Name: citizens_gov citizens_gov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_gov
    ADD CONSTRAINT citizens_gov_pkey PRIMARY KEY (citizens_gov_id);


--
-- TOC entry 3661 (class 2606 OID 17722)
-- Name: citizens_gov citizens_gov_reg_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_gov
    ADD CONSTRAINT citizens_gov_reg_number_key UNIQUE (reg_number);


--
-- TOC entry 3687 (class 2606 OID 17878)
-- Name: citizens_services citizens_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services
    ADD CONSTRAINT citizens_services_pkey PRIMARY KEY (citizens_services_id);


--
-- TOC entry 3611 (class 2606 OID 17585)
-- Name: district district_district_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_district_name_key UNIQUE (district_name);


--
-- TOC entry 3613 (class 2606 OID 17583)
-- Name: district district_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_pkey PRIMARY KEY (district_id);


--
-- TOC entry 3639 (class 2606 OID 17659)
-- Name: education_level education_level_level_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_level
    ADD CONSTRAINT education_level_level_name_key UNIQUE (level_name);


--
-- TOC entry 3641 (class 2606 OID 17657)
-- Name: education_level education_level_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_level
    ADD CONSTRAINT education_level_pkey PRIMARY KEY (education_level_id);


--
-- TOC entry 3627 (class 2606 OID 17632)
-- Name: election_district election_district_district_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_district
    ADD CONSTRAINT election_district_district_name_key UNIQUE (district_name);


--
-- TOC entry 3629 (class 2606 OID 17630)
-- Name: election_district election_district_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_district
    ADD CONSTRAINT election_district_pkey PRIMARY KEY (election_district_id);


--
-- TOC entry 3623 (class 2606 OID 17621)
-- Name: election_type election_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_type
    ADD CONSTRAINT election_type_pkey PRIMARY KEY (election_type_id);


--
-- TOC entry 3625 (class 2606 OID 17623)
-- Name: election_type election_type_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_type
    ADD CONSTRAINT election_type_type_name_key UNIQUE (type_name);


--
-- TOC entry 3619 (class 2606 OID 17612)
-- Name: election_year election_year_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_year
    ADD CONSTRAINT election_year_pkey PRIMARY KEY (election_year_id);


--
-- TOC entry 3621 (class 2606 OID 17614)
-- Name: election_year election_year_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.election_year
    ADD CONSTRAINT election_year_year_key UNIQUE (year);


--
-- TOC entry 3607 (class 2606 OID 17576)
-- Name: governorate governorate_governorate_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.governorate
    ADD CONSTRAINT governorate_governorate_name_key UNIQUE (governorate_name);


--
-- TOC entry 3609 (class 2606 OID 17574)
-- Name: governorate governorate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.governorate
    ADD CONSTRAINT governorate_pkey PRIMARY KEY (governorate_id);


--
-- TOC entry 3683 (class 2606 OID 17840)
-- Name: leader_reference leader_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leader_reference
    ADD CONSTRAINT leader_reference_pkey PRIMARY KEY (leader_reference_id);


--
-- TOC entry 3651 (class 2606 OID 17695)
-- Name: list_candidates list_candidates_candidate_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_candidates
    ADD CONSTRAINT list_candidates_candidate_id_key UNIQUE (candidate_id);


--
-- TOC entry 3653 (class 2606 OID 17693)
-- Name: list_candidates list_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_candidates
    ADD CONSTRAINT list_candidates_pkey PRIMARY KEY (list_candidate_id);


--
-- TOC entry 3647 (class 2606 OID 17686)
-- Name: list list_list_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list
    ADD CONSTRAINT list_list_name_key UNIQUE (list_name);


--
-- TOC entry 3649 (class 2606 OID 17684)
-- Name: list list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list
    ADD CONSTRAINT list_pkey PRIMARY KEY (list_id);


--
-- TOC entry 3635 (class 2606 OID 17648)
-- Name: marital_status marital_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marital_status
    ADD CONSTRAINT marital_status_pkey PRIMARY KEY (marital_status_id);


--
-- TOC entry 3637 (class 2606 OID 17650)
-- Name: marital_status marital_status_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marital_status
    ADD CONSTRAINT marital_status_status_name_key UNIQUE (status_name);


--
-- TOC entry 3655 (class 2606 OID 17709)
-- Name: mukhtar mukhtar_mukh_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mukhtar
    ADD CONSTRAINT mukhtar_mukh_name_key UNIQUE (mukh_name);


--
-- TOC entry 3657 (class 2606 OID 17707)
-- Name: mukhtar mukhtar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mukhtar
    ADD CONSTRAINT mukhtar_pkey PRIMARY KEY (mukh_id);


--
-- TOC entry 3615 (class 2606 OID 17599)
-- Name: municipality municipality_municipality_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipality
    ADD CONSTRAINT municipality_municipality_name_key UNIQUE (municipality_name);


--
-- TOC entry 3617 (class 2606 OID 17597)
-- Name: municipality municipality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipality
    ADD CONSTRAINT municipality_pkey PRIMARY KEY (municipality_id);


--
-- TOC entry 3685 (class 2606 OID 17853)
-- Name: relatives_details relatives_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatives_details
    ADD CONSTRAINT relatives_details_pkey PRIMARY KEY (relatives_details_id);


--
-- TOC entry 3695 (class 2606 OID 17974)
-- Name: service_status service_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_pkey PRIMARY KEY (service_status_id);


--
-- TOC entry 3697 (class 2606 OID 17976)
-- Name: service_status service_status_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_status_name_key UNIQUE (status_name);


--
-- TOC entry 3691 (class 2606 OID 17965)
-- Name: service_type service_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type
    ADD CONSTRAINT service_type_pkey PRIMARY KEY (service_type_id);


--
-- TOC entry 3693 (class 2606 OID 17967)
-- Name: service_type service_type_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type
    ADD CONSTRAINT service_type_type_name_key UNIQUE (type_name);


--
-- TOC entry 3643 (class 2606 OID 17666)
-- Name: support_status support_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_status
    ADD CONSTRAINT support_status_pkey PRIMARY KEY (support_status_id);


--
-- TOC entry 3645 (class 2606 OID 17668)
-- Name: support_status support_status_status_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_status
    ADD CONSTRAINT support_status_status_name_key UNIQUE (status_name);


--
-- TOC entry 3671 (class 2606 OID 17797)
-- Name: system_users system_users_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users
    ADD CONSTRAINT system_users_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3673 (class 2606 OID 17791)
-- Name: system_users system_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users
    ADD CONSTRAINT system_users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3675 (class 2606 OID 17795)
-- Name: system_users system_users_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users
    ADD CONSTRAINT system_users_user_email_key UNIQUE (user_email);


--
-- TOC entry 3677 (class 2606 OID 17793)
-- Name: system_users system_users_user_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users
    ADD CONSTRAINT system_users_user_name_key UNIQUE (user_name);


--
-- TOC entry 3699 (class 2606 OID 18003)
-- Name: volunteer_assignments volunteer_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_pkey PRIMARY KEY (assignment_id);


--
-- TOC entry 3679 (class 2606 OID 17992)
-- Name: volunteer volunteer_citizen_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_citizen_id_unique UNIQUE (citizen_id);


--
-- TOC entry 3681 (class 2606 OID 17810)
-- Name: volunteer volunteer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_pkey PRIMARY KEY (volunteer_id);


--
-- TOC entry 3704 (class 2606 OID 17751)
-- Name: citizen_attrib citizen_attrib_blood_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_blood_type_id_fkey FOREIGN KEY (blood_type_id) REFERENCES public.blood_type(blood_type_id) ON DELETE SET NULL;


--
-- TOC entry 3705 (class 2606 OID 17746)
-- Name: citizen_attrib citizen_attrib_citizens_gov_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_citizens_gov_id_fkey FOREIGN KEY (citizens_gov_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3706 (class 2606 OID 17944)
-- Name: citizen_attrib citizen_attrib_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(district_id) ON DELETE SET NULL;


--
-- TOC entry 3707 (class 2606 OID 17761)
-- Name: citizen_attrib citizen_attrib_education_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_education_level_id_fkey FOREIGN KEY (education_level_id) REFERENCES public.education_level(education_level_id) ON DELETE SET NULL;


--
-- TOC entry 3708 (class 2606 OID 17949)
-- Name: citizen_attrib citizen_attrib_governorate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_governorate_id_fkey FOREIGN KEY (governorate_id) REFERENCES public.governorate(governorate_id) ON DELETE SET NULL;


--
-- TOC entry 3709 (class 2606 OID 17756)
-- Name: citizen_attrib citizen_attrib_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES public.marital_status(marital_status_id) ON DELETE SET NULL;


--
-- TOC entry 3710 (class 2606 OID 17776)
-- Name: citizen_attrib citizen_attrib_mukh_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_mukh_id_fkey FOREIGN KEY (mukh_id) REFERENCES public.mukhtar(mukh_id) ON DELETE SET NULL;


--
-- TOC entry 3711 (class 2606 OID 17939)
-- Name: citizen_attrib citizen_attrib_municipality_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_municipality_id_fkey FOREIGN KEY (municipality_id) REFERENCES public.municipality(municipality_id) ON DELETE SET NULL;


--
-- TOC entry 3712 (class 2606 OID 17771)
-- Name: citizen_attrib citizen_attrib_support_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_attrib
    ADD CONSTRAINT citizen_attrib_support_status_id_fkey FOREIGN KEY (support_status_id) REFERENCES public.support_status(support_status_id) ON DELETE SET NULL;


--
-- TOC entry 3723 (class 2606 OID 17897)
-- Name: citizen_vote_preference citizen_vote_preference_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_citizen_id_fkey FOREIGN KEY (citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3724 (class 2606 OID 17912)
-- Name: citizen_vote_preference citizen_vote_preference_election_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_election_district_id_fkey FOREIGN KEY (election_district_id) REFERENCES public.election_district(election_district_id) ON DELETE SET NULL;


--
-- TOC entry 3725 (class 2606 OID 17907)
-- Name: citizen_vote_preference citizen_vote_preference_election_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_election_type_id_fkey FOREIGN KEY (election_type_id) REFERENCES public.election_type(election_type_id) ON DELETE CASCADE;


--
-- TOC entry 3726 (class 2606 OID 17902)
-- Name: citizen_vote_preference citizen_vote_preference_election_year_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_election_year_id_fkey FOREIGN KEY (election_year_id) REFERENCES public.election_year(election_year_id) ON DELETE CASCADE;


--
-- TOC entry 3727 (class 2606 OID 17927)
-- Name: citizen_vote_preference citizen_vote_preference_fav1_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_fav1_candidate_id_fkey FOREIGN KEY (fav1_candidate_id) REFERENCES public.list_candidates(candidate_id) ON DELETE SET NULL;


--
-- TOC entry 3728 (class 2606 OID 17932)
-- Name: citizen_vote_preference citizen_vote_preference_fav2_candidate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_fav2_candidate_id_fkey FOREIGN KEY (fav2_candidate_id) REFERENCES public.list_candidates(candidate_id) ON DELETE SET NULL;


--
-- TOC entry 3729 (class 2606 OID 17922)
-- Name: citizen_vote_preference citizen_vote_preference_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.list(list_id) ON DELETE SET NULL;


--
-- TOC entry 3730 (class 2606 OID 17917)
-- Name: citizen_vote_preference citizen_vote_preference_municipality_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizen_vote_preference
    ADD CONSTRAINT citizen_vote_preference_municipality_id_fkey FOREIGN KEY (municipality_id) REFERENCES public.municipality(municipality_id) ON DELETE SET NULL;


--
-- TOC entry 3703 (class 2606 OID 17723)
-- Name: citizens_gov citizens_gov_municipality_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_gov
    ADD CONSTRAINT citizens_gov_municipality_id_fkey FOREIGN KEY (municipality_id) REFERENCES public.municipality(municipality_id) ON DELETE SET NULL;


--
-- TOC entry 3719 (class 2606 OID 17879)
-- Name: citizens_services citizens_services_citizens_gov_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services
    ADD CONSTRAINT citizens_services_citizens_gov_id_fkey FOREIGN KEY (citizens_gov_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3720 (class 2606 OID 17884)
-- Name: citizens_services citizens_services_relatives_details_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services
    ADD CONSTRAINT citizens_services_relatives_details_id_fkey FOREIGN KEY (relatives_details_id) REFERENCES public.relatives_details(relatives_details_id) ON DELETE SET NULL;


--
-- TOC entry 3700 (class 2606 OID 17586)
-- Name: district district_governorate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_governorate_id_fkey FOREIGN KEY (governorate_id) REFERENCES public.governorate(governorate_id) ON DELETE CASCADE;


--
-- TOC entry 3721 (class 2606 OID 17982)
-- Name: citizens_services fk_service_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services
    ADD CONSTRAINT fk_service_status FOREIGN KEY (service_status_id) REFERENCES public.service_status(service_status_id) ON DELETE SET NULL;


--
-- TOC entry 3722 (class 2606 OID 17977)
-- Name: citizens_services fk_service_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citizens_services
    ADD CONSTRAINT fk_service_type FOREIGN KEY (service_type_id) REFERENCES public.service_type(service_type_id) ON DELETE SET NULL;


--
-- TOC entry 3715 (class 2606 OID 17841)
-- Name: leader_reference leader_reference_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leader_reference
    ADD CONSTRAINT leader_reference_citizen_id_fkey FOREIGN KEY (citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3702 (class 2606 OID 17696)
-- Name: list_candidates list_candidates_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.list_candidates
    ADD CONSTRAINT list_candidates_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.list(list_id) ON DELETE CASCADE;


--
-- TOC entry 3701 (class 2606 OID 17600)
-- Name: municipality municipality_district_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipality
    ADD CONSTRAINT municipality_district_id_fkey FOREIGN KEY (district_id) REFERENCES public.district(district_id) ON DELETE CASCADE;


--
-- TOC entry 3716 (class 2606 OID 17854)
-- Name: relatives_details relatives_details_citizens_gov_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatives_details
    ADD CONSTRAINT relatives_details_citizens_gov_id_fkey FOREIGN KEY (citizens_gov_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3717 (class 2606 OID 17864)
-- Name: relatives_details relatives_details_marital_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatives_details
    ADD CONSTRAINT relatives_details_marital_status_id_fkey FOREIGN KEY (marital_status_id) REFERENCES public.marital_status(marital_status_id) ON DELETE SET NULL;


--
-- TOC entry 3718 (class 2606 OID 17954)
-- Name: relatives_details relatives_details_related_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.relatives_details
    ADD CONSTRAINT relatives_details_related_citizen_id_fkey FOREIGN KEY (related_citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE SET NULL;


--
-- TOC entry 3713 (class 2606 OID 17798)
-- Name: system_users system_users_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_users
    ADD CONSTRAINT system_users_citizen_id_fkey FOREIGN KEY (citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3731 (class 2606 OID 18009)
-- Name: volunteer_assignments volunteer_assignments_assigned_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_assigned_citizen_id_fkey FOREIGN KEY (assigned_citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


--
-- TOC entry 3732 (class 2606 OID 18004)
-- Name: volunteer_assignments volunteer_assignments_volunteer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteer(volunteer_id) ON DELETE CASCADE;


--
-- TOC entry 3714 (class 2606 OID 17811)
-- Name: volunteer volunteer_citizen_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volunteer
    ADD CONSTRAINT volunteer_citizen_id_fkey FOREIGN KEY (citizen_id) REFERENCES public.citizens_gov(citizens_gov_id) ON DELETE CASCADE;


-- Completed on 2025-04-13 04:54:44 EEST

--
-- PostgreSQL database dump complete
--

