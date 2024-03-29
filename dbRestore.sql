USE [master]
GO
/****** Object:  Database [TestCoreBankingDB]    Script Date: 03/05/2016 22:10:38 ******/
CREATE DATABASE [TestCoreBankingDB] ON  PRIMARY 
( NAME = N'TestCoreBankingDB', FILENAME = N'D:\Work\TestCoreBankingDB.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestCoreBankingDB_log', FILENAME = N'D:\Work\TestCoreBankingDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestCoreBankingDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestCoreBankingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestCoreBankingDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET ARITHABORT OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [TestCoreBankingDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [TestCoreBankingDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [TestCoreBankingDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [TestCoreBankingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [TestCoreBankingDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [TestCoreBankingDB] SET  READ_WRITE
GO
ALTER DATABASE [TestCoreBankingDB] SET RECOVERY FULL
GO
ALTER DATABASE [TestCoreBankingDB] SET  MULTI_USER
GO
ALTER DATABASE [TestCoreBankingDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [TestCoreBankingDB] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestCoreBankingDB', N'ON'
GO
USE [TestCoreBankingDB]
GO
/****** Object:  Table [dbo].[PaymentTypes]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentTypes](
	[PaymentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentTypeCode] [varchar](50) NULL,
	[PaymentTypeName] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentTypes] ON
INSERT [dbo].[PaymentTypes] ([PaymentTypeId], [PaymentTypeCode], [PaymentTypeName], [BankCode], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn]) VALUES (1, N'CASH', N'CASH', N'STANBIC', N'admin', N'admin', CAST(0x0000A5BC015B3430 AS DateTime), CAST(0x0000A5BC015B3430 AS DateTime))
SET IDENTITY_INSERT [dbo].[PaymentTypes] OFF
/****** Object:  Table [dbo].[RejectedTransactionRequests]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RejectedTransactionRequests](
	[RecordId] [int] NOT NULL,
	[CustomerName] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[ToAccount] [varchar](50) NULL,
	[FromAccount] [varchar](50) NULL,
	[TranAmount] [money] NULL,
	[TranCategory] [varchar](50) NULL,
	[PaymentDate] [datetime] NULL,
	[RecordDate] [datetime] NULL,
	[Teller] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Narration] [varchar](50) NULL,
	[RequiresApproval] [bit] NULL,
	[Approver] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[Reason] [varchar](8000) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[PaymentType] [varchar](50) NULL,
	[ChequeNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RejectedBankSystemUsers]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RejectedBankSystemUsers](
	[RecordId] [int] NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Fullname] [varchar](50) NULL,
	[Usertype] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[DateOfBirth] [varchar](50) NULL,
	[RecordDate] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[TranAmountLimit] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RejectedBankCustomers]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RejectedBankCustomers](
	[RecordId] [int] NOT NULL,
	[CustomerId] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Fullname] [varchar](50) NULL,
	[Pin] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[DateOfBirth] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[PathToProfilePic] [varchar](8000) NULL,
	[PathToSignature] [varchar](8000) NULL,
	[NextOfKinName] [varchar](50) NULL,
	[NextOfKinContact] [varchar](50) NULL,
	[Nationality] [varchar](50) NULL,
	[PlaceOfBirth] [varchar](50) NULL,
	[Salutation] [varchar](50) NULL,
	[MaritalStatus] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[RejectedBankCustomers] ([RecordId], [CustomerId], [Email], [Fullname], [Pin], [Password], [IsActive], [BankCode], [DateOfBirth], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [PathToProfilePic], [PathToSignature], [NextOfKinName], [NextOfKinContact], [Nationality], [PlaceOfBirth], [Salutation], [MaritalStatus]) VALUES (1, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'Kiracho Islam', NULL, N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC016A54A1 AS DateTime), CAST(0x0000A5BC016A54A1 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'humphrey.tugume@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'', N'635924663331200116.jpg', N'635924663450215428.jpg', N'Mrs Kiracho', N'0785975800', N'Ugandan', NULL, NULL, N'SINGLE')
/****** Object:  Table [dbo].[RejectedBankAccounts]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RejectedBankAccounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccBalance] [money] NULL,
	[AccNumber] [varchar](50) NULL,
	[AccType] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[IsActive] [varchar](50) NULL,
	[RejectedBy] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrlRedirects]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UrlRedirects](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[EditType] [varchar](50) NULL,
	[Url] [varchar](850) NULL,
	[UserTypeWhoCanView] [varchar](850) NULL,
	[Name] [varchar](50) NULL,
	[StoredProc] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[UrlRedirects] ON
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (1, N'TELLER', N'AddOrEditBankUser.aspx', N'BANK_ADMIN,SYS_ADMIN', N'BANK TELLER', N'SearchBankUsersTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (2, N'CUSTOMER', N'AddOrEditCustomer.aspx', N'CUSTOMER_SERVICE', N'BANK CUSTOMER', N'SearchBankUsersTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (3, N'TRANSACTIONCATEGORY', N'AddOrEditTranCategory.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'TRANSACTION CATEGORIES', N'SearchTransactionCategoriesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (4, N'USERTYPE', N'AddOrEditUserType.aspx', N'BANK_ADMIN,SYS_ADMIN', N'USER TYPES', N'SearchUserTypesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (5, N'ACCOUNTTYPE', N'AddOrEditAccountType.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'ACCOUNT TYPES', N'SearchAccountTypesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (6, N'ACCOUNT', N'AddOrEditBankAccount.aspx', N'CUSTOMER_SERVICE', N'BANK ACCOUNTS', N'SearchBankAccountsTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (7, N'BRANCHES', N'AddOrEditBankBranch.aspx', N'BANK_ADMIN,SYS_ADMIN', N'BANK BRANCHES', N'SearchBankBranchesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (8, N'CHARGES', N'AddOrEditBankCharges.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'BANK CHARGES', N'SearchBankChargesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (9, N'CURRENCIES', N'AddOrEditCurrency.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'BANK CURRENCIES', N'SearchCurrenciesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (10, N'PAYMENTTYPE', N'AddOrEditPaymentType.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'PAYMENT TYPES', N'SearchPaymentTypesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (11, N'CHARGETYPE', N'AddOrEditChargeType.aspx', N'BUSSINESS_ADMIN,SYS_ADMIN', N'CHARGE TYPES', N'SearchChargeTypesTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (12, N'SYSTEMUSERS', N'AddOrEditBankUser.aspx', N'BANK_ADMIN,SYS_ADMIN', N'SYSTEM USERS', N'SearchBankUsersTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (13, N'ACCESSCONTROL', N'AddOrEditAccessControl.aspx', N'BANK_ADMIN,SYS_ADMIN', N'ACCESS CONTROL', N'SearchAccessControlTable')
INSERT [dbo].[UrlRedirects] ([RecordId], [EditType], [Url], [UserTypeWhoCanView], [Name], [StoredProc]) VALUES (14, N'BANK', N'AddOrEditBank.aspx', N'SYS_ADMIN', N'BANKS', N'SearchBanksTable')
SET IDENTITY_INSERT [dbo].[UrlRedirects] OFF
/****** Object:  Table [dbo].[UsersToAccounts]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsersToAccounts](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserTypes](
	[UserTypeId] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [varchar](50) NULL,
	[Role] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (1, N'BANK_ADMIN', N'Banks IT Admin', N'Banks IT Admin', N'STANBIC', CAST(0x0000A5BC015B337A AS DateTime), CAST(0x0000A5BC015B337A AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (2, N'MANAGER', N'Branch Manager', N'Branch Manager', N'STANBIC', CAST(0x0000A5BC015B3380 AS DateTime), CAST(0x0000A5BC015B3380 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (3, N'CUSTOMER', N'Banks Customer', N'Banks Customer', N'STANBIC', CAST(0x0000A5BC015B3380 AS DateTime), CAST(0x0000A5BC015B3380 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (4, N'TELLER', N'Bank Teller', N'Bank Teller', N'STANBIC', CAST(0x0000A5BC015B3380 AS DateTime), CAST(0x0000A5BC015B3381 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (5, N'SUPERVISOR_TELLER', N'Teller Supervisor', N'Teller Supervisor', N'STANBIC', CAST(0x0000A5BC015B3381 AS DateTime), CAST(0x0000A5BC015B3381 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (6, N'CUSTOMER_SERVICE', N'Customer Service', N'Customer Service', N'STANBIC', CAST(0x0000A5BC015B3381 AS DateTime), CAST(0x0000A5BC015B3381 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (7, N'BUSSINESS_ADMIN', N'Bussiness Admin', N'Bussiness Admin', N'STANBIC', CAST(0x0000A5BC015B3381 AS DateTime), CAST(0x0000A5BC015B3388 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (8, N'BANK_ADMIN', N'Banks IT Admin', N'Banks IT Admin', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (9, N'MANAGER', N'Branch Manager', N'Branch Manager', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (10, N'TELLER', N'Bank Teller', N'Bank Teller', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (11, N'SUPERVISOR_TELLER', N'Teller Supervisor', N'Teller Supervisor', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (12, N'CUSTOMER_SERVICE', N'Customer Service', N'Customer Service', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (13, N'BUSSINESS_ADMIN', N'Bussiness Admin', N'Bussiness Admin', N'CENTENARY', CAST(0x0000A5BE014E0418 AS DateTime), CAST(0x0000A5BE014E0418 AS DateTime), N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
/****** Object:  Table [dbo].[TransactionRules]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionRules](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[RuleName] [varchar](50) NULL,
	[RuleCode] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[Description] [varchar](150) NULL,
	[MinimumAmount] [money] NULL,
	[MaximumAmount] [money] NULL,
	[IsActive] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Approver] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionRequests]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionRequests](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[ToAccount] [varchar](50) NULL,
	[FromAccount] [varchar](50) NULL,
	[TranAmount] [money] NULL,
	[TranCategory] [varchar](50) NULL,
	[PaymentDate] [datetime] NULL,
	[RecordDate] [datetime] NULL,
	[Teller] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Narration] [varchar](50) NULL,
	[RequiresApproval] [bit] NULL,
	[Approver] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[Reason] [varchar](8000) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[PaymentType] [varchar](50) NULL,
	[ChequeNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionRequests] ON
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (1, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 1000.0000, N'DEPOSIT', CAST(0x0000A5BD011DE8F8 AS DateTime), CAST(0x0000A5BD011DE99F AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (2, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 35000.0000, N'DEPOSIT', CAST(0x0000A5BD013E1740 AS DateTime), CAST(0x0000A5BD013E17B7 AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (3, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 35000.0000, N'DEPOSIT', CAST(0x0000A5BD013E5430 AS DateTime), CAST(0x0000A5BD013E54C8 AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (4, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 35000.0000, N'DEPOSIT', CAST(0x0000A5BD013ECBB8 AS DateTime), CAST(0x0000A5BD013ECD9B AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (5, N'BANK BRANCH VAULT CREDIT', N'000000001', N'', N'000000001', 3000.0000, N'DEPOSIT', CAST(0x0000A5BE014E5894 AS DateTime), CAST(0x0000A5BE014E5961 AS DateTime), N'admin', N'admin', N'Pegasus', N'Pegasus', N'BANK BRANCH VAULT CREDIT', NULL, NULL, NULL, NULL, N'UGS', NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (6, N'BANK BRANCH VAULT CREDIT', N'', N'', N'', 3000.0000, N'DEPOSIT', CAST(0x0000A5BE014EFDD0 AS DateTime), CAST(0x0000A5BE014EFDE2 AS DateTime), N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BANK BRANCH VAULT CREDIT', NULL, NULL, NULL, NULL, N'UGS', NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (7, N'BANK BRANCH VAULT CREDIT', N'20160303201606885', N'20160303202253901', N'20160303201606885', 35000.0000, N'DEPOSIT', CAST(0x0000A5BE01501CEC AS DateTime), CAST(0x0000A5BE01501DC7 AS DateTime), N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BANK BRANCH VAULT CREDIT', NULL, NULL, NULL, NULL, N'UGS', NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (8, N'BRANCH TELLER ACCOUNT CREDIT', N'20160303201606885', N'20160302170014157', N'20160303201606885', 2000.0000, N'DEPOSIT', CAST(0x0000A5BE01554CA8 AS DateTime), CAST(0x0000A5BE01554CEE AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', NULL, NULL, NULL, NULL, N'UGS', NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (9, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 1000.0000, N'DEPOSIT', CAST(0x0000A5BE015A7C64 AS DateTime), CAST(0x0000A5BE015A7D8A AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (10, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 2000.0000, N'DEPOSIT', CAST(0x0000A5BE015B3C94 AS DateTime), CAST(0x0000A5BE015B3CD2 AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (11, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 2000.0000, N'DEPOSIT', CAST(0x0000A5BE015B691C AS DateTime), CAST(0x0000A5BE015B692C AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (12, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 1000.0000, N'DEPOSIT', CAST(0x0000A5BE015B853C AS DateTime), CAST(0x0000A5BE015B865E AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (13, N'BRANCH TELLER ACCOUNT CREDIT', N'20160303201606885', N'20160302170014157', N'20160303201606885', 20000.0000, N'DEPOSIT', CAST(0x0000A5BF011BEB34 AS DateTime), CAST(0x0000A5BF011BEC37 AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', NULL, NULL, NULL, NULL, N'UGS', NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (14, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 2000.0000, N'DEPOSIT', CAST(0x0000A5BF011C7A2C AS DateTime), CAST(0x0000A5BF011C7ABF AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (15, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 2000.0000, N'DEPOSIT', CAST(0x0000A5BF011CFB14 AS DateTime), CAST(0x0000A5BF011CFB8C AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', NULL, NULL, NULL, NULL, N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (16, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 2500.0000, N'DEPOSIT', CAST(0x0000A5BF011DA758 AS DateTime), CAST(0x0000A5BF011DA819 AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', NULL, NULL, N'SUCCESS', N'10000011', N'UGS', N'CASH', N'')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason], [CurrencyCode], [PaymentType], [ChequeNumber]) VALUES (17, N'Kiracho Islam', N'20160302124223645', N'20160302124223645', N'20160302170014157', 1700.0000, N'DEPOSIT', CAST(0x0000A5C001635A50 AS DateTime), CAST(0x0000A5C001635B8D AS DateTime), N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', NULL, NULL, N'SUCCESS', N'10000013', N'UGS', N'CASH', N'')
SET IDENTITY_INSERT [dbo].[TransactionRequests] OFF
/****** Object:  Table [dbo].[TransactionCategories]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionCategories](
	[TranTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TranType] [varchar](50) NULL,
	[Description] [varchar](150) NULL,
	[BankCode] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionCategories] ON
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (1, N'WITHDRAW', N'WITHDRAW OPERATION', N'STANBIC', CAST(0x0000A5BC015B33A0 AS DateTime), CAST(0x0000A5BC015B33A0 AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (2, N'DEPOSIT', N'DEPOSIT OPERATION', N'STANBIC', CAST(0x0000A5BC015B33AA AS DateTime), CAST(0x0000A5BC015B33AA AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (3, N'INTERNAL_TRANSFER', N'AN INTERNAL TRANSFER', N'STANBIC', CAST(0x0000A5BC015B33AB AS DateTime), CAST(0x0000A5BC015B33AB AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (4, N'EXTERNAL_TRANSFER', N'AN EXTERNAL TRANSFER', N'STANBIC', CAST(0x0000A5BC015B33AB AS DateTime), CAST(0x0000A5BC015B33AB AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (5, N'WITHDRAW', N'WITHDRAW OPERATION', N'CENTENARY', CAST(0x0000A5BE014E041A AS DateTime), CAST(0x0000A5BE014E041A AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (6, N'DEPOSIT', N'DEPOSIT OPERATION', N'CENTENARY', CAST(0x0000A5BE014E041A AS DateTime), CAST(0x0000A5BE014E041A AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (7, N'INTERNAL_TRANSFER', N'AN INTERNAL TRANSFER', N'CENTENARY', CAST(0x0000A5BE014E041A AS DateTime), CAST(0x0000A5BE014E041A AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (8, N'EXTERNAL_TRANSFER', N'AN EXTERNAL TRANSFER', N'CENTENARY', CAST(0x0000A5BE014E041A AS DateTime), CAST(0x0000A5BE014E041A AS DateTime), N'admin', N'admin', 1)
SET IDENTITY_INSERT [dbo].[TransactionCategories] OFF
/****** Object:  Table [dbo].[TellersToAccountsMapping]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TellersToAccountsMapping](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TellersToAccountsMapping] ON
INSERT [dbo].[TellersToAccountsMapping] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (1, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'20160302170014157', N'STANBIC')
SET IDENTITY_INSERT [dbo].[TellersToAccountsMapping] OFF
/****** Object:  Table [dbo].[ChargeTypes]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChargeTypes](
	[ChargeTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ChargeTypeCode] [varchar](50) NULL,
	[ChargeTypeName] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ChargeTypes] ON
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode], [Description], [IsActive]) VALUES (1, N'FLAT_FEE', N'FLAT FEE', CAST(0x0000A5BC015B33D3 AS DateTime), CAST(0x0000A5BC015B33D3 AS DateTime), N'admin', N'admin', N'STANBIC', N'FLAT FEE', 1)
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode], [Description], [IsActive]) VALUES (2, N'PERCENTAGE', N'PERCENTAGE', CAST(0x0000A5BC015B33DC AS DateTime), CAST(0x0000A5BC015B33DC AS DateTime), N'admin', N'admin', N'STANBIC', N'PERCENTAGE', 1)
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode], [Description], [IsActive]) VALUES (3, N'FLAT_FEE', N'FLAT FEE', CAST(0x0000A5BE014E0420 AS DateTime), CAST(0x0000A5BE014E0420 AS DateTime), N'admin', N'admin', N'CENTENARY', N'FLAT FEE', 1)
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode], [Description], [IsActive]) VALUES (4, N'PERCENTAGE', N'PERCENTAGE', CAST(0x0000A5BE014E0420 AS DateTime), CAST(0x0000A5BE014E0420 AS DateTime), N'admin', N'admin', N'CENTENARY', N'PERCENTAGE', 1)
SET IDENTITY_INSERT [dbo].[ChargeTypes] OFF
/****** Object:  Table [dbo].[Currencies]    Script Date: 03/05/2016 22:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Currencies](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyName] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedOn] [datetime] NULL,
	[ValueInLocalCurrency] [money] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Currencies] ON
INSERT [dbo].[Currencies] ([RecordId], [CurrencyName], [CurrencyCode], [BankCode], [ModifiedBy], [CreatedBy], [ModifiedOn], [CreatedOn], [ValueInLocalCurrency]) VALUES (1, N'UGANDA SHILLINGS', N'UGS', N'STANBIC', N'admin', N'admin', CAST(0x0000A5BC015B33F4 AS DateTime), CAST(0x0000A5BC015B33F4 AS DateTime), 1.0000)
INSERT [dbo].[Currencies] ([RecordId], [CurrencyName], [CurrencyCode], [BankCode], [ModifiedBy], [CreatedBy], [ModifiedOn], [CreatedOn], [ValueInLocalCurrency]) VALUES (2, N'UGANDA SHILLINGS', N'UGS', N'CENTENARY', N'admin', N'admin', CAST(0x0000A5BE014E0422 AS DateTime), CAST(0x0000A5BE014E0422 AS DateTime), 1.0000)
SET IDENTITY_INSERT [dbo].[Currencies] OFF
/****** Object:  StoredProcedure [dbo].[Banks_DeleteRow]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_DeleteRow]	@BankId intASSET NOCOUNT ON
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Banks](
	[BankId] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [varchar](50) NULL,
	[BankCode] [varchar](50) NOT NULL,
	[BankContactEmail] [varchar](50) NULL,
	[BankPassword] [varchar](50) NULL,
	[IsActive] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[LastUpdateDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[PathToLogoImage] [varchar](1300) NULL,
	[PathToPublicKey] [varchar](1300) NULL,
	[ThemeColor] [varchar](50) NULL,
	[NavbarTextColor] [varchar](50) NULL,
	[BankVaultAccNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Banks] ON
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey], [ThemeColor], [NavbarTextColor], [BankVaultAccNumber]) VALUES (1, N'STANBIC BANK UGANDA', N'STANBIC', N'nsubugak@yahoo.com', N'F3D05B8DC763605BCEEA27D11D0E8346', N'TRUE', CAST(0x0000A5BC015B3369 AS DateTime), CAST(0x0000A5C000FFFF0E AS DateTime), NULL, NULL, N'Desert.jpg', N'C:\CoreBankingResources\PublicKeys\STANBIC\pegasus.cer', N'#660033', N'#FF0066', N'20160303201606885')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey], [ThemeColor], [NavbarTextColor], [BankVaultAccNumber]) VALUES (2, N'CENTENARY BANK', N'CENTENARY', N'nsubugak@yahoo.com', N'F3D05B8DC763605BCEEA27D11D0E8346', N'TRUE', CAST(0x0000A5BE014E0416 AS DateTime), CAST(0x0000A5BE014E0416 AS DateTime), NULL, NULL, N'Desert.jpg', N'C:\CoreBankingResources\PublicKeys\STANBIC\pegasus.cer', N'#FFCC00', N'#00FFCC', N'20160303201606884')
SET IDENTITY_INSERT [dbo].[Banks] OFF
/****** Object:  Table [dbo].[BankCustomers]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankCustomers](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Fullname] [varchar](50) NULL,
	[Pin] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[DateOfBirth] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[PathToProfilePic] [varchar](8000) NULL,
	[PathToSignature] [varchar](8000) NULL,
	[NextOfKinName] [varchar](50) NULL,
	[NextOfKinContact] [varchar](50) NULL,
	[Nationality] [varchar](50) NULL,
	[PlaceOfBirth] [varchar](50) NULL,
	[Salutation] [varchar](50) NULL,
	[MaritalStatus] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankCustomers] ON
INSERT [dbo].[BankCustomers] ([RecordId], [CustomerId], [Email], [Fullname], [Pin], [Password], [IsActive], [BankCode], [DateOfBirth], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [PathToProfilePic], [PathToSignature], [NextOfKinName], [NextOfKinContact], [Nationality], [PlaceOfBirth], [Salutation], [MaritalStatus]) VALUES (2, N'kiracho.islam@pegasustechnologies.co.ug', N'kiracho.islam@pegasustechnologies.co.ug', N'Kiracho Islam', NULL, N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BD00CA217B AS DateTime), CAST(0x0000A5BD00CCD47B AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'humphrey.tugume@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'dennis.mushabe@pegasustechnologies.co.ug', N'635925183320745394.jpg', N'635925177109682152.jpg', N'Mrs Kiracho', N'0785975800', N'Ugandan', NULL, NULL, N'SINGLE')
SET IDENTITY_INSERT [dbo].[BankCustomers] OFF
/****** Object:  Table [dbo].[BankCharges]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankCharges](
	[ChargeId] [int] IDENTITY(1,1) NOT NULL,
	[ChargeAmount] [money] NULL,
	[CommissionAccount] [varchar](50) NULL,
	[TransCategory] [varchar](50) NULL,
	[IsDebit] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[ChargeCode] [varchar](50) NULL,
	[ChargeName] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ChargeDesc] [varchar](150) NULL,
	[IsActive] [varchar](50) NULL,
	[AccountType] [varchar](50) NULL,
	[ChargeType] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectRow]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankTellers_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 9:32:04 PM
-- Description:	This stored procedure is intended for selecting a specific row from BankTellers table
-- ==========================================================================================
Create Procedure [dbo].[BankTellers_SelectRow]
	@TellerId int
As
Begin
	Select 
	*
	From BankTellers
	Where
		[TellerId] = @TellerId
End
GO
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectAll]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankTellers_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 9:32:04 PM
-- Description:	This stored procedure is intended for selecting all rows from BankTellers table
-- ==========================================================================================
Create Procedure [dbo].[BankTellers_SelectAll]
As
Begin
	Select 
		*
	From BankTellers
End
GO
/****** Object:  StoredProcedure [dbo].[BankTellers_Insert]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankTellers_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 9:32:04 PM
-- Description:	This stored procedure is intended for inserting values to BankTellers table
-- ==========================================================================================
Create Procedure [dbo].[BankTellers_Insert]
	@UserId varchar(50),
	@AccountNumber varchar(50),
	@BranchCode varchar(50),
	@BankCode varchar(50)
As
Begin
	Insert Into BankTellers
		([UserId],[AccountNumber],[BranchCode],[BankCode])
	Values
		(@UserId,@AccountNumber,@BranchCode,@BankCode)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[BankTellers_DeleteRow]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankTellers_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 9:32:04 PM
-- Description:	This stored procedure is intended for deleting a specific row from BankTellers table
-- ==========================================================================================
Create Procedure [dbo].[BankTellers_DeleteRow]
	@TellerId int
As
Begin
	Delete BankTellers
	Where
		[TellerId] = @TellerId

End
GO
/****** Object:  Table [dbo].[BankSystemUsers]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankSystemUsers](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Fullname] [varchar](50) NULL,
	[Usertype] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[BankCode] [varchar](50) NULL,
	[DateOfBirth] [varchar](50) NULL,
	[RecordDate] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[TranAmountLimit] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankSystemUsers] ON
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (1, N'admin', N'nsubugak@yahoo.com', N'admin', N'SYS_ADMIN', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'Pegasus', N'12/01/1988', CAST(0x0000A5BC00000000 AS DateTime), CAST(0x0000A5BC00000000 AS DateTime), N'admin', N'admin', N'0785975800', N'Pegasus', N'Male', N'Admin', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (2, N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'Deo Emorut', N'BANK_ADMIN', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC015B6E6B AS DateTime), CAST(0x0000A5BC015B6E6B AS DateTime), N'admin', N'admin', N'', N'Kansanga-001', N'Male', N'admin', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (3, N'arnold@pegasustechnologies.co.ug', N'arnold@pegasustechnologies.co.ug', N'Arnold Muhwezi', N'BANK_ADMIN', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC015B8C8C AS DateTime), CAST(0x0000A5BC015B8C8C AS DateTime), N'admin', N'admin', N'', N'Kansanga-001', N'Male', N'admin', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (4, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'Andrew Kagwa', N'TELLER', N'T3rr1613', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC015BD5DF AS DateTime), CAST(0x0000A5C0016D0C79 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'', N'Kansanga-001', N'Male', N'deo.emorut@pegasustechnologies.co.ug', N'3000000')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (5, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'Dennis Mushabe', N'MANAGER', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC01610B0E AS DateTime), CAST(0x0000A5BC01610B0E AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'deo.emorut@pegasustechnologies.co.ug', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (6, N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'Paul Kavule', N'BUSSINESS_ADMIN', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC0169116F AS DateTime), CAST(0x0000A5BC0169116F AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'deo.emorut@pegasustechnologies.co.ug', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (7, N'humphrey.tugume@pegasustechnologies.co.ug', N'humphrey.tugume@pegasustechnologies.co.ug', N'Humphrey Tugume', N'CUSTOMER_SERVICE', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC0169294B AS DateTime), CAST(0x0000A5BF0118362A AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'deo.emorut@pegasustechnologies.co.ug', N'0')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [ModifiedOn], [CreatedBy], [ModifiedBy], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit]) VALUES (8, N'martha.anthea@pegasustechnologies.co.ug', N'martha.anthea@pegasustechnologies.co.ug', N'Martha Anthea', N'SUPERVISOR_TELLER', N'F3D05B8DC763605BCEEA27D11D0E8346', 1, N'STANBIC', N'28/02/2016', CAST(0x0000A5BC016973C9 AS DateTime), CAST(0x0000A5BC016973C9 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'', N'Kansanga-001', N'Male', N'deo.emorut@pegasustechnologies.co.ug', N'0')
SET IDENTITY_INSERT [dbo].[BankSystemUsers] OFF
/****** Object:  Table [dbo].[GeneralLedgerTable]    Script Date: 03/05/2016 22:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GeneralLedgerTable](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[PegPayTranId] [varchar](50) NULL,
	[CustomerName] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[ToAccount] [varchar](50) NULL,
	[FromAccount] [varchar](50) NULL,
	[TranAmount] [money] NULL,
	[BankTranId] [varchar](50) NULL,
	[TranType] [varchar](50) NULL,
	[TranCategory] [varchar](50) NULL,
	[PaymentDate] [datetime] NULL,
	[RecordDate] [datetime] NULL,
	[AccountBalBefore] [money] NULL,
	[AccountBalAfter] [money] NULL,
	[Teller] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Narration] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[ValueInLocalCurrencyFromAccount] [money] NULL,
	[ValueInLocalCurrencyToAccount] [money] NULL,
	[ValueInLocalCurrencyTranAmount] [money] NULL,
	[PaymentType] [varchar](50) NULL,
	[ChequeNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GeneralLedgerTable] ON
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (1, N'10000001', N'BANK BRANCH VAULT CREDIT', N'20160303202253901', N'', N'20160303201606885', 35000.0000, N'7', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE015092D5 AS DateTime), 0.0000, 35000.0000, N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BANK BRANCH VAULT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (2, N'10000001', N'BANK BRANCH VAULT CREDIT', N'20160303201606885', N'20160303202253901', N'', 35000.0000, N'7', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE015092D6 AS DateTime), 0.0000, -35000.0000, N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BANK BRANCH VAULT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (3, N'10000003', N'BRANCH TELLER ACCOUNT CREDIT', N'20160302170014157', N'', N'20160303201606885', 2000.0000, N'8', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE01555B39 AS DateTime), 0.0000, 2000.0000, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (4, N'10000003', N'BRANCH TELLER ACCOUNT CREDIT', N'20160303201606885', N'20160302170014157', N'', 2000.0000, N'8', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE01555B39 AS DateTime), -35000.0000, -37000.0000, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (5, N'10000005', N'Kiracho Islam', N'20160302124223645', N'', N'20160302170014157', 1000.0000, N'9', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE015A860B AS DateTime), 0.0000, 1000.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (6, N'10000005', N'Kiracho Islam', N'20160302170014157', N'20160302124223645', N'', 1000.0000, N'9', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BE00000000 AS DateTime), CAST(0x0000A5BE015A860B AS DateTime), 2000.0000, 1000.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'test', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (7, N'10000007', N'BRANCH TELLER ACCOUNT CREDIT', N'20160302170014157', N'', N'20160303201606885', 20000.0000, N'13', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011BF451 AS DateTime), 1000.0000, 21000.0000, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (8, N'10000007', N'BRANCH TELLER ACCOUNT CREDIT', N'20160303201606885', N'20160302170014157', N'', 20000.0000, N'13', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011BF451 AS DateTime), -37000.0000, -57000.0000, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'STANBIC', N'Kansanga-001', N'BRANCH TELLER ACCOUNT CREDIT', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (9, N'10000009', N'Kiracho Islam', N'20160302124223645', N'', N'20160302170014157', 2000.0000, N'15', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011D0DB6 AS DateTime), 1000.0000, 3000.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (10, N'10000009', N'Kiracho Islam', N'20160302170014157', N'20160302124223645', N'', 2000.0000, N'15', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011D0DB6 AS DateTime), 21000.0000, 19000.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (11, N'10000011', N'Kiracho Islam', N'20160302124223645', N'', N'20160302170014157', 2500.0000, N'16', N'CREDIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011E1D43 AS DateTime), 3000.0000, 5500.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (12, N'10000011', N'Kiracho Islam', N'20160302170014157', N'20160302124223645', N'', 2500.0000, N'16', N'DEBIT', N'DEPOSIT', CAST(0x0000A5BF00000000 AS DateTime), CAST(0x0000A5BF011E1D43 AS DateTime), 19000.0000, 16500.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (13, N'10000013', N'Kiracho Islam', N'20160302124223645', N'', N'20160302170014157', 1700.0000, N'17', N'CREDIT', N'DEPOSIT', CAST(0x0000A5C000000000 AS DateTime), CAST(0x0000A5C001635F48 AS DateTime), 5500.0000, 7200.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [CurrencyCode], [ValueInLocalCurrencyFromAccount], [ValueInLocalCurrencyToAccount], [ValueInLocalCurrencyTranAmount], [PaymentType], [ChequeNumber]) VALUES (14, N'10000013', N'Kiracho Islam', N'20160302170014157', N'20160302124223645', N'', 1700.0000, N'17', N'DEBIT', N'DEPOSIT', CAST(0x0000A5C000000000 AS DateTime), CAST(0x0000A5C001635F48 AS DateTime), 16500.0000, 14800.0000, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'STANBIC', N'Kansanga-001', N'Rent', N'UGS', 1.0000, 1.0000, 1.0000, N'CASH', N'')
SET IDENTITY_INSERT [dbo].[GeneralLedgerTable] OFF
/****** Object:  UserDefinedFunction [dbo].[fn_GetReceiptno]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_GetReceiptno](@TransID bigint)
  RETURNS varchar(50)
      AS
    BEGIN
		DECLARE @ret varchar(50)
		DECLARE @res varchar(50)
		DECLARE @tranCode varchar(50)
		SET @tranCode = (CONVERT( varchar(50),@TransID))
		IF (LEN(@TransID) = 1)
		  SET @ret = '000000'+@tranCode
		ELSE IF (LEN(@TransID) = 2)
		  SET @ret = '00000'+@tranCode
		ELSE IF (LEN(@TransID) = 3)
		  SET @ret = '0000'+@tranCode
		ELSE IF(LEN(@TransID) = 4)
		  SET @ret = '000'+@tranCode
		ELSE IF (LEN(@TransID) = 5)
		  SET @ret = '00'+@tranCode
		ELSE IF (LEN(@TransID) = 6)
		  SET @ret = '0'+@tranCode
		ELSE
		   SET @ret = @tranCode	
		   
		   SET @res = '1'+@ret
		return @res
    END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetAccountNo]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_GetAccountNo](@CurrentDateTime datetime)
  RETURNS varchar(50)
      AS
    BEGIN
		DECLARE @ret varchar(50)
		DECLARE @res varchar(50)
		
		SET @ret = DATEPART(YEAR,@CurrentDateTime)+DATEPART(MONTH,@CurrentDateTime)+DATEPART(DAY,@CurrentDateTime)+
				   DATEPART(HOUR,@CurrentDateTime)+DATEPART(MINUTE,@CurrentDateTime)+DATEPART(SECOND,@CurrentDateTime)+
				   DATEPART(MICROSECOND,@CurrentDateTime)
		   
	    SET @res = @ret
		return @res
    END
GO
/****** Object:  Table [dbo].[Errorlogs]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Errorlogs](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[BankId] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[Message] [varchar](950) NULL,
	[RecordDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[CustomerTypes_Update]
	@CustomerTypeId int,
	@CustomerType varchar(50),
	@Description varchar(100),
	@BankCode varchar(50)
As
if not exists(Select * from CustomerTypes where CustomerType=@CustomerType and BankCode=@BankCode)
Begin
	Insert Into CustomerTypes
			([CustomerType],[Description],BankCode)
	Values
			(@CustomerType,@Description,@BankCode)
			
	Select  @CustomerType as InsertedId
End
Else
Begin
	Update CustomerTypes
	Set
		[CustomerType] = @CustomerType,
		[Description] = @Description,
		BankCode=@BankCode
	Where		
		CustomerType = @CustomerType and BankCode=@BankCode
		
   Select  @CustomerType as InsertedId
End
GO
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_CustomerTypes_SelectRow
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:43:59 PM
-- Description:	This stored procedure is intended for selecting a specific row from CustomerTypes table
-- ==========================================================================================
Create Procedure [dbo].[CustomerTypes_SelectRow]
	@CustomerTypeId int
As
Begin
	Select 
		[CustomerTypeId],
		[CustomerType],
		[Description]
	From CustomerTypes
	Where
		[CustomerTypeId] = @CustomerTypeId
End
GO
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_CustomerTypes_SelectAll
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:43:59 PM
-- Description:	This stored procedure is intended for selecting all rows from CustomerTypes table
-- ==========================================================================================
Create Procedure [dbo].[CustomerTypes_SelectAll]
As
Begin
	Select 
		[CustomerTypeId],
		[CustomerType],
		[Description]
	From CustomerTypes
End
GO
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_CustomerTypes_Insert
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:43:59 PM
-- Description:	This stored procedure is intended for inserting values to CustomerTypes table
-- ==========================================================================================
Create Procedure [dbo].[CustomerTypes_Insert]
	@CustomerType varchar(50),
	@Description varchar(100)
As
Begin
	Insert Into CustomerTypes
		([CustomerType],[Description])
	Values
		(@CustomerType,@Description)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[CustomerTypes_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_CustomerTypes_DeleteRow
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:43:59 PM
-- Description:	This stored procedure is intended for deleting a specific row from CustomerTypes table
-- ==========================================================================================
Create Procedure [dbo].[CustomerTypes_DeleteRow]
	@CustomerTypeId int
As
Begin
	Delete CustomerTypes
	Where
		[CustomerTypeId] = @CustomerTypeId

End
GO
/****** Object:  Table [dbo].[CustomersToAccountsMapping]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomersToAccountsMapping](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CustomersToAccountsMapping] ON
INSERT [dbo].[CustomersToAccountsMapping] ([RecordId], [CustomerId], [AccountNumber], [BankCode]) VALUES (1, N'kiracho.islam@pegasustechnologies.co.ug', N'20160302124223645', N'STANBIC')
SET IDENTITY_INSERT [dbo].[CustomersToAccountsMapping] OFF
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[AccTypeId] [int] IDENTITY(1,1) NOT NULL,
	[AccTypeName] [varchar](50) NULL,
	[AccTypeCode] [varchar](50) NULL,
	[MinimumBal] [money] NULL,
	[BankCode] [varchar](50) NULL,
	[IsDebitable] [bit] NULL,
	[Description] [varchar](150) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
	[MinNumberOfSignatories] [int] NULL,
	[MaxNumberOfSignatories] [int] NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[AccTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (1, N'COMMISSION ACCOUNT', N'COMMISSION_ACCOUNT', 0.0000, N'STANBIC', 1, N'Commission Account', N'admin', N'admin', CAST(0x0000A5BC015B33B3 AS DateTime), CAST(0x0000A5BC015B33B3 AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (2, N'TELLER ACCOUNT', N'TELLER_ACCOUNT', 0.0000, N'STANBIC', 1, N'Teller Account', N'admin', N'admin', CAST(0x0000A5BC015B33CA AS DateTime), CAST(0x0000A5BC015B33CA AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (3, N'SAVINGS ACCOUNT', N'SAVINGS_ACCOUNT', 0.0000, N'STANBIC', 1, N'Savings Account', N'admin', N'admin', CAST(0x0000A5BC015B33CA AS DateTime), CAST(0x0000A5BC015B33CA AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (4, N'CURRENT ACCOUNT', N'CURRENT_ACCOUNT', 0.0000, N'STANBIC', 1, N'Current Account', N'admin', N'admin', CAST(0x0000A5BC015B33CA AS DateTime), CAST(0x0000A5BC015B33CA AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (5, N'CORPORATE ACCOUNT', N'CORPORATE_ACCOUNT', 0.0000, N'STANBIC', 1, N'Corporate Account', N'admin', N'admin', CAST(0x0000A5BC015B33CA AS DateTime), CAST(0x0000A5BC015B33CA AS DateTime), 1, 1, 4)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (6, N'COMMISSION ACCOUNT', N'COMMISSION_ACCOUNT', 0.0000, N'CENTENARY', 1, N'Commission Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (7, N'SUSPENSE ACCOUNT', N'SUSPENSE_ACCOUNT', -1000000000.0000, N'CENTENARY', 1, N'Suspense Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 0, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (8, N'TELLER ACCOUNT', N'TELLER_ACCOUNT', 0.0000, N'CENTENARY', 1, N'Teller Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (9, N'SAVINGS ACCOUNT', N'SAVINGS_ACCOUNT', 0.0000, N'CENTENARY', 1, N'Savings Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (10, N'CURRENT ACCOUNT', N'CURRENT_ACCOUNT', 0.0000, N'CENTENARY', 1, N'Current Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 1, 1)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (11, N'CORPORATE ACCOUNT', N'CORPORATE_ACCOUNT', 0.0000, N'CENTENARY', 1, N'Corporate Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 1, 4)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (12, N'SUSPENSE ACCOUNT', N'SUSPENSE_ACCOUNT', -1000000000.0000, N'STANBIC', 1, N'Suspense Account', N'admin', N'admin', CAST(0x0000A5BE014E041E AS DateTime), CAST(0x0000A5BE014E041E AS DateTime), 1, 0, 1)
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
/****** Object:  Table [dbo].[AccessAreas]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccessAreas](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[AreaName] [varchar](50) NULL,
	[AreaCode] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AccessRules]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccessRules](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[RuleName] [varchar](50) NULL,
	[UserType] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[CanAccess] [varchar](8000) NULL,
	[UserId] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AccessRules] ON
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (1, N'Bank Admin Rule', N'BANK_ADMIN', N'STANBIC', N'BANK_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3390 AS DateTime), N'admin', CAST(0x0000A5BC015B3390 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (2, N'Manager Rule', N'MANAGER', N'STANBIC', N'MANAGER,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3395 AS DateTime), N'admin', CAST(0x0000A5BC015B3395 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (3, N'Teller Rule', N'TELLER', N'STANBIC', N'TELLER,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3395 AS DateTime), N'admin', CAST(0x0000A5BC015B3395 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (4, N'Supervisor Rule', N'SUPERVISOR_TELLER', N'STANBIC', N'SUPERVISOR,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3395 AS DateTime), N'admin', CAST(0x0000A5BC015B3395 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (5, N'Customer Service Rule', N'CUSTOMER_SERVICE', N'STANBIC', N'CUSTOMER_SERVICE,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3396 AS DateTime), N'admin', CAST(0x0000A5BC015B3396 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (6, N'Bussiness Admin Rule', N'BUSSINESS_ADMIN', N'STANBIC', N'BUSSINESS_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5BC015B3396 AS DateTime), N'admin', CAST(0x0000A5BC015B3396 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (7, N'Bank Admin Rule', N'BANK_ADMIN', N'CENTENARY', N'BANK_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (8, N'Manager Rule', N'MANAGER', N'CENTENARY', N'MANAGER,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (9, N'Teller Rule', N'TELLER', N'CENTENARY', N'TELLER,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (10, N'Supervisor Rule', N'SUPERVISOR_TELLER', N'CENTENARY', N'SUPERVISOR,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (11, N'Customer Service Rule', N'CUSTOMER_SERVICE', N'CENTENARY', N'CUSTOMER_SERVICE,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (12, N'Bussiness Admin Rule', N'BUSSINESS_ADMIN', N'CENTENARY', N'BUSSINESS_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5BE014E0419 AS DateTime), N'admin', CAST(0x0000A5BE014E0419 AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[AccessRules] OFF
/****** Object:  Table [dbo].[BankBranches]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankBranches](
	[BranchId] [int] IDENTITY(1,1) NOT NULL,
	[BranchName] [nvarchar](50) NULL,
	[BranchCode] [nvarchar](50) NULL,
	[Location] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[BankCode] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[BranchVaultAccNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankBranches] ON
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BranchVaultAccNumber]) VALUES (1, N'Kansanga Branch', N'Kansanga-001', N'Kansanga', 1, N'STANBIC', CAST(0x0000A5BC015B4DCB AS DateTime), CAST(0x0000A5BC015B4DCB AS DateTime), N'admin', N'admin', N'20160303201606885')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BranchVaultAccNumber]) VALUES (2, N'Wandegeya Branch', N'Wandegeya-001', N'Wandegeya', 1, N'STANBIC', CAST(0x0000A5BE014FE127 AS DateTime), CAST(0x0000A5BE014FE127 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'20160303202253901')
SET IDENTITY_INSERT [dbo].[BankBranches] OFF
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankAccounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccBalance] [money] NULL,
	[AccNumber] [varchar](50) NULL,
	[AccType] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[ApprovedBy] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankAccounts] ON
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (1, 7200.0000, N'20160302124223645', N'CURRENT_ACCOUNT', N'STANBIC', CAST(0x0000A5BD00D16FCF AS DateTime), CAST(0x0000A5BD00D16FCF AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'humphrey.tugume@pegasustechnologies.co.ug', 1, N'dennis.mushabe@pegasustechnologies.co.ug', N'Kansanga-001', N'UGS')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (2, 14800.0000, N'20160302170014157', N'TELLER_ACCOUNT', N'STANBIC', CAST(0x0000A5BD01183E2A AS DateTime), CAST(0x0000A5BD01183E2A AS DateTime), N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', 1, N'paul.kavule@pegasustechnologies.co.ug', N'Kansanga-001', N'UGS')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (3, 0.0000, N'20160303201606884', N'SUSPENSE_ACCOUNT', N'CENTENARY', CAST(0x0000A5BE014E0424 AS DateTime), CAST(0x0000A5BE014E0424 AS DateTime), N'admin', N'admin', 1, N'admin', N'CENTENARY', N'UGS')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (4, 0.0000, N'000000001', N'SUSPENSE_ACCOUNT', N'Pegasus', CAST(0x0000A5BE014E0424 AS DateTime), CAST(0x0000A5BE014E0424 AS DateTime), N'admin', N'admin', 1, N'admin', N'Pegasus', N'UGS')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (5, -57000.0000, N'20160303201606885', N'SUSPENSE_ACCOUNT', N'STANBIC', CAST(0x0000A5BE014E0424 AS DateTime), CAST(0x0000A5BE014E0424 AS DateTime), N'admin', N'admin', 1, N'admin', N'STANBIC', N'UGS')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode], [CurrencyCode]) VALUES (6, 35000.0000, N'20160303202253901', N'SUSPENSE_ACCOUNT', N'STANBIC', CAST(0x0000A5BE014FE127 AS DateTime), CAST(0x0000A5BE014FE127 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', 1, N'deo.emorut@pegasustechnologies.co.ug', N'Wandegeya-001', N'UGS')
SET IDENTITY_INSERT [dbo].[BankAccounts] OFF
/****** Object:  Table [dbo].[AuditTrail]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AuditTrail](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[ActionType] [varchar](50) NULL,
	[TableName] [varchar](50) NULL,
	[BankCode] [nvarchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Action] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AuditTrail] ON
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (1, N'CREATE', N'Bank', N'STANBIC', CAST(0x0000A5BC015B3359 AS DateTime), N'admin', N'Created new Bank with BankId = 0, BankName = STANBIC BANK UGANDA, BankCode = STANBIC, BankContactEmail = nsubugak@yahoo.com, BankPassword = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = admin, PathToPublicKey = C:\CoreBankingResources\PublicKeys\STANBIC\pegasus.cer, PathToLogoImage = Desert.jpg, BankThemeColor = #FF6633, TextColor = #99FF66, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (2, N'CREATE', N'BankBranch', N'STANBIC', CAST(0x0000A5BC015B4DBE AS DateTime), N'admin', N'Created new BankBranch with BankBranchId = , BranchName = Kansanga Branch, BranchCode = Kansanga-001, Location = Kansanga, BankCode = STANBIC, ModifiedBy = admin, IsActive = TRUE, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (3, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC015B6E62 AS DateTime), N'admin', N'Created new BankUser with Email = deo.emorut@pegasustechnologies.co.ug, Id = deo.emorut@pegasustechnologies.co.ug, FullName = Deo Emorut, Usertype = BANK_ADMIN, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = admin, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = admin, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (4, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC015B8C84 AS DateTime), N'admin', N'Created new BankUser with Email = arnold@pegasustechnologies.co.ug, Id = arnold@pegasustechnologies.co.ug, FullName = Arnold Muhwezi, Usertype = BANK_ADMIN, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = admin, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = admin, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (5, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC015BD5DF AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankUser with Email = kagwa.andrew@pegasustechnolgoies.co.ug, Id = kagwa.andrew@pegasustechnolgoies.co.ug, FullName = Andrew Kagwa, Usertype = TELLER, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 3000000, ApprovedBy = deo.emorut@pegasustechnologies.co.ug, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (6, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC01610B09 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankUser with Email = dennis.mushabe@pegasustechnologies.co.ug, Id = dennis.mushabe@pegasustechnologies.co.ug, FullName = Dennis Mushabe, Usertype = MANAGER, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = , StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (7, N'UPDATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC0168EA6A AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Updated BankUser, Changed ModifiedBy From  To deo.emorut@pegasustechnologies.co.ug, Changed TransactionLimit From  To 3000000, Changed ApprovedBy From deo.emorut@pegasustechnologies.co.ug To ,')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (12, N'CREATE', N'BankCustomer', N'STANBIC', CAST(0x0000A5BD00CA1CC8 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Created new BankCustomer with Email = kiracho.islam@pegasustechnologies.co.ug, Id = kiracho.islam@pegasustechnologies.co.ug, FullName = Kiracho Islam, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = humphrey.tugume@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, PathToProfilePic = 635925177024307269.jpg, PathToSignature = 635925177109682152.jpg, ApprovedBy = , NextOfKinName = Mrs Kiracho, NextOfKinContact = 0785975800, MaritalStatus = SINGLE, Nationality = Ugandan, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (8, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC01691169 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankUser with Email = paul.kavule@pegasustechnologies.co.ug, Id = paul.kavule@pegasustechnologies.co.ug, FullName = Paul Kavule, Usertype = BUSSINESS_ADMIN, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = , StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (9, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC0169294B AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankUser with Email = humphrey.tugume@pegasustechnologies.co.ug, Id = humphrey.tugume@pegasustechnologies.co.ug, FullName = Humphrey Tugume, Usertype = CUSTOMER_SERVICE, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = , StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (10, N'CREATE', N'BankUser', N'STANBIC', CAST(0x0000A5BC016973C1 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankUser with Email = martha.anthea@pegasustechnologies.co.ug, Id = martha.anthea@pegasustechnologies.co.ug, FullName = Martha Anthea, Usertype = SUPERVISOR_TELLER, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, TransactionLimit = 0, ApprovedBy = , StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (11, N'UPDATE', N'BankCustomer', N'STANBIC', CAST(0x0000A5BC016A5481 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Updated BankCustomer, Changed FullName From Andrew Kagwa To Kiracho Islam, Changed ModifiedBy From  To humphrey.tugume@pegasustechnologies.co.ug, Changed ApprovedBy From deo.emorut@pegasustechnologies.co.ug To ,')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (13, N'CREATE', N'BankCustomer', N'STANBIC', CAST(0x0000A5BD00CCD473 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Created new BankCustomer with Email = kiracho.islam@pegasustechnologies.co.ug, Id = kiracho.islam@pegasustechnologies.co.ug, FullName = Kiracho Islam, Password = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = humphrey.tugume@pegasustechnologies.co.ug, BranchCode = Kansanga-001, DateOfBirth = 28/02/2016, PhoneNumber = , Gender = Male, BankCode = STANBIC, PathToProfilePic = 635925183320745394.jpg, PathToSignature = 635925183410130506.jpg, ApprovedBy = , NextOfKinName = Mrs Kiracho, NextOfKinContact = 0785975800, MaritalStatus = SINGLE, Nationality = Ugandan, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (16, N'CREATE', N'BankAccount', N'STANBIC', CAST(0x0000A5BD00D16F76 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Created new BankAccount with AccountId = , AccountNumber = 20160302124223645, AccountBalance = 0, AccountType = CURRENT_ACCOUNT, BankCode = STANBIC, ModifiedBy = humphrey.tugume@pegasustechnologies.co.ug, BranchCode = Kansanga-001, IsActive = TRUE, CurrencyCode = UGS, AccountSignatories = System.Collections.Generic.List`1[System.String], ApprovedBy = , StatusCode = 0, StatusDesc = , ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (17, N'CREATE', N'BankAccount', N'STANBIC', CAST(0x0000A5BD01183E28 AS DateTime), N'paul.kavule@pegasustechnologies.co.ug', N'Created new BankAccount with AccountId = , AccountNumber = 20160302170014157, AccountBalance = 0, AccountType = TELLER_ACCOUNT, BankCode = STANBIC, ModifiedBy = paul.kavule@pegasustechnologies.co.ug, BranchCode = Kansanga-001, IsActive = TRUE, CurrencyCode = UGS, AccountSignatories = System.Collections.Generic.List`1[System.String], ApprovedBy = , StatusCode = , StatusDesc = , ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (14, N'CREATE', N'BankAccount', N'STANBIC', CAST(0x0000A5BD00CDC653 AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Created new BankAccount with AccountId = , AccountNumber = 20160302122848966, AccountBalance = 0, AccountType = CURRENT_ACCOUNT, BankCode = STANBIC, ModifiedBy = humphrey.tugume@pegasustechnologies.co.ug, BranchCode = Kansanga-001, IsActive = TRUE, CurrencyCode = UGS, AccountSignatories = System.Collections.Generic.List`1[System.String], ApprovedBy = , StatusCode = 0, StatusDesc = , ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (15, N'CREATE', N'BankAccount', N'STANBIC', CAST(0x0000A5BD00D1339C AS DateTime), N'humphrey.tugume@pegasustechnologies.co.ug', N'Created new BankAccount with AccountId = , AccountNumber = 20160302122848966, AccountBalance = 0, AccountType = CURRENT_ACCOUNT, BankCode = STANBIC, ModifiedBy = humphrey.tugume@pegasustechnologies.co.ug, BranchCode = Kansanga-001, IsActive = TRUE, CurrencyCode = UGS, AccountSignatories = System.Collections.Generic.List`1[System.String], ApprovedBy = , StatusCode = 0, StatusDesc = , ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (18, N'UPDATE', N'Bank', N'STANBIC', CAST(0x0000A5BE0149D102 AS DateTime), N'admin', N'Updated Bank, Changed BankId From 1 To 0, Changed ModifiedBy From  To admin, Changed BankThemeColor From #FF6633 To #336633, Changed TextColor From #99FF66 To #00FFCC, Changed BankVaultAccNumber From  To 20160303200049441,')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (19, N'CREATE', N'Bank', N'CENTENARY', CAST(0x0000A5BE014E0416 AS DateTime), N'admin', N'Created new Bank with BankId = 0, BankName = CENTENARY BANK, BankCode = CENTENARY, BankContactEmail = nsubugak@yahoo.com, BankPassword = F3D05B8DC763605BCEEA27D11D0E8346, IsActive = TRUE, ModifiedBy = admin, PathToPublicKey = C:\CoreBankingResources\PublicKeys\STANBIC\pegasus.cer, PathToLogoImage = Desert.jpg, BankThemeColor = #FFCC00, TextColor = #00FFCC, BankVaultAccNumber = 20160303201606884, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (20, N'CREATE', N'BankBranch', N'STANBIC', CAST(0x0000A5BE014FE113 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Created new BankBranch with BankBranchId = , BranchName = Wandegeya Branch, BranchCode = Wandegeya-001, Location = Wandegeya, BankCode = STANBIC, ModifiedBy = deo.emorut@pegasustechnologies.co.ug, IsActive = TRUE, BranchVaultAccNumber = 20160303202253901, StatusCode = 0, StatusDesc = SUCCESS, ')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (21, N'UPDATE', N'BankUser', N'STANBIC', CAST(0x0000A5BF0117DD15 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Updated BankUser, Changed IsActive From TRUE To FALSE, Changed ModifiedBy From  To deo.emorut@pegasustechnologies.co.ug, Changed TransactionLimit From  To 0, Changed ApprovedBy From deo.emorut@pegasustechnologies.co.ug To ,')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (22, N'UPDATE', N'BankUser', N'STANBIC', CAST(0x0000A5BF01183629 AS DateTime), N'deo.emorut@pegasustechnologies.co.ug', N'Updated BankUser, Changed IsActive From FALSE To TRUE, Changed ModifiedBy From  To deo.emorut@pegasustechnologies.co.ug, Changed TransactionLimit From  To 0, Changed ApprovedBy From deo.emorut@pegasustechnologies.co.ug To ,')
INSERT [dbo].[AuditTrail] ([RecordId], [ActionType], [TableName], [BankCode], [ModifiedOn], [ModifiedBy], [Action]) VALUES (23, N'UPDATE', N'Bank', N'STANBIC', CAST(0x0000A5C000FFFF07 AS DateTime), N'admin', N'Updated Bank, Changed BankId From 1 To 0, Changed ModifiedBy From  To admin, Changed BankThemeColor From #336633 To #FF3300, Changed TextColor From #00FFCC To #FF0066, Changed BankVaultAccNumber From 20160303201606885 To 20160305153203214,')
SET IDENTITY_INSERT [dbo].[AuditTrail] OFF
/****** Object:  StoredProcedure [dbo].[AprroveOrRejectUser]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AprroveOrRejectUser]
@UserId varchar(50),
@BankCode varchar(50),
@IsActive varchar(50),
@ApprovedBy varchar(50)
as
Begin transaction trans
Begin try
if(@IsActive='true')
Begin
	Update BankSystemUsers set IsActive=@IsActive,ApprovedBy=@ApprovedBy 
	where UserId=@UserId and BankCode=@BankCode
End
Else
Begin
	insert into RejectedBankSystemUsers
	select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode
	Delete from BankSystemUsers where UserId=@UserId and BankCode=@BankCode
End
Commit transaction trans
End try
Begin catch
Rollback transaction trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
End catch
GO
/****** Object:  StoredProcedure [dbo].[AprroveOrRejectTellerAccount]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AprroveOrRejectTellerAccount]
@AccountNumber varchar(50),
@BankCode varchar(50),
@Status bit,
@ApprovedBy varchar(50)
as
Begin transaction trans
Begin try
if(@Status=1)
Begin
	Update BankAccounts set IsActive=@status,ApprovedBy=@ApprovedBy 
	where AccNumber=@AccountNumber and BankCode=@BankCode
End
Else
Begin
	Insert into RejectedBankAccounts(AccBalance,AccNumber,AccType,BankCode,BranchCode,CreatedBy,CreatedOn,CurrencyCode,IsActive,ModifiedBy,ModifiedOn,RejectedBy)
	Select AccBalance,AccNumber,AccType,BankCode,BranchCode,CreatedBy,CreatedOn,CurrencyCode,IsActive,ModifiedBy,ModifiedOn,ApprovedBy from BankAccounts where AccNumber=@AccountNumber and BankCode=@BankCode
	Delete from BankAccounts where AccNumber=@AccountNumber and BankCode=@BankCode
End
Commit transaction trans
End try
Begin Catch
Rollback transaction trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
End Catch
GO
/****** Object:  StoredProcedure [dbo].[AprroveOrRejectCustomer]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AprroveOrRejectCustomer]
@UserId varchar(50),
@BankCode varchar(50),
@IsActive varchar(50),
@ApprovedBy varchar(50)
as
Begin transaction trans
Begin try
if(@IsActive='true')
Begin
	Update BankCustomers set ApprovedBy=@ApprovedBy 
	where CustomerId=@UserId and BankCode=@BankCode
End
Else
Begin
	insert into RejectedBankcustomers
	select * from BankCustomers where CustomerId=@UserId and BankCode=@BankCode
	Delete from BankCustomers where CustomerId=@UserId and BankCode=@BankCode
End
Commit transaction trans
End try
Begin catch
Rollback transaction trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
End catch
GO
/****** Object:  StoredProcedure [dbo].[ApproveOrRejectBankAccount]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ApproveOrRejectBankAccount]
@BankCode varchar(50),
@AccountNumber varchar(50),
@Status varchar(50),
@ApprovedBy varchar(50)
as
Begin transaction trans
Begin try
if(@Status='true')
Begin
	Update BankAccounts set IsActive=@status,ApprovedBy=@ApprovedBy 
	where AccNumber=@AccountNumber and BankCode=@BankCode
End
Else
Begin
	Insert into RejectedBankAccounts(AccBalance,AccNumber,AccType,BankCode,BranchCode,CreatedBy,CreatedOn,CurrencyCode,IsActive,ModifiedBy,ModifiedOn,RejectedBy)
	Select AccBalance,AccNumber,AccType,BankCode,BranchCode,CreatedBy,CreatedOn,CurrencyCode,IsActive,ModifiedBy,ModifiedOn,ApprovedBy from BankAccounts where AccNumber=@AccountNumber and BankCode=@BankCode
	Delete from BankAccounts where AccNumber=@AccountNumber and BankCode=@BankCode
End
Commit transaction trans
End try
Begin Catch
Rollback transaction trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
End Catch
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccountTypes_Update
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 8:59:16 PM
-- Description:	This stored procedure is intended for updating AccountTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[AccountTypes_Update]
	@AccTypeId varchar(50),
	@AccTypeName varchar(50),
	@AccTypeCode varchar(50),
	@MinimumBal money,
	@BankCode varchar(50),
	@IsDebitable bit,
	@Description varchar(150),
	@ModifiedBy varchar(50),
	@IsActive bit,
	@MinSignatories int,
	@MaxSignatories int
As
Begin Transaction Trans
Begin try
if exists(Select * from AccountTypes where BankCode=@BankCode and AccTypeCode=@AccTypeCode)
Begin
	Update AccountTypes
	Set
		[AccTypeName] = @AccTypeName,
		[AccTypeCode] = @AccTypeCode,
		[MinimumBal] = @MinimumBal,
		[BankCode] = @BankCode,
		[IsDebitable] = @IsDebitable,
		Description=@Description,
		ModifiedBy=@ModifiedBy,
		ModifiedOn=GETDATE(),
		IsActive=@IsActive,
		MinNumberOfSignatories=@MinSignatories,
		MaxNumberOfSignatories=@MaxSignatories
	Where		
		BankCode=@BankCode and AccTypeCode=@AccTypeCode
		
		Select @AccTypeCode as InseretedId
End
Else
Begin
	Insert Into AccountTypes
		([AccTypeName],[AccTypeCode],[MinimumBal],[BankCode],[IsDebitable],Description,ModifiedBy,CreatedBy,ModifiedOn,CreatedOn,IsActive,MinNumberOfSignatories,MaxNumberOfSignatories)
	Values
		(@AccTypeName,@AccTypeCode,@MinimumBal,@BankCode,@IsDebitable,@Description,@ModifiedBy,@ModifiedBy,GETDATE(),GETDATE(),@IsActive,@MinSignatories,@MaxSignatories)

	select @AccTypeCode as InsertedId
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccountTypes_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 8:59:16 PM
-- Description:	This stored procedure is intended for selecting a specific row from AccountTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[AccountTypes_SelectRow]
	@AccTypeCode varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
		*
	From AccountTypes
	Where AccTypeCode=@AccTypeCode and BankCode=@BankCode
	 
End
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccountTypes_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 8:59:16 PM
-- Description:	This stored procedure is intended for selecting all rows from AccountTypes table
-- ==========================================================================================
Create Procedure [dbo].[AccountTypes_SelectAll]
As
Begin
	Select *
	From AccountTypes
End
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccountTypes_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 8:59:16 PM
-- Description:	This stored procedure is intended for inserting values to AccountTypes table
-- ==========================================================================================
Create Procedure [dbo].[AccountTypes_Insert]
	@AccTypeName varchar(50),
	@AccTypeCode varchar(50),
	@MinimumBal money,
	@BankCode varchar(50),
	@IsDebitable bit
As
Begin
	Insert Into AccountTypes
		([AccTypeName],[AccTypeCode],[MinimumBal],[BankCode],[IsDebitable])
	Values
		(@AccTypeName,@AccTypeCode,@MinimumBal,@BankCode,@IsDebitable)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccountTypes_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 8:59:16 PM
-- Description:	This stored procedure is intended for deleting a specific row from AccountTypes table
-- ==========================================================================================
Create Procedure [dbo].[AccountTypes_DeleteRow]
	@AccTypeId int
As
Begin
	Delete AccountTypes
	Where
		[AccTypeId] = @AccTypeId

End
GO
/****** Object:  StoredProcedure [dbo].[Accounts_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectRow]	@AccountNumber varchar(50),	@BankCode varchar(50)ASSET NOCOUNT ONSELECT A.*,B.CustomerId as UserIdFROM BankAccounts Ainner join CustomersToAccountsMapping B on (A.AccNumber=B.AccountNumber and A.BankCode=B.BankCode)WHERE (A.AccNumber=@AccountNumber and A.BankCode=@BankCode)UNION
SELECT A.*,B.UserId as UserIdFROM BankAccounts Ainner join TellersToAccountsMapping B on (A.AccNumber=B.AccountNumber and A.BankCode=B.BankCode)WHERE (A.AccNumber=@AccountNumber and A.BankCode=@BankCode)
GO
/****** Object:  StoredProcedure [dbo].[Accounts_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankAccounts Ainner join UsersToAccounts B on A.AccNumber=B.AccountNumberSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Accounts_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Accounts_Insert]
@AccountId varchar(50),	@AccBalance money,	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50),	@ModifiedBy varchar(50),	@BranchCode varchar(50),	@IsActive bit,	@CurrencyCode varchar(50),	@ApprovedBy varchar(50)ASBEGIN TRANSACTION CreateAccountBEGIN TRYIF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode,		CreatedOn,		ModifiedOn,		CreatedBy,		ModifiedBy,		BranchCode,		IsActive,		CurrencyCode,		ApprovedBy	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode,		GETDATE(),		GETDATE(),		@ModifiedBy,		@ModifiedBy,		@BranchCode,		@IsActive,		@CurrencyCode,		@ApprovedBy	)		SELECT @AccNumber As InsertedID	ENDCOMMIT TRANSACTION CreateAccountEND TRYBEGIN CATCH
ROLLBACK Transaction CreateAccount

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Accounts_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_DeleteRow]	@AccountId intASSET NOCOUNT ONDELETE FROM BankAccountsWHERE [AccountId] = @AccountIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessRules_Update
-- Author:	Nsubuga Kasozi
-- Create date:	1/7/2016 4:47:57 PM
-- Description:	This stored procedure is intended for updating AccessRules table
-- ==========================================================================================
CREATE Procedure [dbo].[AccessRules_Update]
	@RecordId varchar(50),
	@RuleName varchar(50),
	@UserType varchar(50),
	@BankCode varchar(50),
	@CanAccess varchar(8000),
	@UserId varchar(50),
	@BranchCode varchar(50),
	@IsActive bit,
	@ModifiedOn varchar(50),
	@ModifiedBy varchar(50)
As
Begin Transaction trans
Begin Try
if exists (Select * from AccessRules where BankCode=@BankCode and RuleName=@RuleName)
Begin
	Update AccessRules
	Set
		[RuleName] = @RuleName,
		[UserType] = @UserType,
		[BankCode] = @BankCode,
		[CanAccess] = @CanAccess,
		[UserId] = @UserId,
		[BranchCode] = @BranchCode,
		[IsActive] = @IsActive,
		[ModifiedOn] = GETDATE(),
		[ModifiedBy] = @ModifiedBy,
		[CreatedOn] = GETDATE(),
		[CreatedBy] = @modifiedBy
	Where		
		BankCode=@BankCode and RuleName=@RuleName
		
		Select @RuleName as InsertedId
End
Else 
Begin
	Insert Into AccessRules
		([RuleName],[UserType],[BankCode],[CanAccess],[UserId],[BranchCode],[IsActive],[ModifiedOn],[ModifiedBy],[CreatedOn],[CreatedBy])
	Values
		(@RuleName,@UserType,@BankCode,@CanAccess,@UserId,@BranchCode,@IsActive,GETDATE(),@ModifiedBy,GETDATE(),@ModifiedBy)
    
    Select @RuleName as InsertedId
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessRules_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/7/2016 4:47:57 PM
-- Description:	This stored procedure is intended for selecting a specific row from AccessRules table
-- ==========================================================================================
CREATE Procedure [dbo].[AccessRules_SelectRow]
	@Id varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
		*
	From AccessRules
	Where (UserType=@Id) and (BankCode=@BankCode or BankCode='ALL') 
		
End
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessRules_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	1/7/2016 4:47:57 PM
-- Description:	This stored procedure is intended for selecting all rows from AccessRules table
-- ==========================================================================================
Create Procedure [dbo].[AccessRules_SelectAll]
As
Begin
	Select *
	From AccessRules
End
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessRules_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	1/7/2016 4:47:57 PM
-- Description:	This stored procedure is intended for inserting values to AccessRules table
-- ==========================================================================================
Create Procedure [dbo].[AccessRules_Insert]
	@RuleName varchar(50),
	@UserType varchar(50),
	@BankCode varchar(50),
	@CanAccess varchar(8000),
	@UserId varchar(50),
	@BranchCode varchar(50),
	@IsActive bit,
	@ModifiedOn datetime,
	@ModifiedBy datetime,
	@CreatedOn datetime,
	@CreatedBy datetime
As
Begin
	Insert Into AccessRules
		([RuleName],[UserType],[BankCode],[CanAccess],[UserId],[BranchCode],[IsActive],[ModifiedOn],[ModifiedBy],[CreatedOn],[CreatedBy])
	Values
		(@RuleName,@UserType,@BankCode,@CanAccess,@UserId,@BranchCode,@IsActive,@ModifiedOn,@ModifiedBy,@CreatedOn,@CreatedBy)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessRules_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/7/2016 4:47:57 PM
-- Description:	This stored procedure is intended for deleting a specific row from AccessRules table
-- ==========================================================================================
Create Procedure [dbo].[AccessRules_DeleteRow]
	@RecordId int
As
Begin
	Delete AccessRules
	Where
		[RecordId] = @RecordId

End
GO
/****** Object:  StoredProcedure [dbo].[AccessAreas_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessAreas_Update
-- Author:	Nsubuga Kasozi
-- Create date:	1/5/2016 4:20:40 PM
-- Description:	This stored procedure is intended for updating AccessAreas table
-- ==========================================================================================
Create Procedure [dbo].[AccessAreas_Update]
	@RecordId int,
	@AreaName varchar(50),
	@AreaCode varchar(50)
As
Begin
	Update AccessAreas
	Set
		[AreaName] = @AreaName,
		[AreaCode] = @AreaCode
	Where		
		[RecordId] = @RecordId

End
GO
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessAreas_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/5/2016 4:20:40 PM
-- Description:	This stored procedure is intended for selecting a specific row from AccessAreas table
-- ==========================================================================================
Create Procedure [dbo].[AccessAreas_SelectRow]
	@RecordId int
As
Begin
	Select *
	From AccessAreas
	Where
		[RecordId] = @RecordId
End
GO
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessAreas_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	1/5/2016 4:20:40 PM
-- Description:	This stored procedure is intended for selecting all rows from AccessAreas table
-- ==========================================================================================
Create Procedure [dbo].[AccessAreas_SelectAll]
As
Begin
	Select *
	From AccessAreas
End
GO
/****** Object:  StoredProcedure [dbo].[AccessAreas_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessAreas_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	1/5/2016 4:20:40 PM
-- Description:	This stored procedure is intended for inserting values to AccessAreas table
-- ==========================================================================================
Create Procedure [dbo].[AccessAreas_Insert]
	@AreaName varchar(50),
	@AreaCode varchar(50)
As
Begin
	Insert Into AccessAreas
		([AreaName],[AreaCode])
	Values
		(@AreaName,@AreaCode)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[AccessAreas_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	AccessAreas_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/5/2016 4:20:40 PM
-- Description:	This stored procedure is intended for deleting a specific row from AccessAreas table
-- ==========================================================================================
Create Procedure [dbo].[AccessAreas_DeleteRow]
	@RecordId int
As
Begin
	Delete AccessAreas
	Where
		[RecordId] = @RecordId

End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankBranches_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 7:57:44 PM
-- Description:	This stored procedure is intended for selecting a specific row from BankBranches table
-- ==========================================================================================
CREATE Procedure [dbo].[BankBranches_SelectRow]
	@BranchCode varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
		*
	From BankBranches
	Where
		BranchCode=@BranchCode and BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankBranches_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 7:57:44 PM
-- Description:	This stored procedure is intended for selecting all rows from BankBranches table
-- ==========================================================================================
Create Procedure [dbo].[BankBranches_SelectAll]
As
Begin
	Select 
		*
	From BankBranches
End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankBranches_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 7:57:44 PM
-- Description:	This stored procedure is intended for inserting values to BankBranches table
-- ==========================================================================================
CREATE Procedure [dbo].[BankBranches_Insert]
	@BranchName nvarchar(50),
	@BranchCode nvarchar(50),
	@Location nvarchar(100),
	@BankCode nvarchar(50),
	@CreatedOn datetime,
	@ModifiedOn datetime,
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50)
As
Begin
	Insert Into BankBranches
		([BranchName],[BranchCode],[Location],[BankCode],[CreatedOn],[ModifiedOn],[CreatedBy],[ModifiedBy])
	Values
		(@BranchName,@BranchCode,@Location,@BankCode,@CreatedOn,@ModifiedOn,@CreatedBy,@ModifiedBy)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankBranches_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 7:57:44 PM
-- Description:	This stored procedure is intended for deleting a specific row from BankBranches table
-- ==========================================================================================
Create Procedure [dbo].[BankBranches_DeleteRow]
	@BranchId int
As
Begin
	Delete BankBranches
	Where
		[BranchId] = @BranchId

End
GO
/****** Object:  StoredProcedure [dbo].[Accounts_UpdateReturnAccountId]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_UpdateReturnAccountId]	@AccountId int,	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50)ASDeclare @Ret int;IF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	SET @AccNumber = dbo.fn_GetAccountNo(GETDATE())	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode	)			SELECT @Ret = SCOPE_IDENTITY() 	return @RetENDELSE BEGIN	UPDATE BankAccounts SET		[AccType] = @AccType,		BankCode = @BankCode	WHERE AccNumber = @AccNumber		SELECT @Ret=AccountId from BankAccounts where AccNumber= @AccNumber	return @RetEND
GO
/****** Object:  StoredProcedure [dbo].[CustomersToAccounts_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CustomersToAccounts_Insert]
@UserId varchar(50),
@AccountNumber varchar(50),
@BankCode varchar(50)
as
if not exists(select * from CustomersToAccountsMapping where CustomerId=@UserId and AccountNumber=@AccountNumber and BankCode=@BankCode)
Begin
INSERT INTO CustomersToAccountsMapping
           (CustomerId
           ,[AccountNumber]
           ,[BankCode])
     VALUES
           (@UserId
           ,@AccountNumber
           ,@BankCode)
End
GO
/****** Object:  StoredProcedure [dbo].[Customers_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_Update]	@UserId varchar(50),
	@Email varchar(50),
	@Fullname varchar(50),
	@Password varchar(50),
	@IsActive bit,
	@BankCode varchar(50),
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50),
	@ApprovedBy varchar(50),
	@PhoneNumber varchar(50),
	@BranchCode varchar(50),
	@DateOfBirth varchar(50),
	@Gender varchar(50),
	@PathToProfilePic varchar(50),
	@PathToSignature varchar(50),
	@NextOfKinName varchar(50),
	@NextOfKinContact varchar(50),
	@MaritalStatus varchar(50),
	@Nationality varchar(50)
As
Begin transaction trans
Begin try
IF not exists(Select * from BankCustomers where CustomerId=@UserId and BankCode=@BankCode)
Begin
	Insert Into BankCustomers
		(CustomerId,Email,[Fullname],
		[Password],[IsActive],BankCode,CreatedOn,
		ModifiedOn,CreatedBy,ModifiedBy,ApprovedBy,
		PhoneNumber,BranchCode,DateOfBirth,Gender,
		PathToProfilePic,PathToSignature,
		NextOfKinName,NextOfKinContact,Nationality,MaritalStatus
		)
	Values
		(@UserId,@Email,@Fullname,
		 @Password,@IsActive,@BankCode,GETDATE(),
		 GETDATE(),@CreatedBy,@ModifiedBy,
		 @ApprovedBy,@PhoneNumber,@BranchCode,
		 @DateOfBirth,@Gender,
		 @PathToProfilePic,@PathToSignature,@NextOfKinName,
		 @NextOfKinContact,@Nationality,@MaritalStatus)
	Select @UserId as InsertedId
End
Else
Begin
	if(@ApprovedBy='')
	Begin
		Update BankCustomers
		Set
			[Fullname] = @Fullname,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode=@BankCode,
			ModifiedOn=GETDATE(),
			ModifiedBy=@ModifiedBy,
			PhoneNumber=@PhoneNumber,
			BranchCode=@BranchCode,
			DateOfBirth=@DateOfBirth,
			Gender=@Gender,
			PathToProfilePic=@PathToProfilePic
		Where		
			CustomerId = @UserId and BankCode=@BankCode
		Select @UserId as InsertedId
	End
	Else
	Begin
		Update BankCustomers
		Set
			[Fullname] = @Fullname,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode=@BankCode,
			ModifiedOn=GETDATE(),
			ModifiedBy=@ModifiedBy,
			ApprovedBy=@ApprovedBy,
			PhoneNumber=@PhoneNumber,
			BranchCode=@BranchCode,
			DateOfBirth=@DateOfBirth,
			Gender=@Gender,
			PathToProfilePic=@PathToProfilePic
		Where		
			CustomerId = @UserId and BankCode=@BankCode
		Select @UserId as InsertedId
	End
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Customers_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectRow]	@CustomerId varchar(50)ASSET NOCOUNT ONSELECT * FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankCustomersSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_DeleteRow]	@CustomerId intASSET NOCOUNT ONDELETE FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Currencies_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Currencies_Update]
@CurrencyName varchar(50),
@CurrencyCode varchar(50),
@BankCode varchar(50),
@ModifiedBy varchar(50),
@ValueInLocalCurrency money
as
Begin transaction trans
Begin try
if exists(Select * from Currencies where BankCode=@BankCode and CurrencyCode=@CurrencyCode)
	Begin
		Update Currencies set CurrencyName=@CurrencyName,ModifiedBy=@ModifiedBy,
		ModifiedOn=GETDATE(),ValueInLocalCurrency=@ValueInLocalCurrency 
		where BankCode=@BankCode and CurrencyCode=@CurrencyCode
		Select @CurrencyCode as InsertedId
	End
Else
	Begin
		INSERT INTO [TestCoreBankingDB].[dbo].[Currencies]
				   ([CurrencyName]
				   ,[CurrencyCode]
				   ,[BankCode]
				   ,[ModifiedBy]
				   ,[CreatedBy]
				   ,[ModifiedOn]
				   ,[CreatedOn]
				   ,[ValueInLocalCurrency])
			 VALUES
				   (@CurrencyName
				   ,@CurrencyCode
				   ,@BankCode
				   ,@ModifiedBy
				   ,@ModifiedBy
				   ,GETDATE()
				   ,GETDATE()
				   ,@ValueInLocalCurrency)
		 Select @CurrencyCode as InsertedId
	End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Currencies_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Currencies_SelectRow]
@CurrencyCode varchar(50),
@BankCode varchar(50)
as
Select * from Currencies 
where CurrencyCode=@CurrencyCode and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[InsertIntoAuditTrail]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertIntoAuditTrail]
@ActionType varchar(50),
@TableName varchar(50),
@BankCode varchar(50),
@ModifiedBy varchar(50),
@Action nvarchar(4000)
as
Insert into AuditTrail([Action],ActionType,BankCode,ModifiedBy,ModifiedOn,TableName)
values(@Action,@ActionType,@BankCode,@ModifiedBy,GETDATE(),@TableName)

Select SCOPE_IDENTITY() as InsertedId
GO
/****** Object:  StoredProcedure [dbo].[GetUserTypesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUserTypesByBankCode]
@bankCode varchar(50)
as
Select * from UserTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionTypesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetTransactionTypesByBankCode]
	@bankcode varchar(50)
As
Begin
	Select *
	From TransactionCategories
	Where
		BankCode=@bankcode
End
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionRequestDetails]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTransactionRequestDetails]
@BankId varchar(50),
@BankCode varchar(50)
as
Select * from TransactionRequests 
where RecordId=@BankId and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionRequest]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTransactionRequest]
@BankTranId varchar(50),
@BankCode varchar(50)
as 
Select * from TransactionRequests where RecordId=@BankTranId and @BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionByBankId]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetTransactionByBankId]
@Bankref varchar(50),
@BankCode varchar(50)
as 
Select * from GeneralLedgerTable with(nolock) where 
BankTranId=@Bankref and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTellersWhoDontHaveAccounts]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetTellersWhoDontHaveAccounts]
@BankCode varchar(50)
as
Select * from BankSystemUsers where 
Usertype='TELLER' and UserId not in (Select UserId from TellersToAccountsMapping)
and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTellerAccounts]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetTellerAccounts]
@BankCode varchar(50),
@BranchCode varchar(50)
as
Select AccNumber as AccountNumber,Fullname,AccType,A.BranchCode,A.IsActive,A.CreatedBy from BankAccounts A
inner join TellersToAccountsMapping B on A.AccNumber=B.AccountNumber
inner join BankSystemUsers C on C.UserId=B.UserId 
where 
(A.BankCode=@BankCode) and
(A.BranchCode=@BranchCode)
GO
/****** Object:  StoredProcedure [dbo].[GetRedirectUrl]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetRedirectUrl]
@EditType varchar(50)
as
Select * from UrlRedirects where EditType=@EditType
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentTypesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[GetPaymentTypesByBankCode]
	@bankcode varchar(50)
As
Begin
	Select *
	From PaymentTypes
	Where
		BankCode=@bankcode
End
GO
/****** Object:  StoredProcedure [dbo].[GetCurrenciesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetCurrenciesByBankCode]
@BankCode varchar(50)
as
Select * from Currencies where BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetCommissionAccountsByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCommissionAccountsByBankCode]
	@bankcode varchar(50)
As
Begin
	Select *
	From BankAccounts
	Where
		BankCode=@bankcode and AccType like '%COMMISSION%'
End
GO
/****** Object:  StoredProcedure [dbo].[GetChargeTypesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetChargeTypesByBankCode]
@bankCode varchar(50)
as
Select * from ChargeTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankUsersPendingApproval]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetBankUsersPendingApproval]
@bankCode varchar(50),
@branchCode varchar(50),
@teller varchar(50),
@accountNumber varchar(50),
@name varchar(50),
@fromDate varchar(50),
@toDate varchar(50)
as
Select UserId,Email,Fullname,Gender,Usertype,RecordDate as CreatedOn,CreatedBy from BankSystemUsers
where
ApprovedBy='' and
((Fullname like '%'+@name+'%') or @name='') and
(BankCode=@bankCode or @bankCode='ALL') and
(BranchCode=@branchCode or @branchCode='ALL') and
(RecordDate>=@fromDate or @fromDate='') and
(RecordDate<=@toDate or @toDate='')
GO
/****** Object:  StoredProcedure [dbo].[GetBankTellerAccountsPendingApproval]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetBankTellerAccountsPendingApproval]
@BankCode varchar(50),
@BranchCode varchar(50),
@UserId varchar(50)
as
Select AccNumber,Fullname,AccType,A.BranchCode,A.IsActive,A.CreatedBy from BankAccounts A
inner join TellersToAccountsMapping B on A.AccNumber=B.AccountNumber
inner join BankSystemUsers C on C.UserId=B.UserId 
where 
((A.ApprovedBy='') or (A.ApprovedBy is NULL)) and
(A.BankCode=@BankCode) and
(A.BranchCode=@BranchCode or @BranchCode='ALL') and
((C.UserId=@UserId) or @UserId='')
GO
/****** Object:  StoredProcedure [dbo].[GetBankCustomersPendingApproval]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBankCustomersPendingApproval]
@bankCode varchar(50),
@branchCode varchar(50),
@name varchar(50)
as
Select CustomerId,Email,Fullname,Gender,CreatedOn,CreatedBy from BankCustomers
where
ApprovedBy='' and
((Fullname like '%'+@name+'%') or @name='') and
(BankCode=@bankCode or @bankCode='ALL') and
(BranchCode=@branchCode or @branchCode='ALL')
GO
/****** Object:  StoredProcedure [dbo].[GetBankBranchesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBankBranchesByBankCode]
@bankCode varchar(50)
as
Select * from BankBranches where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankAccountsPendingApproval]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetBankAccountsPendingApproval]
@BankCode varchar(50),
@BranchCode varchar(50),
@AccountNumber varchar(50),
@Custname varchar(50),
@fromDate varchar(50),
@toDate varchar(50)
as
Select AccNumber,Fullname,AccType,A.BranchCode,A.IsActive,A.CreatedBy from BankAccounts A
inner join CustomersToAccountsMapping B on A.AccNumber=B.AccountNumber
inner join BankCustomers C on C.CustomerId=B.CustomerId 
where 
((A.ApprovedBy='') or (A.ApprovedBy is NULL)) and
(A.BankCode=@BankCode) and
(A.BranchCode=@BranchCode or @BranchCode='ALL') and
(AccNumber=@AccountNumber or @AccountNumber='') and
((C.Fullname like '%'+@Custname+'%') or @Custname='')
GO
/****** Object:  StoredProcedure [dbo].[GetAllRedirectUrls]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAllRedirectUrls]
@EditType varchar(50)
as
Select * from UrlRedirects
GO
/****** Object:  StoredProcedure [dbo].[GetAllBanks]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAllBanks]
as
Select BankName,BankCode,BankContactEmail,IsActive,BankVaultAccNumber
 from Banks
GO
/****** Object:  StoredProcedure [dbo].[GetAccountTypesByBankCode]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAccountTypesByBankCode]
@bankCode varchar(50)
as
Select * from AccountTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetAccountStatement]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAccountStatement]
@AccountNumber varchar(50),
@BankCode varchar(50),
@StatementType varchar(50)
as
if(@StatementType='MINI')
Begin
Select top 15 * from GeneralLedgerTable where 
(toAccount=@AccountNumber or fromAccount=@AccountNumber) and 
BankCode=@BankCode order by RecordDate desc
End
Else
Begin
Select * from GeneralLedgerTable where 
(toAccount=@AccountNumber or fromAccount=@AccountNumber) and 
BankCode=@BankCode order by RecordDate desc
End
GO
/****** Object:  StoredProcedure [dbo].[GetAccountSignatories]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAccountSignatories]
@AccNumber varchar(50),
@BankCode varchar(50)
as
Select * from BankSystemUsers A
inner join UsersToAccounts B on (A.UserId=B.UserId and A.BankCode=B.BankCode)
inner join BankAccounts C on (B.AccountNumber=C.AccNumber)
where C.AccNumber=@AccNumber and C.BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetAccountsByUserId]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAccountsByUserId]
@UserId varchar(50)
as
Select * from BankAccounts A
inner join TellersToAccountsMapping B on A.AccNumber=B.AccountNumber
where 
UserId=@UserId
GO
/****** Object:  StoredProcedure [dbo].[CheckIfItViolatesRules]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[CheckIfItViolatesRules]
@BankCode varchar(50),
@BranchCode varchar(50),
@UserId varchar(50),
@Amount varchar(50)
As
Begin
	Select 
		*
	From TransactionRules
	Where
		BankCode=@BankCode and 
		(BranchCode=@BranchCode or BranchCode='ALL') and 
		(UserId=@UserId or UserId='ALL') and
		(MinimumAmount>@Amount or MaximumAmount<@Amount)
End
GO
/****** Object:  StoredProcedure [dbo].[ChargeTypes_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ChargeTypes_Update]
@ChargeTypeCode varchar(50),
@ChargeTypeName varchar(50),
@ModifiedBy varchar(50),
@BankCode varchar(50),
@Description varchar(50),
@IsActive bit
as
Begin Transaction trans
Begin try
If exists(select * from ChargeTypes where ChargeTypeCode=@ChargeTypeCode and BankCode=@BankCode)
	Begin
		Update ChargeTypes set ChargeTypeName=@ChargeTypeName,ModifiedOn=GETDATE(),
		ModifiedBy=@ModifiedBy,Description=@Description,IsActive=@IsActive
		where ChargeTypeCode=@ChargeTypeCode and BankCode=@BankCode
		Select @ChargeTypeCode as InsertedId
	End
Else
	Begin
		INSERT INTO [ChargeTypes]
				   ([ChargeTypeCode]
				   ,[ChargeTypeName]
				   ,[CreatedOn]
				   ,[ModifiedOn]
				   ,[CreatedBy]
				   ,[ModifiedBy]
				   ,[BankCode]
				   ,Description
				   ,IsActive)
			 VALUES
				   (@ChargeTypeCode,
					@ChargeTypeName,
					GETDATE(),
					GETDATE(),
					@ModifiedBy,
					@ModifiedBy,
					@BankCode,
					@Description,
					@IsActive)
		Select @ChargeTypeCode as InsertedId
	End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[ChargeTypes_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for selecting a specific row from Charges table
-- ==========================================================================================
create Procedure [dbo].[ChargeTypes_SelectRow]
	@ChargeType varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
	*
	From ChargeTypes
	Where
		ChargeTypeCode=@ChargeType and BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[Charges_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_Update
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for updating Charges table
-- ==========================================================================================
CREATE Procedure [dbo].[Charges_Update]
	@ChargeId varchar(50),
	@ChargeAmount money,
	@CommissionAccount varchar(50),
	@TranType varchar(50),
	@IsDebit bit,
	@BankCode varchar(50),
    @ModifiedBy varchar(50),
    @ModifiedOn datetime,
    @ChargeDescription varchar(100),
    @ChargeName varchar(50),
    @ChargeCode varchar(50),
    @IsActive bit,
    @AccountType varchar(50),
    @ChargeType varchar(50)
As
Begin Transaction trans
Begin try
if not exists(Select * from BankCharges where BankCode=@BankCode and ChargeCode=@ChargeCode)
	Begin
		Insert Into BankCharges
				([ChargeAmount],[CommissionAccount],TransCategory,[IsDebit],BankCode,ModifiedBy,ModifiedOn,ChargeDesc,ChargeName,ChargeCode,CreatedOn,CreatedBy,IsActive,AccountType,ChargeType)
			Values
				(@ChargeAmount,@CommissionAccount,@TranType,@IsDebit,@BankCode,@ModifiedBy,GETDATE(),@ChargeDescription,@ChargeName,@ChargeCode,GETDATE(),@ModifiedBy,@IsActive,@AccountType,@ChargeType)
				
		Select  @ChargeCode as InsertedId
		
	End
Else
	Begin
		Update BankCharges
		Set
			[ChargeAmount] = @ChargeAmount,
			[CommissionAccount] = @CommissionAccount,
			TransCategory = @TranType,
			[IsDebit] = @IsDebit,
			[BankCode] = @BankCode,
			ModifiedBy=@ModifiedBy,
			ModifiedOn=GETDATE(),
			ChargeDesc=@ChargeDescription,
			ChargeName=@ChargeName,
			ChargeCode=@ChargeCode,
			IsActive=@IsActive,
			AccountType=@AccountType,
			ChargeType=@ChargeType
		Where		
			ChargeCode=@ChargeCode and BankCode=@BankCode
			
			Select  @ChargeCode as InsertedId

	End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Charges_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for selecting a specific row from Charges table
-- ==========================================================================================
CREATE Procedure [dbo].[Charges_SelectRow]
	@ChargeCode varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
	*
	From BankCharges
	Where
		ChargeCode = @ChargeCode and BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[Charges_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for selecting all rows from Charges table
-- ==========================================================================================
CREATE Procedure [dbo].[Charges_SelectAll]
As
Begin
	Select 
	*
	From BankCharges
End
GO
/****** Object:  StoredProcedure [dbo].[Charges_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for inserting values to Charges table
-- ==========================================================================================
CREATE Procedure [dbo].[Charges_Insert]
	@ChargeAmount money,
	@CommissionAccount varchar(50),
	@TranType varchar(50),
	@IsDebit bit,
	@BankCode varchar(50)
As
Begin
	Insert Into BankCharges
		([ChargeAmount],[CommissionAccount],[IsDebit],[BankCode])
	Values
		(@ChargeAmount,@CommissionAccount,@IsDebit,@BankCode)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[Charges_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Charges_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 8:37:16 AM
-- Description:	This stored procedure is intended for deleting a specific row from Charges table
-- ==========================================================================================
CREATE Procedure [dbo].[Charges_DeleteRow]
	@ChargeId int
As
Begin
	Delete from BankCharges
	Where
		[ChargeId] = @ChargeId

End
GO
/****** Object:  StoredProcedure [dbo].[ChangeUsersPassword]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ChangeUsersPassword]
@UserId varchar(50),
@BankCode varchar(50),
@NewPassword varchar(50)
as
Update BankSystemUsers set Password=@NewPassword,ModifiedBy=@UserId,ModifiedOn=GETDATE() where UserId=@UserId and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[BankTellers_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankTellers_Update
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 9:32:04 PM
-- Description:	This stored procedure is intended for updating BankTellers table
-- ==========================================================================================
CREATE Procedure [dbo].[BankTellers_Update]
	@UserId varchar(50),
	@Email varchar(50),
    @FullName varchar(50),
    @Usertype varchar(50),
    @Password varchar(50),
    @IsActive varchar(50),
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50),
    @ApprovedBy varchar(50),
    @BranchCode varchar(50),
    @DateOfBirth varchar(50),
    @PhoneNumber varchar(50),
    @Gender varchar(50),
	@AccountNumber varchar(50),
	@BankCode varchar(50),
	@TranAmountLimit varchar(50)
As
Begin transaction trans
Begin try
IF not exists(Select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode)
Begin
	Insert Into BankSystemUsers
		(UserId,Email,[Fullname],[Usertype],
		[Password],[IsActive],BankCode,RecordDate,
		ModifiedOn,CreatedBy,ModifiedBy,ApprovedBy,PhoneNumber,BranchCode,DateOfBirth,Gender,TranAmountLimit,PathToProfilePic,PathToSignature)
	Values
		(@UserId,@Email,@Fullname,@Usertype,
		 @Password,@IsActive,@BankCode,GETDATE(),
		 GETDATE(),@CreatedBy,@ModifiedBy,@ApprovedBy,@PhoneNumber,@BranchCode,@DateOfBirth,@Gender,@TranAmountLimit,'','')
	
	--EXEC Accounts_Update '',0,@UserId,@AccountNumber,'TELLER_ACCOUNT',@BankCode,@ModifiedBy,@BranchCode,@IsActive,
	Select @UserId as InsertedId
End
Else
Begin
	--if this is approved By field is not set	if(@ApprovedBy='')	Begin
		Update BankSystemUsers
		Set
			[Fullname] = @Fullname,
			[Usertype] = @Usertype,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode=@BankCode,
			ModifiedOn=GETDATE(),
			ModifiedBy=@ModifiedBy,
			PhoneNumber=@PhoneNumber,
			BranchCode=@BranchCode,
			DateOfBirth=@DateOfBirth,
			Gender=@Gender,
			TranAmountLimit=@TranAmountLimit
		Where		
			UserId = @UserId and BankCode=@BankCode
			Select @UserId as InsertedId
	End
	Else
	Begin
		Update BankSystemUsers
		Set
			[Fullname] = @Fullname,
			[Usertype] = @Usertype,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode=@BankCode,
			ModifiedOn=GETDATE(),
			ModifiedBy=@ModifiedBy,
			ApprovedBy=@ApprovedBy,
			PhoneNumber=@PhoneNumber,
			BranchCode=@BranchCode,
			DateOfBirth=@DateOfBirth,
			Gender=@Gender,
			TranAmountLimit=@TranAmountLimit
		Where		
			UserId = @UserId and BankCode=@BankCode
		Select @UserId as InsertedId
	End
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
Begin Catch
ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
End Catch
GO
/****** Object:  StoredProcedure [dbo].[TellersToAccounts_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[TellersToAccounts_Insert]
@UserId varchar(50),
@AccountNumber varchar(50),
@BankCode varchar(50)
as
if not exists(select * from TellersToAccountsMapping where UserId=@UserId and AccountNumber=@AccountNumber and BankCode=@BankCode)
Begin
INSERT INTO TellersToAccountsMapping
           ([UserId]
           ,[AccountNumber]
           ,[BankCode])
     VALUES
           (@UserId
           ,@AccountNumber
           ,@BankCode)
End
GO
/****** Object:  StoredProcedure [dbo].[SearchUserTypesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchUserTypesTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select UserType as Id,UserType,Role,Description,BankCode from UserTypes where 
(BankCode=@bankCode or @bankCode='ALL') and
(UserTypeId=@Id or UserType=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchTransactionRequestsTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchTransactionRequestsTable]
@BankCode varchar(50),
@BranchCode varchar(50),
@Teller varchar(50),
@AccountNumber varchar(50),
@CustomerName varchar(50),
@TransCategory varchar(50),
@BankId varchar(50),
@FromDate varchar(50),
@ToDate varchar(50),
@Approver varchar(50),
@Status varchar(50)
as
Select RecordId as BankTranId,Teller,CustomerName,ToAccount,FromAccount,TranAmount,TranCategory,RecordDate
from TransactionRequests with(nolock) where
(BankCode=@BankCode or @BankCode='ALL') and
(BranchCode=@BranchCode or @BranchCode='ALL') and
(Teller=@Teller or @Teller='') and
(ToAccount=@AccountNumber or @AccountNumber='') and
(fromAccount=@AccountNumber or @AccountNumber='') and
((CustomerName like '%'+@CustomerName+'%') or @CustomerName='') and
(TranCategory=@TransCategory or @TransCategory='ALL') and 
(PaymentDate>=@FromDate or @FromDate='') and 
(PaymentDate<=@ToDate or @ToDate='')
and (status=@Status or @Status='')
and (Approver=@Approver or @Approver='')
order by RecordDate desc
GO
/****** Object:  StoredProcedure [dbo].[SearchTransactionCategoriesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchTransactionCategoriesTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select TranType as Id,TranType,Description,BankCode,CreatedOn from TransactionCategories where 
BankCode=@bankCode or @bankCode='ALL' and
(TranTypeId=@Id or TranType=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchPaymentTypesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SearchPaymentTypesTable]
@BankCode varchar(50),
@Id varchar(50)
as
Select PaymentTypeCode as Id,PaymentTypeCode,BankCode,ModifiedBy from PaymentTypes where 
(BankCode=@BankCode or @BankCode='ALL') and 
(PaymentTypeCode=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchGeneralLedgerTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchGeneralLedgerTable]
@BankCode varchar(50),
@BranchCode varchar(50),
@Teller varchar(50),
@AccountNumber varchar(50),
@CustomerName varchar(50),
@TransCategory varchar(50),
@BankId varchar(50),
@PegPayId varchar(50),
@FromDate varchar(50),
@ToDate varchar(50)
as
Select PegPayTranId,BankTranId,AccountNumber,TranAmount,TranType,TranCategory,PaymentDate,AccountBalBefore,AccountBalAfter,Narration 
from GeneralLedgerTable with(nolock) where
(BankCode=@BankCode or @BankCode='ALL') and
(BranchCode=@BranchCode or @BranchCode='ALL') and
(Teller=@Teller or @Teller='') and
(AccountNumber=@AccountNumber or @AccountNumber='') and
((CustomerName like '%'+@CustomerName+'%') or @CustomerName='') and
(TranCategory=@TransCategory or @TransCategory='ALL') and 
(BankTranId=@BankId or @BankId='') and 
(PegPayTranId=@PegPayId or @PegPayId='') and 
(PaymentDate>=@FromDate or @FromDate='') and 
(PaymentDate<=@ToDate or @ToDate='')
order by RecordDate desc
GO
/****** Object:  StoredProcedure [dbo].[SearchCurrenciesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchCurrenciesTable]
@BankCode varchar(50),
@Id varchar(50)
as
Select CurrencyCode as Id,CurrencyCode,BankCode,ModifiedBy,ValueInLocalCurrency from Currencies where 
(BankCode=@BankCode or @BankCode='ALL') and 
(CurrencyCode=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchChargeTypesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SearchChargeTypesTable]
@BankCode varchar(50),
@Id varchar(50)
as
Select ChargeTypeCode as Id,ChargeTypeCode,BankCode,ModifiedBy from ChargeTypes where 
(BankCode=@BankCode or @BankCode='ALL') and 
(ChargeTypeCode=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchBankUsersTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBankUsersTable]
@bankCode varchar(50),
@UserType varchar(50),
@Name varchar(50)
as
Select UserId as Id,Email,Fullname,IsActive,Gender,BranchCode,PhoneNumber from BankSystemUsers where 
(Usertype=@UserType or @UserType='ALL') and
(BankCode=@bankCode or @bankCode='ALL') and
((Fullname like '%'+@Name+'%') or (Fullname=''))
GO
/****** Object:  StoredProcedure [dbo].[SearchBanksTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBanksTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select BankCode as id,BankName,BankCode,BankContactEmail,IsActive 
from Banks where 
(BankCode=@bankCode or @bankCode='ALL') and 
(BankName=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchBankChargesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBankChargesTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select ChargeCode as Id,ChargeName,ChargeAmount,CommissionAccount,TransCategory as TransCategoryAffected,BankCode,IsActive,ChargeDesc from BankCharges where 
(BankCode=@bankCode or @bankCode='ALL') and
(ChargeId=@Id or ChargeCode=@Id or ChargeName like '%'+@Id+'%' or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchBankBranchesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBankBranchesTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select BranchCode as Id,BranchName,Location,IsActive,BankCode,CreatedOn from BankBranches where 
(BankCode=@bankCode or @bankCode='ALL') and
(BranchId=@Id or BranchCode=@Id or BranchName like '%'+@Id+'%' or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchBankAccountsTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBankAccountsTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select AccNumber as Id,AccNumber,AccBalance,AccType,BankCode,IsActive,CreatedOn from BankAccounts where 
(BankCode=@bankCode or @bankCode='ALL') and
(AccNumber=@Id or @Id='' or AccType=@Id)
GO
/****** Object:  StoredProcedure [dbo].[SearchAuditlogsTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchAuditlogsTable]
@UserId varchar(50),
@BankCode varchar(50),
@ActionType varchar(50)
as
Select * from AuditTrail where 
(BankCode=@BankCode or BankCode='ALL') and 
(ModifiedBy=@UserId or @UserId='') and
(ActionType=@ActionType or @ActionType='')
order by ModifiedOn desc
GO
/****** Object:  StoredProcedure [dbo].[SearchAccountTypesTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchAccountTypesTable]
@bankCode varchar(50),
@Id varchar(50)
as
Select AccTypeCode as Id,AccTypeName,MinimumBal,BankCode,IsActive,Description from AccountTypes where 
(BankCode=@bankCode or @bankCode='ALL') and
(AccTypeCode=@Id or AccTypeName=@Id or @Id='')
GO
/****** Object:  StoredProcedure [dbo].[SearchAccountsTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchAccountsTable]
@AccountNumber varchar(50),
@bankCode varchar(50)
as
select BankCode,AccNumber,AccBalance,AccType,CreatedOn from BankAccounts where AccNumber=@AccountNumber and BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[SearchAccessControlTable]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchAccessControlTable]
@BankCode varchar(50),
@Id varchar(50)
as
Select RecordId as Id,RuleName,UserType,BankCode,CanAccess,IsActive,ModifiedBy from AccessRules where 
(BankCode=@BankCode or @BankCode='ALL') and 
((RuleName like '%'+@Id+'%') or (RuleName=''))
GO
/****** Object:  StoredProcedure [dbo].[SaveTranRequest]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SaveTranRequest]
@CustomerName varchar(50),
@AccountNumber varchar(50),
@ToAccount varchar(50),
@FromAccount varchar(50),
@TranAmount money,
@TranCategory varchar(50),
@PaymentDate datetime,
@Teller varchar(50),
@ApprovedBy varchar(50),
@BankCode varchar(50),
@BranchCode varchar(50),
@Narration varchar(50),
@CurrencyCode varchar(50),
@PaymentType varchar(50),
@ChequeNumber varchar(50)
as
Begin transaction trans
Begin try
INSERT INTO [TransactionRequests]
           ([CustomerName],
           [AccountNumber]
           ,[ToAccount]
           ,[FromAccount]
           ,[TranAmount]
           ,[TranCategory]
           ,[PaymentDate]
           ,[RecordDate]
           ,[Teller]
           ,[ApprovedBy]
           ,[BankCode]
           ,[BranchCode]
           ,[Narration]
           ,CurrencyCode
           ,PaymentType
           ,ChequeNumber)
     VALUES
           (@CustomerName,
           @AccountNumber,
           @ToAccount,
           @FromAccount,
           @TranAmount,
           @TranCategory,
           @PaymentDate,
           GETDATE(),
           @Teller,
           @ApprovedBy,
           @BankCode,
           @BranchCode,
           @Narration,
           @CurrencyCode,
           @PaymentType,
           @ChequeNumber)
           
 Select SCOPE_IDENTITY() as InsertedId
 ---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Banks_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectRow]	@BankCode varchar(50)ASSET NOCOUNT ONSELECT * FROM BanksWHERE ((BankCode=@BankCode) or (@BankCode='ALL'))SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Banks_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectAll]ASSET NOCOUNT ONSELECT * FROM BanksSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	UserTypes_Update
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:55:14 PM
-- Description:	This stored procedure is intended for updating UserTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[UserTypes_Update]
	@UserTypeId varchar(50),
	@UserType varchar(50),
	@Role varchar(50),
	@Description varchar(50),
	@BankCode varchar(50),
	@ModifiedBy varchar(50)
As
Begin transaction trans
Begin try
IF not exists(Select * from UserTypes where UserType=@UserType and BankCode=@BankCode)
Begin
	Insert Into UserTypes
		([UserType],[Role],[Description],BankCode,CreatedBy,ModifiedBy,CreatedOn,ModifiedOn)
	Values
		(@UserType,@Role,@Description,@BankCode,@ModifiedBy,@ModifiedBy,GETDATE(),GETDATE())
	Select @UserType as InsertedId
End
Begin
	Update UserTypes
	Set
		[UserType] = @UserType,
		[Role] = @Role,
		[Description] = @Description,
		BankCode=@BankCode,
		ModifiedOn=GETDATE(),
		ModifiedBy=@ModifiedBy
	Where		
		 UserType=@UserType and BankCode=@BankCode
	Select @UserType as InsertedId

End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	UserTypes_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:55:13 PM
-- Description:	This stored procedure is intended for selecting a specific row from UserTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[UserTypes_SelectRow]
	@UserType varchar(50),
	@BankCode varchar(50)
	as
Begin
	Select 
	*
	From UserTypes
	Where UserType=@UserType and BankCode=@BankCode
		
End
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	UserTypes_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:55:13 PM
-- Description:	This stored procedure is intended for selecting all rows from UserTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[UserTypes_SelectAll]
@BankCode varchar(50)
As
Begin
	Select 
		*
	From UserTypes where BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	UserTypes_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:55:13 PM
-- Description:	This stored procedure is intended for inserting values to UserTypes table
-- ==========================================================================================
Create Procedure [dbo].[UserTypes_Insert]
	@UserType varchar(50),
	@Role varchar(50),
	@Description varchar(50)
As
Begin
	Insert Into UserTypes
		([UserType],[Role],[Description])
	Values
		(@UserType,@Role,@Description)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_DeleteRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	UserTypes_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:55:14 PM
-- Description:	This stored procedure is intended for deleting a specific row from UserTypes table
-- ==========================================================================================
Create Procedure [dbo].[UserTypes_DeleteRow]
	@UserTypeId int
As
Begin
	Delete UserTypes
	Where
		[UserTypeId] = @UserTypeId

End
GO
/****** Object:  StoredProcedure [dbo].[UsersToAccounts_Insert]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UsersToAccounts_Insert]
@UserId varchar(50),
@AccountNumber varchar(50),
@BankCode varchar(50)
as
if not exists(select * from UsersToAccounts where UserId=@UserId and AccountNumber=@AccountNumber and BankCode=@BankCode)
Begin
INSERT INTO [dbo].[UsersToAccounts]
           ([UserId]
           ,[AccountNumber]
           ,[BankCode])
     VALUES
           (@UserId
           ,@AccountNumber
           ,@BankCode)
End
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Users_Update
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:54:58 PM
-- Description:	This stored procedure is intended for updating Users table
-- ==========================================================================================
CREATE Procedure [dbo].[Users_Update]
	@UserId varchar(50),
	@Email varchar(50),
	@Fullname varchar(50),
	@Usertype varchar(50),
	@Password varchar(50),
	@IsActive bit,
	@BankCode varchar(50),
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50),
	@ApprovedBy varchar(50),
	@PhoneNumber varchar(50),
	@BranchCode varchar(50),
	@DateOfBirth varchar(50),
	@Gender varchar(50),
	@TranAmountLimit varchar(50)
As
Begin transaction trans
Begin try
IF not exists(Select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode)
Begin
	Insert Into BankSystemUsers
		(UserId,Email,[Fullname],[Usertype],
		[Password],[IsActive],BankCode,RecordDate,
		ModifiedOn,CreatedBy,ModifiedBy,ApprovedBy,PhoneNumber,BranchCode,DateOfBirth,Gender,TranAmountLimit)
	Values
		(@UserId,@Email,@Fullname,@Usertype,
		 @Password,@IsActive,@BankCode,GETDATE(),
		 GETDATE(),@CreatedBy,@ModifiedBy,@ApprovedBy,@PhoneNumber,@BranchCode,@DateOfBirth,@Gender,@TranAmountLimit)
	Select @UserId as InsertedId
End
Else
Begin
	--if this is approved By field is not set	if(@ApprovedBy='')	Begin
		Update BankSystemUsers
		Set
			[Fullname] = @Fullname,
			[Usertype] = @Usertype,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode = @BankCode,
			ModifiedOn = GETDATE(),
			ModifiedBy = @ModifiedBy,
			PhoneNumber = @PhoneNumber,
			BranchCode = @BranchCode,
			DateOfBirth = @DateOfBirth,
			Gender = @Gender,
			TranAmountLimit = @TranAmountLimit
		Where		
			UserId = @UserId and BankCode=@BankCode
			Select @UserId as InsertedId
	End
	Else
	Begin
		Update BankSystemUsers
		Set
			[Fullname] = @Fullname,
			[Usertype] = @Usertype,
			[Password] = @Password,
			[IsActive] = @IsActive,
			BankCode = @BankCode,
			ModifiedOn = GETDATE(),
			ModifiedBy = @ModifiedBy,
			ApprovedBy = @ApprovedBy,
			PhoneNumber = @PhoneNumber,
			BranchCode = @BranchCode,
			DateOfBirth = @DateOfBirth,
			Gender = @Gender,
			TranAmountLimit = @TranAmountLimit
		Where		
			UserId = @UserId and BankCode=@BankCode
		Select @UserId as InsertedId
	End
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectRow]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Users_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:54:58 PM
-- Description:	This stored procedure is intended for selecting a specific row from Users table
-- ==========================================================================================
CREATE Procedure [dbo].[Users_SelectRow]
	@UserId varchar(50)
As
Begin
	Select 
		*
	From BankSystemUsers
	Where
		[UserId] = @UserId
End
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 03/05/2016 22:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Users_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:54:58 PM
-- Description:	This stored procedure is intended for selecting all rows from Users table
-- ==========================================================================================
CREATE Procedure [dbo].[Users_SelectAll]
@BankCode varchar(50)
As
Begin
	Select 
	*
	From BankSystemUsers where BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Users_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:54:58 PM
-- Description:	This stored procedure is intended for inserting values to Users table
-- ==========================================================================================
CREATE Procedure [dbo].[Users_Insert]
	@Username varchar(50),
	@Fullname varchar(50),
	@Usertype varchar(50),
	@Password varchar(50),
	@IsActive bit
As
Begin
	Insert Into BankSystemUsers
		(UserId,[Fullname],[Usertype],[Password],[IsActive])
	Values
		(@Username,@Fullname,@Usertype,@Password,@IsActive)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[Users_DeleteRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	Users_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	12/21/2015 3:54:58 PM
-- Description:	This stored procedure is intended for deleting a specific row from Users table
-- ==========================================================================================
CREATE Procedure [dbo].[Users_DeleteRow]
	@UserId int
As
Begin
	Delete BankSystemUsers
	Where
		[UserId] = @UserId

End
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserIsActiveStatus]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateUserIsActiveStatus]
@UserId varchar(50),
@BankCode varchar(50),
@IsActive varchar(50),
@ApprovedBy varchar(50)
as
Update BankSystemUsers set IsActive=@IsActive,ApprovedBy=@ApprovedBy 
where UserId=@UserId and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[UpdateTransacttionApprovalStatus]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateTransacttionApprovalStatus]
@BankTranId varchar(50),
@Status varchar(50),
@RequiresApproval bit,
@Approver varchar(50)
as
Update TransactionRequests set RequiresApproval=@RequiresApproval,Status=@Status,Approver=@Approver where RecordId=@BankTranId
GO
/****** Object:  StoredProcedure [dbo].[UpdateBankTransactionStatus]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UpdateBankTransactionStatus]
@BankId varchar(50),
@BankCode varchar(50),
@PegPayId varchar(50),
@Status varchar(50)
as
Update TransactionRequests set Status=@Status,Reason=@PegPayId where RecordId=@BankId and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[UpdateBankAccountsIsActiveStatus]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateBankAccountsIsActiveStatus]
@BankCode varchar(50),
@AccountNumber varchar(50),
@Status varchar(50),
@ApprovedBy varchar(50)
as
Update BankAccounts set IsActive=@status,ApprovedBy=@ApprovedBy 
where AccNumber=@AccountNumber and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[TransactionTypes_Update]
	@TranTypeId varchar(50),
	@TranType varchar(50),
	@Description varchar(150),
	@BankCode varchar(50),
	@ModifiedBy varchar(50),
	@IsActive bit
As
Begin Transaction trans
Begin Try
IF not exists(select * from TransactionCategories where TranType=@TranType and BankCode=@BankCode)
Begin
   Insert Into TransactionCategories
		([TranType],[Description],BankCode,CreatedOn,ModifiedOn,CreatedBy,ModifiedBy,IsActive)
	Values
		(@TranType,@Description,@BankCode,GETDATE(),GETDATE(),@ModifiedBy,@ModifiedBy,@IsActive)
	Select @TranType as InsertedId
End
ELSE
Begin
	Update TransactionCategories
	Set
		[TranType] = @TranType,
		[Description] = @Description,
		BankCode=@BankCode,
		ModifiedOn=GETDATE(),
		ModifiedBy=@ModifiedBy,
		IsActive=@IsActive
	Where		
		TranType=@TranType and BankCode=@BankCode
	Select @TranType as InsertedId

End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_TransactionTypes_SelectRow
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:45:02 PM
-- Description:	This stored procedure is intended for selecting a specific row from TransactionTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionTypes_SelectRow]
	@TranTypeCode varchar(50)
As
Begin
	Select *
	From TransactionCategories
	Where
		TranType=@TranTypeCode
End
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectAll]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_TransactionTypes_SelectAll
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:45:02 PM
-- Description:	This stored procedure is intended for selecting all rows from TransactionTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionTypes_SelectAll]
As
Begin
	Select *
	From TransactionCategories
End
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Insert]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_TransactionTypes_Insert
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:45:02 PM
-- Description:	This stored procedure is intended for inserting values to TransactionTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionTypes_Insert]
	@TranType varchar(50),
	@Description varchar(150)
As
Begin
	Insert Into TransactionCategories
		([TranType],[Description])
	Values
		(@TranType,@Description)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_DeleteRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	sp_TransactionTypes_DeleteRow
-- Author:	Mehdi Keramati
-- Create date:	12/19/2015 10:45:02 PM
-- Description:	This stored procedure is intended for deleting a specific row from TransactionTypes table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionTypes_DeleteRow]
	@TranTypeId int
As
Begin
	Delete TransactionCategories
	Where
		[TranTypeId] = @TranTypeId

End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	TransactionRules_Update
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 10:19:17 PM
-- Description:	This stored procedure is intended for updating TransactionRules table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionRules_Update]
	@RecordId varchar(50),
	@RuleName varchar(50),
	@RuleCode varchar(50),
	@UserId varchar(50),
	@Description varchar(150),
	@MinimumAmount money,
	@MaximumAmount money,
	@IsActive bit,
	@BankCode varchar(50),
	@BranchCode varchar(50),
	@ModifiedBy varchar(50),
	@Approver varchar(50)
As
Begin Transaction trans
Begin try
if exists(select * from TransactionRules where BankCode=@BankCode and RuleCode=@RuleCode)
Begin
	Update TransactionRules
	Set
		[RuleName] = @RuleName,
		[RuleCode] = @RuleCode,
		[UserId] = @UserId,
		[Description] = @Description,
		[MinimumAmount] = @MinimumAmount,
		[MaximumAmount] = @MaximumAmount,
		[IsActive] = @IsActive,
		[BankCode] = @BankCode,
		[BranchCode] = @BranchCode,
		[ModifiedOn] = GETDATE(),
		[ModifiedBy] = @ModifiedBy,
		Approver=@Approver
	Where		
		BankCode=@BankCode and RuleCode=@RuleCode
	Select @RuleCode as InsertedId

End
Else
Begin
    Insert Into TransactionRules
		([RuleName],[RuleCode],[UserId],[Description],[MinimumAmount],[MaximumAmount],[IsActive],[BankCode],[BranchCode],[CreatedOn],[ModifiedOn],[CreatedBy],[ModifiedBy],Approver)
	Values
		(@RuleName,@RuleCode,@UserId,@Description,@MinimumAmount,@MaximumAmount,@IsActive,@BankCode,@BranchCode,GETDATE(),GETDATE(),@ModifiedBy,@ModifiedBy,@Approver)
	Select @RuleCode as InsertedId
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	TransactionRules_SelectRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 10:19:17 PM
-- Description:	This stored procedure is intended for selecting a specific row from TransactionRules table
-- ==========================================================================================
CREATE Procedure [dbo].[TransactionRules_SelectRow]
	@BranchCode varchar(50),
	@BankCode varchar(50)
As
Begin
	Select 
		*
	From TransactionRules
	Where
		RuleCode=@BranchCode and BankCode=@BankCode
End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectAll]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	TransactionRules_SelectAll
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 10:19:17 PM
-- Description:	This stored procedure is intended for selecting all rows from TransactionRules table
-- ==========================================================================================
Create Procedure [dbo].[TransactionRules_SelectAll]
As
Begin
	Select 
		*
	From TransactionRules
End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_Insert]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	TransactionRules_Insert
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 10:19:17 PM
-- Description:	This stored procedure is intended for inserting values to TransactionRules table
-- ==========================================================================================
Create Procedure [dbo].[TransactionRules_Insert]
	@RuleName varchar(50),
	@RuleCode varchar(50),
	@UserId varchar(50),
	@Description varchar(150),
	@MinimumAmount money,
	@MaximumAmount money,
	@IsActive bit,
	@BankCode varchar(50),
	@BranchCode varchar(50),
	@CreatedOn datetime,
	@ModifiedOn datetime,
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50)
As
Begin
	Insert Into TransactionRules
		([RuleName],[RuleCode],[UserId],[Description],[MinimumAmount],[MaximumAmount],[IsActive],[BankCode],[BranchCode],[CreatedOn],[ModifiedOn],[CreatedBy],[ModifiedBy])
	Values
		(@RuleName,@RuleCode,@UserId,@Description,@MinimumAmount,@MaximumAmount,@IsActive,@BankCode,@BranchCode,@CreatedOn,@ModifiedOn,@CreatedBy,@ModifiedBy)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_DeleteRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	TransactionRules_DeleteRow
-- Author:	Nsubuga Kasozi
-- Create date:	1/3/2016 10:19:17 PM
-- Description:	This stored procedure is intended for deleting a specific row from TransactionRules table
-- ==========================================================================================
Create Procedure [dbo].[TransactionRules_DeleteRow]
	@RecordId int
As
Begin
	Delete TransactionRules
	Where
		[RecordId] = @RecordId

End
GO
/****** Object:  StoredProcedure [dbo].[PaymentTypes_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PaymentTypes_Update]
@PaymentTypeCode varchar(50),
@PaymentTypeName varchar(50),
@BankCode varchar(50),
@ModifiedBy varchar(50),
@IsActive varchar(50)
as
Begin Transaction trans
Begin try
If exists(Select * from PaymentTypes where PaymentTypeCode=@PaymentTypeCode and PaymentTypeName=@PaymentTypeName)
Begin
	Update PaymentTypes 
	set PaymentTypeName=@PaymentTypeName,ModifiedBy=@ModifiedBy,ModifiedOn=GETDATE()
	where PaymentTypeCode=@PaymentTypeCode and BankCode=@BankCode

	Select @PaymentTypeCode as InsertedId
End
Else
Begin
	Insert into PaymentTypes(PaymentTypeCode,PaymentTypeName,BankCode,ModifiedBy,CreatedBy,ModifiedOn,CreatedOn)
	values(@PaymentTypeCode,@PaymentTypeName,@BankCode,@ModifiedBy,@ModifiedBy,GETDATE(),GETDATE())
	
	Select @PaymentTypeCode as InsertedId
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[PaymentTypes_SelectRow]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[PaymentTypes_SelectRow]
	@PaymentTypeCode varchar(50),
	@bankcode varchar(50)
As
Begin
	Select *
	From PaymentTypes
	Where
		BankCode=@bankcode and PaymentTypeCode=@PaymentTypeCode
End
GO
/****** Object:  StoredProcedure [dbo].[IsValidBankRef]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[IsValidBankRef]
@BankTranId varchar(50),
@BankCode varchar(50),
@AccountNumber varchar(50),
@fromAccount varchar(50),
@Amount money
as 
Select * from GeneralLedgerTable
where BankTranId=@BankTranId and 
BankCode=@BankCode
UNION
Select * from GeneralLedgerTable
where AccountNumber=@AccountNumber and FromAccount=@fromAccount and 
TranAmount=@Amount and BankCode=@BankCode
and DATEDIFF(MINUTE,RecordDate,GETDATE())<10
GO
/****** Object:  StoredProcedure [dbo].[InsertTranIntoGeneralLedger]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertTranIntoGeneralLedger]@CustomerName varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50),@CurrecnyTranAmount varchar(50),@PaymentType varchar(50),@ChequeNumber varchar(50)as--This Stored Procedure will move money between any 2 accounts--NB: This stored Procedure has no try cacth(Intentionally) because its not meant to be called directly by code--Stored proc with the try catch is InsertReceivedTransactionWithCharges and its the one meant--to be called to do the work--this procedure was separated from the one above mainly for readabilityDeclare @AccountType varchar(50);Declare @MinimumFromAccBal money;Declare @toAccBalBefore money;Declare @toAccBalAfter money;Declare @fromAccBalBefore money;Declare @fromAccBalAfter money;Declare @ErrorMsg varchar(8000);DECLARE @ReturnValue int;DECLARE @RecordId1 varchar(50);DECLARE @RecordId2 varchar(50);DECLARE @PegPayTranId varchar(50);Declare @CurrecnyOfFromAcc varchar(50);
Declare @CurrencyOfToAcc varchar(50);
Declare @ValueInLocalCurrencyFromAccount money;
Declare @ValueInLocalCurrencytoAccount money;
Declare @ValueInLocalCurrencyTranAmount money;--------------------------------------------set some globalsSelect @toAccBalBefore = AccBalance from BankAccounts where AccNumber=@toAccount and BankCode=@BankCodeSelect @fromAccBalBefore =  AccBalance from BankAccounts where AccNumber=@fromAccount and BankCode=@BankCodeSelect @AccountType = AccType from BankAccounts where AccNumber=@fromAccount and BankCode=@BankCodeSelect @MinimumFromAccBal =  MinimumBal from AccountTypes where AccTypeCode=@AccountType and BankCode=@BankCode--Get currency of from account
Select @CurrecnyOfFromAcc = CurrencyCode from BankAccounts 
where AccNumber=@FromAccount and BankCode=@BankCode

--Get currency of to account
Select @CurrencyOfToAcc = CurrencyCode from BankAccounts 
where AccNumber=@ToAccount and BankCode=@BankCode

--Get Value in local currency of the from account cuurency(e.g value of 1 Usd in Ugshs)
Select @ValueInLocalCurrencyFromAccount=ValueInLocalCurrency from Currencies 
where CurrencyCode=@CurrecnyOfFromAcc and BankCode=@BankCode

--Get Value in local currency of the to account cuurency(e.g value of 1 Usd in Ugshs)
Select @ValueInLocalCurrencyToAccount=ValueInLocalCurrency from Currencies 
where CurrencyCode = @CurrencyOfToAcc and BankCode=@BankCode

--Get Value in local currency of the transaction amount currency(e.g value of 1 Usd in Ugshs)
Select @ValueInLocalCurrencyTranAmount=ValueInLocalCurrency from Currencies 
where CurrencyCode = @CurrecnyTranAmount and BankCode=@BankCode
--if no minimum balance is found--set it to 0IF(@MinimumFromAccBal='' or @MinimumFromAccBal is NULL )BEGIN	Set @MinimumFromAccBal=0END--------------------------------------------------------Validate the data--Is to account same as from accountif(@toAccount=@fromAccount)BEGINset @ErrorMsg='TO ['+@toAccount+'] AND FROM ['+@fromAccount+'] ACCOUNT CANNOT BE THE SAME';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );END--does to account exist              else if((LEN(@toAccBalBefore) <= 0) or @toAccBalBefore is NULL)BEGINset @ErrorMsg='UNABLE TO FIND TO_ACCOUNT:'+@toAccount+' FOR SPECIFIED BANK';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND--does from account existELSE IF((LEN(@fromAccBalBefore) <= 0) or @fromAccBalBefore is NULL)BEGINset @ErrorMsg='UNABLE TO FIND FROM_ACCOUNT:'+@fromAccount+' FOR SPECIFIED BANK';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND--does from account have a typeELSE IF((LEN(@AccountType) <= 0) or @AccountType is NULL)BEGINset @ErrorMsg='UNABLE TO DETERMINE ACCOUNT TYPE OF FROM_ACCOUNT:'+@fromAccount;
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND--do we have the currency code for fromAccountELSE IF((LEN(@CurrecnyOfFromAcc) <= 0) or @CurrecnyOfFromAcc is NULL)BEGINset @ErrorMsg='UNABLE TO DETERMINE CURRENCY OF FROM_ACCOUNT:'+@fromAccount;
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND--do we have the currency code for toAccountELSE IF((LEN(@CurrencyOfToAcc) <= 0) or @CurrencyOfToAcc is NULL)BEGINset @ErrorMsg='UNABLE TO DETERMINE CURRENCY OF TO_ACCOUNT:'+@toAccount;
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND----do we have the currency code for tranAmountELSE IF((LEN(@CurrecnyTranAmount) <= 0) or @CurrecnyTranAmount is NULL)BEGINset @ErrorMsg='UNABLE TO DETERMINE CURRENCY OF THE TRANSACTION AMOUNT';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND--====================================================================------AT THIS STAGE ALL DATA SHOULD BE VALID--if the account on the from account is --less than the total transaction amount---------------------------------------------------Change Amounts into local currency
--Change Tran Amount into local currency
Set @tranAmount = @tranAmount * @ValueInLocalCurrencyTranAmount 

--Change from Acc BalanceBefore into local currency
Set @fromAccBalBefore = @fromAccBalBefore * @ValueInLocalCurrencyFromAccount

--Change to Acc BalanceBefore into local currency
Set @toAccBalBefore = @toAccBalBefore * @ValueInLocalCurrencyToAccount--calculate new balance for each account in local currencySet @fromAccBalAfter = @fromAccBalBefore - @TranAmount;Set @toAccBalAfter = @toAccBalBefore + @TranAmount;-----------------------------------------------------if(@fromAccBalAfter>@MinimumFromAccBal)BEGIN	--Insert Credit	INSERT INTO GeneralLedgerTable (		    [PegPayTranId]
           ,[CustomerName]
           ,[AccountNumber]
           ,[ToAccount]
           ,[FromAccount]
           ,[TranAmount]
           ,[BankTranId]
           ,[TranType]
           ,[TranCategory]
           ,[PaymentDate]
           ,[RecordDate]
           ,[AccountBalBefore]
           ,[AccountBalAfter]
           ,[Teller]
           ,[ApprovedBy]
           ,[BankCode]
           ,[BranchCode]           ,Narration           ,ValueInLocalCurrencyFromAccount           ,ValueInLocalCurrencytoAccount           ,ValueInLocalCurrencyTranAmount           ,CurrencyCode           ,PaymentType           ,ChequeNumber	)	VALUES (			'',			@CustomerName,			@toAccount,			'',			@fromAccount,			@TranAmount,			@VendorTranId,			'CREDIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@toAccBalBefore,			@toAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration,			@ValueInLocalCurrencyFromAccount,			@ValueInLocalCurrencytoAccount,			@ValueInLocalCurrencyTranAmount,			@CurrecnyTranAmount,			@PaymentType,			@ChequeNumber	)		Set @RecordId1=SCOPE_IDENTITY()		--Insert Debit	INSERT INTO GeneralLedgerTable (		    [PegPayTranId]
           ,[CustomerName]
           ,[AccountNumber]
           ,[ToAccount]
           ,[FromAccount]
           ,[TranAmount]
           ,[BankTranId]
           ,[TranType]
           ,[TranCategory]
           ,[PaymentDate]
           ,[RecordDate]
           ,[AccountBalBefore]
           ,[AccountBalAfter]
           ,[Teller]
           ,[ApprovedBy]
           ,[BankCode]
           ,[BranchCode]           ,Narration           ,ValueInLocalCurrencyFromAccount           ,ValueInLocalCurrencytoAccount           ,ValueInLocalCurrencyTranAmount           ,CurrencyCode           ,PaymentType           ,ChequeNumber	)	VALUES (			'',			@CustomerName,			@fromAccount,			@toAccount,			'',			@TranAmount,			@VendorTranId,			'DEBIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@fromAccBalBefore,			@fromAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration,			@ValueInLocalCurrencyFromAccount,			@ValueInLocalCurrencytoAccount,			@ValueInLocalCurrencyTranAmount,			@CurrecnyTranAmount,			@PaymentType,			@ChequeNumber	)			--Generate PegPayId	Set @RecordId2=SCOPE_IDENTITY()	SET @PegPayTranId=dbo.fn_GetReceiptno(@RecordId1)		Update GeneralLedgerTable set PegPayTranId=@PegPayTranId where RecordId=@RecordId1 or RecordId=@RecordId2		--Before Updating to and from account balance after change the balance back to Actual Account Currency
	--Change from Acc BalanceAfter into Account currency
	Set @fromAccBalAfter=@fromAccBalAfter / @ValueInLocalCurrencyFromAccount

	--Change to Acc BalanceBefore into local currency
	Set @toAccBalAfter=@toAccBalAfter / @ValueInLocalCurrencyToAccount		--Update account balances	Update BankAccounts set AccBalance=@fromAccBalAfter where AccNumber=@fromAccount and BankCode=@BankCode	Update BankAccounts set AccBalance=@toAccBalAfter where AccNumber=@toAccount and BankCode=@BankCode		Select @PegPayTranId as InsertedIdEND---------------------------------------------ELSEBEGIN--return error message
set @ErrorMsg='INSUFFICIENT FUNDS ON FROM ACCOUNT:['+@fromAccount+
'], MIN.BAL =['+convert(varchar(30), @MinimumFromAccBal, 1)+'], TRAN_AMOUNT=['+convert(varchar(30), @TranAmount, 1)+']';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[InsertReversedTransaction]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertReversedTransaction]
@BankRef varchar(50),
@BankCode varchar(50),
@Approver varchar(50)
as
--if not exists(select * from TransactionRequests where BankCode=@bankcode and RecordId=@BankRef)
BEGIN

INSERT INTO [TransactionRequests]
           ([CustomerName]
           ,[AccountNumber]
           ,[ToAccount]
           ,[FromAccount]
           ,[TranAmount]
           ,[TranCategory]
           ,[PaymentDate]
           ,[RecordDate]
           ,[Teller]
           ,[ApprovedBy]
           ,[BankCode]
           ,[BranchCode]
           ,[Narration]
           ,[RequiresApproval]
           ,[Approver]
           ,[Status]
           ,[Reason])
    SELECT
           [CustomerName]
           ,[AccountNumber]
           ,[ToAccount]
           ,[FromAccount]
           ,[TranAmount]
           ,'REVERSAL'
           ,[PaymentDate]
           ,GETDATE()
           ,[Teller]
           ,@Approver
           ,[BankCode]
           ,[BranchCode]
           ,[Narration]
           ,[RequiresApproval]
           ,@Approver
           ,[Status]
           ,[Reason]
   FROM
		   TransactionRequests where RecordId=@BankRef and BankCode=@BankCode
END
GO
/****** Object:  StoredProcedure [dbo].[InsertReceivedTransactionWithCharges]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery12.sql|7|0|C:\Users\home\AppData\Local\Temp\~vs3A0D.sql
--DECLARE
--@CustomerName varchar(50)='TEST',--@CustomerId varchar(50)='1',--@toAccount varchar(50)='0140586848602',--@fromAccount varchar(50)='0140586848601',--@TranAmount money=1100,--@VendorTranId varchar(50)='TEST-0025',--@PaymentDate datetime='2015-12-20 00:00:00.000',--@Teller varchar(50)='TEST',--@ApprovedBy varchar(50)='TEST',--@BankCode varchar(50)='TESTBANK',--@Narration varchar(50)='TEST',--@TranType varchar(50)='TEST';
CREATE proc [dbo].[InsertReceivedTransactionWithCharges]
@CustomerName varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50),@Currency varchar(50),@PaymentType varchar(50),@ChequeNumber varchar(50)as
---------------------------------------------------------------------
--Lets start
--prevent lost updates and phantom reads
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN Transaction Trans
BEGIN TRY
Declare @PegPayId int
--------------------------------------------------------------------
--Insert Transaction
 EXEC @PegPayId=InsertTranIntoGeneralLedger @CustomerName,											@toAccount,											@fromAccount,											@TranAmount,											@VendorTranId,											@PaymentDate,											@Teller,											@ApprovedBy,											@BankCode,											@Narration,											@TranCategory,
											@BranchCode,
											@Currency,
											@PaymentType,
											@ChequeNumber;

--------------------------------------------------------------------
--Insert Charges
Declare @Id int;
DECLARE @chargeAmount int
DECLARE @accountType varchar(50)
DECLARE @commissionAcc varchar(100)
DECLARE @ChargeCode varchar(50)

--drop temp table
if object_id('tempdb..#Temp1') is not null
    drop table #Temp1


--pick all applicable charges from charges table
Select @accountType=AccType from BankAccounts where AccNumber=@fromAccount
Select *
Into   #Temp1
From   BankCharges where 
(TransCategory=@TranCategory or TransCategory='') and 
(AccountType=@accountType or AccountType='') and 
IsActive=1


--loop through the charges
While (Select Count(*) From #Temp1) > 0
Begin
	--pick 1 charge
	Select Top 1 @Id = #Temp1.ChargeId,@chargeAmount=#Temp1.ChargeAmount,
				 @commissionAcc=#Temp1.CommissionAccount,@ChargeCode=#Temp1.ChargeCode From #Temp1
	
	--apply charge
    EXEC @PegPayId=InsertTranIntoGeneralLedger @CustomerName,											   @commissionAcc,--com Acc											   @fromAccount,											   @chargeAmount,--chargeAmnt											   @VendorTranId,											   @PaymentDate,											   @Teller,											   @ApprovedBy,											   @BankCode,											   @ChargeCode,											   @TranCategory,
											   @BranchCode,
											   @Currency,
											   @PaymentType,
											   @ChequeNumber;
	--delete charge							
    Delete #Temp1 Where #Temp1.ChargeId = @Id
END
Select PegPayTranId as PegPayId from GeneralLedgerTable 
where BankCode=@BankCode and BankTranId=@VendorTranId
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[ReverseTransaction]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DECLARE--@VendorTranId varchar(50)='TEST-0039',--@BankCode varchar(50)='TESTBANK';
CREATE proc [dbo].[ReverseTransaction]
@VendorTranId varchar(50),@BankCode varchar(50),@Teller varchar(50),@ApprovedBy varchar(50)as
---------------------------------------------------------------------
--Lets start
BEGIN Transaction Trans
BEGIN TRY
------------------------------
Declare @PegPayId int,
@CustomerName varchar(50),@CustomerId varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@PaymentDate datetime,@Narration varchar(50),@BranchCode varchar(50),
@TranCategory varchar(50),
@PegPayTranId varchar(50),
@PaymentType varchar(50),
@ChequeNumber varchar(50);
Declare @Id int;

--check for existing reversal
select @PegPayId = RecordId from GeneralLedgerTable where 
BankTranId=@VendorTranId and BankCode=@Bankcode and Narration='REVERSAL' 
order by RecordDate desc

--if it exists return the id of that transaction 
--and stop
if @PegPayId!='' or @PegPayId is NOT NULL
BEGIN
	Select @PegPayId as PegPayId
RETURN
END
ELSE
BEGIN
    --else reverse that transaction
	--drop temp table if it exists
	if object_id('tempdb..#Temp1') is not null
		drop table #Temp1


	--pick all transactions that match that bankId 
	--and dump them into temp table
	Select *
	Into   #Temp1
	From   GeneralLedgerTable where 
	BankTranId=@VendorTranId and 
	BankCode=@BankCode and TranType='CREDIT' order by RecordDate desc

	--loop through the charges
	While (Select Count(*) From #Temp1) > 0
	Begin
		--pick 1 charge
		Select Top 1 
			@Id=#Temp1.RecordId,
			@CustomerName=#Temp1.CustomerName,			@toAccount=#Temp1.AccountNumber,--com Acc			@fromAccount=#Temp1.fromAccount,			@TranAmount=#Temp1.TranAmount,--chargeAmnt			@VendorTranId=#Temp1.BankTranId,			@PaymentDate=#Temp1.PaymentDate,			@Teller=#Temp1.Teller,			@ApprovedBy=#Temp1.ApprovedBy,			@BankCode=#Temp1.BankCode,			@Narration=#Temp1.Narration,			@TranCategory='REVERSAL',			@BranchCode=#Temp1.BranchCode,
			@PegPayTranId=#Temp1.PegPayTranId,
			@PaymentType=#Temp1.PaymentType,
			@ChequeNumber=#Temp1.ChequeNumber
		From #Temp1
		
		SET @Narration='REVERSAL OF '+@PegPayTranId
		
		--move money back to original account
		EXEC @PegPayId=InsertTranIntoGeneralLedger @CustomerName,													@fromAccount,--swap to account and from account													@toAccount,--swap to account and from account													@TranAmount,													@VendorTranId,													@PaymentDate,													@Teller,													@ApprovedBy,													@BankCode,													@Narration,													@TranCategory,
													@BranchCode,
													@PaymentType,
													@ChequeNumber;
										
		--delete transaction from temp table in memory							
		Delete #Temp1 Where #Temp1.RecordId = @Id
	END
	Select @PegPayId as PegPayId
END

---------------------------------------------------------------------
Commit Transaction Trans
END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Banks_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_Update]	@BankId varchar(50),	@BankName varchar(50),	@BankCode varchar(50),	@BankContactEmail varchar(50),	@BankPassword varchar(50),	@IsActive varchar(50),	@ModifiedBy varchar(50),	@PathToLogoImage varchar(1300),	@PathToPublicKey varchar(1300),	@ThemeColor varchar(50),	@TextColor varchar(50),	@BankVaultAccNumber varchar(50)ASBEGIN TRANSACTION BankUpdaterBEGIN TRYIF not exists(Select * from Banks where (BankCode=@BankCode or BankId=@BankId)) BEGIN	INSERT INTO Banks (		[BankName],		[BankCode],		[BankContactEmail],		BankPassword,		IsActive,		CreatedOn,		LastUpdateDate,		PathToLogoImage,		PathToPublicKey,		ThemeColor,		NavbarTextColor,		BankVaultAccNumber	)	VALUES (		@BankName,		@BankCode,		@BankContactEmail,		@BankPassword,		@IsActive,		GETDATE(),		GETDATE(),		@PathToLogoImage,		@PathToPublicKey,		@ThemeColor,		@TextColor,		@BankVaultAccNumber	)		--create default user types for Bank	EXEC dbo.UserTypes_Update '','BANK_ADMIN','Banks IT Admin','Banks IT Admin',@BankCode,@ModifiedBy 	EXEC dbo.UserTypes_Update '','MANAGER','Branch Manager','Branch Manager',@BankCode,@ModifiedBy 	EXEC dbo.UserTypes_Update '','TELLER','Bank Teller','Bank Teller',@BankCode,@ModifiedBy 	EXEC dbo.UserTypes_Update '','SUPERVISOR_TELLER','Teller Supervisor','Teller Supervisor',@BankCode,@ModifiedBy 	EXEC dbo.UserTypes_Update '','CUSTOMER_SERVICE','Customer Service','Customer Service',@BankCode,@ModifiedBy 	EXEC dbo.UserTypes_Update '','BUSSINESS_ADMIN','Bussiness Admin','Bussiness Admin',@BankCode,@ModifiedBy			----set default access rules for the users	DECLARE @date DATETIME
    SET @date = GETDATE()	EXEC dbo.AccessRules_Update '','Bank Admin Rule','BANK_ADMIN',@BankCode,'BANK_ADMIN,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Manager Rule','MANAGER',@BankCode,'MANAGER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Teller Rule','TELLER',@BankCode,'TELLER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Supervisor Rule','SUPERVISOR_TELLER',@BankCode,'SUPERVISOR,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Customer Service Rule','CUSTOMER_SERVICE',@BankCode,'CUSTOMER_SERVICE,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Bussiness Admin Rule','BUSSINESS_ADMIN',@BankCode,'BUSSINESS_ADMIN,REPORTS','','','True',@date,@ModifiedBy		--create default transaction Categories	EXEC dbo.TransactionTypes_Update '','WITHDRAW','WITHDRAW OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','DEPOSIT','DEPOSIT OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','INTERNAL_TRANSFER','AN INTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','EXTERNAL_TRANSFER','AN EXTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'		--create default Account Types	EXEC dbo.AccountTypes_Update '','COMMISSION ACCOUNT','COMMISSION_ACCOUNT',0,@BankCode,'True','Commission Account',@ModifiedBy,'True',0,1	EXEC dbo.AccountTypes_Update '','SUSPENSE ACCOUNT','SUSPENSE_ACCOUNT',-1000000000,@BankCode,'True','Suspense Account',@ModifiedBy,'True',0,1	EXEC dbo.AccountTypes_Update '','TELLER ACCOUNT','TELLER_ACCOUNT',0,@BankCode,'True','Teller Account',@ModifiedBy,'True',1,1	EXEC dbo.AccountTypes_Update '','SAVINGS ACCOUNT','SAVINGS_ACCOUNT',0,@BankCode,'True','Savings Account',@ModifiedBy,'True',1,1	EXEC dbo.AccountTypes_Update '','CURRENT ACCOUNT','CURRENT_ACCOUNT',0,@BankCode,'True','Current Account',@ModifiedBy,'True',1,1	EXEC dbo.AccountTypes_Update '','CORPORATE ACCOUNT','CORPORATE_ACCOUNT',0,@BankCode,'True','Corporate Account',@ModifiedBy,'True',1,4		--create default Charge Types	EXEC dbo.ChargeTypes_Update 'FLAT_FEE','FLAT FEE',@ModifiedBy,@BankCode,'FLAT FEE','True'	EXEC dbo.ChargeTypes_Update 'PERCENTAGE','PERCENTAGE',@ModifiedBy,@BankCode,'PERCENTAGE','True'		--create default Currencies	EXEC dbo.Currencies_Update 'UGANDA SHILLINGS','UGS',@BankCode,@ModifiedBy,1		--create default Payment types	EXEC dbo.PaymentTypes_Update 'CASH','CASH',@BankCode,@ModifiedBy,'True'			--create Bank Vault Account	EXEC dbo.Accounts_Insert '',0,@BankVaultAccNumber,'SUSPENSE_ACCOUNT',@BankCode,@ModifiedBy,@BankCode,'True','UGS',@ModifiedBy		SELECT @BankCode As InsertedIDENDELSE BEGIN	UPDATE Banks SET 		[BankName] = @BankName,		[BankCode] = @BankCode,		[BankContactEmail] = @BankContactEmail,		IsActive=@IsActive,		LastUpdateDate=GETDATE(),		PathToLogoImage=@PathToLogoImage,		PathToPublicKey=@PathToPublicKey,		ThemeColor=@ThemeColor,		NavbarTextColor=@TextColor	WHERE BankCode = @BankCode	SELECT @BankCode As InsertedIDENDCOMMIT TRANSACTION BankUpdaterEND TRYBEGIN CATCHROLLBACK Transaction BankUpdater

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )             END CATCH
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================
-- Entity Name:	BankBranches_Update
-- Author:	Nsubuga Kasozi
-- Create date:	12/27/2015 7:57:44 PM
-- Description:	This stored procedure is intended for updating BankBranches table
-- ==========================================================================================
CREATE Procedure [dbo].[BankBranches_Update]
	@BranchId varchar(50),
	@BranchName nvarchar(50),
	@BranchCode nvarchar(50),
	@Location nvarchar(100),
	@IsActive nvarchar(50),
	@BankCode nvarchar(50),
	@ModifiedBy varchar(50),
	@BranchVaultAccNumber varchar(50)
As
Begin Transaction trans
Begin try
if exists(select * from BankBranches where BranchCode=@BranchCode and BankCode=@BankCode)
Begin
	Update BankBranches
	Set
		[BranchName] = @BranchName,
		[BranchCode] = @BranchCode,
		[Location] = @Location,
		IsActive = @IsActive,
		[BankCode] = @BankCode,
		[ModifiedOn] = GETDATE(),
		[CreatedBy] = @ModifiedBy,
		[ModifiedBy] = @ModifiedBy
	Where		
		[BranchId] = @BranchId
		Select @BranchCode as InsertedId

End
Else
Begin
	Insert Into BankBranches
		([BranchName],[BranchCode],[Location],
		 IsActive,[BankCode],[CreatedOn],
		 [ModifiedOn],[CreatedBy],[ModifiedBy],BranchVaultAccNumber)
	Values
		(@BranchName,@BranchCode,@Location,
		 @IsActive,@BankCode,GETDATE(),
		 GETDATE(),@ModifiedBy,@ModifiedBy,
		 @BranchVaultAccNumber)

	--create Bank Vault Account	EXEC dbo.Accounts_Insert '',0,@BranchVaultAccNumber,'COMMISSION_ACCOUNT',@BankCode,@ModifiedBy,@BranchCode,'True','UGS',@ModifiedBy	
	Select  @BranchCode as InsertedId	
End
---------------------------------------------------------------------
Commit Transaction Trans

END TRY
BEGIN CATCH

ROLLBACK Transaction Trans

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[Accounts_Update]    Script Date: 03/05/2016 22:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_Update]	@AccountId varchar(50),	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50),	@ModifiedBy varchar(50),	@BranchCode varchar(50),	@IsActive bit,	@CurrencyCode varchar(50),	@ApprovedBy varchar(50)ASBEGIN TRANSACTION CreateAccountBEGIN TRYIF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode,		CreatedOn,		ModifiedOn,		CreatedBy,		ModifiedBy,		BranchCode,		IsActive,		CurrencyCode,		ApprovedBy	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode,		GETDATE(),		GETDATE(),		@ModifiedBy,		@ModifiedBy,		@BranchCode,		@IsActive,		@CurrencyCode,		@ApprovedBy	)		--if this is a teller account	if exists(select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode)	Begin		--add link btn teller and account in teller to accounts mapping table		EXEC dbo.TellersToAccounts_Insert @UserId,@AccNumber,@BankCode	End	--this is a customer	Else	Begin		--add link btn customer and account in customer to accounts mapping table		EXEC dbo.CustomersToAccounts_Insert @UserId,@AccNumber,@BankCode	End		SELECT @AccNumber As InsertedID	ENDELSE BEGIN	--if this is approved By field is not set	if(@ApprovedBy='')	Begin		UPDATE BankAccounts SET			[AccType] = @AccType,			ModifiedOn=GETDATE(),			ModifiedBy=@ModifiedBy,			IsActive=@IsActive		WHERE AccNumber = @AccNumber and BankCode=@BankCode				SELECT @AccNumber As InsertedID	End		--Approved By Field is set	Else	Begin		UPDATE BankAccounts SET			[AccType] = @AccType,			ModifiedOn=GETDATE(),			ModifiedBy=@ModifiedBy,			IsActive=@IsActive,			ApprovedBy=@ApprovedBy		WHERE AccNumber = @AccNumber and BankCode=@BankCode				SELECT @AccNumber As InsertedID	End	ENDCOMMIT TRANSACTION CreateAccountEND TRYBEGIN CATCH
ROLLBACK Transaction CreateAccount

  DECLARE
   @ErMessage NVARCHAR(2048),
   @ErSeverity INT,
   @ErState INT
 
 SELECT
   @ErMessage = ERROR_MESSAGE(),
   @ErSeverity = ERROR_SEVERITY(),
   @ErState = ERROR_STATE()
 
 RAISERROR (@ErMessage,
             @ErSeverity,
             @ErState )END CATCH
GO
