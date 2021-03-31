-- --------------------------------------------------------------------------------
-- Name:  Devin  Watters
-- Class: IT-111 
-- Abstract: Test 2 part 2
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbIndemnities;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						Problem #10
-- --------------------------------------------------------------------------------

-- Drop Table Statements
IF OBJECT_ID ('TCustomerPolicy')			IS NOT NULL DROP TABLE TCustomerPolicy
IF OBJECT_ID ('TStatus')			IS NOT NULL DROP TABLE TStatus
IF OBJECT_ID ('TCustomers')			IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TGenders')			IS NOT NULL DROP TABLE TGenders
IF OBJECT_ID ('TCities')			IS NOT NULL DROP TABLE TCities
IF OBJECT_ID ('TStates')			IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TMaritalStatus')		IS NOT NULL DROP TABLE TMaritalStatus
IF OBJECT_ID ('TIncome')			IS NOT NULL DROP TABLE TIncome
IF OBJECT_ID ('TRank')				IS NOT NULL DROP TABLE TRank
IF OBJECT_ID ('TRisk')				IS NOT NULL DROP TABLE TRisk
IF OBJECT_ID ('TSaleAgents')		IS NOT NULL DROP TABLE TSaleAgents
IF OBJECT_ID ('TClaim')				IS NOT NULL DROP TABLE TClaim
IF OBJECT_ID ('TType')				IS NOT NULL DROP TABLE TType
IF OBJECT_ID ('TClaimSpecialists')	IS NOT NULL DROP TABLE TType
IF OBJECT_ID ('TPolicy')			IS NOT NULL DROP TABLE TType
-- --------------------------------------------------------------------------------
--	Step #1 : Create table 
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	 intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(255)	NOT NULL
	,strLastName			VARCHAR(255)	NOT NULL
	,strSSN					VARCHAR(255)	NOT NULL
	,intMaritalStatusID		INTEGER			NOT NULL
	,intIncomeID			INTEGER			NOT NULL
	,intRiskID				INTEGER			NOT NULL
	,strAddress				VARCHAR(255)	NOT NULL
	,intCityID				INTEGER			NOT NULL
	,intStateID				INTEGER			NOT NULL
	,strZip					VARCHAR(255)	NOT NULL
	,dtmDateOfBirth			DATETIME		NOT NULL
	,intGenderID			INTEGER			NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)
CREATE TABLE TMaritalStatus
(
	 intMaritalStatusID		INTEGER			NOT NULL
	,strMStatus				VARCHAR(255)	NOT NULL
	,CONSTRAINT TMaritalStatus_PK PRIMARY KEY ( intMaritalStatusID )
)

	CREATE TABLE TIncome
(
	 intIncomeID			INTEGER			NOT NULL
	,strIncome				VARCHAR(255)	NOT NULL
	,CONSTRAINT TIncome_PK PRIMARY KEY ( intIncomeID )
)

	CREATE TABLE TPolicy
(
	 intPolicyID			INTEGER			NOT NULL
	,intTypeID				INTEGER			NOT NULL
	,intSaleAgentID			INTEGER			NOT NULL
	,dtmDateOfPurchase		DATETIME		NOT NULL
	,StrPremuim				VARCHAR(255)	NOT NULL
	,CONSTRAINT TPolicy_PK PRIMARY KEY ( intPolicyID )
)

CREATE TABLE TType
(
	 intTypeID				INTEGER			NOT NULL
	,strType				VARCHAR(255)	NOT NULL
	,CONSTRAINT TType_PK PRIMARY KEY ( intTypeID )
)

CREATE TABLE TCities
(
	 intCityID				INTEGER			NOT NULL
	,strCity				VARCHAR(255)	NOT NULL
	,CONSTRAINT TCities_PK PRIMARY KEY ( intCityID )
)

	CREATE TABLE TClaim
(
	 intClaimID						INTEGER			NOT NULL
	,intStatusID					INTEGER			NOT NULL
	,StrReason						VARCHAR(255)	NOT NULL
	,intClaimSpecialistID			INTEGER			NOT NULL
	,dtmDateOfClaim					DATETIME		NOT NULL
	,intClaimAmount					INTEGER			NOT NULL
	,intPolicyID					INTEGER			NOT NULL
	,CONSTRAINT TClaim_PK PRIMARY KEY ( intClaimID )
)

