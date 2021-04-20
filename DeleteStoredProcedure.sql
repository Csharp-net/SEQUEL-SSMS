CREATE PROC usp_CustomerDelete 
    @CustomerID int
AS 
BEGIN 
DELETE
FROM   CUSTOMER
WHERE  cust_ID = @CustomerID 
END
GO

EXECUTE usp_CustomerDelete 
@CustomerID='111';
 