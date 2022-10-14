namespace afreed.db;
using { cuid , managed , temporal , Currency } from '@sap/cds/common'; //importing aspects
using { afreed.common } from './mycommon';  // I created this common cds file 



type Guid : String(32);  //this is like data element concept


context master {   //context is used to group the tables
    
    entity businesspartner {    //this is a table
        key NODE_KEY : Guid;            	
        BP_ROLE	: String(2);  
        EMAIL_ADDRESS : String(64);                                                                                                                                                                                                                                                   	
        PHONE_NUMBER : String(14);                  	
        FAX_NUMBER : String(14);                 	
        WEB_ADDRESS : String(64);                                                                                                                                                                                                                                                     	
        ADDRESS_GUID : Association to address; //creates FK relationship between this column and primary key in address table                 	
        BP_ID : String(16);  	
        COMPANY_NAME : String(84);       
    }

   //Providing lables to fields in enities
   annotate businesspartner with {
       NODE_KEY @title : '{i18n>bpkey}';
       BP_ROLE @title : '{i18n>bprole}';
   };
   

    entity address {    //address table
        key NODE_KEY : Guid;                 	
        CITY : String(64);                                     	
        POSTAL_CODE	: String(14); 
        STREET : String(64);                                                      	
        BUILDING : String(32);  	
        COUNTRY	: String(2); 
        ADDRESS_TYPE : String(64); 
        VAL_START_DATE : Date;
        VAL_END_DATE : Date;	
        LATITUDE : Decimal;        	
        LONGITUDE : Decimal;   
        businesspartner : Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    // entity prodtext {
    //     key NODE_KEY : Guid;                    	
    //     PARENT_KEY : Guid;              	
    //     LANGUAGE : String(2);
    //     TEXT  : String(256);
    // }

    entity product {
        key NODE_KEY : Guid;                        	
        PRODUCT_ID 	: String(28);
        TYPE_CODE: String(2);
        CATEGORY : String(32);                                    	
        SUPPLIER_GUID : Association to master.businesspartner;           	
        TAX_TARIF_CODE: String(12);
        MEASURE_UNIT : String(2);
        WEIGHT_MEASURE : String(12);
        WEIGHT_UNIT	: String(2);
        CURRENCY_CODE : String(4);
        PRICE : Decimal;	
        WIDTH : Decimal;	         	
        DEPTH : Decimal;	         	
        HEIGHT : Decimal;	         	
        DIM_UNIT : Decimal;	
        DESCRIPTION : localized String(256);  //localization
    }

    entity employees : cuid {  //cuid , temporal are aspects
        nameFirst : String(40);
        nameMiddle : String(40);	
        nameLast : String(40);	
        nameInitials : String(40);	
        sex	: common.Gender;
        language : String(10);
        phoneNumber	: common.PhoneNumber;
        email : common.Email;
        loginName : String(15);
        Currency : Currency;
        salaryAmount : common.AmountT;
        accountNumber : String(20);
        bankId	: String(15);
        bankName : String(80); 
    }
}

context transaction {   //for transaction data

   entity purchaseorder : common.Amount{    //po table
        key NODE_KEY : Guid;                 	
        PO_ID  : String(32);
        PARTNER_GUID : Association to master.businesspartner;           	
        // CURRENCY_CODE : String(4); //these four fields are added in Amount aspect
        // GROSS_AMOUNT : Decimal;       	
        // NET_AMOUNT : Decimal;         	
        // TAX_AMOUNT : Decimal;         	
        LIFECYCLE_STATUS : String(1);	
        OVERALL_STATUS : String(1);
        NOTE : String(255);
        Items: association to many poitems on Items.PARENT_KEY = $self
   }

   entity poitems : common.Amount {
        key NODE_KEY : Guid;                        	
        PARENT_KEY :  Association to purchaseorder;             	
        PO_ITEM_POS	: Integer;
        PRODUCT_GUID : Association to master.product;   	
        // CURRENCY_CODE : String(4);
        // GROSS_AMOUNT  : Decimal;      	
        // NET_AMOUNT : Decimal;
        // TAX_AMOUNT : Decimal;
   }
}

