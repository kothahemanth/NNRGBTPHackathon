using { com.hemanth.nnrg as db } from '../db/schema';
service nnrg {
    entity Business as projection on db.Business;
    entity Store as projection on db.Store;
    entity Product as projection on db.Product;
    
    entity States as projection on db.States{
        @UI.Hidden: true
        ID,
        *
    };
}
annotate nnrg.Business with @odata.draft.enabled;
annotate nnrg.States with @odata.draft.enabled;
annotate nnrg.Store with @odata.draft.enabled;
annotate nnrg.Business  with {
    name      @assert.format: '^[a-zA-Z]{2,}$';
    pincode @assert.format: '^[1-9][0-9]{5}$';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
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
        {
            $Type : 'UI.DataField',
            Value : is_gstn_registered
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
        {
            $Type : 'UI.DataField',
            Value : is_gstn_registered,
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