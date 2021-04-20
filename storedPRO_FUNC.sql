/*CREATE FUNCTION Sales(@storeid int)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT P.prod_ID, P.prod_name, SUM(SD.dist_ID) AS 'Total'  
    FROM product_deatils AS P   
    JOIN Distributors AS SD ON SD.prod_ID = P.prod_ID 
    WHERE SD.dist_ID = @storeid  
    GROUP BY P.prod_ID, P.prod_name 
); */

CREATE FUNCTION dbo.countProduct(@ProductID int)  
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

/*CREATE PROCEDURE GetEmployeeID
AS
    DECLARE @ID NUMERIC (10) 
    SET @ID = @ID
BEGIN
    SELECT * 
    FROM [CUSTOMER] 
    WHERE cust_ID = @ID
END


EXEC GetEmployeeID ; */