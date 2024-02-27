using { com.hemanth.nnrg as db } from '../db/schema';

service nnrg {
    entity Business_Partner as projection on db.Business_Partner;
    entity States           as projection on db.States;

    entity Store            as
        projection on db.Store {
            @UI.Hidden: true
            ID,
            *
        };

    entity Product          as
        projection on db.Product {
            @UI.Hidden: true
            ID,
            *
        };

    entity Stock            as projection on db.Stock;
    entity Items            as projection on db.Items;
    entity PurchaseApp      as projection on db.PurchaseApp;
}

annotate nnrg.Business_Partner with @odata.draft.enabled;
annotate nnrg.Store with @odata.draft.enabled;
annotate nnrg.Product with @odata.draft.enabled;
annotate nnrg.Stock with @odata.draft.enabled;
annotate nnrg.PurchaseApp with @odata.draft.enabled;
annotate nnrg.Items with @odata.draft.enabled;

annotate nnrg.Business_Partner with {
    pinCode @assert.format: '^[1-9][0-9]{5}$';
    Gst_num @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
}

annotate nnrg.States with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],

);

annotate nnrg.Business_Partner with @(
    UI.LineItem             : [

        {
            Label: 'Bussiness Partner Id',
            Value: bp_no
        },
        {
            Label: 'Name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Is_gstn_registered',
            Value: Is_gstn_registered
        },
        {
            $Type : 'UI.DataField',
            Value : Is_vendor
        },
        {
            $Type : 'UI.DataField',
            Value : Is_customer
        },
        {
            Label: 'GSTIN Number',
            Value: Gst_num
        },
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Bussiness Partner Id',
                Value: bp_no
            },
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: add1
            },
            {
                $Type: 'UI.DataField',
                Value: add2
            },
            {
                $Type: 'UI.DataField',
                Value: city
            },
            {
                $Type: 'UI.DataField',
                Value: pinCode
            },
            {
                $Type: 'UI.DataField',
                Value: state_code
            },
            {
            $Type : 'UI.DataField',
            Value : Is_vendor
            },
            {
            $Type : 'UI.DataField',
            Value : Is_customer
            },
            {
                $Type : 'UI.DataField',
                Value: Is_gstn_registered},
            {
                $Type: 'UI.DataField',
                Value: Gst_num
            },
        ],
    },
    UI.Facets               : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'BusinessPFacet',
        Label : 'BusinessP',
        Target: '@UI.FieldGroup#BusinessP',
    }, ],
);


annotate nnrg.Store with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: store_id
        },
        {
            Label: 'Store name',
            Value: name
        },
        {
            Label: 'Address 1',
            Value: add1
        },
        {
            Label: 'Address 2',
            Value: add2
        },
        {
            Label: 'City',
            Value: city
        },
        {
            Label: 'State',
            Value: state_code
        },
        {
            Label: 'Pin code',
            Value: PinCode // corrected to PinCode
        },
    ],
    UI.FieldGroup #store: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: store_id
            },
            {
                Label: 'Store name',
                Value: name
            },
            {
                Label: 'Address 1',
                Value: add1
            },
            {
                Label: 'Address 2',
                Value: add2
            },
            {
                Label: 'City',
                Value: city
            },
            {
                Label: 'State',
                Value: state_code
            },
            {
                Label: 'Pin code',
                Value: PinCode
            },
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'storeFacet',
        Label : 'store facets',
        Target: '@UI.FieldGroup#store'
    }, ],
);


annotate nnrg.Product with {
@Common.Text : ' {Product}'
@Core.IsURL: true
@Core.MediaType: 'image/jpg'
product_img;
};

annotate nnrg.Product with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Label:'ProductID',
            Value : product_id
        },
        {
            $Type : 'UI.DataField',
            Value : product_name
        },
        {
            $Type : 'UI.DataField',
            Value : product_img
        },
        {
            $Type : 'UI.DataField',
            Value : product_cost
        },
        {
            $Type : 'UI.DataField',
            Value : product_sell
        }
    ],  
);
annotate nnrg.Product with @(       
    UI.FieldGroup #ProductInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            
            Value : product_id
        },
        {
            $Type : 'UI.DataField',
            Value : product_name
        },
        {
            $Type : 'UI.DataField',
            Value : product_img
        },
        {
            $Type : 'UI.DataField',
            Value : product_cost
        },
        {
            $Type : 'UI.DataField',
            Value : product_sell
        }
        
        ],
    },


    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ProductInfoFacet',
            Label : 'Product Information',
            Target : '@UI.FieldGroup#ProductInformation',
        },
        
        
        
    ],    
);

