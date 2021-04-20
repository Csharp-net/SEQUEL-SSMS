USE [master]
GO
/****** Object:  Database [Shopping]    Script Date: 14-04-2021 17:24:09 ******/
CREATE DATABASE [Shopping]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Shopping', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Shopping.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Shopping_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Shopping_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Shopping] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Shopping].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Shopping] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Shopping] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Shopping] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Shopping] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Shopping] SET ARITHABORT OFF 
GO
ALTER DATABASE [Shopping] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Shopping] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Shopping] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Shopping] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Shopping] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Shopping] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Shopping] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Shopping] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Shopping] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Shopping] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Shopping] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Shopping] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Shopping] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Shopping] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Shopping] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Shopping] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Shopping] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Shopping] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Shopping] SET  MULTI_USER 
GO
ALTER DATABASE [Shopping] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Shopping] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Shopping] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Shopping] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Shopping] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Shopping] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Shopping] SET QUERY_STORE = OFF
GO
USE [Shopping]
GO
/****** Object:  UserDefinedFunction [dbo].[AddressINFO]    Script Date: 14-04-2021 17:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[AddressINFO](@cust_ID int)
returns varchar(20)
as
begin

Declare @returnvalue varchar(20)
select @returnvalue = cust_address from CUSTOMER 
where cust_ID=@cust_ID 
return @returnvalue
End
GO
/****** Object:  UserDefinedFunction [dbo].[countProduct]    Script Date: 14-04-2021 17:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[countProduct](@ProductID int)  
RETURNS int   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret int;  
    SELECT @ret = SUM(p.prod_price)   
    FROM product_deatils p   
    WHERE p.prod_ID = @ProductID   
        AND p.prod_name = 'saree';  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END; 
GO
/****** Object:  UserDefinedFunction [dbo].[net_total]    Script Date: 14-04-2021 17:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[net_total](
    @delivery_charge INT
)
RETURNS INT
AS
BEGIN
    RETURN @delivery_charge;
END
GO
/****** Object:  Table [dbo].[product_deatils]    Script Date: 14-04-2021 17:24:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_deatils](
	[prod_ID] [int] NOT NULL,
	[prod_name] [varchar](10) NULL,
	[prod_price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[prod_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distributors]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distributors](
	[dist_ID] [int] NOT NULL,
	[prod_ID] [int] NULL,
	[dist_name] [varchar](50) NULL,
	[location] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[dist_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Sales]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Sales](@storeid int)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT P.prod_ID, P.prod_name, SUM(SD.dist_ID) AS 'Total'  
    FROM product_deatils AS P   
    JOIN Distributors AS SD ON SD.prod_ID = P.prod_ID 
    WHERE SD.dist_ID = @storeid  
    GROUP BY P.prod_ID, P.prod_name 
); 
GO
/****** Object:  Table [dbo].[ORDER_details]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER_details](
	[order_ID] [int] NOT NULL,
	[prod_ID] [int] NULL,
	[cust_ID] [int] NULL,
	[order_date] [date] NULL,
	[delivery_charge] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPrice]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPrice]
(
@delivery_price int,
@delivery_price1 int
) 
RETURNS TABLE AS RETURN       
-- Add the SELECT statement with parameter references here     
SELECT * FROM ORDER_details WHERE delivery_charge BETWEEN @delivery_price AND @delivery_price1
GO
/****** Object:  Table [dbo].[ADDRESS]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADDRESS](
	[state] [varchar](80) NULL,
	[place] [varchar](80) NULL,
	[pin] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[cust_ID] [int] NOT NULL,
	[cust_name] [varchar](50) NULL,
	[cust_email] [varchar](50) NULL,
	[cust_phno] [bigint] NOT NULL,
	[cust_address] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cust_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[cust_phno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[cust_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[dep_id] [int] NOT NULL,
	[dep_name] [varchar](20) NULL,
	[dep_location] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[dep_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salary_grade]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salary_grade](
	[grade] [int] NOT NULL,
	[min_salary] [int] NULL,
	[max_salary] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales_details]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales_details](
	[sales_ID] [int] NOT NULL,
	[prod_ID] [int] NULL,
	[order_ID] [int] NULL,
	[quantity] [int] NULL,
	[list_price] [int] NULL,
	[discount] [decimal](5, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	[sales_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Distributors]  WITH CHECK ADD  CONSTRAINT [prod_ID] FOREIGN KEY([prod_ID])
REFERENCES [dbo].[product_deatils] ([prod_ID])
GO
ALTER TABLE [dbo].[Distributors] CHECK CONSTRAINT [prod_ID]
GO
ALTER TABLE [dbo].[ORDER_details]  WITH CHECK ADD FOREIGN KEY([cust_ID])
REFERENCES [dbo].[CUSTOMER] ([cust_ID])
GO
ALTER TABLE [dbo].[ORDER_details]  WITH CHECK ADD FOREIGN KEY([prod_ID])
REFERENCES [dbo].[product_deatils] ([prod_ID])
GO
ALTER TABLE [dbo].[Sales_details]  WITH CHECK ADD FOREIGN KEY([order_ID])
REFERENCES [dbo].[ORDER_details] ([order_ID])
GO
ALTER TABLE [dbo].[Sales_details]  WITH CHECK ADD FOREIGN KEY([prod_ID])
REFERENCES [dbo].[product_deatils] ([prod_ID])
GO
/****** Object:  StoredProcedure [dbo].[customer_INFO]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[customer_INFO]

@cust_ID int

AS
select * from CUSTOMER where cust_ID=@cust_ID;

GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeID]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeeID]
AS
    DECLARE @ID NUMERIC (10) 
    SET @ID = @ID
BEGIN
    SELECT * 
    FROM [CUSTOMER] 
    WHERE cust_ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CustomerDelete]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_CustomerDelete] 
    @CustomerID int
AS 
BEGIN 
DELETE
FROM   CUSTOMER
WHERE  cust_ID = @CustomerID 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CustomerINSERT]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CustomerINSERT]
       @customerID int,
	   @Name varchar(50),   
	   @Email	varchar(50),
	   @PhoneNumber bigint,
	   @Address varchar(50)
	 
AS
BEGIN
INSERT INTO CUSTOMER  (
       cust_ID,
	   cust_name,
	   cust_email,
	   cust_phno,
	   cust_address)
    VALUES (
	@customerID,
	   @Name,
	   @Email,
	   @PhoneNumber,
	   @Address)
 

 
SELECT 
	   cust_name = @Name,
	   cust_email	= @Email,
	   cust_phno =@PhoneNumber,
	   cust_address = @Address
FROM CUSTOMER 
WHERE  cust_ID = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CustomerUpdate]    Script Date: 14-04-2021 17:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_CustomerUpdate]
    @CustomerID int,
    @Name varchar(20),
    @Email varchar(20),
    @PhoneNumber bigint,
	@Address varchar(20)
  
AS 
BEGIN 
 
UPDATE CUSTOMER 
SET  cust_name = @Name,
     
     cust_email = @Email,
     cust_phno = @PhoneNumber
WHERE  cust_ID = @CustomerID

SELECT 
	   cust_name = @Name,
	   cust_email	= @Email,
	   cust_phno =@PhoneNumber,
	   cust_address = @Address
FROM CUSTOMER 

WHERE  cust_ID = @CustomerID

END
GO
USE [master]
GO
ALTER DATABASE [Shopping] SET  READ_WRITE 
GO
