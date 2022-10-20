namespace afreed.db;

using { afreed.db.master , afreed.db.transaction } from './datamodel';


context CdsViews {
    define view ![POWorklist] //![] used to make name case sensitive, it is optional
    as select from transaction.purchaseorder {
        key PO_ID as ![PurchaseOrderId],
        PARTNER_GUID.BP_ID as ![PartnerID],
        PARTNER_GUID.COMPANY_NAME  as ![CompanyName],
        GROSS_AMOUNT as ![POGrossAmount],
        Currency.code AS ![POCurrencyCode],
        LIFECYCLE_STATUS as ![LifeCycleStatus],
    key Items.PO_ITEM_POS as ![ItemPosition],
        Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
        Items.PRODUCT_GUID.DESCRIPTION as ![Description],
        PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
        PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
        Items.GROSS_AMOUNT as ![GrossAmount],
        Items.NET_AMOUNT as ![NetAmount],
        Items.Currency.code as ![CurrencyCode]

    };

      define view ProductVH as 
        select from master.product{
            @EndUserText.label : [
                {
                language : 'EN',
                text : 'Product ID'
            },
            {
                language : 'DE',
                text : 'Prodekt ID'
            }]
            PRODUCT_ID as ![ProductID],

            @EndUserText.label : [
                {
                language : 'EN',
                text : 'Product Description'
            },
            {
                language : 'DE',
                text : 'Prodekt Deskrpt'
            }]
            DESCRIPTION as ![ProductDescription]
        };
     
  //Defining another View
  define view ![ItemView] as 
       select from transaction.poitems{
           PARENT_KEY.PARTNER_GUID.NODE_KEY as ![Partner],
           PRODUCT_GUID.NODE_KEY as ![ProductID],
           Currency.code as ![CurrencyCode],
           GROSS_AMOUNT as ![GrossAmount],
           NET_AMOUNT as ![NetAmount],
           TAX_AMOUNT as ![TaxAmount],
           PARENT_KEY.OVERALL_STATUS as ![OverAllStatus] 
       };
    

    define view ![ProductViewSub] as 
        select from master.product {
            PRODUCT_ID  as ![ProductID],
            texts.DESCRIPTION as ![Description],
            (
                select from transaction.poitems as a {
                    SUM(a.GROSS_AMOUNT) as SUM
                } where a.PRODUCT_GUID.NODE_KEY = product.NODE_KEY
            ) as PO_SUM: Decimal
        };


    //exposing the association
    define view ProductView as select from master.product
    mixin{ //mixin used to exposing the associations
       PO_ORDERS : Association[*] to ItemView on  //PO_ORDERS is association name
                           PO_ORDERS.ProductID = $projection.ProductID
    }
   into {
       NODE_KEY as ![ProductID],
       DESCRIPTION,
       CATEGORY as ![Category],
       PRICE as ![Price],
       TYPE_CODE as ![TypeCode],
       SUPPLIER_GUID.BP_ID as ![BusineessPartnerID],
       SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
       SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
       SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
      //Exposed Association, means when someone read the view
      // then the data won't be read by default
      //until unless someone consume the association
       PO_ORDERS  //Association
   };


   //final consumption view
   define view CProductValuesView as 
     select from ProductView{
         ProductID,
         Country,
         PO_ORDERS.CurrencyCode as CurrencyCode,
         sum(PO_ORDERS.GrossAmount) as ![TotalGrossAmount] : Decimal
     } group by ProductID,Country,PO_ORDERS.CurrencyCode


}

