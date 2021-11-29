alter procedure admin.delete_columns
as
--Christian 29.11.2021
--Azure Data Factory loads admin source table in a loop - table by table
--there is no option for deselecting specific columns 
--the better solution would be to change the load into the DWH server
print ('the column admin.cust.adminpass is deleted');
update admin.cust
set adminpass = null;

print ('the column admin.cust.bookiepass is deleted');
update admin.cust
set bookiepass = null;

print ('the column admin.forhandlere.[password] is deleted');
update admin.forhandlere
set [password] = null;
