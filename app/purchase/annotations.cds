using CatalogService as service from '../../srv/CatalogService';

//********************  Custom Annotations by AFREED  ***************************/

//************* Adding Value Help for Partner GUID ****************/

annotate CatalogService.POs with {
    PARTNER_GUID@(
        Common : {
            Text : PARTNER_GUID.COMPANY_NAME
        },
        ValueList.entity : CatalogService.BPSet
    )
};

@cds.odata.valuelist
annotate CatalogService.BPSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME ,
    }]
);


//****************************************************************/
//************* Adding Value Help for Product GUID****************/

annotate CatalogService.POItems with {
    PRODUCT_GUID@(
        Common : {
            Text : PRODUCT_GUID.DESCRIPTION
        },
        ValueList.entity : CatalogService.ProductSet
    )
};

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : PRODUCT_ID ,
    }]
);


//****************************************************************/


//Adding fields , filters

annotate CatalogService.POs with @(
    UI : {
        SelectionFields : [     //SelectionFields are filters
           PO_ID,
           GROSS_AMOUNT,
           LIFECYCLE_STATUS,
           Currency.code
        ],
        LineItem : [       //LineItem are table columns
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataFieldForAction',   //we are adding the boost action
                Label : 'Boost',
                Action : 'CatalogService.boost',
                Inline : true,                        //inline means for every line
            },
            {
                $Type : 'UI.DataField',
                Value : Currency.code,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : LIFECYCLE_STATUS,
                Criticality : Criticality , //Criticality is fieled in CatalogService.cds
                CriticalityRepresentation : #WithIcon
            }
        ],
        HeaderInfo  : {    //For navigation purpose
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order',
            TypeNamePlural : 'Purchase Orders',
            Title : {
                Label : 'Purchase Order ID',
                Value : PO_ID
            },
            Description : {
                Label : 'Company Name',
                Value : PARTNER_GUID.COMPANY_NAME
            }
            
        },
        //We are adding facets
        Facets  : [
           {
               $Type : 'UI.ReferenceFacet',
               Label : 'PO Header Info',
               Target : ![@UI.FieldGroup#HeaderGeneralInformation],
           },
           {   //ADDING PO Line Items
               $Type : 'UI.ReferenceFacet',
               Label : 'PO Line Items',
               Target : 'Items/@UI.LineItem',  //Items is an association
           }
        ],

        //Field Groups
        FieldGroup#HeaderGeneralInformation  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ID,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID_NODE_KEY,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.COMPANY_NAME,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : PARTNER_GUID.BP_ID,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : Currency.code,
                },
                 {
                    $Type : 'UI.DataField',
                    Value : LIFECYCLE_STATUS,
                },
            ]
            
        },
    }
);


//adding po line items
annotate CatalogService.POItems with @(
    UI : {
        LineItem : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ITEM_POS,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID_NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : Currency.code,
                },
        ],
        //if we click on the line item then it will navigate to another page
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title : {
                $Type : 'UI.DataField',
                Value : ID,
            },
            Description : {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
        },
        Facets  : [
            {   
                Label : 'Line Item Header',
                $Type : 'UI.ReferenceFacet',
                Target : ![@UI.FieldGroup#LineItemHeader],
            },
            {
                Label : 'Product Details',
                $Type : 'UI.ReferenceFacet',
                Target : 'PRODUCT_GUID/@UI.FieldGroup#ProductDetails'
            }
        ],
        FieldGroup#LineItemHeader : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID_NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : Currency.code,
                },
            ]
            
        },
    }
);

annotate CatalogService.ProductSet with @(
    UI : {
        FieldGroup#ProductDetails  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TYPE_CODE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CATEGORY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : SUPPLIER_GUID.COMPANY_NAME,
                },
            ]
            
        },
    }
);










//********************  AUTOGENERATED  ***************************/

// annotate service.POs with @(    //These are autogenerated code commented by afreed
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'NODE_KEY',
//             Value : NODE_KEY,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'CURRENCY_CODE',
//             Value : CURRENCY_CODE,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'GROSS_AMOUNT',
//             Value : GROSS_AMOUNT,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'NET_AMOUNT',
//             Value : NET_AMOUNT,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'TAX_AMOUNT',
//             Value : TAX_AMOUNT,
//         },
//     ]
// );
// annotate service.POs with @(
//     UI.FieldGroup #GeneratedGroup1 : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'CURRENCY_CODE',
//                 Value : CURRENCY_CODE,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'GROSS_AMOUNT',
//                 Value : GROSS_AMOUNT,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'NET_AMOUNT',
//                 Value : NET_AMOUNT,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'TAX_AMOUNT',
//                 Value : TAX_AMOUNT,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'NODE_KEY',
//                 Value : NODE_KEY,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'PO_ID',
//                 Value : PO_ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'PARTNER_GUID_NODE_KEY',
//                 Value : PARTNER_GUID_NODE_KEY,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'LIFECYCLE_STATUS',
//                 Value : LIFECYCLE_STATUS,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'OVERALL_STATUS',
//                 Value : OVERALL_STATUS,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'NOTE',
//                 Value : NOTE,
//             },
//         ],
//     },
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneratedFacet1',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneratedGroup1',
//         },
//     ]
// );
