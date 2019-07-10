CREATE TABLE "planets" (
	"planet_id" INTEGER,
	"name" VARCHAR(15) not null,
	"popvalue" INTEGER,
	primary key("planet_id"));

CREATE TABLE "heroes" (
	"hero_id" INTEGER,
	"codename" VARCHAR(30),
	"secretIdentity" VARCHAR(30),
	"homeWorld_id" INTEGER,
	primary key("hero_id"),
	foreign key("homeWorld_id") references "planets" ("planet_id"));

CREATE TABLE "powers" (
	"hero_id" INTEGER,
	"description" VARCHAR (100),
	primary key("hero_id", "description"),
	foreign key("hero_id") references "heroes" ("hero_id"));

CREATE TABLE "missions" (
	"name" VARCHAR (100),
	"planet_name" VARCHAR (15) not null,
	primary key("name"),
	foreign key("planet_name") references "planets" ("name"));

