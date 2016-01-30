USE [master]
GO
/****** Object:  Database [TestCoreBankingDB]    Script Date: 01/30/2016 23:40:53 ******/
CREATE DATABASE [TestCoreBankingDB] ON  PRIMARY 
( NAME = N'TestCoreBankingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.KASOZIDB\MSSQL\DATA\TestCoreBankingDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestCoreBankingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.KASOZIDB\MSSQL\DATA\TestCoreBankingDB_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[TransactionRules]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[TransactionRequests]    Script Date: 01/30/2016 23:40:54 ******/
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
	[CurrencyCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionCategories]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[UsersToAccounts]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[CustomerTypes]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[UserTypes]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[BankTypes]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[Currencies]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[ChargeTypes]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[AccessAreas]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[GeneralLedgerTable]    Script Date: 01/30/2016 23:40:54 ******/
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
	[ValueInLocalCurrencyTranAmount] [money] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetReceiptno]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetAccountNo]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[Errorlogs]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[BankTellers]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  Table [dbo].[BankSystemUsers]    Script Date: 01/30/2016 23:40:54 ******/
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
/****** Object:  StoredProcedure [dbo].[Banks_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_DeleteRow]	@BankId intASSET NOCOUNT ON
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[BankCustomers]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[BankCharges]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[AccessRules]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[BankBranches]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[BankAccountSignatories]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 01/30/2016 23:40:56 ******/
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
	[BranchCode] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccountTypes_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Accounts_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectRow]	@AccountNumber varchar(50),	@BankCode varchar(50)ASSET NOCOUNT ONSELECT * FROM BankAccounts Ainner join UsersToAccounts B on (A.AccNumber=B.AccountNumber and A.BankCode=B.BankCode)WHERE A.AccNumber=@AccountNumber and A.BankCode=@BankCodeSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Accounts_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankAccounts Ainner join UsersToAccounts B on A.AccNumber=B.AccountNumberSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Accounts_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_DeleteRow]	@AccountId intASSET NOCOUNT ONDELETE FROM BankAccountsWHERE [AccountId] = @AccountIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[AccessRules_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessRules_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[AccessAreas_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankBranches_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserTypesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUserTypesByBankCode]
@bankCode varchar(50)
as
Select * from UserTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionTypesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTransactionRequestDetails]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTransactionRequest]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTransactionByBankId]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetCurrenciesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetCurrenciesByBankCode]
@BankCode varchar(50)
as
Select * from Currencies where BankCode=@BankCode
GO
/****** Object:  StoredProcedure [dbo].[GetCommissionAccountsByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetChargeTypesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetChargeTypesByBankCode]
@bankCode varchar(50)
as
Select * from ChargeTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankUsersPendingApproval]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetBankBranchesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBankBranchesByBankCode]
@bankCode varchar(50)
as
Select * from BankBranches where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetBankAccountsPendingApproval]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllBanks]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAllBanks]
as
Select BankName,BankCode,BankContactEmail,IsActive,PathToLogoImage,PathToPublicKey
 from Banks
GO
/****** Object:  StoredProcedure [dbo].[GetAccountTypesByBankCode]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetAccountTypesByBankCode]
@bankCode varchar(50)
as
Select * from AccountTypes where BankCode=@bankCode
GO
/****** Object:  StoredProcedure [dbo].[GetAccountStatement]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAccountSignatories]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAccountsByUserId]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CustomerTypes_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Accounts_UpdateReturnAccountId]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_UpdateReturnAccountId]	@AccountId int,	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50)ASDeclare @Ret int;IF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	SET @AccNumber = dbo.fn_GetAccountNo(GETDATE())	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode	)			SELECT @Ret = SCOPE_IDENTITY() 	return @RetENDELSE BEGIN	UPDATE BankAccounts SET		[AccType] = @AccType,		BankCode = @BankCode	WHERE AccNumber = @AccNumber		SELECT @Ret=AccountId from BankAccounts where AccNumber= @AccNumber	return @RetEND
GO
/****** Object:  StoredProcedure [dbo].[Charges_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Charges_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[CheckIfItViolatesRules]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[ChargeTypes_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[Banks_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectRow]	@BankCode varchar(50)ASSET NOCOUNT ONSELECT * FROM BanksWHERE ((BankCode=@BankCode) or (@BankCode='ALL'))SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Banks_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_SelectAll]ASSET NOCOUNT ONSELECT * FROM BanksSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[UsersToAccounts_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Customers_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Customers_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectRow]	@CustomerId intASSET NOCOUNT ONSELECT * FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_SelectAll]ASSET NOCOUNT ONSELECT * FROM BankCustomersSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Customers_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Customers_DeleteRow]	@CustomerId intASSET NOCOUNT ONDELETE FROM BankCustomersWHERE [CustomerId] = @CustomerIdSET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[Currencies_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Users_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateUserIsActiveStatus]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateTransacttionApprovalStatus]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateBankTransactionStatus]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateBankAccountsIsActiveStatus]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionTypes_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[TransactionRules_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchUserTypesTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchTransactionRequestsTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchTransactionCategoriesTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchGeneralLedgerTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankUsersTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBanksTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankChargesTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankBranchesTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchBankAccountsTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchAccountTypesTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SearchAccountsTable]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[SaveTranRequest]    Script Date: 01/30/2016 23:40:56 ******/
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
@CurrencyCode varchar(50)
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
           ,[Narration]
           ,CurrencyCode)
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
           @CurrencyCode)
           
 Select SCOPE_IDENTITY() as InsertedId
