CREATE FUNCTION [dbo].[GetPrice]
(
@delivery_price int,
@delivery_price1 int
) 
RETURNS TABLE AS RETURN       
-- Add the SELECT statement with parameter references here     
SELECT * FROM ORDER_details WHERE delivery_charge BETWEEN @delivery_price AND @delivery_price1

SELECT * from GetPrice(100,1000)
ORDER BY 
delivery_charge;

Declare @delivery_price Int=100;
if @delivery_price < 90
print 'delivered!!';
else
print 'Not deliverable';