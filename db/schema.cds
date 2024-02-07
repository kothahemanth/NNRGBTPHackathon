namespace com.satinfotech.electronics;
using { cuid } from '@sap/cds/common';

@assert.unique:{
    BusinessPartnerNumber:[BusinessPartnerNumber]
}
entity BusinessPartner {
    key ID: UUID;
    BusinessPartnerNumber: String(6);
    @title:'Name'
    Name: String(20);
    @title:'Address 1'
    Address1: String(70);
    @title:'Address 2'
    Address2: String(70);
    @title:'City'
    City: String(20);
    @title:'State'
    State: Association to States;
    @title:'PINCode'
    PINCode: String(10);
    @title:'Is_gstn_registered'
    Is_gstn_registered: Boolean default false;
    @title:'GSTINNumber'
    GSTINNumber: String(20);
    @title:'Is_vendor'
    Is_vendor: Boolean default false;
    @title:'Is_customer'
    Is_customer: Boolean default false;
}

entity Store {
    key ID: UUID;
    StoreID: String(10);
    Name: String(100);
    Address1: String(255);
    Address2: String(255);
    City: String(100);
    State: Association to States;
    PINCode: String(10) @(assert.format: '^[1-9][0-9]{5}$');
}

entity Product {
    key ID: UUID;
    ProductID: String(20); 
    ProductName: String(100);
    ProductImageURL: String(255);
    ProductCostPrice: Decimal(15, 2); 
    ProductSellPrice: Decimal(15, 2); 
}

entity StockData {
    key ID: UUID;
    StockID: Association to Stock;
    ProductID: Association to Product;
    StockQuantity: Integer;
}

entity PurchaseOrder {
    key ID: UUID;
    PurchaseOrderNumber: Association to BusinessPartner;
    PurchaseOrderDate: DateTime;
    Items: Composition of many {
        key ID: UUID;
        Items: Association to ProductStock;
    };
}

entity SalesOrder {
    key ID: UUID;
    SalesOrderNumber: Association to BusinessPartner;
    SalesDate: DateTime;
    Items: Composition of many {
        key ID: UUID;
        Items: Association to ProductStock;
    };
}

entity ProductStock {
    key ID: UUID;
    ProductStockID: Association to PurchaseOrder;
    SalesOrder: Association to SalesOrder;
    Product: Association to Product;
    Quantity: Integer;
    Price: Decimal(15, 2);
    Store: Association to Store;
}

entity States {
    @title:'code'
    key code: String(3);
    @title:'description'
    description: String(10);
}
