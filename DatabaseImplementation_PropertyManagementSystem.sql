--Creation of database

CREATE DATABASE PropertyManagementSystem;

USE PropertyManagementSystem;

--Creation of schemas for our database

CREATE SCHEMA PortfolioInformation;

CREATE SCHEMA ApartmentInformation;

CREATE SCHEMA ResidentInformation;

CREATE SCHEMA StaffInformation;

CREATE SCHEMA BillingInformation;

--Creation of tables for our database

CREATE TABLE PortfolioInformation.ApartmentPromotions (
  ApartmentPromotionID INT NOT NULL,
  ApartmentPromotionType VARCHAR(45) NULL,
  ApartmentPromotionDescription VARCHAR(250) NULL,
  ApartmentPromotionStartDate DATE NULL,
  ApartmentPromotionEndDate DATE NULL,
  PRIMARY KEY (ApartmentPromotionID));
  
CREATE TABLE PortfolioInformation.ApartmentPortfolio (
  ApartmentPortfolioID INT NOT NULL,
  ApartmentAvailabilityStatus VARCHAR(45) NOT NULL,
  ApartmentAvailabilityDate DATE NULL,
  ApartmentPromotionID INT NOT NULL,
  PRIMARY KEY (ApartmentPortfolioID),
  CONSTRAINT ApartmentPromotionID
    FOREIGN KEY (ApartmentPromotionID)
    REFERENCES PortfolioInformation.ApartmentPromotions (ApartmentPromotionID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ApartmentInformation.Blocks (
  BlockID INT NOT NULL,
  BlockName VARCHAR(45) NOT NULL,
  PRIMARY KEY (BlockID));   
   
CREATE TABLE ApartmentInformation.Apartments (
  ApartmentID INT NOT NULL,
  ApartmentName VARCHAR(45) NOT NULL,
  ApartmentTotalArea INT NOT NULL,
  ApartmentType VARCHAR(45) NOT NULL,
  ApartmentRent DECIMAL(7,2) NOT NULL,
  ApartmentPortfolioID INT NOT NULL,
  BlockID INT NOT NULL,
  PRIMARY KEY (ApartmentID),
  CONSTRAINT BlockID
    FOREIGN KEY (BlockID)
    REFERENCES ApartmentInformation.Blocks (BlockID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT ApartmentPortfolioID
    FOREIGN KEY (ApartmentPortfolioID)
    REFERENCES PortfolioInformation.ApartmentPortfolio (ApartmentPortfolioID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
   
CREATE TABLE ApartmentInformation.Amenities (
  AmenityID INT NOT NULL,
  AmenityName VARCHAR(45) NULL,
  AmenityDescription VARCHAR(250) NULL,
  AmenityCharge DECIMAL(5,2) NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (AmenityID),
  CONSTRAINT AmenityApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ApartmentInformation.Appliances (
  ApplianceID INT NOT NULL,
  ApplianceName VARCHAR(45) NULL,
  ApplianceDescription VARCHAR(250) NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (ApplianceID),
  CONSTRAINT ApplianceApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ApartmentInformation.Utilities (
  UtilityID INT NOT NULL,
  UtilityName VARCHAR(45) NULL,
  UtilityDescription VARCHAR(250) NULL,
  UtilityCharge DECIMAL(5,2) NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (UtilityID),
  CONSTRAINT UtilityApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);   
   
CREATE TABLE ApartmentInformation.Insurance (
  InsuranceID INT NOT NULL,
  InsurancePolicyNumber INT NOT NULL,
  InsuranceProvider VARCHAR(45) NULL,
  InsuranceName VARCHAR(45) NOT NULL,
  InsurancePremium DECIMAL(6,2) NOT NULL,
  InsuranceType VARCHAR(45) NULL,
  InsuranceDescription VARCHAR(250) NULL,
  InsuranceDuration INT NULL,
  InsuranceStartDate DATE NULL,
  InsuranceEndDate DATE NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (InsuranceID),
  CONSTRAINT InsuranceApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
   
CREATE TABLE ApartmentInformation.ApartmentsMaintenanceRecords (
  ApartmentsMaintenanceRecordID INT NOT NULL,
  ApartmentsMaintenanceRecordDate DATE NULL,
  ApartmentsMaintenanceRecordDescription VARCHAR(250) NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (ApartmentsMaintenanceRecordID),
  CONSTRAINT MaintenanceRecordApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ApartmentInformation.ApartmentAddress (
  ApartmentAddressID INT NOT NULL,
  AddressLine1 VARCHAR(45) NULL,
  AddressLine2 VARCHAR(45) NULL,
  City VARCHAR(45) NULL,
  State VARCHAR(45) NULL,
  Country VARCHAR(45) NULL,
  Zipcode INT NULL,
  PostboxNumber INT NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (ApartmentAddressID),
  CONSTRAINT AddressApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);   
   
CREATE TABLE ResidentInformation.Residents (
  ResidentID INT NOT NULL,
  ResidentFirstName VARCHAR(45) NULL,
  ResidentLastName VARCHAR(45) NULL,
  ResidentContactNumber VARCHAR(20) NULL,
  ResidentEmailAddress VARCHAR(45) NULL,
  ResidentDOB DATE NULL,
  ResidentBloodType VARCHAR(45) NULL,
  ApartmentID INT NOT NULL,
  PRIMARY KEY (ResidentID),
  CONSTRAINT ResidentApartmentID
    FOREIGN KEY (ApartmentID)
    REFERENCES ApartmentInformation.Apartments (ApartmentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE ResidentInformation.ParkingLots (
  ParkingLotID INT NOT NULL,
  ParkingLotName VARCHAR(45) NULL,
  ParkingLotType VARCHAR(45) NULL,
  ParkingLotRent DECIMAL(5,2) NULL,
  ResidentID INT NOT NULL,
  PRIMARY KEY (ParkingLotID),
  CONSTRAINT ParkingLotResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ResidentInformation.Pets (
  PetID INT NOT NULL,
  PetType VARCHAR(45) NULL,
  PetRent DECIMAL(5,2) NULL,
  ResidentID INT NOT NULL,
  PRIMARY KEY (PetID),
  CONSTRAINT PetResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);   

CREATE TABLE ResidentInformation.ResidentsEmergencyContacts (
  ResidentsEmergencyContactID INT NOT NULL,
  ResidentsEmergencyContactType VARCHAR(45) NULL,
  ResidentsEmergencyContactName VARCHAR(45) NULL,
  ResidentsEmergencyContactNumber VARCHAR(20) NULL,
  ResidentsEmergencyContactEmailAddress VARCHAR(45) NULL,
  ResidentsEmergencyContactRelation VARCHAR(45) NULL,
  ResidentID INT NOT NULL,
  PRIMARY KEY (ResidentsEmergencyContactID),
  CONSTRAINT EmergencyContactResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);   

CREATE TABLE ResidentInformation.ResidentsEmploymentRecords (
  ResidentsEmploymentRecordID INT NOT NULL,
  ResidentsEmploymentCompanyName VARCHAR(45) NULL,
  ResidentsEmploymentCompanyContactNumber VARCHAR(20) NULL,
  ResidentID INT NOT NULL,
  PRIMARY KEY (ResidentsEmploymentRecordID),
  CONSTRAINT EmploymentRecordResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE ResidentInformation.ResidentsCompanyAddress (
  ResidentsCompanyAddressID INT NOT NULL,
  ResidentsCompanyAddressLine1 VARCHAR(45) NULL,
  ResidentsCompanyAddressLine2 VARCHAR(45) NULL,
  ResidentsCompanyCity VARCHAR(45) NULL,
  ResidentsCompanyState VARCHAR(45) NULL,
  ResidentsCompanyCountry VARCHAR(45) NULL,
  ResidentsCompanyZipcode VARCHAR(45) NULL,
  ResidentsEmploymentRecordID INT NOT NULL,
  PRIMARY KEY (ResidentsCompanyAddressID),
  CONSTRAINT CompanyAddressResidentsEmploymentRecordID
    FOREIGN KEY (ResidentsEmploymentRecordID)
    REFERENCES ResidentInformation.ResidentsEmploymentRecords (ResidentsEmploymentRecordID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);    
   
CREATE TABLE StaffInformation.StaffMembers (
  StaffMemberID INT NOT NULL,
  StaffMemberFirstName VARCHAR(45) NULL,
  StaffMemberLastName VARCHAR(45) NULL,
  StaffMemberContactNumber VARCHAR(20) NULL,
  StaffMemberEmailAddress VARCHAR(45) NULL,
  StaffMemberDesignation VARCHAR(45) NULL,
  PRIMARY KEY (StaffMemberID));
  
CREATE TABLE ResidentInformation.Lease (
  LeaseID INT NOT NULL,
  LeaseDate DATE NULL,
  LeaseStartDate DATE NULL,
  LeaseEndDate DATE NULL,
  LeaseDuration INT NULL,
  ResidentID INT NOT NULL,
  StaffMemberID INT NOT NULL,
  PRIMARY KEY (LeaseID),
  CONSTRAINT LeaseResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT LeaseStaffMemberID
    FOREIGN KEY (StaffMemberID)
    REFERENCES StaffInformation.StaffMembers (StaffMemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE ResidentInformation.MaintenanceRequests (
  MaintenanceRequestID INT NOT NULL,
  MaintenanceRequestName VARCHAR(45) NULL,
  MaintenanceRequestType VARCHAR(45) NULL,
  MaintenanceRequestDescription VARCHAR(250) NULL,
  MaintenanceRequestDate DATE NULL,
  MaintenanceRequestStatus VARCHAR(45) NULL,
  ResidentID INT NOT NULL,
  StaffMemberID INT NOT NULL,
  PRIMARY KEY (MaintenanceRequestID),
  CONSTRAINT MaintenanceResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT MaintenanceStaffMemberID
    FOREIGN KEY (StaffMemberID)
    REFERENCES StaffInformation.StaffMembers (StaffMemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE ResidentInformation.CommunityEvents (
  CommunityEventID INT NOT NULL,
  CommunityEventDate DATE NULL,
  CommunityEventTime TIME NULL,
  CommunityEventType VARCHAR(45) NULL,
  CommunityEventDuration INT NULL,
  PRIMARY KEY (CommunityEventID));
   
CREATE TABLE ResidentInformation.ResidentsCommunityEvents (
  ResidentsCommunityEventID INT NOT NULL,
  ResidentID INT NOT NULL,
  CommunityEventID INT NOT NULL,
  PRIMARY KEY (ResidentsCommunityEventID),
  CONSTRAINT EventResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT ResidentCommunityEventID
    FOREIGN KEY (CommunityEventID)
    REFERENCES ResidentInformation.CommunityEvents (CommunityEventID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);     

CREATE TABLE StaffInformation.StaffMembersCommunityEvents (
  StaffMembersCommunityEventID INT NOT NULL,
  StaffMemberID INT NOT NULL,
  CommunityEventID INT NOT NULL,
  PRIMARY KEY (StaffMembersCommunityEventID),
  CONSTRAINT EventStaffMemberID
    FOREIGN KEY (StaffMemberID)
    REFERENCES StaffInformation.StaffMembers (StaffMemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT StaffCommunityEventID
    FOREIGN KEY (CommunityEventID)
    REFERENCES ResidentInformation.CommunityEvents (CommunityEventID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE StaffInformation.StaffMembersEmergencyContacts (
  StaffMembersEmergencyContactID INT NOT NULL,
  StaffMembersEmergencyContactType VARCHAR(45) NULL,
  StaffMembersEmergencyContactName VARCHAR(45) NULL,
  StaffMembersEmergencyContactNumber VARCHAR(20) NULL,
  StaffMembersEmergencyContactEmailAddress VARCHAR(45) NULL,
  StaffMembersEmergencyContactRelation VARCHAR(45) NULL,
  StaffMemberID INT NULL,
  PRIMARY KEY (StaffMembersEmergencyContactID),
  CONSTRAINT EmergencyContactStaffMemberID
    FOREIGN KEY (StaffMemberID)
    REFERENCES StaffInformation.StaffMembers (StaffMemberID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE BillingInformation.Billing (
  BillingID INT NOT NULL,
  BillingAmount DECIMAL(8,2) NOT NULL,
  BillingDate DATE NOT NULL,
  BillingDueDate DATE NOT NULL,
  ResidentID INT NOT NULL,
  PRIMARY KEY (BillingID),
  CONSTRAINT BillingResidentID
    FOREIGN KEY (ResidentID)
    REFERENCES ResidentInformation.Residents (ResidentID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE BillingInformation.Payments (
  PaymentID INT NOT NULL,
  PaymentMode VARCHAR(45) NULL,
  PaymentStatus VARCHAR(45) NULL,
  PaymentMade DECIMAL(8,2) NULL,
  PaymentDue DECIMAL(8,2) NULL,
  PaymentDate DATE NULL,
  BillingID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  CONSTRAINT PaymentBillingID
    FOREIGN KEY (BillingID)
    REFERENCES BillingInformation.Billing (BillingID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

--Insertion of data in the tables   
   
INSERT INTO ApartmentInformation.Blocks VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E'),
(6, 'F'),
(7, 'G'),
(8, 'H'),
(9, 'I'),
(10, 'J'),
(11, 'K');

SELECT * FROM ApartmentInformation.Blocks;

INSERT INTO PortfolioInformation.ApartmentPromotions VALUES
(101, 'Social Media Marketing', 'Facebook', '2015-03-12', '2015-04-11'),
(102, 'Social Media Marketing', 'Instagram', '2015-08-05', '2015-08-04'),
(103, 'Social Media Marketing', 'Twitter', '2015-12-30', '2016-01-29'),
(104, 'General Advertising', 'Television Advertisement', '2016-05-20', '2016-05-30'),
(105, 'General Advertising', 'Newspaper Advertisement', '2016-10-01', '2016-10-02'),
(106, 'General Advertising', 'Poster', '2017-01-01', '2017-01-31'),
(107, 'General Advertising', 'Internet Banner', '2017-09-16', '2017-09-30'),
(108, 'General Advertising', 'Magazine Advertisement', '2017-11-10', '2017-12-09'),
(109, 'Personal Selling', 'Telephone Calls', '2018-02-11', '2018-04-10'),
(110, 'Direct Marketing', 'Email', '2018-11-01', '2018-12-31'),
(111, 'Sponsorship', 'Resident Sponsorship Program', '2019-04-19', '2019-05-18');

SELECT * FROM PortfolioInformation.ApartmentPromotions

INSERT INTO PortfolioInformation.ApartmentPortfolio VALUES
(2001, 'Unavailable', '2015-05-01', 101),
(2002, 'Unavailable', '2015-10-01', 102),
(2003, 'Unavailable', '2016-03-01', 103),
(2004, 'Unavailable', '2016-07-01', 104),
(2005, 'Unavailable', '2016-11-15', 105),
(2006, 'Unavailable', '2017-02-10', 106),
(2007, 'Unavailable', '2017-10-05', 107),
(2008, 'Unavailable', '2018-01-01', 108),
(2009, 'Unavailable', '2018-05-01', 109),
(2010, 'Unavailable', '2019-01-15', 110),
(2011, 'Available', '2019-06-01', 111),
(2012, 'Available', '2019-06-01', 111);

SELECT * FROM PortfolioInformation.ApartmentPortfolio;

INSERT INTO ApartmentInformation.Apartments VALUES
(1001, 'A1', 640, '1 Bedroom 1 Bath', 1650, 2001, 1),
(1002, 'A2', 625, '1 Bedroom 1 Bath', 1620, 2002, 1),
(1003, 'A3', 540, '1 Bedroom 1 Bath', 1580, 2003, 1),
(1004, 'B1', 320, 'Studio', 1350, 2004, 2),
(1005, 'B2', 780, '2 Bedroom 1 Bath', 1750, 2005, 2),
(1006, 'C1', 950, '2 Bedroom 2 Bath', 1900, 2006, 3),
(1007, 'D1', 600, '1 Bedroom 1 Bath', 1610, 2007, 4),
(1008, 'E1', 540, '1 Bedroom 1 Bath', 1565, 2008, 5),
(1009, 'E2', 640, '1 Bedroom 1 Bath', 1680, 2009, 5),
(1010, 'F1', 950, '2 Bedroom 2 Bath', 1930, 2010, 6),
(1011, 'G1', 320, 'Studio', 1310, 2011, 7),
(1012, 'G2', 800, '2 Bedroom 1 Bath', 1780, 2005, 7),
(1013, 'H1', 625, '1 Bedroom 1 Bath', 1620, 2006, 8),
(1014, 'I1', 550, '1 Bedroom 1 Bath', 1575, 2001, 9),
(1015, 'J1', 280, 'Studio', 1300, 2004, 10),
(1016, 'J2', 610, '1 Bedroom 1 Bath', 1670, 2008, 10),
(1017, 'K1', 320, 'Studio', 1330, 2010, 11),
(1018, 'K2', 320, 'Studio', 1330, 2012, 11);

SELECT * FROM ApartmentInformation.Apartments;

INSERT INTO ApartmentInformation.Appliances VALUES
(3001, 'WD', 'Washer and Dryer', 1001),
(3002, 'WH', 'Water Heater', 1001),
(3003, 'R', 'Refrigerator', 1001),
(3004, 'GR', 'Cooking Gas Range', 1001),
(3005, 'WD', 'Washer and Dryer', 1002),
(3006, 'WH', 'Water Heater', 1002),
(3007, 'R', 'Refrigerator', 1002),
(3008, 'GR', 'Cooking Gas Range', 1002),
(3009, 'WH', 'Water Heater', 1003),
(3010, 'R', 'Refrigerator', 1003),
(3011, 'GR', 'Cooking Gas Range', 1004),
(3012, 'WD', 'Washer and Dryer', 1005),
(3013, 'WH', 'Water Heater', 1005),
(3014, 'R', 'Refrigerator', 1005),
(3015, 'GR', 'Cooking Gas Range', 1005),
(3016, 'D', 'Dishwasher', 1005),
(3017, 'WD', 'Washer and Dryer', 1006),
(3018, 'WH', 'Water Heater', 1006),
(3019, 'R', 'Refrigerator', 1006),
(3020, 'GR', 'Cooking Gas Range', 1006),
(3021, 'D', 'Dishwasher', 1006),
(3022, 'M', 'Microwave', 1006),
(3023, 'WD', 'Washer and Dryer', 1007),
(3024, 'WH', 'Water Heater', 1007),
(3025, 'R', 'Refrigerator', 1007),
(3026, 'GR', 'Cooking Gas Range', 1007),
(3027, 'WD', 'Washer and Dryer', 1008),
(3028, 'WH', 'Water Heater', 1008),
(3029, 'R', 'Refrigerator', 1008),
(3030, 'WD', 'Washer and Dryer', 1009),
(3031, 'WH', 'Water Heater', 1009),
(3032, 'R', 'Refrigerator', 1009),
(3033, 'GR', 'Cooking Gas Range', 1009),
(3034, 'WD', 'Washer and Dryer', 1010),
(3035, 'WH', 'Water Heater', 1010),
(3036, 'R', 'Refrigerator', 1010),
(3037, 'GR', 'Cooking Gas Range', 1010),
(3038, 'D', 'Dishwasher', 1010),
(3039, 'GR', 'Cooking Gas Range', 1011),
(3040, 'WD', 'Washer and Dryer', 1012),
(3041, 'WH', 'Water Heater', 1012),
(3042, 'R', 'Refrigerator', 1012),
(3043, 'GR', 'Cooking Gas Range', 1012),
(3044, 'D', 'Dishwasher', 1012),
(3045, 'WD', 'Washer and Dryer', 1013),
(3046, 'WH', 'Water Heater', 1013),
(3047, 'R', 'Refrigerator', 1013),
(3048, 'GR', 'Cooking Gas Range', 1013),
(3049, 'WD', 'Washer and Dryer', 1014),
(3050, 'WH', 'Water Heater', 1014),
(3051, 'R', 'Refrigerator', 1014),
(3052, 'GR', 'Cooking Gas Range', 1014),
(3053, 'GR', 'Cooking Gas Range', 1015),
(3054, 'WD', 'Washer and Dryer', 1016),
(3055, 'WH', 'Water Heater', 1016),
(3056, 'R', 'Refrigerator', 1016),
(3057, 'GR', 'Cooking Gas Range', 1016),
(3058, 'GR', 'Cooking Gas Range', 1017),
(3059, 'GR', 'Cooking Gas Range', 1018);

SELECT * FROM ApartmentInformation.Appliances;

INSERT INTO ApartmentInformation.Utilities VALUES
(4001, 'E', 'Electricity', 50, 1001),
(4002, 'W', 'Water', 20, 1001),
(4003, 'G', 'Garbage', 10, 1001),
(4004, 'E', 'Electricity', 48, 1002),
(4005, 'W', 'Water', 18, 1002),
(4006, 'G', 'Garbage', 8, 1002),
(4007, 'E', 'Electricity', 40, 1003),
(4008, 'W', 'Water', 15, 1003),
(4009, 'G', 'Garbage', 7, 1003),
(4010, 'E', 'Electricity', 30, 1004),
(4011, 'W', 'Water', 10, 1004),
(4012, 'G', 'Garbage', 5, 1004),
(4013, 'E', 'Electricity', 54, 1005),
(4014, 'W', 'Water', 22, 1005),
(4015, 'G', 'Garbage', 12, 1005),
(4016, 'E', 'Electricity', 60, 1006),
(4017, 'W', 'Water', 25, 1006),
(4018, 'G', 'Garbage', 15, 1006),
(4019, 'E', 'Electricity', 45, 1007),
(4020, 'W', 'Water', 16, 1007),
(4021, 'G', 'Garbage', 7, 1007),
(4022, 'E', 'Electricity', 40, 1008),
(4023, 'W', 'Water', 15, 1008),
(4024, 'G', 'Garbage', 7, 1008),
(4025, 'E', 'Electricity', 50, 1009),
(4026, 'W', 'Water', 20, 1009),
(4027, 'G', 'Garbage', 10, 1009),
(4028, 'E', 'Electricity', 60, 1010),
(4029, 'W', 'Water', 25, 1010),
(4030, 'G', 'Garbage', 15, 1010),
(4031, 'E', 'Electricity', 30, 1011),
(4032, 'W', 'Water', 10, 1011),
(4033, 'G', 'Garbage', 5, 1011),
(4034, 'E', 'Electricity', 54, 1012),
(4035, 'W', 'Water', 22, 1012),
(4036, 'G', 'Garbage', 12, 1012),
(4037, 'E', 'Electricity', 48, 1013),
(4038, 'W', 'Water', 18, 1013),
(4039, 'G', 'Garbage', 8, 1013),
(4040, 'E', 'Electricity', 40, 1014),
(4041, 'W', 'Water', 15, 1014),
(4042, 'G', 'Garbage', 7, 1014),
(4043, 'E', 'Electricity', 28, 1015),
(4044, 'W', 'Water', 8, 1015),
(4045, 'G', 'Garbage', 4, 1015),
(4046, 'E', 'Electricity', 45, 1016),
(4047, 'W', 'Water', 16, 1016),
(4048, 'G', 'Garbage', 7, 1016),
(4049, 'E', 'Electricity', 30, 1017),
(4050, 'W', 'Water', 10, 1017),
(4051, 'G', 'Garbage', 5, 1017),
(4052, 'E', 'Electricity', 30, 1018),
(4053, 'W', 'Water', 10, 1018),
(4054, 'G', 'Garbage', 5, 1018);

SELECT * FROM ApartmentInformation.Utilities;

INSERT INTO ApartmentInformation.Insurance VALUES
(5001, 100012345, 'TAG', 'TAG Max', 150, 'FA', 'Full apartment insurance', 24, '2015-05-01', '2017-04-30', 1001),
(5002, 100012345, 'TAG', 'TAG Max', 100, 'FA', 'Full coverage insurance', 24, '2015-05-16', '2017-05-15', 1014),
(5003, 100012345, 'RIG', 'RIG Home', 20, 'A', 'Applicances insurance', 12, '2015-11-01', '2016-10-31', 1002),
(5004, 100012345, 'TAG', 'TAG Max', 100, 'FA', 'Full coverage insurance', 24, '2016-03-15', '2018-03-14', 1003),
(5005, 100012345, 'TAG', 'TAG Max', 15, 'A', 'Applicances insurance', 12, '2016-07-05', '2017-07-04', 1015),
(5006, 100012345, 'RIG', 'RIG Home', 120, 'FA', 'Full coverage insurance', 36, '2016-07-20', '2019-07-19', 1004),
(5007, 100012345, 'RIG', 'RIG Home',  25, 'A', 'Applicances insurance', 12, '2016-11-15', '2017-11-14', 1005), 
(5008, 100012345, 'RIG', 'RIG Home', 54, 'FA', 'Full coverage insurance', 8, '2016-11-15', '2017-07-14', 1012),
(5009, 100012345, 'TAG', 'TAG Max', 46, 'FA', 'Full coverage insurance', 8, '2017-02-25', '2017-10-24', 1013),
(5010, 100012345, 'LDG', 'LDG Property', 180, 'FA', 'Full coverage insurance', 24, '2017-03-01', '2019-02-28', 1006),
(5011, 100012345, 'TAG', 'TAG Max', 75, 'FA', 'Full apartment insurance', 12, '2017-05-10', '2018-05-09', 1001),
(5012, 100012345, 'LDG', 'LDG Property', 40, 'A', 'Applicances insurance', 12, '2017-10-05', '2018-10-04', 1007),
(5013, 100012345, 'LDG', 'LDG Property', 180, 'FA', 'Full coverage insurance', 24, '2017-12-14', '2019-12-13', 1005),
(5014, 100012345, 'LDG', 'LDG Property', 60, 'A', 'Applicances insurance', 36, '2018-01-19', '2021-01-18', 1016),
(5015, 100012345, 'TAG', 'TAG Max', 100, 'FA', 'Full coverage insurance', 24, '2018-02-01', '2020-01-31', 1008),
(5016, 100012345, 'TAG', 'TAG Max', 75, 'FA', 'Full coverage insurance', 12, '2018-05-01', '2019-04-30', 1009),
(5018, 100012345, 'LDG', 'LDG Property', 50, 'A', 'Applicances insurance', 24, '2019-01-15', '2021-01-14', 1010),
(5019, 100012345, 'RIG', 'RIG Home', 40, 'FA', 'Full coverage insurance', 12, '2019-01-15', '2020-01-14', 1017),
(5020, 100012345, 'RIG', 'RIG Home', 15, 'A', 'Applicances insurance', 12, '2019-06-01', '2020-05-31', 1011),
(5021, 100012345, 'TAG', 'TAG Max', 80, 'FA', 'Full apartment insurance', 24, '2019-06-01', '2021-05-31', 1018),
(5017, 100012345, 'LDG', 'LDG Property', 160, 'FA', 'Full coverage insurance', 24, '2019-06-16', '2021-06-15', 1009);

SELECT * FROM ApartmentInformation.Insurance;

INSERT INTO ApartmentInformation.ApartmentsMaintenanceRecords VALUES
(6001, '2016-10-05', 'Carpet replacement in the living room', 1015),
(6002, '2015-06-01', 'Bath tub replacement', 1001),
(6003, '2015-12-16', 'Apartment walls painting', 1014),
(6004, '2015-12-01', 'New lights installation in the patio', 1002),
(6005, '2017-01-31', 'Carpet replacement in the bedroom', 1014),
(6006, '2018-02-16', 'Restroom taps replacement', 1008),
(6007, '2018-02-16', 'Fan installation', 1008),
(6008, '2019-07-01', 'Patio wooden floor construction', 1011),
(6009, '2019-01-31', 'Dishwasher installation', 1017),
(6010, '2019-08-10', 'Switch board replacement in the dining area', 1018),
(6011, '2019-09-01', 'Shower installation', 1018);

SELECT * FROM ApartmentInformation.ApartmentsMaintenanceRecords;

INSERT INTO ApartmentInformation.ApartmentAddress VALUES
(7001, '14005 NE 10th Street', 'Apt A1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1001),
(7002, '14006 NE 10th Street', 'Apt A2', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1002),
(7003, '14007 NE 10th Street', 'Apt A3', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1003),
(7004, '14008 NE 10th Street', 'Apt B1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1004),
(7005, '14009 NE 10th Street', 'Apt B2', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1005),
(7006, '14010 NE 10th Street', 'Apt C1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1006),
(7007, '14011 NE 10th Street', 'Apt D1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1007),
(7008, '14012 NE 10th Street', 'Apt E1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1008),
(7009, '14013 NE 10th Street', 'Apt E2', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1009),
(7010, '14014 NE 10th Street', 'Apt F1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1010),
(7011, '14015 NE 10th Street', 'Apt G1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1011),
(7012, '14016 NE 10th Street', 'Apt G2', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1012),
(7013, '14017 NE 10th Street', 'Apt H1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1013),
(7014, '14018 NE 10th Street', 'Apt I1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1014),
(7015, '14019 NE 10th Street', 'Apt J1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1015),
(7016, '14020 NE 10th Street', 'Apt K1', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1016),
(7017, '14021 NE 10th Street', 'Apt K2', 'Gold Lake', 'Washington', 'USA', 10012, 102, 1017);

SELECT * FROM ApartmentInformation.ApartmentAddress;

INSERT INTO ApartmentInformation.Amenities VALUES
(8001, 'Fitness Center', 'Gym and workout area', 10, 1001),
(8002, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1001),
(8003, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1002),
(8004, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1003),
(8005, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1004),
(8006, 'Fitness Center', 'Gym and workout area', 10, 1005),
(8007, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1005),
(8008, 'Community Center', 'Community Center for parties and religious functions', 20, 1005),
(8009, 'Fitness Center', 'Gym and workout area', 10, 1006),
(8010, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1006),
(8011, 'Community Center', 'Community Center for parties and religious functions', 20, 1006),
(8012, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1007),
(8013, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1008),
(8014, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1009),
(8015, 'Fitness Center', 'Gym and workout area', 10, 1010),
(8016, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1010),
(8017, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1011),
(8018, 'Fitness Center', 'Gym and workout area', 10, 1012),
(8019, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1012),
(8020, 'Fitness Center', 'Gym and workout area', 10, 1013),
(8021, 'Fitness Center', 'Gym and workout area', 10, 1014),
(8022, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1015),
(8023, 'Fitness Center', 'Gym and workout area', 10, 1016),
(8024, 'Community Center', 'Community Center for parties and religious functions', 20, 1016),
(8025, 'Fitness Center', 'Gym and workout area', 10, 1017),
(8026, 'Swimming Pool', 'Swimming pool for adults and kids', 8, 1018);

SELECT * FROM ApartmentInformation.Amenities;

INSERT INTO ResidentInformation.Residents VALUES
(101001, 'Alex', 'Thomas', '7658768901','alext@dmail.com', '1992-04-08', 'A+', 1001),
(101002, 'Jeena', 'Thomas', '7658668901','jjenny@hmail.com', '1992-05-24', 'A+', 1001),
(101003, 'James', 'Will', '7658767801','jamesw@hmail.com', '1982-04-26', 'B+', 1002),
(101004, 'Joy', 'Jose', '8658668901','jjose@hmail.com', '1989-05-01', 'B+', 1003),
(101005, 'Mary', 'Jose', '8658448901','maryt@hmail.com', '1993-07-11', 'A+', 1003),
(101006, 'Tina', 'Thomas', '7458708902','tinathomas@fmail.com', '1961-01-17', 'A+', 1004),
(101007, 'Amy', 'Mathew', '8658790900','amym@hmail.com', '1976-05-09', 'A-', 1005),
(101008, 'Nithya', 'Mohan', '7456768909','nithyam@hmail.com', '1988-03-11', 'AB+', 1006),
(101009, 'Ishwar', 'Mohan', '7452268909','ishmohan@fmail.com', '1989-08-27', 'A-', 1006),
(101010, 'Rahul', 'Menon', '7958768700','rmenon@hmail.com', '1993-07-14', 'A-', 1007),
(101011, 'Sapna', 'Ravi', '8658768901','sravi@hmail.com', '1984-06-22', 'O+', 1008),
(101012, 'Lee', 'Jacob', '6658568501','leej@hmail.com', '1992-04-03', 'AB-', 1009),
(101013, 'Sreya', 'Nair', '6758768921','sreyan@hmail.com', '1989-04-12', 'B-', 1010),
(101014, 'Pratik', 'Senik', '8958768903','psenik@vmail.com', '1987-02-11', 'A+', 1011),
(101015, 'Aravind', 'Gopal', '6898768901','aravindg@hmail.com', '1985-02-16', 'B+', 1012),
(101016, 'Anoop', 'Fernando', '8009168901','anoopf@hmail.com', '1993-06-25', 'A+', 1013),
(101017, 'Bini', 'Baby', '7000768901','binibaby@hmail.com', '1991-08-23', 'O+', 1014),
(101018, 'Christie', 'Ann', '7651218901','chrisann@vmail.com', '1990-01-30', 'O-', 1015),
(101019, 'Arun', 'Vinay', '7658763331','arunv@hmail.com', '1988-03-19', 'AB+', 1016),
(101020, 'Shyam', 'Sunder', '7634568901','shyams@hmail.com', '1987-08-29', 'B+', 1017),
(101021, 'Sandip', 'Arakkal', '7600778901','sarakkal@pmail.com', '1991-07-28', 'B+', 1018),
(101022, 'Alexa', 'Thomas', '7650968901','alexat@hmail.com', '1992-04-08', 'A+', 1001),
(101023, 'Ari', 'Maw', '8658798900','arim@hmail.com', '1976-05-09', 'A-', 1005),
(101024, 'Tre', 'Jacob', '6568568501','trej@pmail.com', '1992-04-03', 'AB-', 1009);

SELECT * FROM ResidentInformation.Residents;

INSERT INTO ResidentInformation.ParkingLots VALUES
(102001, 'P1', 'Open', 25, 101001),
(102002, 'P1', 'Open', 25, 101002),
(102003, 'P1', 'Open', 25, 101003),
(102004, 'P1', 'Open', 25, 101004),
(102005, 'P1', 'Open', 25, 101005),
(102006, 'P1', 'Open', 25, 101005),
(102007, 'P1', 'Open', 25, 101006),
(102008, 'P1', 'Covered', 100,101007),
(102009, 'P1', 'Covered', 100,101008),
(102010, 'P2', 'Open', 25, 101009),
(102011, 'P2', 'Open', 25, 101010),
(102012, 'P2', 'Open', 25, 101014),
(102013, 'P2', 'Covered', 100, 101015),
(102014, 'P2', 'Covered', 100, 101016),
(102015, 'P3', 'Open', 25, 101017),
(102016, 'P3', 'Open', 25, 101018);

SELECT * FROM ResidentInformation.ParkingLots;

INSERT INTO ResidentInformation.Pets VALUES
(103001, 'Dog', 125, 101003),
(103002, 'Dog', 125, 101004),
(103003, 'Dog', 125, 101006),
(103004, 'Cat', 100, 101006),
(103005, 'Dog', 125, 101015),
(103006, 'Cat', 100, 101015),
(103007, 'Cat', 100, 101016),
(103008, 'Cat', 100, 101017),	
(103009, 'Dog', 125, 101017),
(103010, 'Cat', 100, 101018);

SELECT * FROM ResidentInformation.Pets;

INSERT INTO ResidentInformation.ResidentsEmergencyContacts VALUES 
(104001, 'Primary', 'Melvin Thomas', '7661268901','melvint@hmail.com','Cousin', 101001),
(104002, 'Primary', 'Xavier Thomas', '7661368901','xaviert@hmail.com', 'Cousin', 101002),
(104003, 'Primary', 'Jenson Will', '7656147801','jensonw@hmail.com', 'Friend', 101003),
(104004, 'Primary', 'Ted Jose', '8651468901','tedjose@hmail.com', 'Cousin', 101004),
(104005, 'Secondary', 'Fany Jose', '8651668901','fanyjose@hmail.com', 'Cousin', 101004),
(104006, 'Primary', 'Tim Luke', '8651548901','timl@hmail.com', 'Friend', 101005),
(104007, 'Primary', 'Linda Thomas', '7451608902','lindathomas@hmail.com', 'Cousin', 101006),
(104008, 'Primary', 'Lisa Mathew', '8658717900','lisam@hmail.com', 'Cousin', 101007),
(104009, 'Primary', 'Preeti Mohan', '7418768909','preethim@hmail.com', 'Sister', 101008),
(104010, 'Secondary', 'Raghav Mohan', '7452261909','rmohan@hmail.com', 'Cousin', 101008),
(104011, 'Primary', 'Renu Menon', '7952268700','renumenon@hmail.com', 'Cousin', 101009),
(104012, 'Primary', 'Jayam Ravi', '8658768231','jayamravi@hmail.com', 'Brother', 101010),
(104013, 'Primary', 'Tenny Jacob', '6624568501','tennyj@hmail.com', 'Cousin', 101011),
(104014, 'Primary', 'Vikram Nair', '6758768251','vikrun@hmail.com', 'Brother', 101012),
(104015, 'Primary', 'Mithun Senik', '8926768903','mitsenik@hmail.com', 'Cousin', 101013),
(104016, 'Primary', 'Gokul Gopal', '6898768271','gokulg@hmail.com', 'Cousin', 101014),
(104017, 'Primary', 'Jaby Fernando', '8002868901','jabyf@hmail.com', 'Friend', 101015),
(104018, 'Primary', 'Arun Baby', '7000298901','arunbaby@hmail.com', 'Cousin', 101016),
(104019, 'Primary', 'Mary Ann', '7631218901','maryann@hmail.com', 'Sister', 101017),
(104020, 'Primary', 'Ashwin Vinay', '7653263331','ashv@hmail.com', 'Cousin', 101018),
(104021, 'Primary', 'Yajat Sunder', '7634533901','yajats@hmail.com', 'Sister', 101019),
(104022, 'Secondary', 'Pranav Arakkal', '7634778901','pranavarakkal@hmail.com', 'Friend', 101019),
(104023, 'Primary', 'Tamy Lee', '7634521901','tamyl@hmail.com', 'Friend', 101020),
(104024, 'Primary', 'Jaya Thambi', '7654778901','jthambi@hmail.com', 'Friend', 101021),
(104025, 'Primary', 'Levi Thomas', '7600268901','levit@hmail.com','Cousin', 101022),
(104026, 'Primary', 'Jo Luke', '8651500901','jol@hmail.com', 'Friend', 101023),
(104027, 'Primary', 'Yina Menon', '7900268700','yinamenon@hmail.com', 'Cousin', 101024);

SELECT * FROM ResidentInformation.ResidentsEmergencyContacts;

INSERT INTO ResidentInformation.ResidentsEmploymentRecords VALUES 
(105001,'XYZ Ltd', '8000108901', 101001),
(105002,'ABC Ltd', '8100107801', 101003),
(105003, 'TTT Ltd', '810108901', 101004),
(105004,'Target', '8001108902', 101006),
(105005, 'Walmart', '8100100900', 101007),
(105006, 'XYZ Ltd', '8000108901', 101008),
(105007, 'Panorama', '8110108700', 101010),
(105008, 'ABC Ltd', '8100107801', 101011),
(105009, 'Boeing', '8001108501', 101012),
(105010, 'TCS', '8100108921', 101013),
(105011, 'Walmart', '8100100901', 101014),
(105012, 'TTT Ltd', '810108901', 101015),
(105013, 'XYZ Ltd', '8000108901', 101018),
(105014, 'Target', '8001108903', 101019),
(105015, 'ABC Ltd', '8100107801', 101020),
(105016,  'Zeedac Ltd', '8010108901', 101021);

SELECT * FROM ResidentInformation.ResidentsEmploymentRecords;

INSERT INTO ResidentInformation.ResidentsCompanyAddress VALUES 
(106001, '121 Thomas Rd', 'Terry Ave N','Seattle', 'WA','USA', 98105, 105001),
(106002, '105 Evergreen Pt', 'Westlake Ave N', 'Seattle','WA','USA', 98109, 105002),
(106003, '115 Evergreen Pt', 'Westlake Ave N', 'Seattle','WA','USA', 98109, 105003),
(106004, '175 Yale Pt', 'Richards Rd', 'Bellevue', 'WA','USA', 98007, 105004),
(106005, '110 Peak Pt', 'Wester Rd','Seattle', 'WA', 'USA',98114, 105005),
(106006, '121 Thomas Rd', 'Terry Ave N','Seattle', 'WA', 'USA', 98105, 105006),
(106007, '115 Yale Pt', 'Richards Rd','Bellevue', 'WA', 'USA', 98007, 105007),
(106008, '105 Evergreen Pt', 'Westlake Ave N','Seattle', 'WA', 'USA', 98109, 105008),
(106009, '111 Yale Pt', 'Richards Rd','Bellevue', 'WA', 'USA', 98007, 105009),
(106010, '122 Yale Pt', 'Richards Rd','Bellevue', 'WA', 'USA', 98007, 105010),
(106011, '116 Yale Pt', 'Richards Rd','Bellevue', 'WA', 'USA', 98007, 105011),
(106012, '115 Evergreen Pt','Westlake Ave N','Seattle', 'WA', 'USA', 98109, 105012),
(106013, '121 Thomas Rd', 'Terry Ave N','Seattle', 'WA', 'USA', 98105, 105013),
(106014, '119 Peak Pt', 'Wester Rd','Seattle', 'WA', 'USA', 98114, 105014),
(106015, '105 Evergreen Pt', 'Westlake Ave N','Seattle', 'WA', 'USA', 98109, 105015),
(106016, '112 Peak Pt','Wester Rd','Seattle', 'WA', 'USA', 98114, 105016);

SELECT * FROM ResidentInformation.ResidentsCompanyAddress;

INSERT INTO ResidentInformation.CommunityEvents VALUES
(107001, '2018-01-25', '10:30', 'Resident Event', 3),
(107002, '2018-02-15', '11:30', 'Staff Event', 2),
(107003, '2018-06-02', '13:30', 'Staff Event', 2),
(107004, '2019-01-01', '10:30', 'Management Event', 1),
(107005, '2019-01-02', '12:30', 'Resident Event', 3),
(107006, '2019-03-22', '9:30', 'Management Event', 1),
(107007, '2019-07-16', '8:30', 'Resident Event', 3),
(107008, '2019-08-03', '10:30', 'Management Event', 1),
(107009, '2019-09-04', '12:30', 'Resident Event', 3),
(107010, '2019-10-25', '9:30', 'Management Event', 1);

SELECT * FROM ResidentInformation.CommunityEvents;

INSERT INTO StaffInformation.StaffMembers VALUES
(201001, 'Jack', 'Morris', '8009965478', 'jmorris@hmail.com', 'Office Assistant'),
(201002, 'Tiara','Laze', '8011965478', 'tlaze@vmail.com', 'Office Assistant'),
(201003, 'George','Watson', '8022265478', 'georgew@hmail.com', 'Maintanence Assistant'),
(201004, 'Phil', 'Melvoy', '8009333478', 'pmelvoy@fmail.com', 'Maintenence Assistant'),
(201005, 'Dario', 'Tese', '8009947978', 'dariot@hmail.com', 'Gardener'),
(201006, 'Jalo', 'Minas', '8088865478', 'jmorris@pmail.com', 'Office Assistant'),
(201007, 'Tia', 'Lazer', '8011865478', 'tlazer@hmail.com', 'Office Assistant'),
(201008, 'Georgia', 'Watts', '8023365478', 'georgiaw@hmail.com', 'Maintanence Assistant'),
(201009, 'Philda', 'Melvoyia', '8119333478', 'pmelvoyia@fmail.com', 'Maintenence Assistant'),
(201010, 'Dariore', 'Tesene', '8009887978', 'darioret@hmail.com', 'Maintenence Assistant');

SELECT * FROM StaffInformation.StaffMembers;

INSERT INTO StaffInformation.StaffMembersEmergencyContacts VALUES
(202001, 'Primary', 'Jobin Thomas', '7660008901', 'jobint@hmail.com','Cousin', 201001),
(202002, 'Primary', 'Davis Mel', '7600368901', 'davismel@hmail.com', 'Cousin', 201002),
(202003, 'Primary', 'Nancy Will', '7656100001', 'nancyw@hmail.com', 'Friend', 201003),
(202004, 'Primary', 'Ted Varys', '8611168901', 'tedv@hmail.com', 'Cousin', 201004),
(202005, 'Secondary', 'Davie Jose', '8651667771', 'daviejose@hmail.com', 'Cousin', 201004),
(202006, 'Primary', 'Tessy Luke', '8651566601', 'tluke@hmail.com', 'Friend', 201005),
(202007, 'Secondary', 'Leo Daniel', '7452228902', 'leodan@hmail.com', 'Cousin', 201005),
(202008, 'Primary', 'Daz Jose', '8651777771', 'dazjose@hmail.com', 'Cousin', 201006),
(202009, 'Primary', 'Tes Luka', '8656666601', 'tesluka@hmail.com', 'Friend', 201007),
(202010, 'Primary', 'Leah Dan', '7452221102', 'leahdan@hmail.com', 'Cousin', 201008),
(202011, 'Primary', 'Tesla Luke', '8651566111', 'teslaluke@hmail.com', 'Friend', 201009),
(202012, 'Primary', 'Leonard Danz', '7112228902', 'leodanz@hmail.com', 'Cousin', 201010);

SELECT * FROM StaffInformation.StaffMembersEmergencyContacts;

INSERT INTO StaffInformation.StaffMembersCommunityEvents VALUES
(203001, 201001, 107004),
(203002, 201002, 107004),
(203003, 201003, 107002),
(203004, 201004, 107003),
(203005, 201005, 107003),
(203006, 201006, 107006),
(203007, 201007, 107008),
(203008, 201008, 107002),
(203009, 201009, 107003),
(203010, 201010, 107010);

SELECT * FROM StaffInformation.StaffMembersCommunityEvents;

INSERT INTO ResidentInformation.Lease VALUES
(110001,'2015-04-04','2015-05-01', '2017-04-30',24,101001,201001),
(110002,'2015-04-04','2015-05-01', '2017-04-30',24,101002,201001),
(110003,'2015-04-13','2015-05-16', '2017-05-15',24,101017,201002),
(110004,'2015-10-05','2015-11-01', '2016-10-31',12,101003,201002),
(110005,'2016-02-20','2016-03-15', '2018-03-14',24,101004,201001),
(110006,'2016-02-20','2016-03-15', '2018-03-14',24,101005,201001),
(110007,'2016-06-23','2016-07-05', '2017-07-04',12,101018,201001),
(110008,'2016-06-08','2016-07-20', '2019-07-19',36,101006,201001),
(110009,'2016-10-24','2016-11-15', '2017-11-14',12,101007,201002),
(110010,'2016-09-16','2016-11-15', '2017-07-14',8,101015,201002),
(110011,'2017-01-26','2017-02-25', '2017-10-24',8,101016,201001),
(110012,'2017-02-09','2017-03-01', '2019-02-28',24,101008,201002),
(110013,'2017-02-09','2017-03-01', '2019-02-28',24,101009,201002),
(110014,'2017-04-22','2017-05-10', '2018-05-09',12,101022,201001),
(110015,'2017-09-20','2017-10-05', '2018-10-04',12,101010,201001),
(110016,'2017-11-22','2017-12-14', '2019-12-13',24,101023,201002),
(110017,'2018-01-01','2018-01-19', '2021-01-18',36,101019,201001),
(110018,'2018-01-14','2018-02-01', '2020-01-31',24,101011,201002),
(110019,'2018-04-15','2018-05-01', '2019-04-30',12,101012,201001),
(110020,'2019-01-01','2019-01-15', '2021-01-14',2,101013,201001),
(110021,'2018-01-01','2019-01-15', '2020-01-14',1,101020,201002),
(110022,'2019-05-14','2019-06-01', '2020-05-31',1,101014,201001),
(110023,'2019-05-22','2019-06-01', '2021-05-31',2,101021,201001),
(110024,'2019-05-22','2019-06-16', '2021-06-15',2,101024,201001);

SELECT * FROM ResidentInformation.Lease;

INSERT INTO ResidentInformation.MaintenanceRequests VALUES
(109001,'Repair','Normal','Cupboard repair','2018-02-05','Completed',101008,201004),
(109002,'Electric','Emergency','Faulty Heaters','2018-02-05','Completed',101008,201004),
(109003,'Plumbing','Emergency','Kitchen sink overflow','2018-11-26','Completed',101009,201003),
(109004,'Repair','Normal','Cupboard repair','2018-11-26','Completed',101009,201003),
(109005,'Repair','Normal','Storage door lock repair','2019-06-01','Completed',101006,201003),
(109006,'Electric','Emergency','Faulty Heaters','2019-06-01','Completed',101006,201003),
(109007,'Repair','Normal','Storage door lock repair','2019-06-01','Completed',101006,201003),
(109008,'Plumbing','Emergency','Kitchen sink overflow','2019-11-28','Pending',101013,201004),
(109009,'Electric','Emergency','Faulty Heaters','2019-11-28','Pending',101013,201004),
(109010,'Electric','Emergency','Faulty Heaters','2019-11-28','Pending',101009,201004);

SELECT * FROM ResidentInformation.MaintenanceRequests;

INSERT INTO BillingInformation.Billing VALUES
(301001,1872,'2016-10-01','2016-10-05',101003),
(301002,1923,'2017-04-01','2017-04-05',101001),
(301003,25,'2017-04-01','2017-04-05',101002),
(301004,1997,'2017-05-01','2017-05-05',101017),
(301005,1488,'2017-06-01','2017-06-05',101018),
(301006,2165,'2017-07-01','2017-07-05',101015),
(301007,2001,'2017-10-01','2017-10-05',101007),
(301008,1950,'2017-10-01','2017-10-05',101016),
(301009,1824,'2018-02-01','2018-02-05',101004),
(301010,50,'2018-02-01','2018-02-05',101005),
(301011,1823,'2018-04-01','2018-04-05',101022),
(301012,1751,'2018-09-01','2018-09-05',101010),
(301013,2308,'2019-02-01','2019-02-05',101008),
(301014,25,'2019-02-01','2019-02-05',101009),
(301015,1843,'2019-04-01','2019-04-05',101012),
(301016,1773,'2019-06-01','2019-06-05',101006),
(301017,1735,'2019-11-01','2019-11-05',101011),
(301018,2098,'2019-11-01','2019-11-05',101013),
(301019,1403,'2019-11-01','2019-11-05',101014),
(301020,1828,'2019-11-01','2019-11-05',101019),
(301021,1425,'2019-11-01','2019-11-05',101020),
(301022,1463,'2019-11-01','2019-11-05',101021),
(301023,1926,'2019-11-01','2019-11-05',101023),
(301024,1828,'2019-11-01','2019-11-05',101024);

SELECT * FROM BillingInformation.Billing;

INSERT INTO BillingInformation.Payments VALUES
(302001,'Card','Paid',1872,0,'2016-10-03',301003),
(302002,'Card','Paid',1923,0,'2017-04-01',301001),
(302003,'Card','Paid',25,0,'2017-04-02',301002),
(302004,'Card','Paid',1997,0,'2017-05-04',301017),
(302005,'Card','Paid',1488,0,'2017-06-02',301018),
(302006,'Card','Paid',2165,0,'2017-10-01',301015),
(302007,'Card','Paid',2001,0,'2017-10-05',301007),
(302008,'Card','Paid',1950,0,'2017-10-05',301016),
(302009,'Card','Paid',1824,0,'2018-02-04',301004),
(302010,'Card','Paid',50,0,'2018-02-05',301005),
(302011,'Card','Paid',1823,0,'2018-04-05',301022),
(302012,'Card','Paid',1751,0,'2018-09-05',301010),
(302013,'Card','Paid',2308,0,'2019-02-03',301008),
(302014,'Card','Paid',25,0,'2019-02-04',301009),
(302015,'Card','Paid',1843,0,'2019-04-02',301012),
(302016,'Card','Paid',1773,0,'2019-06-02',301006),
(302017,'Card','Paid',1735,0,'2019-11-04',301011),
(302018,'Card','Pending',2000,98,'2019-11-04',301013),
(302019,'Card','Paid',1403,0,'2019-11-04',301014),
(302020,'Card','Paid',1828,0,'2019-11-05',301019),
(302021,'Card','Pending',1400,25,'2019-11-05',301020),
(302022,'Card','Paid',1463,0,'2019-11-05',301021),
(302023,'Card','Paid',1926,0,'2019-11-05',301023),
(302024,'Card','Pending',1800,28,'2019-11-05',301024);

SELECT * FROM BillingInformation.Payments;

INSERT INTO ResidentInformation.ResidentsCommunityEvents VALUES
(108001, 101009, 107001),
(108002, 101009, 107005),
(108003, 101011, 107005),
(108004, 101012, 107005),
(108006, 101014, 107005),
(108007, 101015, 107007),
(108008, 101016, 107007),
(108009, 101009, 107009),
(108010, 101011, 107009);

SELECT * FROM ResidentInformation.ResidentsCommunityEvents;

--Views

/* View to display the list of all available apartments for leasing and its features*/

CREATE VIEW ApartmentPortfolioAvailability
AS 
SELECT AIA.ApartmentName, AIA.ApartmentTotalArea, AIA.ApartmentType, AIA.ApartmentRent, PIAP.ApartmentAvailabilityStatus
FROM ApartmentInformation.Apartments AS AIA
INNER JOIN PortfolioInformation.ApartmentPortfolio AS PIAP
ON AIA.ApartmentPortfolioID = PIAP.ApartmentPortfolioID
WHERE PIAP.ApartmentAvailabilityStatus = 'Available';
--Testing
SELECT * FROM ApartmentPortfolioAvailability;

/* View to list all the apartments and residents information who have pets and also the type of pet 
 * Data to be retrieved: ApartmentName, ResidentFirstName, ResidentLastName, ResidentContactNumber, ResidentEmailAddress, PetType */   

CREATE VIEW PetOwnersInformation
AS
SELECT AIA.ApartmentName, RIR.ResidentFirstName + ' ' + RIR.ResidentLastName AS ResidentName, RIR.ResidentContactNumber, RIR.ResidentEmailAddress, RIP.PetType
FROM ApartmentInformation.Apartments AS AIA
INNER JOIN ResidentInformation.Residents AS RIR 
ON AIA.ApartmentID = RIR.ApartmentID
INNER JOIN ResidentInformation.Pets AS RIP
ON RIR.ResidentID = RIP.ResidentID;
--Testing
SELECT * FROM PetOwnersInformation;

/* View to list all the apartments with resident contact details whose lease is ending in next two months (starting from today)
* Data to be retrieved: ApartmentName, ResidentFirstName, ResidentLastName, ResidentContactNumber, ResidentEmailAddress */ 

CREATE VIEW UpcomingExpiringLeases
AS
SELECT AIA.ApartmentName, RIR.ResidentFirstName + ' ' + RIR.ResidentLastName AS ResidentName, RIR.ResidentContactNumber, RIR.ResidentEmailAddress, RIL.LeaseEndDate
FROM ApartmentInformation.Apartments AS AIA
INNER JOIN ResidentInformation.Residents AS RIR 
ON AIA.ApartmentID = RIR.ApartmentID
INNER JOIN ResidentInformation.Lease AS RIL
ON RIR.ResidentID = RIL.ResidentID
WHERE RIL.LeaseEndDate Between GetDate() and DateAdd(Day, 60, GetDate());
--Testing
SELECT * FROM UpcomingExpiringLeases;

/* View to list all the pending maintenance requests along with apartment for which these maintenances are due
* Data to be retrieved: ApartmentName, MaintenanceRequestID, MaintenanceRequestType */ 

CREATE VIEW PendingMaintenanceRequests
AS
SELECT RIM.MaintenanceRequestID, RIM.MaintenanceRequestType, AIA.ApartmentName, RIM.MaintenanceRequestStatus
FROM ResidentInformation.MaintenanceRequests AS RIM
INNER JOIN ResidentInformation.Residents AS RIR
ON RIM.ResidentID = RIR.ResidentID
INNER JOIN ApartmentInformation.Apartments AS AIA
ON RIR.ApartmentID = AIA.ApartmentID
WHERE RIM.MaintenanceRequestStatus = 'Pending';
--Testing
SELECT * FROM PendingMaintenanceRequests;

--Computed Column

/* Computed column to show the number of maintenance requests completed by a staff member */

CREATE FUNCTION fn_CompletedCount_cc 
(@staffMemberID INT)
RETURNS int
AS 
Begin
	Declare @COUNT INT;

	Select @COUNT = COUNT(MaintenanceRequestID)
	FROM ResidentInformation.MaintenanceRequests
	WHERE StaffMemberID = @staffMemberID and MaintenanceRequestStatus = 'Completed';

	RETURN @COUNT;
END
--Adding computed column to our table
ALTER TABLE StaffInformation.StaffMembers 
ADD RequestCompletedCount AS (dbo.fn_CompletedCount_cc(StaffMemberID));
--Testing
SELECT * FROM StaffInformation.StaffMembers ORDER BY RequestCompletedCount DESC;

--Table-level check constriant

/* Table level check constraint to restrict a resident from raising a maintenance request 
 * if their payment due is more than $500 and the bill due date has been passed. */

--Function
CREATE FUNCTION fn_PaymentCheck
(@residentID INT)
RETURNS SMALLINT
AS
BEGIN
	DECLARE @COUNT SMALLINT = 0

	SELECT @COUNT = COUNT(RIR.ResidentID)
	FROM ResidentInformation.Residents AS RIR
	INNER JOIN BillingInformation.Billing AS BB
	ON RIR.ResidentID = BB.ResidentID
	INNER JOIN BillingInformation.Payments AS BP
	ON BB.BillingID = BP.BillingID
	WHERE RIR.ResidentID = @residentID and BP.PaymentDue > 500 and GetDate() > BB.BillingDueDate;
	
	RETURN @COUNT;
END

--Table level check constriant based on the above function
ALTER TABLE ResidentInformation.MaintenanceRequests ADD CONSTRAINT NoRequest CHECK (dbo.fn_PaymentCheck(ResidentID) = 0);

--Testing
--Creation of test data to test the table-level check constriant
INSERT INTO BillingInformation.Billing
VALUES (301025, 1800, '2019-11-25', '2019-11-29', 101024);
INSERT INTO BillingInformation.Payments 
VALUES (302025, 'Card', 'Pending', 1200, 600, '2019-11-07', 301025);

--This is throwing an error as the insert query fails to satisfy the table-level check constraint
INSERT INTO ResidentInformation.MaintenanceRequests
VALUES (109011, 'Electric', 'Normal', 'Light of the living room is not working', '2019-12-01', 'Pending', 101024, 201010);

--This insert query is successful as the insert query satisfies the table-level check constraint
INSERT INTO ResidentInformation.MaintenanceRequests
VALUES (109012, 'Electric', 'Emergency', 'Light of the living room is not working', '2019-12-01', 'Pending', 101019, 201010);

SELECT * FROM BillingInformation.Billing;

SELECT * FROM BillingInformation.Payments;

SELECT * FROM ResidentInformation.MaintenanceRequests;

--Encryption

--Creation of Master Key, Certificate and Symmetric Key for encryption
Create Master Key
Encryption by Password = 'CJKR_PMS_2019';

Create Certificate PMS_Certificate
With Subject = 'Property Management Certificate',
Expiry_Date = '2030-12-31';

Create Symmetric Key PMS_SymmetricKey
With Algorithm = AES_128
Encryption by Certificate PMS_Certificate;

Open Symmetric Key PMS_SymmetricKey
Decryption by Certificate PMS_Certificate;

--Creation of new table (Payment has to be done by either 'Credit Card = 1' or 'Debit Card = 2')
CREATE TABLE ResidentInformation.PaymentSource
(PaymentSourceID int,
PaymentSourceType smallint,
CardNumber varbinary(250),
Month varbinary(250),
Year varbinary(250), 
SecurityCode varbinary(250), 
ResidentID int References ResidentInformation.Residents(ResidentID));

--Insert data into the table
INSERT INTO ResidentInformation.PaymentSource VALUES
(1, 2, EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, '1082992031227124')), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 05)), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 2021)), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 201)), 101022);

INSERT INTO ResidentInformation.PaymentSource VALUES
(2, 1, EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, '1373839201918391')), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 11)), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 2020)), EncryptByKey(Key_GUID(N'PMS_SymmetricKey'), convert(varbinary, 129)), 101023);

--Select query to see the encrypted data
SELECT * FROM ResidentInformation.PaymentSource;

--Select query to see the decrypted data
SELECT PaymentSourceID, PaymentSourceType, convert(varchar, DecryptByKey(CardNumber)) as CardNumber, convert(int, DecryptByKey(Month)) as [Month], convert(int, DecryptByKey(Year)) as [Year], convert(int, DecryptByKey(SecurityCode)) as SecurityCode, ResidentID from ResidentInformation.PaymentSource;

-- Dropping Tables

DROP TABLE BillingInformation.Payments;

DROP TABLE BillingInformation.Billing;
   
DROP TABLE StaffInformation.StaffMembersCommunityEvents;

DROP TABLE ResidentInformation.ResidentsCommunityEvents;

DROP TABLE ResidentInformation.CommunityEvents;

DROP TABLE ResidentInformation.ResidentsCompanyAddress;

DROP TABLE ResidentInformation.ResidentsEmploymentRecords;

DROP TABLE ResidentInformation.ResidentsEmergencyContacts;

DROP TABLE ResidentInformation.Lease;

DROP TABLE ResidentInformation.MaintenanceRequests;

DROP TABLE StaffInformation.StaffMembersEmergencyContacts;

DROP TABLE StaffInformation.StaffMembers;

DROP TABLE ResidentInformation.Pets;

DROP TABLE ResidentInformation.ParkingLots;

DROP TABLE ResidentInformation.Residents;

DROP TABLE ApartmentInformation.ApartmentsMaintenanceRecords;

DROP TABLE ApartmentInformation.ApartmentAddress;

DROP TABLE ApartmentInformation.Utilities;

DROP TABLE ApartmentInformation.Insurance;

DROP TABLE ApartmentInformation.Appliances;

DROP TABLE ApartmentInformation.Amenities;

DROP TABLE ApartmentInformation.Apartments;

DROP TABLE ApartmentInformation.Blocks;

DROP TABLE PortfolioInformation.ApartmentPortfolio;

DROP TABLE PortfolioInformation.ApartmentPromotions;

-- Dropping Schemas

DROP SCHEMA BillingInformation;

DROP SCHEMA StaffInformation;

DROP SCHEMA ResidentInformation;

DROP SCHEMA ApartmentInformation;

DROP SCHEMA PortfolioInformation;