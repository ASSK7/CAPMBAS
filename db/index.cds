using {afreed.db.master , afreed.db.transaction} from './datamodel';


//Providing description for fields for Fiori Elements App
annotate transaction.purchaseorder with {

        PO_ID  @title : 'Purchase Order ID';       	
        CURRENCY_CODE  @title : 'Currency Code'; 
        GROSS_AMOUNT  @title : 'Gross Amount';       	
        NET_AMOUNT  @title : 'Net Amount';         	
        TAX_AMOUNT  @title : 'Tax Amount';         	
        LIFECYCLE_STATUS  @title : 'LifeCycle Status';
        OVERALL_STATUS  @title : 'Overall Status';
        NOTE  @title : 'Note';
        PARTNER_GUID @title : 'Partner GUID';
    
};

annotate master.businesspartner with {

        NODE_KEY @title : 'Node Key';          	
        BP_ROLE	@title : 'Business Partner Role';
        EMAIL_ADDRESS @title : 'Email';                                                                                                                                                                                                                                                 	
        PHONE_NUMBER @title : 'Phone';               	
        FAX_NUMBER @title : 'Fax';             	
        WEB_ADDRESS @title : 'Website';                                                                                                                                                                                                                                                     	            	
        BP_ID @title : 'Business Partner Code';	
        COMPANY_NAME @title : 'Company Name';   
        PARTNER_GUID  @title : 'Partner GUID'; 
};

annotate master.address with {
        CITY @title : 'City';                                   	
        POSTAL_CODE	@title : 'PinCode';
        STREET @title : 'Street';                                                   	
        BUILDING @title : 'Building Number';	
        COUNTRY	@title : 'Country';
        ADDRESS_TYPE @title : 'Address Type';
};


annotate transaction.poitems with {    	
        CURRENCY_CODE  @title : 'Currency Code';
        GROSS_AMOUNT  @title : 'Gross Amount';       	
        NET_AMOUNT  @title : 'Net Amount';         	
        TAX_AMOUNT  @title : 'Tax Amount';         	
        NODE_KEY @title : 'Node Key';
        PO_ITEM_POS @title : 'PO Items Position'; 
        PRODUCT_GUID @title : 'Product GUID'; 
        
};

annotate master.product with {
    NODE_KEY @title : 'Node Key';                        	
        PRODUCT_ID 	@title : 'Product Key';
        TYPE_CODE @title : 'Type Code';
        CATEGORY @title : 'Category';                                   	         	
        TAX_TARIF_CODE @title : 'Tarrif Code';
        PRICE @title : 'Price';
        DESCRIPTION @title : 'Description';
        
};

