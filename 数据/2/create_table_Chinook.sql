CREATE TABLE "Artist" (
	"ArtistId" INTEGER not null,
	"Name" NVARCHAR(120),
	primary key("ArtistId"));

CREATE TABLE "Album" (
	"AlbumId" INTEGER not null,
	"Title" NVARCHAR(160) not null,
	"ArtistId" INTEGER not null,
	primary key("AlbumId"),
	foreign key("ArtistId") references "Artist" ("ArtistId"));

CREATE TABLE "Employee" (
	"EmployeeId" INTEGER not null,
	"LastName" NVARCHAR(20) not null,
	"FirstName" NVARCHAR(20) not null,
	"Title" NVARCHAR(30),
	"ReportsTo" INTEGER,
	"BirthDate" DATETIME,
	"HireDate" DATETIME,
	"Address" NVARCHAR(70),
	"City" NVARCHAR(40),
	"State" NVARCHAR(40),
	"Country" NVARCHAR(40),
	"PostalCode" NVARCHAR(10),
	"Phone" NVARCHAR(24),
	"Fax" NVARCHAR(24),
	"Email" NVARCHAR(60),
	primary key("EmployeeId"),
	foreign key("ReportsTo") references "Employee" ("EmployeeId"));

CREATE TABLE "Customer" (
	"CustomerId" INTEGER not null,
	"FirstName" NVARCHAR(40) not null,
	"LastName" NVARCHAR(20) not null,
	"Company" NVARCHAR(80),
	"Address" NVARCHAR(70),
	"City" NVARCHAR(40),
	"State" NVARCHAR(40),
	"Country" NVARCHAR(40),
	"PostalCode" NVARCHAR(10),
	"Phone" NVARCHAR(24),
	"Fax" NVARCHAR(24),
	"Email" NVARCHAR(60) not null,
	"SupportRepId" INTEGER,
	primary key("CustomerId"),
	foreign key("SupportRepId") references "Employee" ("EmployeeId"));

CREATE TABLE "Genre" (
	"GenreId" INTEGER not null,
	"Name" NVARCHAR(120),
	primary key("GenreId"));

CREATE TABLE "Invoice" (
	"InvoiceId" INTEGER not null,
	"CustomerId" INTEGER not null,
	"InvoiceDate" DATETIME not null,
	"BillingAddress" NVARCHAR(70),
	"BillingCity" NVARCHAR(40),
	"BillingState" NVARCHAR(40),
	"BillingCountry" NVARCHAR(40),
	"BillingPostalCode" NVARCHAR(10),
	"Total" NUMERIC(10,2) not null,
	primary key("InvoiceId"),
	foreign key("CustomerId") references "Customer" ("CustomerId"));

CREATE TABLE "MediaType" (
	"MediaTypeId" INTEGER not null,
	"Name" NVARCHAR(120),
	primary key("MediaTypeId"));

CREATE TABLE "Track" (
	"TrackId" INTEGER not null,
	"Name" NVARCHAR(200) not null,
	"AlbumId" INTEGER,
	"MediaTypeId" INTEGER not null,
	"GenreId" INTEGER,
	"Composer" NVARCHAR(220),
	"Milliseconds" INTEGER not null,
	"Bytes" INTEGER,
	"UnitPrice" NUMERIC(10,2) not null,
	primary key("TrackId"),
	foreign key("AlbumId") references "Album" ("AlbumId"),
	foreign key("GenreId") references "Genre" ("GenreId"),
	foreign key("MediaTypeId") references "MediaType" ("MediaTypeId"));

CREATE TABLE "InvoiceLine" (
	"InvoiceLineId" INTEGER not null,
	"InvoiceId" INTEGER not null,
	"TrackId" INTEGER not null,
	"UnitPrice" NUMERIC(10,2) not null,
	"Quantity" INTEGER not null,
	primary key("InvoiceLineId"),
	foreign key("InvoiceId") references "Invoice" ("InvoiceId"),
	foreign key("TrackId") references "Track" ("TrackId"));

CREATE TABLE "Playlist" (
	"PlaylistId" INTEGER not null,
	"Name" NVARCHAR(120),
	primary key("PlaylistId"));

CREATE TABLE "PlaylistTrack" (
	"PlaylistId" INTEGER not null,
	"TrackId" INTEGER not null,
	primary key("PlaylistId", "TrackId"),
	foreign key("PlaylistId") references "Playlist" ("PlaylistId"),
	foreign key("TrackId") references "Track" ("TrackId"));

CREATE UNIQUE INDEX "IPK_Artist" ON "Artist" ("ArtistId");
CREATE INDEX "IFK_AlbumArtistId" ON "Album" ("ArtistId");
CREATE UNIQUE INDEX "IPK_Album" ON "Album" ("AlbumId");
CREATE INDEX "IFK_EmployeeReportsTo" ON "Employee" ("ReportsTo");
CREATE UNIQUE INDEX "IPK_Employee" ON "Employee" ("EmployeeId");
CREATE INDEX "IFK_CustomerSupportRepId" ON "Customer" ("SupportRepId");
CREATE UNIQUE INDEX "IPK_Customer" ON "Customer" ("CustomerId");
CREATE UNIQUE INDEX "IPK_Genre" ON "Genre" ("GenreId");
CREATE INDEX "IFK_InvoiceCustomerId" ON "Invoice" ("CustomerId");
CREATE UNIQUE INDEX "IPK_Invoice" ON "Invoice" ("InvoiceId");
CREATE UNIQUE INDEX "IPK_MediaType" ON "MediaType" ("MediaTypeId");
CREATE INDEX "IFK_TrackMediaTypeId" ON "Track" ("MediaTypeId");
CREATE INDEX "IFK_TrackGenreId" ON "Track" ("GenreId");
CREATE INDEX "IFK_TrackAlbumId" ON "Track" ("AlbumId");
CREATE UNIQUE INDEX "IPK_Track" ON "Track" ("TrackId");
CREATE INDEX "IFK_InvoiceLineTrackId" ON "InvoiceLine" ("TrackId");
CREATE INDEX "IFK_InvoiceLineInvoiceId" ON "InvoiceLine" ("InvoiceId");
CREATE UNIQUE INDEX "IPK_InvoiceLine" ON "InvoiceLine" ("InvoiceLineId");
CREATE UNIQUE INDEX "IPK_Playlist" ON "Playlist" ("PlaylistId");
CREATE INDEX "IFK_PlaylistTrackTrackId" ON "PlaylistTrack" ("TrackId");
CREATE UNIQUE INDEX "IPK_PlaylistTrack" ON "PlaylistTrack" ("PlaylistId", "TrackId");