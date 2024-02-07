namespace com.hemanth.nnrg;
using { managed, cuid } from '@sap/cds/common';

/*@assert.unique:{
    studentid:[studentid]
}*/
entity Business: cuid, managed {
    @title: 'Business Partner Number'
    bp_number: String(5);
    @title: ' Name'
    name: String(40) ;
    @title: 'Address 1'
    address_1: String(40);
    @title: 'Adress 2'
    address_2: String(100) ;
    @title: 'City'
    city: String(20) ;
    @title: 'State'
    state: Association to States;
    @title: 'PIN Code'
    pincode: String(10);
    @title:'Is_GSTN_Registered'
    is_gstn_registered: Boolean default false;
    @title:'GSTIN Number'
    is_gstin_number: String(15) @mandatory;
    @title:'IS Vendor'
    is_vendor: Boolean default false;
    @title:'IS Customer'
    is_customer: Boolean default false;
}

entity States : cuid, managed {
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(50);
}

entity Store: cuid, managed {
    @title: 'Store ID'
    store_id: String(5);
    @title: ' Name'
    name: String(40) ;
    @title: 'Address 1'
    address_1: String(40);
    @title: 'Adress 2'
    address_2: String(100) ;
    @title: 'City'
    city: String(20) ;
    @title: 'State'
    state: Association to States;
    @title: 'PIN Code'
    pincode: String(10);
}

entity Stock: cuid, managed {
    @title: 'Store ID'
    store_id: String(23);
        @title: 'Product ID'
    product_id:String(5);
        @title: 'Stock Quantity'
    stock_qty: Integer;
}