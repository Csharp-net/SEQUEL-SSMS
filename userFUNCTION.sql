create function dbo.AddressINFO(@cust_ID int)
returns varchar(20)
as
begin

Declare @returnvalue varchar(20)
select @returnvalue = cust_address from CUSTOMER 
where cust_ID=@cust_ID 
return @returnvalue
End

select dbo.AddressINFO (109) as cust_address;

select * from CUSTOMER;