CREATE PROC usp_CustomerUpdate
    @CustomerID int,
    @Name varchar(20),
    @Email varchar(20),
    @PhoneNumber int,
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

EXECUTE usp_CustomerUpdate
   @CustomerID =109,
    @Name='chandu',
    @Email='chandu@gmail.com',
    @PhoneNumber =2345678901,
	@Address='goa';