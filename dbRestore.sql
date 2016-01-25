USE [master]
GO
/****** Object:  Database [TestCoreBankingDB]    Script Date: 01/26/2016 00:57:01 ******/
CREATE DATABASE [TestCoreBankingDB] ON  PRIMARY 
( NAME = N'TestCoreBankingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.KASOZIDB\MSSQL\DATA\TestCoreBankingDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestCoreBankingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.KASOZIDB\MSSQL\DATA\TestCoreBankingDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[UserTypes]    Script Date: 01/26/2016 00:57:02 ******/
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
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[UserTypes] ON
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (1, N'CUSTOMER', N'CUSTOMER', N'BANKS CUSTOMER', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (2, N'TELLER', N'BANKS TELLER', N'BANKS CUSTOMER', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (5, N'BANK ADMIN', N'BANK ADMIN', N'BANK ADMIN', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (4, N'BANK_ADMIN', N'CUSTOMER', N'TEST', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (6, N'SUPERVISOR', N'SUPERVISOR', N'Supervises Tellers', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (7, N'', N'', N'', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (8, N'TestCategory', N'TestCategory', N'Test Category', N'TESTBANK')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (9, N'TestCategory', N'TestCategory', N'Test Category', N'CENTENARY')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (50, N'BANK_ADMIN', N'Banks IT Admin', N'Banks IT Admin', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (51, N'MANAGER', N'Branch Manager', N'Branch Manager', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (52, N'CUSTOMER', N'Banks Customer', N'Banks Customer', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (53, N'TELLER', N'Bank Teller', N'Bank Teller', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (54, N'SUPERVISOR_TELLER', N'Teller Supervisor', N'Teller Supervisor', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (55, N'CUSTOMER_SERVICE', N'Customer Service', N'Customer Service', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (56, N'BUSSINESS_ADMIN', N'Bussiness Admin', N'Bussiness Admin', N'Bank3')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (10, N'BANK_ADMIN', N'Banks IT Admin', N'Banks IT Admin', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (11, N'MANAGER', N'Branch Manager', N'Branch Manager', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (12, N'CUSTOMER', N'Banks Customer', N'Banks Customer', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (13, N'TELLER', N'Bank Teller', N'Bank Teller', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (14, N'SUPERVISOR_TELLER', N'Teller Supervisor', N'Teller Supervisor', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (15, N'CUSTOMER_SERVICE', N'Customer Service', N'Customer Service', N'Bank1')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (16, N'BANK_ADMIN', N'Banks IT Admin', N'Banks IT Admin', N'Bank2')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (17, N'MANAGER', N'Branch Manager', N'Branch Manager', N'Bank2')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (18, N'CUSTOMER', N'Banks Customer', N'Banks Customer', N'Bank2')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (19, N'TELLER', N'Bank Teller', N'Bank Teller', N'Bank2')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (20, N'SUPERVISOR_TELLER', N'Teller Supervisor', N'Teller Supervisor', N'Bank2')
INSERT [dbo].[UserTypes] ([UserTypeId], [UserType], [Role], [Description], [BankCode]) VALUES (21, N'CUSTOMER_SERVICE', N'Customer Service', N'Customer Service', N'Bank2')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
/****** Object:  Table [dbo].[GeneralLedgerTable]    Script Date: 01/26/2016 00:57:02 ******/
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
	[Narration] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[GeneralLedgerTable] ON
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (1, N'10000001', N'TEST CUSTOMER', N'0140586848602', N'', N'0140586848601', 500.0000, N'133326', N'CREDIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012313FA AS DateTime), 34500.0000, 35000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (2, N'10000001', N'TEST CUSTOMER', N'0140586848601', N'0140586848602', N'', 500.0000, N'133326', N'DEBIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012313FA AS DateTime), 16000.0000, 15500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (3, N'10000003', N'TEST CUSTOMER', N'0140586848603', N'', N'0140586848601', 500.0000, N'133326', N'CREDIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012313FA AS DateTime), 30000.0000, 30500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (4, N'10000003', N'TEST CUSTOMER', N'0140586848601', N'0140586848603', N'', 500.0000, N'133326', N'DEBIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012313FA AS DateTime), 15500.0000, 15000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (5, N'10000005', N'TEST CUSTOMER', N'0140586848601', N'', N'0140586848602', 500.0000, N'133326', N'CREDIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012359EB AS DateTime), 15000.0000, 15500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000001')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (6, N'10000005', N'TEST CUSTOMER', N'0140586848602', N'0140586848601', N'', 500.0000, N'133326', N'DEBIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012359EB AS DateTime), 35000.0000, 34500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000001')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (7, N'10000007', N'TEST CUSTOMER', N'0140586848601', N'', N'0140586848603', 500.0000, N'133326', N'CREDIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012359ED AS DateTime), 15500.0000, 16000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000003')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (8, N'10000007', N'TEST CUSTOMER', N'0140586848603', N'0140586848601', N'', 500.0000, N'133326', N'DEBIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D012359ED AS DateTime), 30500.0000, 30000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000003')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (9, N'10000009', N'TEST CUSTOMER', N'0140586848602', N'', N'0140586848601', 500.0000, N'133327', N'CREDIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123E41A AS DateTime), 34500.0000, 35000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (10, N'10000009', N'TEST CUSTOMER', N'0140586848601', N'0140586848602', N'', 500.0000, N'133327', N'DEBIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123E41A AS DateTime), 16000.0000, 15500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (11, N'10000011', N'TEST CUSTOMER', N'0140586848603', N'', N'0140586848601', 500.0000, N'133327', N'CREDIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123E41B AS DateTime), 30000.0000, 30500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (12, N'10000011', N'TEST CUSTOMER', N'0140586848601', N'0140586848603', N'', 500.0000, N'133327', N'DEBIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123E41B AS DateTime), 15500.0000, 15000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (13, N'10000013', N'TEST CUSTOMER', N'0140586848601', N'', N'0140586848603', 500.0000, N'133327', N'CREDIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123F356 AS DateTime), 15000.0000, 15500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000011')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (14, N'10000013', N'TEST CUSTOMER', N'0140586848603', N'0140586848601', N'', 500.0000, N'133327', N'DEBIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123F356 AS DateTime), 30500.0000, 30000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000011')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (15, N'10000015', N'TEST CUSTOMER', N'0140586848601', N'', N'0140586848602', 500.0000, N'133327', N'CREDIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123F356 AS DateTime), 15500.0000, 16000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000009')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (16, N'10000015', N'TEST CUSTOMER', N'0140586848602', N'0140586848601', N'', 500.0000, N'133327', N'DEBIT', N'REVERSAL', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0123F356 AS DateTime), 35000.0000, 34500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000009')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (17, N'10000017', N'TEST CUSTOMER', N'0140586848602', N'', N'0140586848601', 500.0000, N'133328', N'CREDIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0124330F AS DateTime), 34500.0000, 35000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (18, N'10000017', N'TEST CUSTOMER', N'0140586848601', N'0140586848602', N'', 500.0000, N'133328', N'DEBIT', N'TEST', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0124330F AS DateTime), 16000.0000, 15500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TEST NARRATION')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (19, N'10000019', N'TEST CUSTOMER', N'0140586848603', N'', N'0140586848601', 500.0000, N'133328', N'CREDIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0124330F AS DateTime), 30000.0000, 30500.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (20, N'10000019', N'TEST CUSTOMER', N'0140586848601', N'0140586848603', N'', 500.0000, N'133328', N'DEBIT', N'BANK_CHARGE', CAST(0x0000A57C00000000 AS DateTime), CAST(0x0000A57D0124330F AS DateTime), 15500.0000, 15000.0000, N'TEST', N'100', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (21, N'10000021', N'nsubuga kasozi', N'0140586848601', N'', N'0140586848602', 506.0000, N'2', N'CREDIT', N'* TRANSFER', CAST(0x0000A58000000000 AS DateTime), CAST(0x0000A5800022FEF8 AS DateTime), 15000.0000, 15506.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (22, N'10000021', N'nsubuga kasozi', N'0140586848602', N'0140586848601', N'', 506.0000, N'2', N'DEBIT', N'* TRANSFER', CAST(0x0000A58000000000 AS DateTime), CAST(0x0000A5800022FEF8 AS DateTime), 35000.0000, 34494.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (23, N'10000023', N'Dennis Mushabe', N'0140586848601', N'', N'0140586848603', 508.0000, N'3', N'CREDIT', N'INTERNAL TRANSFER', CAST(0x0000A58000000000 AS DateTime), CAST(0x0000A5800049DB88 AS DateTime), 15506.0000, 16014.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Second Test')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (25, N'10000025', N'nsubuga kasozi', N'0140586848601', N'', N'0140586848602', 1300.0000, N'5', N'CREDIT', N'TEST_CATEGORY', CAST(0x0000A58200000000 AS DateTime), CAST(0x0000A5820041B388 AS DateTime), 16014.0000, 17314.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (26, N'10000025', N'nsubuga kasozi', N'0140586848602', N'0140586848601', N'', 1300.0000, N'5', N'DEBIT', N'TEST_CATEGORY', CAST(0x0000A58200000000 AS DateTime), CAST(0x0000A5820041B388 AS DateTime), 34494.0000, 33194.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (45, N'10000045', N'nsubuga kasozi', N'20160103032748988', N'', N'0140586848603', 6500.0000, N'14', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1007 AS DateTime), 2000.0000, 8500.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (46, N'10000045', N'nsubuga kasozi', N'0140586848603', N'20160103032748988', N'', 6500.0000, N'14', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1007 AS DateTime), 29992.0000, 23492.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (47, N'10000047', N'nsubuga kasozi', N'0140586848604', N'', N'0140586848603', 200.0000, N'14', N'CREDIT', N'VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 0.0000, 200.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (48, N'10000047', N'nsubuga kasozi', N'0140586848603', N'0140586848604', N'', 200.0000, N'14', N'DEBIT', N'VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 23492.0000, 23292.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (49, N'10000049', N'nsubuga kasozi', N'0140586848604', N'', N'0140586848603', 200.0000, N'14', N'CREDIT', N'URA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 200.0000, 400.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (50, N'10000049', N'nsubuga kasozi', N'0140586848603', N'0140586848604', N'', 200.0000, N'14', N'DEBIT', N'URA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 23292.0000, 23092.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (51, N'10000051', N'nsubuga kasozi', N'0140586848605', N'', N'0140586848603', 200.0000, N'14', N'CREDIT', N'KCCA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 0.0000, 200.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (52, N'10000051', N'nsubuga kasozi', N'0140586848603', N'0140586848605', N'', 200.0000, N'14', N'DEBIT', N'KCCA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016D1027 AS DateTime), 23092.0000, 22892.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (53, N'10000053', N'nsubuga kasozi', N'20160104221033790', N'', N'0140586848603', 5000.0000, N'18', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3404 AS DateTime), 0.0000, 5000.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (54, N'10000053', N'nsubuga kasozi', N'0140586848603', N'20160104221033790', N'', 5000.0000, N'18', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3404 AS DateTime), 22892.0000, 17892.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Test Transfer')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (55, N'10000055', N'nsubuga kasozi', N'0140586848604', N'', N'0140586848603', 200.0000, N'18', N'CREDIT', N'VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 400.0000, 600.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (56, N'10000055', N'nsubuga kasozi', N'0140586848603', N'0140586848604', N'', 200.0000, N'18', N'DEBIT', N'VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 17892.0000, 17692.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (57, N'10000057', N'nsubuga kasozi', N'0140586848604', N'', N'0140586848603', 200.0000, N'18', N'CREDIT', N'URA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 600.0000, 800.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (58, N'10000057', N'nsubuga kasozi', N'0140586848603', N'0140586848604', N'', 200.0000, N'18', N'DEBIT', N'URA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 17692.0000, 17492.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (59, N'10000059', N'nsubuga kasozi', N'0140586848605', N'', N'0140586848603', 200.0000, N'18', N'CREDIT', N'KCCA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 200.0000, 400.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (60, N'10000059', N'nsubuga kasozi', N'0140586848603', N'0140586848605', N'', 200.0000, N'18', N'DEBIT', N'KCCA_CHARGE', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583016E3405 AS DateTime), 17492.0000, 17292.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (24, N'10000023', N'Dennis Mushabe', N'0140586848603', N'0140586848601', N'', 508.0000, N'3', N'DEBIT', N'INTERNAL TRANSFER', CAST(0x0000A58000000000 AS DateTime), CAST(0x0000A5800049DB88 AS DateTime), 30500.0000, 29992.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Second Test')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (61, N'10000061', N'nsubuga kasozi', N'20160103032748988', N'', N'0140586848603', 4000.0000, N'19', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583017222E5 AS DateTime), 8500.0000, 12500.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'School Fees')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (62, N'10000061', N'nsubuga kasozi', N'0140586848603', N'20160103032748988', N'', 4000.0000, N'19', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583017222E5 AS DateTime), 17292.0000, 13292.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'School Fees')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (63, N'10000063', N'nsubuga kasozi', N'0140586848605', N'', N'0140586848603', 300.0000, N'19', N'CREDIT', N'NEW_KCCA_VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583017222F9 AS DateTime), 400.0000, 700.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (64, N'10000063', N'nsubuga kasozi', N'0140586848603', N'0140586848605', N'', 300.0000, N'19', N'DEBIT', N'NEW_KCCA_VAT', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A583017222F9 AS DateTime), 13292.0000, 12992.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'TRANSACTION CHARGE')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (65, N'10000065', N'nsubuga kasozi', N'20160103032748988', N'', N'0140586848603', 4000.0000, N'20', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A5830172D9E9 AS DateTime), 12500.0000, 16500.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'School Fees')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (66, N'10000065', N'nsubuga kasozi', N'0140586848603', N'20160103032748988', N'', 4000.0000, N'20', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A5830172D9E9 AS DateTime), 12992.0000, 8992.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'School Fees')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (67, N'10000067', N'nsubuga kasozi', N'0140586848605', N'', N'0140586848603', 300.0000, N'20', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A5830172D9EF AS DateTime), 700.0000, 1000.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (68, N'10000067', N'nsubuga kasozi', N'0140586848603', N'0140586848605', N'', 300.0000, N'20', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58300000000 AS DateTime), CAST(0x0000A5830172D9EF AS DateTime), 8992.0000, 8692.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (69, N'10000069', N'Nsubuga Kasozi', N'0140586848601', N'', N'20160103032748988', 3500.0000, N'22', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00CBBB9F AS DateTime), 17314.0000, 20814.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (70, N'10000069', N'Nsubuga Kasozi', N'20160103032748988', N'0140586848601', N'', 3500.0000, N'22', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00CBBB9F AS DateTime), 16500.0000, 13000.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (71, N'10000071', N'Nsubuga Kasozi', N'0140586848605', N'', N'20160103032748988', 300.0000, N'22', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00CBBBED AS DateTime), 1000.0000, 1300.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (72, N'10000071', N'Nsubuga Kasozi', N'20160103032748988', N'0140586848605', N'', 300.0000, N'22', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00CBBBED AS DateTime), 13000.0000, 12700.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (73, N'10000073', N'Nsubuga Kasozi', N'20160103032748988', N'', N'0140586848601', 3500.0000, N'1', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00D5E12D AS DateTime), 12700.0000, 16200.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (74, N'10000073', N'Nsubuga Kasozi', N'0140586848601', N'20160103032748988', N'', 3500.0000, N'1', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00D5E12D AS DateTime), 20814.0000, 17314.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (75, N'10000075', N'Nsubuga Kasozi', N'0140586848605', N'', N'0140586848601', 300.0000, N'1', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00D5E12D AS DateTime), 1300.0000, 1600.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (76, N'10000075', N'Nsubuga Kasozi', N'0140586848601', N'0140586848605', N'', 300.0000, N'1', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A00D5E12D AS DateTime), 17314.0000, 17014.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (77, N'10000077', N'Nsubuga Kasozi', N'0140586848601', N'', N'20160103032748988', 3500.0000, N'1', N'CREDIT', N'REVERSAL', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A01726AE6 AS DateTime), 17014.0000, 20514.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000073')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (78, N'10000077', N'Nsubuga Kasozi', N'20160103032748988', N'0140586848601', N'', 3500.0000, N'1', N'DEBIT', N'REVERSAL', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A01726AE6 AS DateTime), 16200.0000, 12700.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000073')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (79, N'10000079', N'Nsubuga Kasozi', N'0140586848601', N'', N'0140586848605', 300.0000, N'1', N'CREDIT', N'REVERSAL', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A01726AE8 AS DateTime), 20514.0000, 20814.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000075')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (80, N'10000079', N'Nsubuga Kasozi', N'0140586848605', N'0140586848601', N'', 300.0000, N'1', N'DEBIT', N'REVERSAL', CAST(0x0000A58A00000000 AS DateTime), CAST(0x0000A58A01726AE8 AS DateTime), 1600.0000, 1300.0000, N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'REVERSAL OF 10000075')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (81, N'10000081', N'Nsubuga Kasozi', N'0140586848601', N'', N'0140586848602', 1320700.0000, N'2', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00ED4CEE AS DateTime), 20814.0000, 1341514.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (82, N'10000081', N'Nsubuga Kasozi', N'0140586848602', N'0140586848601', N'', 1320700.0000, N'2', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00ED4CEE AS DateTime), 10000000.0000, 8679300.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (83, N'10000083', N'Nsubuga Kasozi', N'0140586848605', N'', N'0140586848602', 300.0000, N'2', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00ED4D0A AS DateTime), 1300.0000, 1600.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (84, N'10000083', N'Nsubuga Kasozi', N'0140586848602', N'0140586848605', N'', 300.0000, N'2', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00ED4D0A AS DateTime), 8679300.0000, 8679000.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (85, N'10000085', N'Nsubuga Kasozi', N'0140586848601', N'', N'0140586848602', 1100000.0000, N'3', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EDB1CE AS DateTime), 1341514.0000, 2441514.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'test')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (86, N'10000085', N'Nsubuga Kasozi', N'0140586848602', N'0140586848601', N'', 1100000.0000, N'3', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EDB1CE AS DateTime), 8679000.0000, 7579000.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'test')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (87, N'10000087', N'Nsubuga Kasozi', N'0140586848605', N'', N'0140586848602', 300.0000, N'3', N'CREDIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EDB1CF AS DateTime), 1600.0000, 1900.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (88, N'10000087', N'Nsubuga Kasozi', N'0140586848602', N'0140586848605', N'', 300.0000, N'3', N'DEBIT', N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EDB1CF AS DateTime), 7579000.0000, 7578700.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'NEW_KCCA_VAT')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (89, N'10000089', N'Joshua', N'0140586848601', N'', N'0140586848602', 3500.0000, N'7', N'CREDIT', N'WITHDRAW', CAST(0x0000A59600000000 AS DateTime), CAST(0x0000A59601655223 AS DateTime), 2441514.0000, 2445014.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent')
INSERT [dbo].[GeneralLedgerTable] ([RecordId], [PegPayTranId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [BankTranId], [TranType], [TranCategory], [PaymentDate], [RecordDate], [AccountBalBefore], [AccountBalAfter], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration]) VALUES (90, N'10000089', N'Joshua', N'0140586848602', N'0140586848601', N'', 3500.0000, N'7', N'DEBIT', N'WITHDRAW', CAST(0x0000A59600000000 AS DateTime), CAST(0x0000A59601655223 AS DateTime), 7578700.0000, 7575200.0000, N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent')
SET IDENTITY_INSERT [dbo].[GeneralLedgerTable] OFF
/****** Object:  UserDefinedFunction [dbo].[fn_GetReceiptno]    Script Date: 01/26/2016 00:57:03 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetAccountNo]    Script Date: 01/26/2016 00:57:03 ******/
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
/****** Object:  Table [dbo].[Errorlogs]    Script Date: 01/26/2016 00:57:03 ******/
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
/****** Object:  Table [dbo].[UsersToAccounts]    Script Date: 01/26/2016 00:57:03 ******/
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
SET IDENTITY_INSERT [dbo].[UsersToAccounts] ON
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (1, N'Njovu', N'20160114203015592', N'TESTBANK')
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (2, N'Njovu', N'20160114203101585', N'TESTBANK')
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (3, N'Njovu', N'0140586848603', N'TESTBANK')
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (4, N'deo.emorut@pegasustechnologies.co.ug', N'20160119105834231', N'TESTBANK')
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (5, N'martha.anthea@pegasustechnologies.co.ug', N'20160120125415093', N'Bank3')
INSERT [dbo].[UsersToAccounts] ([RecordId], [UserId], [AccountNumber], [BankCode]) VALUES (6, N'kiracho.islam@pegasustechnologies.co.ug', N'0140586848601', N'TESTBANK')
SET IDENTITY_INSERT [dbo].[UsersToAccounts] OFF
/****** Object:  Table [dbo].[TransactionRules]    Script Date: 01/26/2016 00:57:03 ******/
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
SET IDENTITY_INSERT [dbo].[TransactionRules] ON
INSERT [dbo].[TransactionRules] ([RecordId], [RuleName], [RuleCode], [UserId], [Description], [MinimumAmount], [MaximumAmount], [IsActive], [BankCode], [BranchCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [Approver]) VALUES (1, N'TEST', N'TEST', N'ALL', N'TRAN AMOUNT REQUIRES APPROVAL', 500.0000, 100000.0000, 1, N'TESTBANK', N'ALL', CAST(0x0000A58200000000 AS DateTime), CAST(0x0000A58200000000 AS DateTime), N'Admin', N'Admin', N'SUPERVISOR')
SET IDENTITY_INSERT [dbo].[TransactionRules] OFF
/****** Object:  Table [dbo].[TransactionRequests]    Script Date: 01/26/2016 00:57:03 ******/
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
	[Reason] [varchar](8000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionRequests] ON
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (1, N'Nsubuga Kasozi', N'0140586848601', N'20160103032748988', N'0140586848601', 3500.0000, N'INTERNAL_TRANSFER', CAST(0x0000A6B100000000 AS DateTime), CAST(0x0000A58A00D5E0D6 AS DateTime), N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent', NULL, NULL, N'SUCCESS', N'10000073')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (2, N'Nsubuga Kasozi', N'0140586848602', N'0140586848601', N'0140586848602', 1320700.0000, N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EBBFBB AS DateTime), N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent', 1, N'SUPERVISOR', N'SUCCESS', N'10000021')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (3, N'Nsubuga Kasozi', N'0140586848602', N'0140586848601', N'0140586848602', 1100000.0000, N'INTERNAL_TRANSFER', CAST(0x0000A6CF00000000 AS DateTime), CAST(0x0000A58B00EDA0C6 AS DateTime), N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'test', 1, N'SUPERVISOR', N'SUCCESS', N'10000023')
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (4, N'Joshua', N'0140586848602', N'0140586848601', N'0140586848602', 3500.0000, N'WITHDRAW', CAST(0x0000A59601639998 AS DateTime), CAST(0x0000A59601639A8A AS DateTime), N'admin', N'', N'TESTBANK', N'TESTBRANCH', N'Rent', NULL, NULL, NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (5, N'Joshua', N'0140586848601', N'0140586848601', N'0140586848601', 3500.0000, N'WITHDRAW', CAST(0x0000A59601640D9C AS DateTime), CAST(0x0000A59601640E2C AS DateTime), N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent', NULL, NULL, NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (6, N'Joshua', N'0140586848602', N'0140586848601', N'0140586848602', 3500.0000, N'WITHDRAW', CAST(0x0000A5960164F5A4 AS DateTime), CAST(0x0000A5960164F6AC AS DateTime), N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent', NULL, NULL, NULL, NULL)
INSERT [dbo].[TransactionRequests] ([RecordId], [CustomerName], [AccountNumber], [ToAccount], [FromAccount], [TranAmount], [TranCategory], [PaymentDate], [RecordDate], [Teller], [ApprovedBy], [BankCode], [BranchCode], [Narration], [RequiresApproval], [Approver], [Status], [Reason]) VALUES (7, N'Joshua', N'0140586848602', N'0140586848601', N'0140586848602', 3500.0000, N'WITHDRAW', CAST(0x0000A596016547AC AS DateTime), CAST(0x0000A59601654928 AS DateTime), N'admin', N'admin', N'TESTBANK', N'TESTBRANCH', N'Rent', NULL, NULL, N'SUCCESS', N'10000089')
SET IDENTITY_INSERT [dbo].[TransactionRequests] OFF
/****** Object:  Table [dbo].[TransactionCategories]    Script Date: 01/26/2016 00:57:03 ******/
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
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (1, N'INTERNAL_TRANSFER', N'Internal Transaction', N'TESTBANK', CAST(0x0000A58100000000 AS DateTime), CAST(0x0000A58100000000 AS DateTime), N'ADMIN', N'ADMIN', NULL)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (2, N'TEST_CATEGORY', N'TESTING', N'TESTBANK', CAST(0x0000A58200062010 AS DateTime), CAST(0x0000A58200062010 AS DateTime), N'admin', N'admin', NULL)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (3, N'WITHDRAW', N'Withdraw', N'TESTBANK', CAST(0x0000A592009CACF7 AS DateTime), CAST(0x0000A592009CACF7 AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (4, N'WITHDRAW', N'WITHDRAW OPERATION', N'Bank3', CAST(0x0000A5920164B7F9 AS DateTime), CAST(0x0000A5920164B7F9 AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (5, N'DEPOSIT', N'DEPOSIT OPERATION', N'Bank3', CAST(0x0000A5920164B7F9 AS DateTime), CAST(0x0000A5920164B7F9 AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (6, N'INTERNAL_TRANSFER', N'AN INTERNAL TRANSFER', N'Bank3', CAST(0x0000A5920164B7F9 AS DateTime), CAST(0x0000A5920164B7F9 AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[TransactionCategories] ([TranTypeId], [TranType], [Description], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive]) VALUES (7, N'EXTERNAL_TRANSFER', N'AN EXTERNAL TRANSFER', N'Bank3', CAST(0x0000A5920164B7F9 AS DateTime), CAST(0x0000A5920164B7F9 AS DateTime), N'admin', N'admin', 1)
SET IDENTITY_INSERT [dbo].[TransactionCategories] OFF
/****** Object:  Table [dbo].[BankTypes]    Script Date: 01/26/2016 00:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankTypes](
	[BankTypeId] [int] IDENTITY(1,1) NOT NULL,
	[BankType] [varchar](50) NULL,
	[Description] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChargeTypes]    Script Date: 01/26/2016 00:57:03 ******/
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
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ChargeTypes] ON
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode]) VALUES (1, N'FLAT_FEE', N'FLAT FEE', CAST(0x0000A59900000000 AS DateTime), CAST(0x0000A59900000000 AS DateTime), N'admin', N'admin', N'TESTBANK')
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode]) VALUES (2, N'PERCENTAGE', N'PERCENTAGE', CAST(0x0000A59900000000 AS DateTime), CAST(0x0000A59900000000 AS DateTime), N'admin', N'admin', N'TESTBANK')
INSERT [dbo].[ChargeTypes] ([ChargeTypeId], [ChargeTypeCode], [ChargeTypeName], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy], [BankCode]) VALUES (3, N'TIERED', N'TIERED', CAST(0x0000A59900000000 AS DateTime), CAST(0x0000A59900000000 AS DateTime), N'admin', N'admin', N'TESTBANK')
SET IDENTITY_INSERT [dbo].[ChargeTypes] OFF
/****** Object:  Table [dbo].[CustomerTypes]    Script Date: 01/26/2016 00:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerTypes](
	[CustomerTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerType] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerTypes] ON
INSERT [dbo].[CustomerTypes] ([CustomerTypeId], [CustomerType], [Description], [BankCode]) VALUES (1, N'CORPORATE', N'This is for Big Banks', NULL)
INSERT [dbo].[CustomerTypes] ([CustomerTypeId], [CustomerType], [Description], [BankCode]) VALUES (2, N'FARMERS', N'TEST', N'TESTBANK')
SET IDENTITY_INSERT [dbo].[CustomerTypes] OFF
/****** Object:  Table [dbo].[AccessRules]    Script Date: 01/26/2016 00:57:03 ******/
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
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (5, N'Bank Admin Rule', N'ALL', N'TESTBANK', N'BANK_ADMIN,REPORTS', N'', N'TESTBRANCH', 1, CAST(0x0000A586015E0703 AS DateTime), N'admin', CAST(0x0000A586015E0703 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (6, N'Teller Rule', N'TELLER', N'TESTBANK', N'REPORTS,TELLER', N'', N'TESTBRANCH', 1, CAST(0x0000A586015E6BB3 AS DateTime), N'admin', CAST(0x0000A586015E6BB3 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (7, N'Sys Admin Rule', N'SYS_ADMIN', N'TESTBANK', N'ALL', N'', N'TESTBRANCH', 1, CAST(0x0000A586015E6BB3 AS DateTime), N'admin', CAST(0x0000A586015E6BB3 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (8, N'Bank Admin Rule', N'BANK_ADMIN', N'Bank3', N'BANK_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (9, N'Manager Rule', N'MANAGER', N'Bank3', N'MANAGER,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (10, N'Teller Rule', N'TELLER', N'Bank3', N'TELLER,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (11, N'Supervisor Rule', N'SUPERVISOR_TELLER', N'Bank3', N'SUPERVISOR,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (12, N'Customer Service Rule', N'CUSTOMER_SERVICE', N'Bank3', N'CUSTOMER_SERVICE,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
INSERT [dbo].[AccessRules] ([RecordId], [RuleName], [UserType], [BankCode], [CanAccess], [UserId], [BranchCode], [IsActive], [ModifiedOn], [ModifiedBy], [CreatedOn], [CreatedBy]) VALUES (13, N'Bussiness Admin Rule', N'BUSSINESS_ADMIN', N'Bank3', N'BUSSINESS_ADMIN,REPORTS', N'', N'', 1, CAST(0x0000A5920164B7F7 AS DateTime), N'admin', CAST(0x0000A5920164B7F7 AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[AccessRules] OFF
/****** Object:  Table [dbo].[AccessAreas]    Script Date: 01/26/2016 00:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccessAreas](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[AreaName] [varchar](50) NULL,
	[AreaCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AccessAreas] ON
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (1, N'TELLER', N'TELLER')
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (2, N'SUPERVISOR', N'SUPERVISOR')
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (3, N'BANK MANAGER', N'MANAGER')
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (4, N'BANK ADMIN', N'BANK_ADMIN')
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (5, N'REPORTS', N'REPORTS')
INSERT [dbo].[AccessAreas] ([RecordId], [AreaName], [AreaCode]) VALUES (6, N'BUSSINESS ADMIN', N'BUSSINESS_ADMIN')
SET IDENTITY_INSERT [dbo].[AccessAreas] OFF
/****** Object:  Table [dbo].[BankTellers]    Script Date: 01/26/2016 00:57:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankTellers](
	[TellerId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankTellers] ON
INSERT [dbo].[BankTellers] ([TellerId], [UserId], [AccountNumber], [BranchCode], [BankCode]) VALUES (1, N'Nkasozi', N'', N'TESTBRANCH', N'TESTBANK')
INSERT [dbo].[BankTellers] ([TellerId], [UserId], [AccountNumber], [BranchCode], [BankCode]) VALUES (2, N'Nkasozi', N'', N'TESTBRANCH', N'TESTBANK')
SET IDENTITY_INSERT [dbo].[BankTellers] OFF
/****** Object:  Table [dbo].[BankSystemUsers]    Script Date: 01/26/2016 00:57:03 ******/
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
	[LastUpdateDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedBy] [varchar](50) NULL,
	[CanHaveAccount] [bit] NULL,
	[PhoneNumber] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[TranAmountLimit] [varchar](50) NULL,
	[PathToProfilePic] [varchar](8000) NULL,
	[PathToSignature] [varchar](8000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankSystemUsers] ON
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (1, N'nsubugak@yahoo.com', N'nsubugak@yahoo.com', N'NSUBUGA KASOZI', N'TELLER', N'TEST', 1, N'TESTBANK', N'17/02/1991', CAST(0x0000A57C004F3EDF AS DateTime), CAST(0x0000A59800D01D3D AS DateTime), N'TEST', N'TEST', 1, N'256794132389', N'MY', N'MALE', NULL, N'1000', NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (2, N'admin', N'nsubugak@yahoo.com', N'Nsubuga Kasozi', N'SYS_ADMIN', N'T3rr1613', 1, N'TESTBANK', N'17/02/1991', CAST(0x0000A57C004F3EDF AS DateTime), CAST(0x0000A57C004F3EDF AS DateTime), N'TEST', N'TEST', 1, N'256785975800', N'TESTBRANCH', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (3, N'nkasozi', N'nsubugak@yahoo.com', N'Nsubuga Kasozi', N'BANK_ADMIN', N'TEST', 1, N'TESTBANK', N'17/02/1991', CAST(0x0000A581008753D5 AS DateTime), CAST(0x0000A581008A3761 AS DateTime), N'admin', N'admin', 0, N'256794132389', N'TESTBRANCH', N'Male', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (4, N'Njovu', N'nvoju@gmail.com', N'Njovu Joshua', N'CUSTOMER', N'T3rr1613', 0, N'TESTBANK', N'07/01/2016', CAST(0x0000A58D01517F12 AS DateTime), CAST(0x0000A58D01517F12 AS DateTime), N'admin', N'admin', 0, N'256789675899', N'TESTBRANCH', N'Male', NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (5, N'deo.emorut@pegasustechnologies.co.ug', N'deo.emorut@pegasustechnologies.co.ug', N'Deo Emorut', N'CUSTOMER', N'T3rr1613', 1, N'TESTBANK', N'17/02/1991', CAST(0x0000A59200B4B598 AS DateTime), CAST(0x0000A59200B4B598 AS DateTime), N'admin', N'admin', 0, N'', N'TESTBRANCH', N'Male', NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (9, N'paul.kavule@pegasustechnologies.co.ug', N'paul.kavule@pegasustechnologies.co.ug', N'Paul Kavule', N'BUSSINESS_ADMIN', N'T3rr1613', 1, N'Bank3', N'04/01/2016', CAST(0x0000A5920170022D AS DateTime), CAST(0x0000A5920170022D AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', 0, N'', N'Branch1', N'Male', NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (7, N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'Dennis Mushabe', N'BANK_ADMIN', N'T3rr1613', 1, N'Bank3', N'08/01/2016', CAST(0x0000A5920168B425 AS DateTime), CAST(0x0000A5920168B425 AS DateTime), N'admin', N'admin', 0, N'', N'Branch1', N'Male', NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (10, N'martha.anthea@pegasustechnologies.co.ug', N'martha.anthea@pegasustechnologies.co.ug', N'Martha Anthea', N'TELLER', N'T3rr1613', 1, N'Bank3', N'29/12/2015', CAST(0x0000A59300C39E22 AS DateTime), CAST(0x0000A59300C39E26 AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', 0, N'', N'Branch1', N'Male', NULL, NULL, NULL, NULL)
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (11, N'kiracho.islam@pegasustechnologies.co.ug', N'kiracho.islam@pegasustechnologies.co.ug', N'Kiracho Islam', N'CUSTOMER', N'T3rr1613', 1, N'TESTBANK', N'17/01/2016', CAST(0x0000A5980180BFDC AS DateTime), CAST(0x0000A5980180BFDC AS DateTime), N'admin', N'admin', 0, N'', N'TESTBRANCH', N'Male', NULL, N'0', N'IMG-20151219-WA0003.jpg', N'IMG-20151219-WA0003.jpg')
INSERT [dbo].[BankSystemUsers] ([RecordId], [UserId], [Email], [Fullname], [Usertype], [Password], [IsActive], [BankCode], [DateOfBirth], [RecordDate], [LastUpdateDate], [CreatedBy], [ModifiedBy], [CanHaveAccount], [PhoneNumber], [BranchCode], [Gender], [ApprovedBy], [TranAmountLimit], [PathToProfilePic], [PathToSignature]) VALUES (8, N'kagwa.andrew@pegasustechnolgoies.co.ug', N'kagwa.andrew@pegasustechnolgoies.co.ug', N'Andrew Kagwa', N'TELLER', N'T3rr1613', 1, N'Bank3', N'07/01/2016', CAST(0x0000A592016AAF48 AS DateTime), CAST(0x0000A592016AAF48 AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', 0, N'', N'Branch1', N'Male', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[BankSystemUsers] OFF
/****** Object:  StoredProcedure [dbo].[Banks_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_DeleteRow]	@BankId intASSET NOCOUNT ON
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 01/26/2016 00:57:05 ******/
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
	[PathToPublicKey] [varchar](1300) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Banks] ON
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (1, N'TESTBANK', N'TESTBANK', N'nsubugak@yahoo.com', N'?', N'True', NULL, CAST(0x0000A58300097CDA AS DateTime), NULL, NULL, N'StanbicLogo.png', N'C:\CoreBankingResources\PublicKeys\TESTBANK\pegasus.cer')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (8, N'dd', N'fff', N'fff', N'T3rr1613', N'True', CAST(0x0000A59200F1D181 AS DateTime), CAST(0x0000A59200F1D181 AS DateTime), NULL, NULL, N'WIN_20160115_19_40_45_Pro.jpg', N'C:\CoreBankingResources\PublicKeys\fff\pegasus.cer')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (7, N'CENTENARY BANK', N'CENTENARY', N'nsubugak@yahoo.com', N'TEST', N'True', CAST(0x0000A581000E01F0 AS DateTime), CAST(0x0000A581000F6180 AS DateTime), NULL, NULL, N'C:\CoreBankingResources\BankLogos\CENTENARY\StanbicLogo.png', N'C:\CoreBankingResources\PublicKeys\CENTENARY\pegasus.cer')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (9, N'Bank1', N'Bank1', N'Bank1', N'T3rr1613', N'True', CAST(0x0000A592010A1C84 AS DateTime), CAST(0x0000A592010A1C84 AS DateTime), NULL, NULL, N'tale of the three brothers 7.jpg', N'C:\CoreBankingResources\PublicKeys\Bank1\pegasus.cer')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (10, N'Bank2', N'Bank2', N'Bank2', N'T3rr1613', N'True', CAST(0x0000A592010CD1E2 AS DateTime), CAST(0x0000A592010CD1E2 AS DateTime), NULL, NULL, N'the_tale_of_three_brothers_by_polisherci-d4plsil.jpg', N'C:\CoreBankingResources\PublicKeys\Bank2\pegasus.cer')
INSERT [dbo].[Banks] ([BankId], [BankName], [BankCode], [BankContactEmail], [BankPassword], [IsActive], [CreatedOn], [LastUpdateDate], [CreatedBy], [ModifiedBy], [PathToLogoImage], [PathToPublicKey]) VALUES (15, N'Bank3', N'Bank3', N'Bank3', N'T3rr1613', N'True', CAST(0x0000A5920164B7E8 AS DateTime), CAST(0x0000A5920164B7E8 AS DateTime), NULL, NULL, N'the_tale_of_three_brothers_by_polisherci-d4plsil.jpg', N'C:\CoreBankingResources\PublicKeys\Bank3\pegasus.cer')
SET IDENTITY_INSERT [dbo].[Banks] OFF
/****** Object:  Table [dbo].[BankCustomers]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankCustomers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[PhoneNumber] [varchar](50) NULL,
	[Sex] [varchar](50) NULL,
	[BankCode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[UrlToImage] [varchar](50) NULL,
	[RecordDate] [datetime] NULL,
	[LastUpdateDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankCustomers] ON
INSERT [dbo].[BankCustomers] ([CustomerId], [CustomerName], [DateOfBirth], [Email], [PhoneNumber], [Sex], [BankCode], [IsActive], [UrlToImage], [RecordDate], [LastUpdateDate]) VALUES (1, N'NSUBUGA KASOZI', CAST(0x0000820400000000 AS DateTime), N'nkasozi@gmail.com', N'2567894132389', N'MALE', N'TESTBANK', 1, N'', CAST(0x0000A56D015E326C AS DateTime), CAST(0x0000A56D015E326C AS DateTime))
INSERT [dbo].[BankCustomers] ([CustomerId], [CustomerName], [DateOfBirth], [Email], [PhoneNumber], [Sex], [BankCode], [IsActive], [UrlToImage], [RecordDate], [LastUpdateDate]) VALUES (2, N'NSUBUGA KASOZI', CAST(0x0000820400000000 AS DateTime), N'nkasozi@gmail.com', N'2567894132389', N'MALE', N'TESTBANK', 1, N'', CAST(0x0000A56D015E49A3 AS DateTime), CAST(0x0000A56D015E49A3 AS DateTime))
SET IDENTITY_INSERT [dbo].[BankCustomers] OFF
/****** Object:  Table [dbo].[BankCharges]    Script Date: 01/26/2016 00:57:05 ******/
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
SET IDENTITY_INSERT [dbo].[BankCharges] ON
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (1, 500.0000, N'0140586848603', N'TEST', 1, N'TESTBANK', N'BANK_CHARGE', N'BANK_CHARGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (2, 200.0000, N'0140586848604', N'INTERNAL_TRANSFER', 1, N'TESTBANK', N'VAT', N'VAT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (3, 200.0000, N'0140586848604', N'INTERNAL_TRANSFER', 1, N'TESTBANK', N'URA_CHARGE', N'URA_CHARGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (4, 200.0000, N'0140586848605', N'INTERNAL_TRANSFER', 1, N'TESTBANK', N'KCCA_CHARGE', N'KCCA_CHARGE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (6, 300.0000, N'0140586848605', N'INTERNAL_TRANSFER', 1, N'TESTBANK', N'NEW_KCCA_VAT', N'NEW KCCA', NULL, N'admin', CAST(0x0000A58301717D90 AS DateTime), CAST(0x0000A58301717D90 AS DateTime), N'New charge introduced by KCCA', N'1', NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (7, 1200.0000, N'0140586848603', N'TEST_CATEGORY', 1, N'TESTBANK', N'TEST_CHARGE', N'Test Charge', N'admin', N'admin', CAST(0x0000A591018A82D8 AS DateTime), CAST(0x0000A591018A82D8 AS DateTime), N'Test Charge', N'1', NULL, NULL)
INSERT [dbo].[BankCharges] ([ChargeId], [ChargeAmount], [CommissionAccount], [TransCategory], [IsDebit], [BankCode], [ChargeCode], [ChargeName], [CreatedBy], [ModifiedBy], [CreatedOn], [ModifiedOn], [ChargeDesc], [IsActive], [AccountType], [ChargeType]) VALUES (8, 3200.0000, N'0140586848603', N'', 1, N'TESTBANK', N'WITHDRAW_CHARGE_001', N'SAVINGS ACCOUNT WITHDRAW CHARGE', N'admin', N'admin', CAST(0x0000A59900053A60 AS DateTime), CAST(0x0000A599000EC55B AS DateTime), N'SAVINGS ACCOUNT WITHDRAW CHARGE', N'1', N'SAVINGS', N'FLAT_FEE')
SET IDENTITY_INSERT [dbo].[BankCharges] OFF
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 01/26/2016 00:57:05 ******/
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
	[MaxNumberOfSignatories] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (1, N'SAVINGS', N'SAVINGS', 500.0000, N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (2, N'CORPORATE ACCOUNT', N'CORPORATE', -2000000.0000, N'TESTBANK', 1, N'Account for Big Companies', N'admin', N'admin', CAST(0x0000A582016A382A AS DateTime), CAST(0x0000A582016AF525 AS DateTime), 1, NULL, NULL)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (3, N'TestCategory', N'TestCategory', -50000.0000, N'TESTBANK', 1, N'TestCategory', N'admin', N'admin', CAST(0x0000A59200DC8473 AS DateTime), CAST(0x0000A59200DC8473 AS DateTime), 1, NULL, NULL)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (4, N'COMMISSION ACCOUNT', N'COMMISSION_ACCOUNT', 0.0000, N'Bank3', 1, N'Commission Account', N'admin', N'admin', CAST(0x0000A5920164B802 AS DateTime), CAST(0x0000A5920164B802 AS DateTime), 1, NULL, NULL)
INSERT [dbo].[AccountTypes] ([AccTypeId], [AccTypeName], [AccTypeCode], [MinimumBal], [BankCode], [IsDebitable], [Description], [ModifiedBy], [CreatedBy], [CreatedOn], [ModifiedOn], [IsActive], [MinNumberOfSignatories], [MaxNumberOfSignatories]) VALUES (5, N'TELLER ACCOUNT', N'TELLER_ACCOUNT', 0.0000, N'Bank3', 1, N'Teller Account', N'admin', N'admin', CAST(0x0000A5920164B802 AS DateTime), CAST(0x0000A5920164B802 AS DateTime), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
/****** Object:  Table [dbo].[BankBranches]    Script Date: 01/26/2016 00:57:05 ******/
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
	[ModifiedBy] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankBranches] ON
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (1, N'TESTBRANCH', N'TESTBRANCH', N'KANSANGA', 1, N'TESTBANK', CAST(0x0000A57B016164C6 AS DateTime), CAST(0x0000A57B016164C6 AS DateTime), N'TEST', N'TEST')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (2, N'KANSANGA BRANCH', N'TESTBANK', N'KANSANGA', 1, N'TESTBANK', CAST(0x0000A582001384C8 AS DateTime), CAST(0x0000A582001384C8 AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (3, N'MyBranch', N'CENTENARY', N'Wandegeya', 1, N'TESTBANK', CAST(0x0000A592009D3876 AS DateTime), CAST(0x0000A592009D3876 AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (4, N'Wandegeya Branch', N'Wandegeya-001', N'Wandegeya', 1, N'TESTBANK', CAST(0x0000A59200A2011A AS DateTime), CAST(0x0000A59200A2011A AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (5, N'Kansanga Branch', N'Kansanga-001', N'Kansanga', 1, N'TESTBANK', CAST(0x0000A59200A51A38 AS DateTime), CAST(0x0000A59200A51A38 AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (6, N'Kansanga Branch', N'Kansanga-001', N'Kansanga', 1, N'CENTENARY', CAST(0x0000A59200A6728C AS DateTime), CAST(0x0000A59200A6728C AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (7, N'first Branch', N'First Branch', N'Knasanga', 1, N'fff', CAST(0x0000A59201065055 AS DateTime), CAST(0x0000A59201065055 AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (8, N'Branch1', N'Branch1', N'Branch1', 1, N'Bank2', CAST(0x0000A592010CF302 AS DateTime), CAST(0x0000A592010CF302 AS DateTime), N'admin', N'admin')
INSERT [dbo].[BankBranches] ([BranchId], [BranchName], [BranchCode], [Location], [IsActive], [BankCode], [CreatedOn], [ModifiedOn], [CreatedBy], [ModifiedBy]) VALUES (9, N'Branch1', N'Branch1', N'Branch1', 1, N'Bank3', CAST(0x0000A59201653EE9 AS DateTime), CAST(0x0000A59201653EE9 AS DateTime), N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[BankBranches] OFF
/****** Object:  Table [dbo].[BankAccountSignatories]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BankAccountSignatories](
	[RecordId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NULL,
	[AccountId] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 01/26/2016 00:57:05 ******/
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
	[IsActive] [varchar](50) NULL,
	[ApprovedBy] [varchar](50) NULL,
	[BranchCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BankAccounts] ON
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (1, 2445014.0000, N'0140586848601', N'SAVINGS', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (2, 7575200.0000, N'0140586848602', N'SAVINGS', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (3, 8692.0000, N'0140586848603', N'COMMISSION', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (4, 800.0000, N'0140586848604', N'COMMISSION', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (5, 1900.0000, N'0140586848605', N'COMMISSION', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (6, 0.0000, N'352085', N'TELLER ACCOUNT', N'testbank', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (12, 0.0000, N'259085', N'SAVINGS', N'TESTBANK', CAST(0x0000A5820038BEDE AS DateTime), CAST(0x0000A5820038BEDE AS DateTime), N'admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (13, 12700.0000, N'20160103032748988', N'SAVINGS', N'TESTBANK', CAST(0x0000A582003A19F1 AS DateTime), CAST(0x0000A582003A19F1 AS DateTime), N'admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (14, 0.0000, N'20160103033353642', N'SAVINGS', N'TESTBANK', CAST(0x0000A582003ACC77 AS DateTime), CAST(0x0000A582003ACC77 AS DateTime), N'admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (15, 0.0000, N'20160103220239693', N'CORPORATE', N'TESTBANK', CAST(0x0000A582016B49E4 AS DateTime), CAST(0x0000A582016B49E4 AS DateTime), N'admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (17, 0.0000, N'20160114203015592', N'SAVINGS', N'TESTBANK', CAST(0x0000A58D0151E98E AS DateTime), CAST(0x0000A58D0151E98E AS DateTime), N'admin', N'admin', N'True', N'admin', N'TESTBRANCH')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (18, 0.0000, N'20160114203101585', N'SAVINGS', N'TESTBANK', CAST(0x0000A58D01521C8F AS DateTime), CAST(0x0000A58D01521C8F AS DateTime), N'admin', N'admin', N'True', N'admin', N'TESTBRANCH')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (19, 0.0000, N'20160119105834231', N'SAVINGS', N'TESTBANK', CAST(0x0000A59200B4E2FF AS DateTime), CAST(0x0000A59200B4E2FF AS DateTime), N'admin', N'admin', N'0', NULL, N'TESTBRANCH')
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (7, 0.0000, N'395101', N'TELLER ACCOUNT', N'testbank', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (8, 0.0000, N'659117', N'TELLER ACCOUNT', N'testbank', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (9, 0.0000, N'189122', N'TELLER ACCOUNT', N'testbank', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (10, 0.0000, N'75146', N'TEST', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (11, 0.0000, N'482136', N'TEST', N'TESTBANK', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (16, 5000.0000, N'20160104221033790', N'SAVINGS', N'TESTBANK', CAST(0x0000A583016D7608 AS DateTime), CAST(0x0000A583016D7608 AS DateTime), N'admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[BankAccounts] ([AccountId], [AccBalance], [AccNumber], [AccType], [BankCode], [CreatedOn], [ModifiedOn], [ModifiedBy], [CreatedBy], [IsActive], [ApprovedBy], [BranchCode]) VALUES (20, 0.0000, N'20160120125415093', N'TELLER_ACCOUNT', N'Bank3', CAST(0x0000A59300D4A977 AS DateTime), CAST(0x0000A59300D4A977 AS DateTime), N'dennis.mushabe@pegasustechnologies.co.ug', N'dennis.mushabe@pegasustechnologies.co.ug', N'0', NULL, N'Branch1')
SET IDENTITY_INSERT [dbo].[BankAccounts] OFF
/****** Object:  StoredProcedure [dbo].[AccountTypes_Update]    Script Date: 01/26/2016 00:57:05 ******/
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
	@IsActive bit
As
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
		IsActive=@IsActive
	Where		
		BankCode=@BankCode and AccTypeCode=@AccTypeCode
		
		Select @AccTypeCode as InseretedId
End
Else
Begin
	Insert Into AccountTypes
		([AccTypeName],[AccTypeCode],[MinimumBal],[BankCode],[IsDebitable],Description,ModifiedBy,CreatedBy,ModifiedOn,CreatedOn,IsActive)
	Values
		(@AccTypeName,@AccTypeCode,@MinimumBal,@BankCode,@IsDebitable,@Description,@ModifiedBy,@ModifiedBy,GETDATE(),GETDATE(),@IsActive)

	select @AccTypeCode as InsertedId
End
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_Insert]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Accounts_UpdateReturnAccountId]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_UpdateReturnAccountId]	@AccountId int,	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50)ASDeclare @Ret int;IF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	SET @AccNumber = dbo.fn_GetAccountNo(GETDATE())	INSERT INTO BankAccounts (		[AccBalance],		[UserId],		[AccNumber],		[AccType],		BankCode	)	VALUES (		0,		@UserId,		@AccNumber,		@AccType,		@BankCode	)			SELECT @Ret = SCOPE_IDENTITY() 	return @RetENDELSE BEGIN	UPDATE BankAccounts SET 		[UserId] = @UserId,		[AccType] = @AccType,		BankCode = @BankCode	WHERE AccNumber = @AccNumber		SELECT @Ret=AccountId from BankAccounts where AccNumber= @AccNumber	return @RetEND
GO
/****** Object:  StoredProcedure [dbo].[Accounts_Update]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_Update]	@AccountId varchar(50),	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50),	@ModifiedBy varchar(50),	@BranchCode varchar(50),	@IsActive bitASBEGIN TRANSACTION CreateAccountBEGIN TRYIF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode,		CreatedOn,		ModifiedOn,		CreatedBy,		ModifiedBy,		BranchCode,		IsActive	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode,		GETDATE(),		GETDATE(),		@ModifiedBy,		@ModifiedBy,		@BranchCode,		@IsActive	)	INSERT INTO [dbo].[UsersToAccounts]
           ([UserId]
           ,[AccountNumber]
           ,BankCode)
     VALUES
           (@UserId
           ,@AccNumber           ,@BankCode)		SELECT @AccNumber As InsertedID	ENDELSE BEGIN	UPDATE BankAccounts SET		[AccType] = @AccType,		ModifiedOn=GETDATE(),		ModifiedBy=@ModifiedBy,		IsActive=@IsActive	WHERE AccNumber = @AccNumber and BankCode=@BankCode	SELECT @AccNumber As InsertedIDENDCOMMIT TRANSACTION CreateAccountEND TRYBEGIN CATCH
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
/****** Object:  StoredProcedure [dbo].[Accounts_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectRow]	@AccountNumber varchar(50),	@BankCode varchar(50)ASSET NOCOUNT ONSELECT * FROM BankAccounts Ainner join UsersToAccounts B on (A.AccNumber=B.AccountNumber and A.BankCode=B.BankCode)WHERE A.AccNumber=@AccountNumber and A.BankCode=@BankCodeSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Accounts_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankAccounts Ainner join UsersToAccounts B on A.AccNumber=B.AccountNumberSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Accounts_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_DeleteRow]	@AccountId intASSET NOCOUNT ONDELETE FROM BankAccountsWHERE [AccountId] = @AccountIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_Update]    Script Date: 01/26/2016 00:57:05 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_Insert]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_Update]    Script Date: 01/26/2016 00:57:05 ******/
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
	@CreatedOn datetime,
	@ModifiedOn datetime,
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50)
As
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
		[CreatedBy] = @CreatedBy,
		[ModifiedBy] = @ModifiedBy
	Where		
		[BranchId] = @BranchId
		Select @BranchCode as InsertedId

End
Else
Begin
	Insert Into BankBranches
		([BranchName],[BranchCode],[Location],IsActive,[BankCode],[CreatedOn],[ModifiedOn],[CreatedBy],[ModifiedBy])
	Values
		(@BranchName,@BranchCode,@Location,@IsActive,@BankCode,GETDATE(),GETDATE(),@CreatedBy,@ModifiedBy)

	Select  @BranchCode as InsertedId	
End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
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
Create Procedure [dbo].[BankBranches_SelectRow]
	@BranchId int
As
Begin
	Select 
		*
	From BankBranches
	Where
		[BranchId] = @BranchId
End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_Insert]    Script Date: 01/26/2016 00:57:05 ******/
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
	@BranchManagerId nvarchar(50),
	@BankCode nvarchar(50),
	@CreatedOn datetime,
	@ModifiedOn datetime,
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50)
As
Begin
	Insert Into BankBranches
		([BranchName],[BranchCode],[Location],[BranchManagerId],[BankCode],[CreatedOn],[ModifiedOn],[CreatedBy],[ModifiedBy])
	Values
		(@BranchName,@BranchCode,@Location,@BranchManagerId,@BankCode,@CreatedOn,@ModifiedOn,@CreatedBy,@ModifiedBy)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[BankBranches_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_Insert]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_Update]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectAll]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_Insert]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_DeleteRow]    Script Date: 01/26/2016 00:57:05 ******/
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
/****** Object:  StoredProcedure [dbo].[Customers_Update]    Script Date: 01/26/2016 00:57:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_Update]	@UserId varchar(50),
	@Email varchar(50),
	@Fullname varchar(50),
	@Usertype varchar(50),
	@Password varchar(50),
	@IsActive bit,
	@BankCode varchar(50),
	@CreatedBy varchar(50),
	@ModifiedBy varchar(50),
	@CanHaveAccount bit,
	@PhoneNumber varchar(50),
	@BranchCode varchar(50),
	@DateOfBirth varchar(50),
	@Gender varchar(50),
	@TranAmountLimit varchar(50),
	@PathToProfilePic varchar(50),
	@PathToSignature varchar(50)
As
IF not exists(Select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode)
Begin
	Insert Into BankSystemUsers
		(UserId,Email,[Fullname],[Usertype],
		[Password],[IsActive],BankCode,RecordDate,
		LastUpdateDate,CreatedBy,ModifiedBy,CanHaveAccount,PhoneNumber,BranchCode,DateOfBirth,Gender,TranAmountLimit,PathToProfilePic,PathToSignature)
	Values
		(@UserId,@Email,@Fullname,@Usertype,
		 @Password,@IsActive,@BankCode,GETDATE(),
		 GETDATE(),@CreatedBy,@ModifiedBy,@CanHaveAccount,@PhoneNumber,@BranchCode,@DateOfBirth,@Gender,@TranAmountLimit,@PathToProfilePic,@PathToSignature)
	Select @UserId as InsertedId
End
Begin
	Update BankSystemUsers
	Set
		[Fullname] = @Fullname,
		[Usertype] = @Usertype,
		[Password] = @Password,
		[IsActive] = @IsActive,
		BankCode=@BankCode,
		LastUpdateDate=GETDATE(),
		ModifiedBy=@ModifiedBy,
		CanHaveAccount=@CanHaveAccount,
		PhoneNumber=@PhoneNumber,
		BranchCode=@BranchCode,
		DateOfBirth=@DateOfBirth,
		Gender=@Gender,
		TranAmountLimit=@TranAmountLimit,
		PathToProfilePic=@PathToProfilePic
	Where		
		UserId = @UserId and BankCode=@BankCode
	Select @UserId as InsertedId

End
GO
/****** Object:  StoredProcedure [dbo].[Customers_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectRow]	@CustomerId intASSET NOCOUNT ONSELECT * FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankCustomersSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_DeleteRow]	@CustomerId intASSET NOCOUNT ONDELETE FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[CheckIfItViolatesRules]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[Charges_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
	@ChargeId int
As
Begin
	Select 
	*
	From BankCharges
	Where
		[ChargeId] = @ChargeId
End
GO
/****** Object:  StoredProcedure [dbo].[Charges_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
		([ChargeAmount],[CommissionAccount],[TranType],[IsDebit],[BankCode])
	Values
		(@ChargeAmount,@CommissionAccount,@TranType,@IsDebit,@BankCode)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[Charges_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Banks_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectRow]	@BankCode varchar(50)ASSET NOCOUNT ONSELECT * FROM BanksWHERE ((BankCode=@BankCode) or (@BankCode='ALL'))SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Banks_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectAll]ASSET NOCOUNT ONSELECT * FROM BanksSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[SearchUserTypesTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchTransactionRequestsTable]    Script Date: 01/26/2016 00:57:06 ******/
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
Select RecordId as BankTranId,CustomerName,ToAccount,FromAccount,TranAmount,TranCategory,PaymentDate
from TransactionRequests where
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
GO
/****** Object:  StoredProcedure [dbo].[SearchTransactionCategoriesTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchGeneralLedgerTable]    Script Date: 01/26/2016 00:57:06 ******/
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
Select PegPayTranId,BankTranId,AccountNumber,TranAmount,TranType,TranCategory,PaymentDate,AccountBalBefore,AccountBalAfter from GeneralLedgerTable where
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
GO
/****** Object:  StoredProcedure [dbo].[SearchBankUsersTable]    Script Date: 01/26/2016 00:57:06 ******/
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
(Usertype=@UserType or @UserType='') and
BankCode=@bankCode or @bankCode='ALL' and
Fullname like '%'+@Name+'%'
GO
/****** Object:  StoredProcedure [dbo].[SearchBanksTable]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SearchBanksTable]
@bankCode varchar(50)
as
Select BankCode as id,BankName,BankCode,BankContactEmail,IsActive from Banks where 
(BankCode=@bankCode or @bankCode='ALL')
GO
/****** Object:  StoredProcedure [dbo].[SearchBankChargesTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankBranchesTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankAccountsTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchAccountTypesTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchAccountsTable]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[SaveTranRequest]    Script Date: 01/26/2016 00:57:06 ******/
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
@Narration varchar(50)
as
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
           ,[Narration])
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
           @Narration)
           
 Select SCOPE_IDENTITY() as InsertedId
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
	@CanHaveAccount bit,
	@PhoneNumber varchar(50),
	@BranchCode varchar(50),
	@DateOfBirth varchar(50),
	@Gender varchar(50),
	@TranAmountLimit varchar(50)
As
IF not exists(Select * from BankSystemUsers where UserId=@UserId and BankCode=@BankCode)
Begin
	Insert Into BankSystemUsers
		(UserId,Email,[Fullname],[Usertype],
		[Password],[IsActive],BankCode,RecordDate,
		LastUpdateDate,CreatedBy,ModifiedBy,CanHaveAccount,PhoneNumber,BranchCode,DateOfBirth,Gender,TranAmountLimit,PathToProfilePic,PathToSignature)
	Values
		(@UserId,@Email,@Fullname,@Usertype,
		 @Password,@IsActive,@BankCode,GETDATE(),
		 GETDATE(),@CreatedBy,@ModifiedBy,@CanHaveAccount,@PhoneNumber,@BranchCode,@DateOfBirth,@Gender,@TranAmountLimit,'','')
	Select @UserId as InsertedId
End
Begin
	Update BankSystemUsers
	Set
		[Fullname] = @Fullname,
		[Usertype] = @Usertype,
		[Password] = @Password,
		[IsActive] = @IsActive,
		BankCode=@BankCode,
		LastUpdateDate=GETDATE(),
		ModifiedBy=@ModifiedBy,
		CanHaveAccount=@CanHaveAccount,
		PhoneNumber=@PhoneNumber,
		BranchCode=@BranchCode,
		DateOfBirth=@DateOfBirth,
		Gender=@Gender,
		TranAmountLimit=@TranAmountLimit
	Where		
		UserId = @UserId and BankCode=@BankCode
	Select @UserId as InsertedId

End
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
		([Username],[Fullname],[Usertype],[Password],[IsActive])
	Values
		(@Username,@Fullname,@Usertype,@Password,@IsActive)

	Declare @ReferenceID int
	Select @ReferenceID = @@IDENTITY

	Return @ReferenceID

End
GO
/****** Object:  StoredProcedure [dbo].[Users_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateUserIsActiveStatus]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateTransacttionApprovalStatus]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateBankTransactionStatus]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateBankTransactionStatus]
@BankId varchar(50),
@BankCode varchar(50),
@PegPayId varchar(50)
as
Update TransactionRequests set Status='SUCCESS',Reason=@PegPayId where RecordId=@BankId and BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[UpdateBankAccountsIsActiveStatus]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
	@ModifiedOn datetime,
	@ModifiedBy varchar(50),
	@Approver varchar(50)
As
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

End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
Create Procedure [dbo].[TransactionRules_SelectRow]
	@RecordId int
As
Begin
	Select 
		*
	From TransactionRules
	Where
		[RecordId] = @RecordId
End
GO
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UsersToAccounts_Insert]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[UsersToAccounts_Insert]
@UserId varchar(50),
@AccountNumber varchar(50),
@BankCode varchar(50)
as
INSERT INTO [TestCoreBankingDB].[dbo].[UsersToAccounts]
           ([UserId]
           ,[AccountNumber]
           ,[BankCode])
     VALUES
           (@UserId
           ,@AccountNumber
           ,@BankCode)
GO
/****** Object:  StoredProcedure [dbo].[GetUserTypesByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUserTypesByBankCode]
@bankCode varchar(50)
as
Select * from UserTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionTypesByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTransactionRequestDetails]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTransactionRequest]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetCommissionAccountsByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[GetCommissionAccountsByBankCode]
	@bankcode varchar(50)
As
Begin
	Select *
	From BankAccounts
	Where
		BankCode=@bankcode and AccType='COMMISSION'
End
GO
/****** Object:  StoredProcedure [dbo].[GetChargeTypesByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetChargeTypesByBankCode]
@bankCode varchar(50)
as
Select * from ChargeTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankUsersPendingApproval]    Script Date: 01/26/2016 00:57:06 ******/
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
((Fullname like '%'+@name+'%') or @name='') and
(BankCode=@bankCode or @bankCode='ALL') and
(BranchCode=@branchCode or @branchCode='ALL') and
(RecordDate>=@fromDate or @fromDate='') and
(RecordDate<=@toDate or @toDate='') and 
IsActive=0
GO
/****** Object:  StoredProcedure [dbo].[GetBankBranchesByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBankBranchesByBankCode]
@bankCode varchar(50)
as
Select * from BankBranches where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankAccountsPendingApproval]    Script Date: 01/26/2016 00:57:06 ******/
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
inner join UsersToAccounts B on A.AccNumber=B.AccountNumber
inner join BankSystemUsers C on C.UserId=B.UserId 
where 
(A.BankCode=@BankCode) and
(A.BranchCode=@BranchCode or @BranchCode='ALL') and
(AccNumber=@AccountNumber or @AccountNumber='') and
((B.UserId like '%'+@Custname+'%') or @Custname='') and
(CreatedOn>=@fromDate or @fromDate='') and
(CreatedOn<=@toDate or @toDate='') and 
(A.ApprovedBy='' or (A.ApprovedBy is NULL))
GO
/****** Object:  StoredProcedure [dbo].[GetAllBanks]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAllBanks]
as
Select * from Banks
GO
/****** Object:  StoredProcedure [dbo].[GetAccountTypesByBankCode]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAccountTypesByBankCode]
@bankCode varchar(50)
as
Select * from AccountTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetAccountStatement]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAccountsByUserId]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAccountsByUserId]
@UserId varchar(50)
as
Select * from BankAccounts A
inner join UsersToAccounts B on A.AccNumber=B.AccountNumber
where 
UserId=@UserId
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
	@BankCode varchar(50)
As
IF not exists(Select * from UserTypes where UserType=@UserType and BankCode=@BankCode)
Begin
	Insert Into UserTypes
		([UserType],[Role],[Description],BankCode)
	Values
		(@UserType,@Role,@Description,@BankCode)
	Select @UserType as InsertedId
End
Begin
	Update UserTypes
	Set
		[UserType] = @UserType,
		[Role] = @Role,
		[Description] = @Description,
		BankCode=@BankCode
	Where		
		 UserType=@UserType and BankCode=@BankCode
	Select @UserType as InsertedId

End
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectAll]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_Insert]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_DeleteRow]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[IsValidBankRef]    Script Date: 01/26/2016 00:57:06 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertTranIntoGeneralLedger]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertTranIntoGeneralLedger]@CustomerName varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50)as--This Stored Procedure will move money between any 2 accounts--NB: This stored Procedure has no try cacth(Intentionally) because its not meant to be called directly by code--Stored proc with the try catch is InsertReceivedTransactionWithCharges and its the one meant--to be called to do the work--this procedure was separated from the one above mainly for readabilityDeclare @AccountType varchar(50);Declare @MinimumFromAccBal money;Declare @toAccBalBefore money;Declare @toAccBalAfter money;Declare @fromAccBalBefore money;Declare @fromAccBalAfter money;Declare @ErrorMsg varchar(1200);DECLARE @ReturnValue int;DECLARE @RecordId1 varchar(50);DECLARE @RecordId2 varchar(50);DECLARE @PegPayTranId varchar(50);--------------------------------------------set some globalsSelect @toAccBalBefore = AccBalance from BankAccounts where AccNumber=@toAccount and BankCode=@BankCodeSelect @fromAccBalBefore =  AccBalance from BankAccounts where AccNumber=@fromAccount and BankCode=@BankCodeSelect @AccountType = AccType from BankAccounts where AccNumber=@fromAccount and BankCode=@BankCodeSelect @MinimumFromAccBal =  MinimumBal from AccountTypes where AccTypeName=@AccountType and BankCode=@BankCode--if no minimum balance is found--set it to 0IF(@MinimumFromAccBal='' or @MinimumFromAccBal is NULL )BEGIN	Set @MinimumFromAccBal=0END--------------------------------------------------------Validate the data--Is to account same as from accountif(@toAccount=@fromAccount)BEGINset @ErrorMsg='TO ['+@toAccount+'] AND FROM ['+@fromAccount+'] ACCOUNT CANNOT BE THE SAME';
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
               );RETURNEND--====================================================================------AT THIS STAGE ALL DATA SHOULD BE VALID--if the account on the from account is --less than the total transaction amount---------------------------------------------------calculate new balance for each accountSet @fromAccBalAfter=@fromAccBalBefore-@TranAmount;Set @toAccBalAfter=@toAccBalBefore+@TranAmount;----------------------------if(@fromAccBalAfter>@MinimumFromAccBal)BEGIN			--Update account balances	Update BankAccounts set AccBalance=@fromAccBalAfter where AccNumber=@fromAccount and BankCode=@BankCode	Update BankAccounts set AccBalance=@toAccBalAfter where AccNumber=@toAccount and BankCode=@BankCode		--Insert Credit	INSERT INTO GeneralLedgerTable (		    [PegPayTranId]
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
           ,[BranchCode]           ,Narration	)	VALUES (			'',			@CustomerName,			@toAccount,			'',			@fromAccount,			@TranAmount,			@VendorTranId,			'CREDIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@toAccBalBefore,			@toAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration	)		Set @RecordId1=SCOPE_IDENTITY()		--Insert Debit	INSERT INTO GeneralLedgerTable (		    [PegPayTranId]
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
           ,[BranchCode]           ,Narration	)	VALUES (			'',			@CustomerName,			@fromAccount,			@toAccount,			'',			@TranAmount,			@VendorTranId,			'DEBIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@fromAccBalBefore,			@fromAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration		)			--Declare @RowId	Set @RecordId2=SCOPE_IDENTITY()	SET @PegPayTranId=dbo.fn_GetReceiptno(@RecordId1)		Update GeneralLedgerTable set PegPayTranId=@PegPayTranId where RecordId=@RecordId1 or RecordId=@RecordId2	Select @PegPayTranId as InsertedId	END---------------------------------------------ELSEBEGIN--return error message
set @ErrorMsg='INSUFFICIENT FUNDS ON FROM ACCOUNT ['+@fromAccount+']';
RAISERROR (@ErrorMsg, -- Message text.
               16, -- Severity.
               1 -- State.
               );RETURNEND------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[InsertReceivedTransactionWithCharges]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery12.sql|7|0|C:\Users\home\AppData\Local\Temp\~vs3A0D.sql
--DECLARE
--@CustomerName varchar(50)='TEST',--@CustomerId varchar(50)='1',--@toAccount varchar(50)='0140586848602',--@fromAccount varchar(50)='0140586848601',--@TranAmount money=1100,--@VendorTranId varchar(50)='TEST-0025',--@PaymentDate datetime='2015-12-20 00:00:00.000',--@Teller varchar(50)='TEST',--@ApprovedBy varchar(50)='TEST',--@BankCode varchar(50)='TESTBANK',--@Narration varchar(50)='TEST',--@TranType varchar(50)='TEST';
CREATE proc [dbo].[InsertReceivedTransactionWithCharges]
@CustomerName varchar(50),@CustomerId varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50)as
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
											@BranchCode;

--------------------------------------------------------------------
--Insert Charges
Declare @Id int;
DECLARE @chargeAmount int
DECLARE @commissionAcc varchar(100)
DECLARE @ChargeCode varchar(50)

--drop temp table
if object_id('tempdb..#Temp1') is not null
    drop table #Temp1


--pick all applicable charges from charges table
Select *
Into   #Temp1
From   BankCharges where TransCategory=@TranCategory and IsActive=1


--loop through the charges
While (Select Count(*) From #Temp1) > 0
Begin
	--pick 1 charge
	Select Top 1 @Id = #Temp1.ChargeId,@chargeAmount=#Temp1.ChargeAmount,
				 @commissionAcc=#Temp1.CommissionAccount,@ChargeCode=#Temp1.ChargeCode From #Temp1
	
	--apply charge
    EXEC @PegPayId=InsertTranIntoGeneralLedger @CustomerName,											   @commissionAcc,--com Acc											   @fromAccount,											   @chargeAmount,--chargeAmnt											   @VendorTranId,											   @PaymentDate,											   @Teller,											   @ApprovedBy,											   @BankCode,											   @ChargeCode,											   @TranCategory,
											   @BranchCode;
	--delete charge							
    Delete #Temp1 Where #Temp1.ChargeId = @Id
END
Select PegPayTranId as PegPayId from GeneralLedgerTable where BankCode=@BankCode and BankTranId=@VendorTranId
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
/****** Object:  StoredProcedure [dbo].[ReverseTransaction]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DECLARE--@VendorTranId varchar(50)='TEST-0039',--@BankCode varchar(50)='TESTBANK';
CREATE proc [dbo].[ReverseTransaction]
@VendorTranId varchar(50),@BankCode varchar(50)as
---------------------------------------------------------------------
--Lets start
BEGIN Transaction Trans
BEGIN TRY
------------------------------
Declare @PegPayId int,
@CustomerName varchar(50),@CustomerId varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@Narration varchar(50),@BranchCode varchar(50),
@TranCategory varchar(50),
@PegPayTranId varchar(50);
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
			@PegPayTranId=#Temp1.PegPayTranId
		From #Temp1
		
		SET @Narration='REVERSAL OF '+@PegPayTranId
		
		--move money back to original account
		EXEC @PegPayId=InsertTranIntoGeneralLedger @CustomerName,													@fromAccount,--swap to account and from account													@toAccount,--swap to account and from account													@TranAmount,													@VendorTranId,													@PaymentDate,													@Teller,													@ApprovedBy,													@BankCode,													@Narration,													@TranCategory,
													@BranchCode;
										
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
/****** Object:  StoredProcedure [dbo].[BankTellers_Update]    Script Date: 01/26/2016 00:57:06 ******/
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
	@Email varchar(50),
    @FullName varchar(50),
    @Usertype varchar(50),
    @Password varchar(50),
    @IsActive varchar(50),
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50),
    @CanHaveAccount varchar(50),
    @BranchCode varchar(50),
    @DateOfBirth varchar(50),
    @PhoneNumber varchar(50),
    @Gender varchar(50),
	@AccountNumber varchar(50),
	@BankCode varchar(50)
As
Begin Transaction trans
Begin try				  
   --if teller doesnt exist create him					 
	Declare @AccountId int;
	
	--update user if he exists else create user
	EXEC Users_Update  0,@Email,@Fullname,@UserType,
				   @Password,@IsActive,@BankCode,
				   @CreatedBy,@ModifiedBy,@CanHaveAccount
	
	if exists(Select * from BankAccounts where UserId=@Email and BankCode=@BankCode)
		Begin
			--return teller Account Number
		   Select @AccountNumber=AccNumber from BankAccounts where UserId=@Email and BankCode=@BankCode
		   select @AccountNumber as InsertedId
		End
	Else
		Begin
			--create teller account
			EXEC @AccountId=dbo.Accounts_UpdateReturnAccountId 0,0,@Email,
							 '','TELLER ACCOUNT',@BankCode
							 
			--get account number of created account
			Select AccNumber as InsertedId from BankAccounts where AccountId=@AccountId
		End
Commit Transaction trans
End try
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
/****** Object:  StoredProcedure [dbo].[Banks_Update]    Script Date: 01/26/2016 00:57:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_Update]	@BankId varchar(50),	@BankName varchar(50),	@BankCode varchar(50),	@BankContactEmail varchar(50),	@BankPassword varchar(50),	@IsActive varchar(50),	@ModifiedBy varchar(50),	@PathToLogoImage varchar(1300),	@PathToPublicKey varchar(1300)ASBEGIN TRANSACTION BankUpdaterBEGIN TRYIF not exists(Select * from Banks where (BankCode=@BankCode or BankId=@BankId)) BEGIN	INSERT INTO Banks (		[BankName],		[BankCode],		[BankContactEmail],		BankPassword,		IsActive,		CreatedOn,		LastUpdateDate,		PathToLogoImage,		PathToPublicKey	)	VALUES (		@BankName,		@BankCode,		@BankContactEmail,		@BankPassword,		@IsActive,		GETDATE(),		GETDATE(),		@PathToLogoImage,		@PathToPublicKey	)		--create default user types for Bank	EXEC dbo.UserTypes_Update '','BANK_ADMIN','Banks IT Admin','Banks IT Admin',@BankCode 	EXEC dbo.UserTypes_Update '','MANAGER','Branch Manager','Branch Manager',@BankCode	EXEC dbo.UserTypes_Update '','CUSTOMER','Banks Customer','Banks Customer',@BankCode	EXEC dbo.UserTypes_Update '','TELLER','Bank Teller','Bank Teller',@BankCode	EXEC dbo.UserTypes_Update '','SUPERVISOR_TELLER','Teller Supervisor','Teller Supervisor',@BankCode	EXEC dbo.UserTypes_Update '','CUSTOMER_SERVICE','Customer Service','Customer Service',@BankCode	EXEC dbo.UserTypes_Update '','BUSSINESS_ADMIN','Bussiness Admin','Bussiness Admin',@BankCode			----set default access rules for the users	DECLARE @date DATETIME
    SET @date = GETDATE()	EXEC dbo.AccessRules_Update '','Bank Admin Rule','BANK_ADMIN',@BankCode,'BANK_ADMIN,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Manager Rule','MANAGER',@BankCode,'MANAGER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Teller Rule','TELLER',@BankCode,'TELLER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Supervisor Rule','SUPERVISOR_TELLER',@BankCode,'SUPERVISOR,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Customer Service Rule','CUSTOMER_SERVICE',@BankCode,'CUSTOMER_SERVICE,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Bussiness Admin Rule','BUSSINESS_ADMIN',@BankCode,'BUSSINESS_ADMIN,REPORTS','','','True',@date,@ModifiedBy		--create default transaction Categories	EXEC dbo.TransactionTypes_Update '','WITHDRAW','WITHDRAW OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','DEPOSIT','DEPOSIT OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','INTERNAL_TRANSFER','AN INTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','EXTERNAL_TRANSFER','AN EXTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'		--create default Account Types	EXEC dbo.AccountTypes_Update '','COMMISSION ACCOUNT','COMMISSION_ACCOUNT',0,@BankCode,'True','Commission Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','TELLER ACCOUNT','TELLER_ACCOUNT',0,@BankCode,'True','Teller Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','SAVINGS ACCOUNT','SAVINGS_ACCOUNT',0,@BankCode,'True','Savings Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','CURRENT ACCOUNT','CURRENT_ACCOUNT',0,@BankCode,'True','Current Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','CORPORATE ACCOUNT','CORPORATE_ACCOUNT',0,@BankCode,'True','Corporate Account',@ModifiedBy,'True'			SELECT @BankCode As InsertedIDENDELSE BEGIN	UPDATE Banks SET 		[BankName] = @BankName,		[BankCode] = @BankCode,		[BankContactEmail] = @BankContactEmail,		IsActive=@IsActive,		LastUpdateDate=GETDATE(),		PathToLogoImage=@PathToLogoImage,		PathToPublicKey=@PathToPublicKey	WHERE BankCode = @BankCode	SELECT @BankCode As InsertedIDENDCOMMIT TRANSACTION BankUpdaterEND TRYBEGIN CATCHROLLBACK Transaction BankUpdater

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
