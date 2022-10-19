using { afreed.db.master , afreed.db.transaction } from '../db/datamodel';


service CatalogService @(path: '/CatalogService'){   //we can provide any name for service , @path is optional
   
   entity EmployeeSet as projection on master.employees; 
   entity AddressSet as projection on master.address;
   entity ProductSet as projection on master.product;
   // entity ProductTextSet as projection on master.prodtext; 
   entity BPSet as projection on master.businesspartner;

   entity POs @(
      title: '{i18n>poHeader}'
   )
    as projection on transaction.purchaseorder{
       *,  //means all fields
       round(GROSS_AMOUNT,2) as GROSS_AMOUNT : Decimal(15, 2),
       CASE LIFECYCLE_STATUS   //in fiori app insted on N,D,B full form will appear
          when 'N' then 'New'
          when 'D' then 'Delivered'
          when 'B' then 'Blocked'
          end as LIFECYCLE_STATUS : String(20),

          CASE LIFECYCLE_STATUS   //in fiori app to provide icons
          when 'N' then 2
          when 'D' then 1
          when 'B' then 3
          end as Criticality : Integer,

       Items : redirected to POItems //Items is association created in purchase order set,  //redirected to used for $expand
    }actions{
        function largestOrder() returns array of POs; //fetching high salary amount
        action boost(); //boosting salary amount by 20000
    }
 
 //since GROSS_AMOUNT label is not displaying in the Fiori elements app then
 annotate POs with {
     GROSS_AMOUNT @title : 'Gross Amount';
     LIFECYCLE_STATUS @title : 'Life Cycle Status';
};
 



    entity POItems @(
       title : '{i18n>poItems}'
     ) as projection on transaction.poitems{
        *,  //means exposing all fields
        PARENT_KEY : redirected to POs,
        PRODUCT_GUID : redirected to ProductSet
     };

}