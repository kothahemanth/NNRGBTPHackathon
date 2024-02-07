namespace com.satinfotech.electronics;
using { cuid, managed } from '@sap/cds/common';

entity BusinessPartner {
  key BusinessPartnerNumber : UUID;
  Name : String;
  Address1 : String;
  Address2 : String;
  City : String;
  State : String(2);
  PINCode : String(6);
  Is_gstn_registered : Boolean;
  GSTINNumber : String(15);
  Is_vendor : Boolean;
  Is_customer : Boolean;
}

entity Store {
  key StoreID : UUID;
  Name : String;
  Address1 : String;
  Address2 : String;
  City : String;
  State : String(2);
  PINCode : String(6);
}

entity Product {
  key ProductID : UUID;
  ProductName : String;
  ProductImageURL : String;
  ProductCostPrice : Decimal(10, 2);
  ProductSellPrice : Decimal(10, 2);
}

entity StockData {
  key StockID : UUID;
  store_id : UUID;
  product_id : UUID;
  stock_qty : Integer;
}

entity PurchaseOrder {
  key PurchaseOrderNumber : UUID;
  BusinessPartner : UUID;
  PurchaseOrderDate : DateTime;
  Items: Composition of many {
        key ID: UUID;
        items: Association to ProductStock;
    };
}

entity SalesOrder {
  key SalesOrderNumber : UUID;
  BusinessPartner : UUID;
  SalesDate : DateTime;
  Items: Composition of many {
        key ID: UUID;
        items: Association to ProductStock;
    };
}

entity ProductStock {
  key ProductStockID : UUID;
  purchase_order : Association to PurchaseOrder;
  sales_order : Association to SalesOrder;
  product : Association to Product;
  qty : Integer;
  price : Decimal(10, 2);
  store : Association to Store;
}
