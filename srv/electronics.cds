namespace com.test.sdb;
using { com.satinfotech.electronics as db } from '../db/schema';

service ElectronicsDB {
    entity Business_Partner as projection on db.BusinessPartner;
    entity States as projection on db.States;
    entity Store as projection on db.Store;
    entity Product as projection on db.Product;
    entity StockData as projection on db.StockData;
    entity PurchaseOrder as projection on db.PurchaseOrder;
    entity SalesOrder as projection on db.SalesOrder;
    entity ProductStock as projection on db.ProductStock;
}

annotate ElectronicsDB.Business_Partner with {
    name @assert.format: '^[a-zA-Z ]{2,}$'; // Only alphabets and space, minimum length 2
    add1 @assert.format: '^[a-zA-Z0-9\s,.-]+$';
    add2 @assert.format: '^[a-zA-Z0-9\s,.-]+$';
    city @assert.format: '^[a-zA-Z ]{2,}$'; // Only alphabets and space, minimum length 2
    state @assert.format: '^[a-zA-Z]{2}$'; // Exactly 2 alphabets
    pinCode @assert.format: '^\d{6}$'; // Exactly 6 digits
    Gst_num @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[0-9A-Z]{1}$'; // GSTIN format
}

annotate ElectronicsDB.Product with {
    ProductName @assert.format: '^[a-zA-Z0-9\s]+$'; // Only alphanumeric characters and spaces
    ProductImageURL @assert.format: '^(http|https)://[a-zA-Z0-9./\-_]+$'; // Valid URL format
    ProductCostPrice @assert.range.min: 0; // Minimum value is 0
    ProductSellPrice @assert.range.min: 0; // Minimum value is 0
}

annotate ElectronicsDB.States with @(
    UI.LineItem:[
        { Value: code },
        { Value: description }
    ],
    UI.FieldGroup #States : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { Value : code },
            { Value : description }
        ]
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StatesFacet',
            Label : 'States',
            Target : '@UI.FieldGroup#States',
        }
    ]
);

annotate ElectronicsDB.States with {
    code @(
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'State',
            CollectionPath: 'States',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: state_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                },
            ]
        }
    );
};


annotate ElectronicsDB.BusinessPartner with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : BusinessPartnerNumber
        },
        {
            $Type : 'UI.DataField',
            Label: 'Name',
            Value : Name
        },
        {
            $Type : 'UI.DataField',
            Value : Address1
        },
        {
            $Type : 'UI.DataField',
            Value : Address2
        },
        {
            $Type : 'UI.DataField',
            Value : City
        },
        {
            $Type : 'UI.DataField',
            Value : State
        },
        {
            $Type : 'UI.DataField',
            Value : PINCode
        },
        {
            $Type : 'UI.DataField',
            Value : Is_gstn_registered
        },
        {
            $Type : 'UI.DataField',
            Value : GSTINNumber
        },
        {
            $Type : 'UI.DataField',
            Value : Is_vendor
        },
        {
            $Type : 'UI.DataField',
            Value: Is_customer
        }
    ],
    UI.SelectionFields: [ BusinessPartnerNumber, Name, City, State, PINCode],       
    UI.FieldGroup #BusinessPartnerInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label: 'BPNO',
                Value : BusinessPartnerNumber,
            },
            {
                $Type : 'UI.DataField',
                Label: 'Name',
                Value : Name
            },
            {
                $Type : 'UI.DataField',
                Label: 'Add1',
                Value : Address1,
            },
            {
                $Type : 'UI.DataField',
                Label: 'Add2',
                Value : Address2,
            },
            {
                $Type : 'UI.DataField',
                Label: 'city',
                Value : City,
            },
            {
                $Type : 'UI.DataField',
                Label: 'State',
                Value : State
            },
            {
                $Type : 'UI.DataField',
                Label: 'Pin',
                Value : PINCode
            },
            {
                $Type : 'UI.DataField',
                Label: 'Is_gstn_registered',
                Value : Is_gstn_registered
            },
            {
                $Type : 'UI.DataField',
                Label: 'GSTINumber',
                Value : GSTINNumber
            },
            {
                $Type : 'UI.DataField',
                Label: 'Is_vendor',
                Value : Is_vendor
            },
            {
                $Type : 'UI.DataField',
                Label: 'Is_customer',
                Value: Is_customer
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BusinessPartnerInfoFacet',
            Label : 'Business Partner Information',
            Target : '@UI.FieldGroup#BusinessPartnerInformation',
        }
    ]
);

