-- --------------------------------------------------------------------------------
-- Name: Devin Watters  
-- Class: IT-111 
-- Abstract: Assignment 14
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbGetemtobuyit;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #10
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TOrderProducts')		IS NOT NULL DROP TABLE TOrderProducts
IF OBJECT_ID ('TOrders')			IS NOT NULL DROP TABLE TOrders
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TRaces')				IS NOT NULL DROP TABLE TRaces
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TVendors')			IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TProducts')			IS NOT NULL DROP TABLE TProducts

-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmDateOfBirth			DATETIME		NOT NULL
	,intRaceID				INTEGER			NOT NULL
	,intGenderID			INTEGER			NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TCities
(
	 intCityID			INTEGER			NOT NULL
	,strCity			VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TRaces
(
	 intRaceID			INTEGER			NOT NULL
	,strRace			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRaces_PK PRIMARY KEY ( intRaceID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TOrders
(
	 intOrderID				INTEGER			NOT NULL
	,intCustomerID			INTEGER			NOT NULL
	,strOrderNumber			VARCHAR(255)	NOT NULL
	,strStatus				VARCHAR(255)	NOT NULL
	,dtmOrderDate			DATETIME		NOT NULL
	,CONSTRAINT TOrders_PK PRIMARY KEY ( intOrderID )
)

CREATE TABLE TProducts
(
	 intProductID			INTEGER			NOT NULL
	,intVendorID			INTEGER			NOT NULL
	,strProductName			VARCHAR(255)	NOT NULL
	,monCostofProduct		MONEY			NOT NULL
	,monRetailCost			MONEY			NOT NULL
	,strProductCategory		VARCHAR(255)	NOT NULL
	,intInventory			INTEGER			NOT NULL
	,CONSTRAINT TProducts_PK PRIMARY KEY ( intProductID )
)

CREATE TABLE TVendors
(
	 intVendorID			INTEGER			NOT NULL
	,strVendorName			VARCHAR(255)	NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,strContactFirstName	VARCHAR(255)	NOT NULL
	,strContactLastName		VARCHAR(255)	NOT NULL
	,strContactPhone		VARCHAR(255)	NOT NULL
	,strContactEmail		VARCHAR(255)	NOT NULL
	,CONSTRAINT TVendors_PK PRIMARY KEY ( intVendorID )
)

CREATE TABLE TOrderProducts
(
	 intOrderProductID		INTEGER			NOT NULL
	,intOrderID				INTEGER			NOT NULL
	,intProductID			INTEGER			NOT NULL
	,CONSTRAINT TTOrderProducts_PK PRIMARY KEY ( intOrderProductID )
)


-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TOrders							TCustomers					intCustomerID	
-- 2	TProducts						TVendors					intVendorID
-- 3	TOrderProducts					TOrders						intOrderID
-- 4	TOrderProducts					TProducts					intProductID
-- 5	TCustomers						TStates						intStateID
-- 6	TCustomers						TCities						intCityID
-- 7	TCustomers						TGenders					intGenderID
-- 8	TCustomers						TRaces						intRaceID
-- 9	TVendors						TStates						intStateID
-- 10	TVendors						TCities						intCityID


-- 1
ALTER TABLE TOrders ADD CONSTRAINT TOrders_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 2
ALTER TABLE TProducts ADD CONSTRAINT TProducts_TVendors_FK 
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

-- 3
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TOrders_FK 
FOREIGN KEY ( intOrderID ) REFERENCES TOrders ( intOrderID )

-- 4
ALTER TABLE TOrderProducts	 ADD CONSTRAINT TOrderProducts_TProducts_FK 
FOREIGN KEY ( intProductID ) REFERENCES TProducts ( intProductID )

-- 5
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates (intStateID ) ON DELETE CASCADE

-- 6
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities (intCityID ) ON DELETE CASCADE

-- 7
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TRaces_FK 
FOREIGN KEY ( intRaceID ) REFERENCES TRaces (intRaceID ) ON DELETE CASCADE

-- 8
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TGenders_FK 
FOREIGN KEY ( intGenderID ) REFERENCES TGenders (intGenderID ) ON DELETE CASCADE

-- 9
ALTER TABLE TVendors	 ADD CONSTRAINT TVendors_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates (intStateID ) ON DELETE CASCADE

-- 10
ALTER TABLE TVendors	 ADD CONSTRAINT TVendors_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities (intCityID ) ON DELETE CASCADE

-- --------------------------------------------------------------------------------
--	Step #3 : Add Data - INSERTS
-- --------------------------------------------------------------------------------
INSERT INTO TStates( intStateID, strState)
VALUES				(1, 'Ohio')
				   ,(2, 'Kentucky')
				   ,(3, 'Indiana')

INSERT INTO TCities( intCityID, strCity)
VALUES				(1, 'Cincinnati')
				   ,(2, 'Florence')
				   ,(3, 'Norwood')
				   ,(4, 'Milford')
				   ,(5, 'West Chester')

INSERT INTO TRaces( intRaceID, strRace)
VALUES				(1, 'Hispanic')
				   ,(2, 'African American')
				   ,(3, 'Cuacasion')
				   ,(4, 'Asian')

INSERT INTO TGenders( intGenderID, strGender)
VALUES				(1, 'Male')
				   ,(2, 'Female')
				   ,(3, 'Other')

INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfBirth, intRaceID, intGenderID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201', '1/1/1997', 1, 1)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 3, 1, '45218', '12/1/1999', 2, 2)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 5, 1, '45069', '9/23/1998', 1, 1)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 4, 1)


INSERT INTO TOrders ( intOrderID, intCustomerID, strOrderNumber, strStatus, dtmOrderDate)
VALUES				 ( 1, 1, '10101010', 'Shipped', '8/28/2017')
					,( 2, 1, '20202020', 'Ordered', '8/28/2007')
					,( 3, 2, '30303030', 'Delivered', '6/28/2017')
					,( 4, 4, '40404040', 'Delivered', '5/28/2007')

INSERT INTO TVendors ( intVendorID, strVendorName, strAddress, intCityID, intStateID, strZip, strContactFirstName, strContactLastName, strContactPhone, strContactEmail)
VALUES					   (1, 'TreesRUs', '321 Elm St.', 1, 1, '45201', 'Iwana', 'Cleantooth', '555-555-5555', 'Icleantooth@treesrus.com')
						  ,(2, 'ShirtsRUs', '987 Main St.', 3, 1, '45218', 'Eilene', 'Totheright' , '666-666-6666', 'etotheright@shirtsrus.com')
						  ,(3, 'ToysRUs', '1569 Windisch Rd.', 5, 1, '45069', 'Mike', 'Metosing', '888-888-8888', 'mmetosing@toysrus.com')					  

INSERT INTO TProducts( intProductID, intVendorID, strProductName, monCostofProduct, monRetailCost, strProductCategory, intInventory)
VALUES					   (1, 1,'Toothpicks', .10, .40, 'Every Day', 100000)
						  ,(2, 2,'T-Shirts', 5.10, 15.40, 'Apparel', 2000)
						  ,(3, 3,'uPlay', 44.10, 85.40, 'Electronics', 300)

INSERT INTO TOrderProducts ( intOrderProductID, intOrderID, intProductID)
VALUES				 ( 1, 1, 1 )
					,( 2, 1, 2 )
					,( 3, 2, 3 )
					,( 4, 3, 2 )
					,( 5, 3, 3 )
					,( 6, 4, 3 )

-- --------------------------------------------------------------------------------
--	Explicit Join Examples
-- --------------------------------------------------------------------------------
-- 1
SELECT TC.strLastName, TC.strFirstName, TOR.dtmOrderDate, TP.strProductName
FROM TCustomers as TC JOIN TOrders as TOR
	ON TC.intCustomerID	= TOR.intCustomerID

	JOIN TProducts as TP JOIN TOrderProducts as TPO
	ON TP.intProductID = TPO.intProductID
	
	ON TOR.intOrderID = TPO.intOrderID
	--Is this^ right?


-- 2
SELECT TP.strProductName, TP.strProductCategory,TP.monRetailCost, TV.strVendorName
FROM TProducts as TP JOIN TVendors as TV
	ON TP.intVendorID = TV.intVendorID
	ORDER BY TV.strVendorName, TP.strProductCategory, TP.monRetailCost


--3
SELECT TP.strProductName, TP.intInventory, TV.strVendorName, TV.strContactFirstName, TV.strContactLastName, TV.strContactPhone, TV.strContactEmail
FROM TProducts as TP JOIN TVendors as TV
	ON TP.intVendorID = TV.intVendorID
	Where TP.intInventory < 10

--4
SELECT TC.strLastName, TC.strFirstName, TC.dtmDateOfBirth, TC.intRaceID,TC.intGenderID
FROM TCustomers as TC JOIN TOrders as TOR
	ON TC.intCustomerID	= TOR.intCustomerID

	JOIN TProducts as TP JOIN TOrderProducts as TPO
	ON TP.intProductID = TPO.intProductID
	
	JOIN TRaces as TR
	ON TC.intRaceID = TR.intRaceID
	
	WHERE TC.dtmDateOfBirth  > '10/28/1998'
	ORDER BY TC.intRaceID

 --5
 SELECT TP.strProductName, TV.strVendorName, TC.intStateID  
FROM TProducts as TP JOIN TVendors as TV
	ON TP.intVendorID = TV.intVendorID

	JOIN TCustomers as TC JOIN TOrders as TOR
	ON TC.intCustomerID	= TOR.intCustomerID

	JOIN TOrderProducts as TPO
	ON TP.intProductID = TPO.intProductID

	ORDER BY TC.inStateID
