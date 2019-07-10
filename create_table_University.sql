CREATE TABLE "department" (
	"d_id" VARCHAR(5),
	"d_title" VARCHAR(10),
	"location" VARCHAR(15),
	primary key("d_id"));

CREATE TABLE "staff" (
	"s_id" VARCHAR(4),
	"initials" VARCHAR (4),
	"s_name" VARCHAR(15),
	"pos" VARCHAR(15),
	"qual" VARCHAR(5),
	"d_id" VARCHAR(5),
	primary key("s_id"),
	foreign key("d_id") references "department" ("d_id"));

CREATE TABLE "courses" (
	"c_id" VARCHAR(3),
	"c_title" VARCHAR(30),
	"code" VARCHAR(4),
	"year" VARCHAR(4),
	"d_id" VARCHAR(5),
	primary key("c_id"),
	foreign key("d_id") references "department" ("d_id"));

CREATE TABLE "projects" (
	"p_id" VARCHAR(10),
	"p_title" VARCHAR(30),
	"funder" VARCHAR(10),
	"funding" INT,
	primary key("p_id"));

CREATE TABLE "give_course" (
	"s_id" VARCHAR(4),
	"c_id" VARCHAR(3),
	primary key("s_id", "c_id"),
	foreign key("s_id") references "staff" ("s_id"),
	foreign key("c_id") references "courses" ("c_id"));

CREATE TABLE "work_on" (
	"s_id" VARCHAR(4),
	"p_id" VARCHAR(10),
	"start_date" INT,
	"stop_date" INT,
	primary key("s_id", "p_id"),
	foreign key("s_id") references "staff" ("s_id"),
	foreign key("p_id") references "projects" ("p_id"));

