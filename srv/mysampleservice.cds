using { afreed.db.master, afreed.db.transaction } from '../db/datamodel';


service mysrv {

     function myFunction(msg: String) returns String;   // this was created in DAY 1 of CAPM Class 

     @readonly
     entity ReadEmployeeSrv as projection on master.employees; //here master.employees represents output data structure
     @insertonly
     entity InsertEmployeeSrv as projection on master.employees;
     @updateonly
     entity UpdateEmployeeSrv as projection on master.employees;
     @deleteonly
     entity DeleteEmployeeSrv as projection  on master.employees;

     //we can do all CRUD operatons on single entity but for practice I am doing this


}