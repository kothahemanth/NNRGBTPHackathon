using { com.hemanth.nnrg as db } from '../db/schema';
service nnrg {
    entity Business as projection on db.Business;
    entity Store as projection on db.Store {
            @UI.Hidden: true
            ID,
            *
        };

    entity Product as projection on db.Product {
            @UI.Hidden: true
            ID,
            *
        };

    entity Stock as projection on db.Stock;
    entity Items as projection on db.Items;
    entity PurchaseApp as projection on db.PurchaseApp;
    entity States as projection on db.States{
        @UI.Hidden: true
        ID,
        *
    };
}

annotate nnrg.Business with @odata.draft.enabled;
annotate nnrg.States with @odata.draft.enabled;
annotate nnrg.Store with @odata.draft.enabled;
annotate nnrg.Items with @odata.draft.enabled;
annotate nnrg.PurchaseApp with @odata.draft.enabled;
annotate nnrg.Product with @odata.draft.enabled;

annotate nnrg.Business  with {

    pincode @assert.format: '^[1-9][0-9]{5}$';
    is_gstin_number @assert.format: '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[Z]{1}[0-9]{1}$';
}

annotate nnrg.Business with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : bp_number
        },
        
        {
            $Type : 'UI.DataField',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Value : address_1
        },
        {
            $Type : 'UI.DataField',
            Value : address_2
        },
        {
            $Type : 'UI.DataField',
            Value : city
        },
        {
            Label: 'State',
            Value: state.code
        },
        {
            Label: 'State',
            Value: pincode
        },
        {
            $Type : 'UI.DataField',
            Value : is_gstin_number
        },
        {
            $Type : 'UI.DataField',
            Value : is_vendor
        },
        {
            $Type : 'UI.DataField',
            Value : is_customer
        },



    ],
    UI.SelectionFields: [ name,city],
    UI.FieldGroup #BusinessPartnerInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bp_number,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : address_1,
            },
            {
                $Type : 'UI.DataField',
                Value : address_2,
            },
            {
                $Type : 'UI.DataField',
                Value : city,
            },
            {
                Label :'State',
                Value :state_ID,
            },
            {
            Label: 'State',
            Value: pincode,
        },
            {
            $Type : 'UI.DataField',
            Value : is_gstin_number,
        },
        {
            $Type : 'UI.DataField',
            Value : is_vendor,
        },
        {
            $Type : 'UI.DataField',
            Value : is_customer,
        },

        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BusinessPartnerInfoFacet',
            Label : 'BuisinessPartnerInformation',
            Target : '@UI.FieldGroup#BusinessPartnerInformation',
        },

    ],
    
);

annotate nnrg.States with @(
    UI.LineItem: [
        {
            Value: code
        },
        {
            Value: description
        }
    ],
    UI.FieldGroup #States: {
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                Value: code,
            },
            {
                Value: description,
            }
        ],
    },
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'StatesFacet',
            Label: 'States',
            Target: '@UI.FieldGroup#States',
        },
    ],

);
annotate nnrg.Business  with {
    state @(
        Common.Text:state.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'States',
            CollectionPath : 'States',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : state_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    )
};

/*STORE*/
annotate nnrg.Store with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : store_id
        },
        
        {
            $Type : 'UI.DataField',
            Value : name
        },
        {
            $Type : 'UI.DataField',
            Value : address_1
        },
        {
            $Type : 'UI.DataField',
            Value : address_2
        },
        {
            $Type : 'UI.DataField',
            Value : city
        },
        {
            Label: 'State',
            Value: state.code
        },
        {
            Label: 'State',
            Value: pincode
        },

    ],
    UI.SelectionFields: [ name,city],
    UI.FieldGroup #StoreInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : store_id,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : address_1,
            },
            {
                $Type : 'UI.DataField',
                Value : address_2,
            },
            {
                $Type : 'UI.DataField',
                Value : city,
            },
            {
                Label :'State',
                Value :state_ID,
            },
            {
            Label: 'State',
            Value: pincode,
        },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StoreInfoFacet',
            Label : 'StoreInformation',
            Target : '@UI.FieldGroup#StoreInformation',
        },

    ],
    
);
annotate nnrg.Store  with {
    state @(
        Common.Text:state.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'States',
            CollectionPath : 'States',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : state_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    )
};

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
            Label: 'Price',
            Value: price.sell_price
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
            Value: b_id
        },
        {
            Label: 'Business Partner',
            Value: bp.name
        },
        {
            Label: 'Product purchase Date',
            Value: pDate
        },
        {
            Label: 'store id',
            Value: Items.item.storeId
        },
        {
            Label: 'quantity',
            Value: Items.item.qty
        },
        {
            Label: 'Product id',
            Value: Items.item.productId
        },
        {
            Label: 'Price',
            Value: Items.item.price
        },
    ],
    UI.FieldGroup #purApp: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Purchase Order Number',
                Value: b_id
            },
            {
                Label: 'Business Partner',
                Value: bp.name
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

/*product*/
annotate nnrg.Product with @(
    UI.LineItem: [
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
            Value : image_url
        },
        {
            $Type : 'UI.DataField',
            Value : cost_price
        },
        {
            $Type : 'UI.DataField',
            Value : sell_price
        },

    ],
    UI.SelectionFields: [product_name],
    UI.FieldGroup #ProductInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : product_id,
            },
            {
                $Type : 'UI.DataField',
                Value : product_name,
            },
            {
                $Type : 'UI.DataField',
                Value : image_url,
            },
            {
                $Type : 'UI.DataField',
                Value : cost_price,
            },
            {
                $Type : 'UI.DataField',
                Value : sell_price,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ProductInfoFacet',
            Label : 'ProductInformation',
            Target : '@UI.FieldGroup#ProductInformation',
        },

    ],
    
);

/* Stock */
annotate nnrg.Stock with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : store_id_ID
        },
        
        {
            $Type : 'UI.DataField',
            Value : product_id_ID
        },
        {
            Label: 'Stock Quantity',
            Value: stock_qty
        },
    ],
    UI.FieldGroup #StoreInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value : store_id_ID,
        },
        
        {
            $Type : 'UI.DataField',
            Value : product_id_ID,
        },
        {
            Label: 'State',
            Value: stock_qty,
        },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'St0ckInfoFacet',
            Label : 'StockInformation',
            Target : '@UI.FieldGroup#StockInformation',
        },
        /*
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentLanguagesFacet',
            Label : 'Student Languages Information',
            Target : 'Languages/@UI.LineItem',
        },
      */
    ],
    
);

annotate nnrg.Stock.Store with @(
    UI.LineItem:[
        {
            Label: 'StockStore',
            Value: Store.store_ID
        },
    ],

    UI.FieldGroup #StockStore : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value :store_ID ,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StockStoreFacet',
            Label : 'StockStore',
            Target : '@UI.FieldGroup#StockStore',
        },
    ],
);
annotate nnrg.Stock.Product with @(
    UI.LineItem:[
        {
            Label: 'StockProduct',
            Value: Product.product_ID
        },
    ],
    UI.FieldGroup #StockProduct : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value :product_ID ,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StockProductFacet',
            Label : 'StockProduct',
            Target : '@UI.FieldGroup#StockProduct',
        },
    ],
);