annotate nnrg.Stock with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: storeId_ID
        },
        {
            Label: 'Product Id',
            Value: productId_ID
        },
        {
            Label: 'Stock Quantity',
            Value: stock_qty
        }
    ],
    UI.FieldGroup #stock: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: storeId_ID
            },
            {
                Label: 'Product Id',
                Value: productId_ID
            },
            {
                Label: 'Stock Quantity',
                Value: stock_qty
            }
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'stockFacet',
        Label : 'stock facets',
        Target: '@UI.FieldGroup#stock'
    }, ],
);

annotate nnrg.Items with @(
    UI.LineItem         : [
        {
            Label: 'Store Id',
            Value: storeId.store_id
        },
        {
            Label: 'Quantity',
            Value: qty.stock_qty
        },
        {
            Label: 'Product',
            Value: productId.product_id
        },
        {
            Label: 'Price',
            Value: price.product_sell
        },

    ],

    UI.FieldGroup #items: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Store Id',
                Value: storeId_ID
            },
            {
                Label: 'Quantity',
                Value: qty_ID
            },
            {
            Label: 'Product',
            Value: productId_ID
            },
            {
            Label: 'Price',
            Value: price_ID
            },
        ],
    },
    UI.Facets           : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'itemsFacet',
        Label : 'items',
        Target: '@UI.FieldGroup#items',
    }, ],
);

annotate nnrg.PurchaseApp with @(
    UI.LineItem          : [
        {
            Label: 'Purchase Order Number',
            Value: pon
        },
        {
            Label: 'Business Partner',
            Value: bp_ID
        },
        {
            Label: 'Product purchase Date',
            Value: pDate
        },
        {
            Label: 'store id',
            Value: Items.item.storeId_ID
        },
        {
            Label: 'quantity',
            Value: Items.item.qty_ID
        },
        {
            Label: 'Product id',
            Value: Items.item.productId_ID
        },
        {
            Label: 'Price',
            Value: Items.item.price_ID
        },
    ],
    UI.FieldGroup #purApp: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Purchase Order Number',
                Value: pon
            },
            {
                Label: 'Business Partner',
                Value: bp_ID
            },
            {
                Label: 'Product purchase Date',
                Value: pDate
            },
        ],
    },
    UI.Facets            : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'purAppFacet',
            Label : 'purApp facets',
            Target: '@UI.FieldGroup#purApp'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'itemssFacet',
            Label : ' facets',
            Target: 'Items/@UI.LineItem'
        },
    ],
);

annotate nnrg.PurchaseApp with {
    bp @(
        Common.Text: bp.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Business_Partner',
            CollectionPath: 'Business_Partner',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: bp_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
};
annotate nnrg.PurchaseApp.Items with {
    item @(
        Common.Text: item.productId.product_name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Items',
            CollectionPath : 'Items',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : item_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'productId'
                },
            ]
        }
    )
};

annotate nnrg.PurchaseApp.Items with @(
    UI.LineItem               : [{Value: item_ID},

    ],
    UI.FieldGroup #purAppitems: {
        $Type    : 'UI.FieldGroupType',
        Data     : [
            {Value: item_ID},
            
        ],
    },
        UI.Facets: [{
            $Type : 'UI.ReferenceFacet',
            ID    : 'purAppitemsFacet',
            Label : 'purAppitems',
            Target: '@UI.FieldGroup#purAppitems',
        }, ]
);
annotate nnrg.Business_Partner with {
    state @(
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

annotate nnrg.Store with {
    state @(
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

annotate nnrg.Stock with {
    storeId   @(
        Common.Text: storeId.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Store id',
            CollectionPath: 'Store',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: storeId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
    productId @(
        Common.Text: productId.product_name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Product id',
            CollectionPath: 'Product',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: productId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'product_name'
                },

            ]
        }
    );
}

annotate nnrg.Items with {
    storeId   @(
        Common.Text: storeId.name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Store id',
            CollectionPath: 'Store',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: storeId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },

            ]
        }
    );
    productId @(
        Common.Text: productId.product_name,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Product id',
            CollectionPath: 'Product',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: productId_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'product_name'
                },

            ]
        }
    );
    qty       @(
        Common.Text: qty.stock_qty,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Quantity',
            CollectionPath: 'Stock',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: qty_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'stock_qty'
                },

            ]
        }
    );
    price     @(
        Common.Text: price.product_sell,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            Label         : 'Price',
            CollectionPath: 'Product',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: price_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'product_sell'
                },

            ]
        }
    );
}