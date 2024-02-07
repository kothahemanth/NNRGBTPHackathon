using { com.hemanth.nnrg as db } from '../db/schema';
service nnrg {
    entity Business as projection on db.Business;
    entity Store as projection on db.Store;
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
annotate nnrg.BusinessPartner  with {
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