CREATE TABLE TRisk
(
	 intRiskID			INTEGER			NOT NULL
	,strRisk			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRisk_PK PRIMARY KEY ( intRiskID )
)

CREATE TABLE TRank
(
	 intRankID			INTEGER			NOT NULL
	,strRank			VARCHAR(255)	NOT NULL
	,CONSTRAINT TRank_PK PRIMARY KEY ( intRankID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL
	,strState			VARCHAR(255)	NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)

CREATE TABLE TGenders
(
	 intGenderID		INTEGER			NOT NULL
	,strGender			VARCHAR(255)	NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TStatus
(
	 intStatusID			INTEGER			NOT NULL
	,strStatus				VARCHAR(255)	NOT NULL
	,CONSTRAINT TStatus_PK PRIMARY KEY ( intStatusID )
)


CREATE TABLE TClaimSpecialists
(
	 intClaimSpecialistID			INTEGER			NOT NULL
	,strFirstName					VARCHAR(255)	NOT NULL
	,strLastName					VARCHAR(255)	NOT NULL
	,CONSTRAINT TClaimSpecialists_PK PRIMARY KEY ( intClaimSpecialistID )
)
CREATE TABLE TSaleAgents
(
	 intSalesAgentID			INTEGER			NOT NULL
	,strFirstName				VARCHAR(255)	NOT NULL
	,strLastName				VARCHAR(255)	NOT NULL
	,strAddress					VARCHAR(255)	NOT NULL
	,intCityID					INTEGER			NOT NULL
	,intStateID					INTEGER			NOT NULL
	,intGenderID				INTEGER			NOT NULL
	,intRankID					INTEGER			NOT NULL
	,strZip						VARCHAR(255)	NOT NULL
	,dtmDateOfhire				DATETIME		NOT NULL
	,CONSTRAINT TSaleAgents_PK PRIMARY KEY ( intSalesAgentID )
)

CREATE TABLE TCustomerPolicy
(
	 intCustomerPolicyID		INTEGER			NOT NULL
	,intCustomerID				INTEGER			NOT NULL
	,intPolicyID				INTEGER			NOT NULL
	,CONSTRAINT TCustomerPolicy_PK PRIMARY KEY ( intCustomerPolicyID )
)


-- --------------------------------------------------------------------------------
--	Step #2 : Establish Referential Integrity 
-- --------------------------------------------------------------------------------
--
-- #	Child							Parent						Column
-- -	-----							------						---------
-- 1	TCustomers						TMaritalStatus				intMaritalStatusID	
-- 2	TCustomers						TRisk						intRiskID
-- 3	TCustomers						TIncome						intIncomeID
-- 4	TCustomers						TStates						intStateID
-- 5	TCustomers						TCities						intCityID
-- 6	TCustomers						TGenders					intGenderID
-- 7	TCustomerPolicy					TCustomers					intCustomerID
-- 8	TCustomerPolicy					TPolicy						intPolicyID
-- 9	TPolicy							TType						intTypeID
-- 10	TPolicy							TSaleAgents					intSaleAgentID
-- 11	TPolicy							TClaim						intClaimID
-- 12	TClaim							TStatus						intStatusID
-- 13	TClaim							TClaimSpecialist			intClaimSpecialistID
-- 14	TSaleAgents						TStates						intStateID
-- 15	TSaleAgents						TCities						intCityID
-- 16	TSaleAgents						TGender						intGenderID
-- 17	TSaleAgents						TRank						intRankID

--1
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TMaritalStatus_FK 
FOREIGN KEY ( intMaritalStatusID ) REFERENCES TMaritalStatus ( intMaritalStatusID )

--2
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TRisk_FK 
FOREIGN KEY ( intRiskID ) REFERENCES TRisk ( intRiskID )

--3
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TIncome_FK 
FOREIGN KEY ( intIncomeID ) REFERENCES TIncome ( intIncomeID )

--4
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates (intStateID ) ON DELETE CASCADE

--5
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities (intCityID ) ON DELETE CASCADE

--6
ALTER TABLE TCustomers	 ADD CONSTRAINT TCustomers_TGenders_FK 
FOREIGN KEY ( intGenderID ) REFERENCES TGenders (intGenderID ) ON DELETE CASCADE

--7
ALTER TABLE TCustomerPolicy	 ADD CONSTRAINT TCustomerPolicy_TCustomers_FK 
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers (intCustomerID ) ON DELETE CASCADE

--8
ALTER TABLE TCustomerPolicy	 ADD CONSTRAINT TCustomerPolicy_TPolicy_FK 
FOREIGN KEY ( intPolicyID ) REFERENCES TPolicy (intPolicyID ) ON DELETE CASCADE

--9
ALTER TABLE TPolicy	 ADD CONSTRAINT TPolicy_TType_FK 
FOREIGN KEY ( intTypeID ) REFERENCES TType (intTypeID ) ON DELETE CASCADE

--10
ALTER TABLE TPolicy	 ADD CONSTRAINT TPolicy_TSaleAgents_FK 
FOREIGN KEY ( intSalesAgentID ) REFERENCES TSaleAgents (intSalesAgentID ) ON DELETE CASCADE

--11
ALTER TABLE TClaim	 ADD CONSTRAINT TClaim_TPolicy_FK 
FOREIGN KEY ( intPolicyID ) REFERENCES TPolicy (intPolicyID ) ON DELETE CASCADE

--12
ALTER TABLE TClaim  ADD CONSTRAINT TClaim_TStatus_FK 
FOREIGN KEY ( intStatusID ) REFERENCES TStatus (intStatusID ) ON DELETE CASCADE

--13
ALTER TABLE TClaim  ADD CONSTRAINT TClaim_TClaimSpecialist_FK 
FOREIGN KEY ( intClaimSpecialistID ) REFERENCES TClaimSpecialist (intClaimSpecialistID ) ON DELETE CASCADE

--14
ALTER TABLE TSaleAgents	 ADD CONSTRAINT TSaleAgents_TStates_FK 
FOREIGN KEY ( intStateID ) REFERENCES TStates (intStateID ) ON DELETE CASCADE

--15
ALTER TABLE TSaleAgents	 ADD CONSTRAINT TSaleAgents_TCities_FK 
FOREIGN KEY ( intCityID ) REFERENCES TCities (intCityID ) ON DELETE CASCADE

--16
ALTER TABLE TSaleAgents	 ADD CONSTRAINT TSaleAgents_TGender_FK 
FOREIGN KEY ( intGenderID ) REFERENCES TGender (inGenderID ) ON DELETE CASCADE

--17
ALTER TABLE TSaleAgents	 ADD CONSTRAINT TSaleAgents_TRank_FK 
FOREIGN KEY ( intRankID ) REFERENCES TRank (intRankID ) ON DELETE CASCADE
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

INSERT INTO TGenders( intGenderID, strGender)
VALUES				(1, 'Male')
				   ,(2, 'Female')
				   ,(3, 'Other')

INSERT INTO TMaritalStatus( intMaritalStatusID, strMStatus)
VALUES				(1, 'Single')
				   ,(2, 'Married')
				   ,(3, 'Divorced')

INSERT INTO TIncome( intIncomeID, strIncome)
VALUES				(1, '0 - $25,000')
				   ,(2, '$25,001 - $50,000')
				   ,(3, '$50,001 - $100,000')
				   ,(4, 'above $100,000')
				   
INSERT INTO TType( intTypeID, strType)
VALUES				(1, 'Auto')
				   ,(2, 'Boat')
				   ,(3, 'Motorcycle')
				   ,(4, 'Home')
				   ,(5, 'Renters')

INSERT INTO TRank( intRankID, strRank)
VALUES				(1, 'Junior Sales Agent')
				   ,(2, 'Sale Agent')
				   ,(3, 'Senior Sales Agent')

INSERT INTO TRisk( intRiskID, strRisk)
VALUES				(1, 'Low')
				   ,(2, 'Average')
				   ,(3, 'High')
				   			
INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfBirth, intGenderID, intMaritalStatusID, intRiskID, strSSN, intIncomeID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201', '1/1/1997', 1, 2, 1, '728133287', 1)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 3, 1, '45218', '12/1/1999', 2, 1, 1, '528133287', 3)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 5, 1, '45069', '9/23/1998', 1, 3, 1, '768133287', 5)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 1, 1, 1, '728173287', 2)
					 ,(5, 'Kim', 'Thomas', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 3, 3, 1, '728733787', 1)

INSERT INTO TStatus( intStatusID, strStatus)
VALUES				(1, 'Submitted')
				   ,(2, 'In process')
				   ,(3, 'Paid')
				   ,(4, 'Rejected')

INSERT INTO TSaleAgents (intSalesAgentID, strFirstName, strLastName, strAddress, intCityID, intStateID, strZip, dtmDateOfhire, intGenderID, intRankID)
VALUES				  (1, 'James', 'Jones', '321 Elm St.', 1, 1, '45201', '1/1/1997', 1,2)
					 ,(2, 'Sally', 'Smith', '987 Main St.', 3, 1, '45218', '12/1/1999', 2, 3)
					 ,(3, 'Jose', 'Hernandez', '1569 Windisch Rd.', 5, 1, '45069', '9/23/1998', 1, 1)
					 ,(4, 'Lan', 'Kim', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 1, 2)
					 ,(5, 'Bob', 'Nields', '44561 Oak Ave.', 4, 1, '45246', '6/11/1999', 1, 2)

INSERT INTO TCustomerPolicy( intCustomerPolicyID, intCustomerID, intPolicyID)
VALUES				(1, 1, 1)
				   ,(2, 1, 5)
				   ,(3, 2, 1)
				   ,(4, 4, 3)
				   ,(5, 5, 4)

INSERT INTO TPolicy	( intPolicyID, intTypeID, intSaleAgentID,dtmDateOfPurchase, StrPremuim)
VALUES				(1, 1, 1, '6/11/1999', '600')
				   ,(2, 2, 3, '6/11/1999', '200')
				   ,(3, 3, 2, '6/11/1999', '800')
				   ,(4, 1, 3, '6/11/1999', '1000')
				   ,(5, 3, 4, '6/11/1999', '500')
				   ,(6, 4, 5, '6/11/1999', '400')
				   ,(7, 5, 1, '6/11/1999', '900')

INSERT INTO TClaim( intClaimID, dtmDateOfClaim, StrReason, intClaimAmount, intClaimSpecialistID, intStatusID, intPolicyID)
VALUES				(1, '6/11/1999', 'Woren Brakes', '10,000',1, 1, 1)
				   ,(2, '6/11/1999', 'Rearended', '25,000',1, 1, 1)
				   ,(3, '6/11/1999', 'T-Boned', '5,000', 2, 1, 1)
				   ,(4, '6/11/1999', 'Blown Tire', '9,000', 2, 1, 1)
				   ,(5, '6/11/1999', 'Tree', '150,000', 3, 1, 1)
				   
INSERT INTO TClaimSpecialists( intClaimSpecialistID, strFirstName, strLastName)
VALUES				(1, 'Gary', 'Jones')
					,(2, 'Bert', 'Goose')
					,(3, 'Jim', 'Jones')
 				   
-- --------------------------------------------------------------------------------
--	Step #4 : Explicit Joins
-- --------------------------------------------------------------------------------
--a.	List all customers and their policies they own. (5 Points)
Select TC.strFirstName, TC.strLastName, TP.intPolicyID, TT.strType
From 
	   TCustomers as TC JOIN TCustomerPolicy as TCPS
	   ON TC.intCustomerID = TCPS.intCustomerID

	   JOIN TPolicy as TP
	   ON TCPS.intPolicyID = TP.intPolicyID

	   JOIN TType as TT
	   ON TP.intTypeID = TT.intTypeID
Order By 
	   TC.strLastName asc, TC.strFirstName asc



--b.	List all customers who are at high risk that have a claim in process.  Show the policy and the date of the claim.  (5 Points)
Select Distinct  TC.strFirstName, TC.strLastName, TR.strRisk, TT.strType, TCM.dtmDateOfClaim
From 
	   TCustomers as TC JOIN TCustomerPolicy as TCPS
	   ON TC.intCustomerID = TCPS.intCustomerID

	   JOIN TPolicy as TP
	   ON TCPS.intPolicyID = TP.intPolicyID

	   JOIN TRisk as TR
	   on TC.intRiskID = TR.intRiskID
	  
	  JOIN TClaim as TCM
	   on TP.intPolicyID = TCM.intPolicyID

	   JOIN TType as TT
	   on TP.intTypeID = TP.intTypeID
Where 
	   TR.strRisk = 'High'
	  
Order By TC.strLastName, TC.strFirstName
	   
--c.	Show all customers who are Female and married that have had a claim against their auto insurance policy. (5 Points)

Select Distinct  TC.strFirstName, TC.strLastName, TG.strGender, TT.strType, TMS.strMStatus
From 
	   TCustomers as TC JOIN TCustomerPolicy as TCPS
	   ON TC.intCustomerID = TCPS.intCustomerID

	   JOIN TMaritalStatus as TMS
	   ON TC.intMaritalStatusID = TMS.intMaritalStatusID
	   
	   JOIN TPolicy as TP
	   ON TCPS.intPolicyID = TP.intPolicyID

	   JOIN TGenders as TG
	   on TC.intGenderID = TG.intGenderID
	  
	  JOIN TClaim as TCM
	   on TP.intPolicyID = TCM.intPolicyID

	   JOIN TType as TT
	   on TP.intTypeID = TP.intTypeID


Where
		TG.strGender = 'Female'
		AND TT.strType = 'Auto'
		AND TMS.strMStatus = 'Married'




--d.	Show all Junior Sales Agents policies they sold during a particular month.  Show agent name, customer, policy and cost of policy.  (5 Points) 
Select TC.strFirstName, TC.strLastName, TP.intPolicyID, TP.strPremuim, TSA.strLastName, TSA.strFirstName, TP.dtmDateOfPurchase
From 
		TCustomers as TC JOIN TCustomerPolicy as TCPS
		ON TC.intCustomerID = TCPS.intCustomerID

		JOIN TPolicy as TP
		ON TCPS.intPolicyID = TP.intPolicyID

		JOIN TSaleAgents as TSA
		ON TP.intPolicyID = TSA.intSalesAgentID
Where
		TP.dtmDateOfPurchase = '6/11/1999'
ORDER BY 
		TSA.strLastName, TSA.strFirstName




--e.	Show all claim specialists that have rejected a claim on a policy for customers who are male and under 21 years of age.  
--		Provide the first name of the specialist, the date of the claim, the policy number, the policy date, the policy type, and 
--		the customer for any claims that have been rejected.   (5 Points)
Select Distinct  TC.strFirstName, TC.strLastName, TG.strGender, TS.strStatus, TC.dtmDateOfBirth, TCS.strFirstName, TT.strType
From 
	   TCustomers as TC JOIN TCustomerPolicy as TCPS
	   ON TC.intCustomerID = TCPS.intCustomerID

	  JOIN TPolicy as TP
	   ON TCPS.intPolicyID = TP.intPolicyID

	   JOIN TGenders as TG
	   on TC.intGenderID = TG.intGenderID
	  
	  JOIN TClaim as TCM
	   on TP.intPolicyID = TCM.intPolicyID

	  JOIN TStatus as TS
	   on TCM.intStatusID = TS.intStatusID

	   JOIN TClaimSpecialists as TCS
	   ON TCM.intClaimSpecialistID = TCS.intClaimSpecialistID

	   JOIN TType as TT
	   on TP.intTypeID = TP.intTypeID


Where
		TG.strGender = 'Male'
		AND TC.dtmDateOfBirth = '11/1/1998'
		AND TS.strStatus = 'Rejected'
Order BY
		TC.strFirstName, TC.strLastName