annotate ElectronicsDB.Store with @(UI.LineItem:[
    { Label: 'Store ID', Value: StoreID },
    { Label: 'Name', Value: Name },
    { Label: 'Address 1', Value: Address1 },
    { Label: 'Address 2', Value: Address2 },
    { Label: 'City', Value: City },
    { Label: 'State', Value: State },
    { Label: 'PIN Code', Value: PINCode }
]);

annotate ElectronicsDB.Product with @(UI.LineItem:[
    { Label: 'Product ID', Value: ProductID },
    { Label: 'Product Name', Value: ProductName },
    { Label: 'Product Image URL', Value: ProductImageURL },
    { Label: 'Cost Price', Value: ProductCostPrice },
    { Label: 'Sell Price', Value: ProductSellPrice }
], UI.FieldGroup #ProductFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Label: 'Product ID', Value: ProductID },
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

annotate ElectronicsDB.StockData with @(UI.LineItem:[
    { Label: 'Stock ID', Value: StockID },
    { Label: 'Store ID', Value: store_id },
    { Label: 'Product ID', Value: product_id },
    { Label: 'Stock Quantity', Value: stock_qty }
], UI.FieldGroup #StockDataFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Label: 'Stock ID', Value: StockID },
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

annotate ElectronicsDB.PurchaseOrder with @(UI.LineItem:[
    { Label: 'Purchase Order Number', Value: PurchaseOrderNumber },
    { Label: 'Business Partner', Value: BusinessPartner },
    { Label: 'Purchase Order Date', Value: PurchaseOrderDate },
    { Label: 'Items', Value: 'Items', Target: '@UI.FieldGroup#PurchaseOrderItemsFieldGroup' }
], UI.FieldGroup #PurchaseOrderItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Label: 'Product ID', Value: Items.items.product.ProductID },
        { $Type: 'UI.DataField', Label: 'Quantity', Value: Items.items.qty },
        { $Type: 'UI.DataField', Label: 'Price', Value: Items.items.price },
        { $Type: 'UI.DataField', Label: 'Store ID', Value: Items.items.store.StoreID }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'PurchaseOrderFacet',
        Label: 'Purchase Order Information',
        Target: '@UI.FieldGroup#PurchaseOrderItemsFieldGroup'
    }
]);

annotate ElectronicsDB.SalesOrder.Items with @(UI.FieldGroup #SalesOrderItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Label: 'Product ID', Value: items.product.ProductID },
        { $Type: 'UI.DataField', Label: 'Quantity', Value: items.qty },
        { $Type: 'UI.DataField', Label: 'Price', Value: items.price },
        { $Type: 'UI.DataField', Label: 'Store ID', Value: items.store.StoreID }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'SalesOrderItemsFacet',
        Label: 'Sales Order Items',
        Target: '@UI.FieldGroup#SalesOrderItemsFieldGroup'
    }
]);

annotate ElectronicsDB.ProductStock.Items with @(UI.FieldGroup #ItemsFieldGroup : {
    $Type: 'UI.FieldGroupType',
    Data: [
        { $Type: 'UI.DataField', Label: 'Purchase Order Number', Value: purchase_order.PurchaseOrderNumber },
        { $Type: 'UI.DataField', Label: 'Sales Order Number', Value: sales_order.SalesOrderNumber },
        { $Type: 'UI.DataField', Label: 'Product ID', Value: product.ProductID },
        { $Type: 'UI.DataField', Label: 'Quantity', Value: qty },
        { $Type: 'UI.DataField', Label: 'Price', Value: price },
        { $Type: 'UI.DataField', Label: 'Store ID', Value: store.StoreID }
    ]
}, UI.Facets: [
    {
        $Type: 'UI.ReferenceFacet',
        ID: 'ItemsFacet',
        Label: 'Items',
        Target: '@UI.FieldGroup#ItemsFieldGroup'
    }
]);
