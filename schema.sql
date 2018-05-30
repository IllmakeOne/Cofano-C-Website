CREATE TABLE Ports(
 name TEXT NOT NULL, 
 p_key char,
 PRIMARY KEY(p_key)
);

 CREATE TABLE Destination_ports(
 name TEXT NOT NULL, 
 unlo char NOT NULL,
 d_key char,
 PRIMARY KEY(d_key)
 );

 CREATE TABLE Terminals(
 name TEXT NOT NULL, 
 terminal_code pk , 
 type char NOT NULL, 
 unlo char NOT NULL,
 PRIMARY KEY(terminal_code)
 );

 CREATE TABLE Seaships(
 imo char, 
 name TEXT NOT NULL,
 callsign char,
 mmsi char , 
 depth int,
 s_id int,
 PRIMARY KEY(s_id));

 
 CREATE TABLE Undgs(
 descriptionEN char,
 hazardNO char,
 classification_Code char, 
 tankSpecialProvisions char, 
 station char, 
 transportForbidden char , 
 transportcategory char, 
 descriptionDE char, 
 collective char, 
 unNO char, 
 descriptionFR char, 
 classification char, 
 packingGroup char , 
 descriptionNL char,
 notApplicable char, 
 tank_Code char, 
 vehicleTankCarriage char, 
 tunnelCode char, 
 collective char, 
 labels char,
 undgs_id int,
 PRIMARY KEY(undgs_id)
 );


 CREATE TABLE Container_types(
 display_name char, 
 iso_Code int, 
 description varchar, 
 length float  , 
 height float , 
 reefer char, 
 c_type char,
 PRIMARY KEY(c_type)
 );




