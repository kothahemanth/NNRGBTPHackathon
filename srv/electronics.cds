using {com.test.sdb as db} from '../db/schema';

service Market {
    entity Business_Partner as projection on db.Business_Partner;
    entity States           as projection on db.States;
    entity Store            as projection on db.Store {
        @UI.Hidden : true
        ID,
        *
    };
    entity Product          as projection on db.Product {
        @UI.Hidden : true
        ID,
        *
    };
    entity Stock            as projection on db.Stock;
}

annotate Market.Business_Partner with @odata.draft.enabled;
annotate Market.Store with @odata.draft.enabled;
annotate Market.Product with @odata.draft.enabled;
annotate Market.Stock with @odata.draft.enabled;

annotate Market.Business_Partner with {
    pinCode @assert.format: '^[0-9]{6}$';
    Gst_num @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
};

annotate Market.States with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    }
]);

annotate Market.Business_Partner with @(
    UI.LineItem : [
        {
            Label: 'Business Partner Id',
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
            Label: 'Is GSTN Registered',
            Value: Is_gstn_registered
        },
        {
            Label: 'GSTIN Number',
            Value: Gst_num
        }
    ],
    UI.FieldGroup #BusinessP: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                $Type: 'UI.DataField',
                Label: 'Business Partner Id',
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
            { Value: Is_gstn_registered },
            {
                $Type: 'UI.DataField',
                Value: Gst_num
            }
        ],
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'BusinessPFacet',
            Label: 'BusinessP',
            Target: '@UI.FieldGroup#BusinessP'
        }
    ]
);


annotate Market.Store with @(
    UI.LineItem : [
        {
            Label: 'Store Id',
            Value: store_id
        },
        {
            Label: 'Store Name',
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
            Label: 'Pin Code',
            Value: PinCode
        }
    ],
    UI.FieldGroup #store: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                Label: 'Store Id',
                Value: store_id
            },
            {
                Label: 'Store Name',
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
                Label: 'Pin Code',
                Value: PinCode
            }
        ]
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'storeFacet',
            Label: 'Store Facets',
            Target: '@UI.FieldGroup#store'
        }
    ]
);


annotate Market.Product with @(
    UI.LineItem : [
        {
            Label: 'Product Id',
            Value: p_id
        },
        {
            Label: 'Product Name',
            Value: name
        },
        {
            Label: 'Product Image URL',
            Value: imageURL
        },
        {
            Label: 'Cost Price',
            Value: costPrice
        },
        {
            Label: 'Sell Price',
            Value: sellPrice
        }
    ],
    UI.FieldGroup #product: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                Label: 'Product Id',
                Value: p_id
            },
            {
                Label: 'Product Name',
                Value: name
            },
            {
                Label: 'Product Image URL',
                Value: imageURL
            },
            {
                Label: 'Cost Price',
                Value: costPrice
            },
            {
                Label: 'Sell Price',
                Value: sellPrice
            }
        ]
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'productFacet',
            Label: 'Product Facets',
            Target: '@UI.FieldGroup#product'
        }
    ]
);

annotate Market.Stock with @(
    UI.LineItem : [
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
        Data: [
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
        ]
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'stockFacet',
            Label: 'Stock Facets',
            Target: '@UI.FieldGroup#stock'
        }
    ]
);