GO
/****** Object:  StoredProcedure [dbo].[UserTypes_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_SelectAll]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_Insert]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[UserTypes_DeleteRow]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[IsValidBankRef]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertTranIntoGeneralLedger]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertTranIntoGeneralLedger]@CustomerName varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50),@CurrecnyTranAmount varchar(50)as--This Stored Procedure will move money between any 2 accounts--NB: This stored Procedure has no try cacth(Intentionally) because its not meant to be called directly by code--Stored proc with the try catch is InsertReceivedTransactionWithCharges and its the one meant--to be called to do the work--this procedure was separated from the one above mainly for readabilityDeclare @AccountType varchar(50);Declare @MinimumFromAccBal money;Declare @toAccBalBefore money;Declare @toAccBalAfter money;Declare @fromAccBalBefore money;Declare @fromAccBalAfter money;Declare @ErrorMsg varchar(8000);DECLARE @ReturnValue int;DECLARE @RecordId1 varchar(50);DECLARE @RecordId2 varchar(50);DECLARE @PegPayTranId varchar(50);Declare @CurrecnyOfFromAcc varchar(50);
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
           ,[BranchCode]           ,Narration           ,ValueInLocalCurrencyFromAccount           ,ValueInLocalCurrencytoAccount           ,ValueInLocalCurrencyTranAmount           ,CurrencyCode	)	VALUES (			'',			@CustomerName,			@toAccount,			'',			@fromAccount,			@TranAmount,			@VendorTranId,			'CREDIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@toAccBalBefore,			@toAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration,			@ValueInLocalCurrencyFromAccount,			@ValueInLocalCurrencytoAccount,			@ValueInLocalCurrencyTranAmount,			@CurrecnyTranAmount	)		Set @RecordId1=SCOPE_IDENTITY()		--Insert Debit	INSERT INTO GeneralLedgerTable (		    [PegPayTranId]
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
           ,[BranchCode]           ,Narration           ,ValueInLocalCurrencyFromAccount           ,ValueInLocalCurrencytoAccount           ,ValueInLocalCurrencyTranAmount           ,CurrencyCode	)	VALUES (			'',			@CustomerName,			@fromAccount,			@toAccount,			'',			@TranAmount,			@VendorTranId,			'DEBIT',			@TranCategory,			@PaymentDate,			GETDATE(),			@fromAccBalBefore,			@fromAccBalAfter,			@Teller,			@ApprovedBy,			@BankCode,			@BranchCode,			@Narration,			@ValueInLocalCurrencyFromAccount,			@ValueInLocalCurrencytoAccount,			@ValueInLocalCurrencyTranAmount,			@CurrecnyTranAmount	)			--Generate PegPayId	Set @RecordId2=SCOPE_IDENTITY()	SET @PegPayTranId=dbo.fn_GetReceiptno(@RecordId1)		Update GeneralLedgerTable set PegPayTranId=@PegPayTranId where RecordId=@RecordId1 or RecordId=@RecordId2		--Before Updating to and from account balance after change the balance back to Actual Account Currency
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
/****** Object:  StoredProcedure [dbo].[InsertReversedTransaction]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[InsertReceivedTransactionWithCharges]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery12.sql|7|0|C:\Users\home\AppData\Local\Temp\~vs3A0D.sql
--DECLARE
--@CustomerName varchar(50)='TEST',--@CustomerId varchar(50)='1',--@toAccount varchar(50)='0140586848602',--@fromAccount varchar(50)='0140586848601',--@TranAmount money=1100,--@VendorTranId varchar(50)='TEST-0025',--@PaymentDate datetime='2015-12-20 00:00:00.000',--@Teller varchar(50)='TEST',--@ApprovedBy varchar(50)='TEST',--@BankCode varchar(50)='TESTBANK',--@Narration varchar(50)='TEST',--@TranType varchar(50)='TEST';
CREATE proc [dbo].[InsertReceivedTransactionWithCharges]
@CustomerName varchar(50),@CustomerId varchar(50),@toAccount varchar(50),@fromAccount varchar(50),@TranAmount money,@VendorTranId varchar(50),@PaymentDate datetime,@Teller varchar(50),@ApprovedBy varchar(50),@BankCode varchar(50),@Narration varchar(50),@TranCategory varchar(50),@BranchCode varchar(50),@Currency varchar(50)as
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
											@Currency;

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
											   @Currency;
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
/****** Object:  StoredProcedure [dbo].[ReverseTransaction]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[BankTellers_Update]    Script Date: 01/30/2016 23:40:56 ******/
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
/****** Object:  StoredProcedure [dbo].[Accounts_Update]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Accounts_Update]	@AccountId varchar(50),	@AccBalance money,	@UserId varchar(50),	@AccNumber varchar(50),	@AccType varchar(50),	@BankCode varchar(50),	@ModifiedBy varchar(50),	@BranchCode varchar(50),	@IsActive bit,	@CurrencyCode varchar(50)ASBEGIN TRANSACTION CreateAccountBEGIN TRYIF not exists(select * from BankAccounts where AccNumber=@AccNumber and BankCode=@BankCode)BEGIN	INSERT INTO BankAccounts (		[AccBalance],		[AccNumber],		[AccType],		BankCode,		CreatedOn,		ModifiedOn,		CreatedBy,		ModifiedBy,		BranchCode,		IsActive,		CurrencyCode	)	VALUES (		0,		@AccNumber,		@AccType,		@BankCode,		GETDATE(),		GETDATE(),		@ModifiedBy,		@ModifiedBy,		@BranchCode,		@IsActive,		@CurrencyCode	)	EXEC dbo.UsersToAccounts_Insert @UserId,@AccNumber,@BankCode		SELECT @AccNumber As InsertedID	ENDELSE BEGIN	UPDATE BankAccounts SET		[AccType] = @AccType,		ModifiedOn=GETDATE(),		ModifiedBy=@ModifiedBy,		IsActive=@IsActive	WHERE AccNumber = @AccNumber and BankCode=@BankCode	EXEC dbo.UsersToAccounts_Insert @UserId,@AccNumber,@BankCode	SELECT @AccNumber As InsertedIDENDCOMMIT TRANSACTION CreateAccountEND TRYBEGIN CATCH
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
/****** Object:  StoredProcedure [dbo].[Banks_Update]    Script Date: 01/30/2016 23:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Banks_Update]	@BankId varchar(50),	@BankName varchar(50),	@BankCode varchar(50),	@BankContactEmail varchar(50),	@BankPassword varchar(50),	@IsActive varchar(50),	@ModifiedBy varchar(50),	@PathToLogoImage varchar(1300),	@PathToPublicKey varchar(1300)ASBEGIN TRANSACTION BankUpdaterBEGIN TRYIF not exists(Select * from Banks where (BankCode=@BankCode or BankId=@BankId)) BEGIN	INSERT INTO Banks (		[BankName],		[BankCode],		[BankContactEmail],		BankPassword,		IsActive,		CreatedOn,		LastUpdateDate,		PathToLogoImage,		PathToPublicKey	)	VALUES (		@BankName,		@BankCode,		@BankContactEmail,		@BankPassword,		@IsActive,		GETDATE(),		GETDATE(),		@PathToLogoImage,		@PathToPublicKey	)		--create default user types for Bank	EXEC dbo.UserTypes_Update '','BANK_ADMIN','Banks IT Admin','Banks IT Admin',@BankCode 	EXEC dbo.UserTypes_Update '','MANAGER','Branch Manager','Branch Manager',@BankCode	EXEC dbo.UserTypes_Update '','CUSTOMER','Banks Customer','Banks Customer',@BankCode	EXEC dbo.UserTypes_Update '','TELLER','Bank Teller','Bank Teller',@BankCode	EXEC dbo.UserTypes_Update '','SUPERVISOR_TELLER','Teller Supervisor','Teller Supervisor',@BankCode	EXEC dbo.UserTypes_Update '','CUSTOMER_SERVICE','Customer Service','Customer Service',@BankCode	EXEC dbo.UserTypes_Update '','BUSSINESS_ADMIN','Bussiness Admin','Bussiness Admin',@BankCode			----set default access rules for the users	DECLARE @date DATETIME
    SET @date = GETDATE()	EXEC dbo.AccessRules_Update '','Bank Admin Rule','BANK_ADMIN',@BankCode,'BANK_ADMIN,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Manager Rule','MANAGER',@BankCode,'MANAGER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Teller Rule','TELLER',@BankCode,'TELLER,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Supervisor Rule','SUPERVISOR_TELLER',@BankCode,'SUPERVISOR,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Customer Service Rule','CUSTOMER_SERVICE',@BankCode,'CUSTOMER_SERVICE,REPORTS','','','True',@date,@ModifiedBy	EXEC dbo.AccessRules_Update '','Bussiness Admin Rule','BUSSINESS_ADMIN',@BankCode,'BUSSINESS_ADMIN,REPORTS','','','True',@date,@ModifiedBy		--create default transaction Categories	EXEC dbo.TransactionTypes_Update '','WITHDRAW','WITHDRAW OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','DEPOSIT','DEPOSIT OPERATION',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','INTERNAL_TRANSFER','AN INTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'	EXEC dbo.TransactionTypes_Update '','EXTERNAL_TRANSFER','AN EXTERNAL TRANSFER',@BankCode,@ModifiedBy,'True'		--create default Account Types	EXEC dbo.AccountTypes_Update '','COMMISSION ACCOUNT','COMMISSION_ACCOUNT',0,@BankCode,'True','Commission Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','TELLER ACCOUNT','TELLER_ACCOUNT',0,@BankCode,'True','Teller Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','SAVINGS ACCOUNT','SAVINGS_ACCOUNT',0,@BankCode,'True','Savings Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','CURRENT ACCOUNT','CURRENT_ACCOUNT',0,@BankCode,'True','Current Account',@ModifiedBy,'True'	EXEC dbo.AccountTypes_Update '','CORPORATE ACCOUNT','CORPORATE_ACCOUNT',0,@BankCode,'True','Corporate Account',@ModifiedBy,'True'		--create default Charge Types	EXEC dbo.ChargeTypes_Update 'FLAT_FEE','FLAT FEE',@ModifiedBy,@BankCode,'FLAT FEE','True'	EXEC dbo.ChargeTypes_Update 'PERCENTAGE','PERCENTAGE',@ModifiedBy,@BankCode,'PERCENTAGE','True'		--create default Currencies	EXEC dbo.Currencies_Update 'UGANDA SHILLINGS','UGS',@BankCode,@ModifiedBy,1		SELECT @BankCode As InsertedIDENDELSE BEGIN	UPDATE Banks SET 		[BankName] = @BankName,		[BankCode] = @BankCode,		[BankContactEmail] = @BankContactEmail,		IsActive=@IsActive,		LastUpdateDate=GETDATE(),		PathToLogoImage=@PathToLogoImage,		PathToPublicKey=@PathToPublicKey	WHERE BankCode = @BankCode	SELECT @BankCode As InsertedIDENDCOMMIT TRANSACTION BankUpdaterEND TRYBEGIN CATCHROLLBACK Transaction BankUpdater

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
