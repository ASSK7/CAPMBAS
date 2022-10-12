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
       Items : redirected to POItems //Items is association created in purchase order set
    };   //redirected to used for $expand

    entity POItems @(
       title : '{i18n>poItems}'
     ) as projection on transaction.poitems{
        *,  //means exposing all fields
        PARENT_KEY : redirected to POs,
        PRODUCT_GUID : redirected to ProductSet
     };

}