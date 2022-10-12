namespace afreed.common;

using { sap , Currency, managed, temporal } from '@sap/cds/common';

type Gender : String(1) enum {  //enum means fix set of values
    male = 'M';
    female = 'F';
    others = 'O';
};


type AmountT : Decimal(15, 2)@(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

//structure
// abstract entity Amount { //deprecated
//         CURRENCY_CODE : String(4);	
//         GROSS_AMOUNT : Decimal;       	
//         NET_AMOUNT : Decimal;         	
//         TAX_AMOUNT : Decimal; 
// }


//Aspect
aspect Amount {
        CURRENCY_CODE : String(4);	
        GROSS_AMOUNT : Decimal;       	
        NET_AMOUNT : Decimal;         	
        TAX_AMOUNT : Decimal; 
}


//@assert.format for validating the entered mobile number
type PhoneNumber : String(30)@assert.format : '^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$';

type Email : String(55)@assert.format : '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$';

