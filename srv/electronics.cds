using { com.satinfotech.electronics as db } from '../db/schema';

service ElectronicsDB {
    entity BusinessPartner as projection on db.BusinessPartner;
    entity Store as projection on db.Store;
    entity Product as projection on db.Product;
    entity StockData as projection on db.StockData;
    entity PurchaseOrder as projection on db.PurchaseOrder;
    entity SalesOrder as projection on db.SalesOrder;
    entity ProductStock as projection on db.ProductStock; 
    entity States as projection on db.States;
}

annotate ElectronicsDB.BusinessPartner with {
    Name @assert.format: '^[a-zA-Z ]{2,}$'; // Only alphabets and space, minimum length 2
    Address1 @assert.format: '^[a-zA-Z0-9\s,.-]+$';
    Address2 @assert.format: '^[a-zA-Z0-9\s,.-]+$';
    City @assert.format: '^[a-zA-Z ]{2,}$'; // Only alphabets and space, minimum length 2
    State @assert.format: '^[a-zA-Z]{2}$'; // Exactly 2 alphabets
    PINCode @assert.format: '^\d{6}$'; // Exactly 6 digits
    GSTINNumber @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[0-9A-Z]{1}$'; // GSTIN format
}

annotate ElectronicsDB.Product with {
    ProductName @assert.format: '^[a-zA-Z0-9\s]+$'; // Only alphanumeric characters and spaces
    ProductImageURL @assert.format: '^(http|https)://[a-zA-Z0-9./\-_]+$'; // Valid URL format
    ProductCostPrice @assert.range.min: 0; // Minimum value is 0
    ProductSellPrice @assert.range.min: 0; // Minimum value is 0
};

annotate BusinessPartner with @(UI.LineItem: [
    { $Type: 'UI.DataField', Value: BusinessPartnerNumber },
    { $Type: 'UI.DataField', Label: 'Name', Value: Name },
    { $Type: 'UI.DataField', Value: Address1 },
    { $Type: 'UI.DataField', Value: Address2 },
    { $Type: 'UI.DataField', Value: City },
    { $Type: 'UI.DataField', Value: State },
    { $Type: 'UI.DataField', Value: PINCode },
    { $Type: 'UI.DataField', Value: Is_gstn_registered },
    { $Type: 'UI.DataField', Value: GSTINNumber },
    { $Type: 'UI.DataField', Value: Is_vendor },
    { $Type: 'UI.DataField', Value: Is_customer }
], UI.SelectionFields: [ BusinessPartnerNumber, Name, City, State, PINCode ], UI.FieldGroup #BusinessPartnerInformation : {
    $Type : 'UI.FieldGroupType',
    Data : [
        { $Type : 'UI.DataField', Value : BusinessPartnerNumber },
        { $Type : 'UI.DataField', Label: 'Name', Value : Name },
        { $Type : 'UI.DataField', Value : Address1 },
        { $Type : 'UI.DataField', Value : Address2 },
        { $Type : 'UI.DataField', Value : City },
        { $Type : 'UI.DataField', Value : State },
        { $Type : 'UI.DataField', Value : PINCode },
        { $Type : 'UI.DataField', Value : Is_gstn_registered },
        { $Type : 'UI.DataField', Value : GSTINNumber },
        { $Type : 'UI.DataField', Value : Is_vendor },
        { $Type : 'UI.DataField', Value: Is_customer }
    ]
}, UI.Facets : [
    {
        $Type : 'UI.ReferenceFacet',
        ID : 'BusinessPartnerInfoFacet',
        Label : 'Business Partner Information',
        Target : '@UI.FieldGroup#BusinessPartnerInformation',
    }
]);

annotate Store with @(UI.LineItem:[
    { Label: 'Store ID', Value: StoreID },
    { Value: Name },
    { Value: Address1 },
    { Value: Address2 },
    { Value: City },
    { Value: State },
    { Value: PINCode }
]);

