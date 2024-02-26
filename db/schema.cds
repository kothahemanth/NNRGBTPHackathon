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
    
    @title:'GSTIN Number'
    is_gstin_number: String(15) @mandatory;
    @title:'IS Vendor'
    is_vendor: Boolean default false;
    @title:'IS Customer'
    is_customer: Boolean default false;
}

@cds.persistence.skip
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

entity PurchaseApp {
    key ID            : UUID;
    b_id:Integer;
    bp:Association to Business;
    pDate:Date;
    Items:Composition of many{
        key ID:UUID;
        item:Association to Items;
    }
}

entity Items {
    key ID :UUID;
     storeId         : Association to Store;
    qty:Association to Stock;
    productId       : Association to Product;
    price:Association to Product;
}

entity Stock: cuid, managed {
    @title: 'Store ID'
    store_id: String(23);
        @title: 'Product ID'
    product_id:String(5);
        @title: 'Stock Quantity'
    stock_qty: Integer;
}

entity SalesApp {
    key ID :UUID;
    s_id:Integer;
    bp:Association to Business;
    saleDate:Association to PurchaseApp;
     Items:Composition of many{
        key ID:UUID;
        item:Association to Items;
    }
}

entity Product : cuid, managed {
    @title: 'Product ID'
    product_id: String(5);
    @title: 'Product Name'
    product_name: String(40) ;
    @title: 'Product Image URL'
    image_url: String(40);
    @title: 'Product Cost Price'
    cost_price: String(100) ;
    @title: 'Product Sell Price'
    sell_price: String(20) ;
    
}