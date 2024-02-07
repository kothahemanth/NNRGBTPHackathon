namespace com.tests.sdb;
using {cuid} from '@sap/cds/common';
@assert.unique:{
    bp_no:[bp_no]
}
entity Business_Partner {
    key ID: UUID;
    bp_no:String(6);
    @title:'Name'
    name:String(20);
 @title:'Address 1'
    add1:String(70);
 @title:'Address 2'
    add2:String(70);
    @title:'City'
    city:String(20);
     @title:'State'
    state:Association to States;
     @title:'pin code'
    pinCode:String(10);
    @title:' Is_gstn_registered'
     Is_gstn_registered:Boolean default false;
       @title:' GSTIN number'
     Gst_num:String(20);
       @title:' is vendor'
    Is_vendor:Boolean default false;
      @title:' is customer'
    Is_customer:Boolean default false;
}

entity Store {
    key ID: UUID;
    store_id :String(10);
    name         : String(100);
    add1     : String(255);
    add2     : String(255);
    city         : String(100);
    state        : Association to States;
    PinCode      : String(10) @(assert.format: '^[1-9][0-9]{5}$');
}

entity Product {
    key ID: UUID;
    p_id           : String(20); 
    name     : String(100);
    imageURL        : String(255);
    costPrice       : Decimal(15, 2); 
    sellPrice       : Decimal(15, 2); 
}


entity Stock {
    key ID            : UUID;
    storeId         : Association to Store;
    productId       : Association to Product;
    stock_qty        : Integer;
}

entity PurchaseApp {
    key ID            : UUID;
    pon:Integer;
    bp:Association to Business_Partner;
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

entity SalesApp {
    key ID :UUID;
    son:Integer;
    bp:Association to Business_Partner;
    saleDate:Association to PurchaseApp;
     Items:Composition of many{
        key ID:UUID;
        item:Association to Items;
    }
}
@cds.persistence.skip
entity States {
    @title:'code'
    key code: String(3);
    @title:'description'
    description:String(10);
    
}