annotate Product with @(UI.LineItem:[
    { Value: ProductID },
    { Label: 'Product Name', Value: ProductName },
    { Label: 'Product Image URL', Value: ProductImageURL },
    { Label: 'Cost Price', Value: ProductCostPrice },
    { Label: 'Sell Price', Value: ProductSellPrice }
], UI.FieldGroup #ProductFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Value: ProductID },
        { $Type: 'UI.DataField', Label: 'Product Name', Value: ProductName },
        { $Type: 'UI.DataField', Label: 'Product Image URL', Value: ProductImageURL },
        { $Type: 'UI.DataField', Label: 'Cost Price', Value: ProductCostPrice },
        { $Type: 'UI.DataField', Label: 'Sell Price', Value: ProductSellPrice }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'ProductFacet',
        Label: 'Product Information',
        Target: '@UI.FieldGroup#ProductFieldGroup'
    }
]);

annotate StockData with @(UI.LineItem:[
    { Value: StockID },
    { Label: 'Store ID', Value: store_id },
    { Label: 'Product ID', Value: product_id },
    { Label: 'Stock Quantity', Value: stock_qty }
], UI.FieldGroup #StockDataFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Value: StockID },
        { $Type: 'UI.DataField', Label: 'Store ID', Value: store_id },
        { $Type: 'UI.DataField', Label: 'Product ID', Value: product_id },
        { $Type: 'UI.DataField', Label: 'Stock Quantity', Value: stock_qty }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'StockDataFacet',
        Label: 'Stock Data Information',
        Target: '@UI.FieldGroup#StockDataFieldGroup'
    }
]);

annotate PurchaseOrder with @(UI.LineItem:[
    { Value: PurchaseOrderNumber },
    { Label: 'Business Partner', Value: BusinessPartner },
    { Label: 'Purchase Order Date', Value: PurchaseOrderDate },
    { Label: 'Items', Value: 'Items', Target: '@UI.FieldGroup#PurchaseOrderItemsFieldGroup' }
], UI.FieldGroup #PurchaseOrderItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Value: Items.items.product.ProductID, Label: 'Product ID' },
        { $Type: 'UI.DataField', Value: Items.items.qty, Label: 'Quantity' },
        { $Type: 'UI.DataField', Value: Items.items.price, Label: 'Price' },
        { $Type: 'UI.DataField', Value: Items.items.store.StoreID, Label: 'Store ID' }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'PurchaseOrderFacet',
        Label: 'Purchase Order Information',
        Target: '@UI.FieldGroup#PurchaseOrderItemsFieldGroup'
    }
]);

annotate SalesOrder.Items with @(UI.FieldGroup #SalesOrderItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Value: items.product.ProductID, Label: 'Product ID' },
        { $Type: 'UI.DataField', Value: items.qty, Label: 'Quantity' },
        { $Type: 'UI.DataField', Value: items.price, Label: 'Price' },
        { $Type: 'UI.DataField', Value: items.store.StoreID, Label: 'Store ID' }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'SalesOrderItemsFacet',
        Label: 'Sales Order Items',
        Target: '@UI.FieldGroup#SalesOrderItemsFieldGroup'
    }
]);

annotate ProductStock.Items with @(UI.FieldGroup #ItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Value: purchase_order.PurchaseOrderNumber, Label: 'Purchase Order Number' },
        { $Type: 'UI.DataField', Value: sales_order.SalesOrderNumber, Label: 'Sales Order Number' },
        { $Type: 'UI.DataField', Value: product.ProductID, Label: 'Product ID' },
        { $Type: 'UI.DataField', Value: qty, Label: 'Quantity' },
        { $Type: 'UI.DataField', Value: price, Label: 'Price' },
        { $Type: 'UI.DataField', Value: store.StoreID, Label: 'Store ID' }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'ItemsFacet',
        Label: 'Items',
        Target: '@UI.FieldGroup#ItemsFieldGroup'
    }
]);
