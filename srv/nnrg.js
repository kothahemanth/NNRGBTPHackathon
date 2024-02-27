const cds=require('@sap/cds')
module.exports = cds.service.impl(async function () {
    const { States, Business_Partner, Product} = this.entities;
    this.on("READ", Business_Partner, async (req) => {
        const results = await cds.run(req.query);
        return results;
      });
    this.before("CREATE",  Business_Partner, async (req) => {
        const { bp_no, Is_gstn_registered, Gst_num } = req.data;
        if (Is_gstn_registered && !Gst_num) {
            req.error({
                code: "MISSING_GST_NUM",
                message: "GSTIN number is mandatory when Is_gstn_registered is true",
                target: "Gst_num",
            });
        }
        this.before(["CREATE"], Product, async (req) => {
          const { product_cost, product_sell } = req.data;
          if (product_sell < product_cost) {
              req.error({
                  code: "INVALID_SELLING_PRICE",
                  message: "Selling price should not be less than Cost Price",
                  target: "product_sell",
              });
          }
      });

        const query1 = SELECT.from( Business_Partner).where({ bp_no: req.data.bp_no });
        const result = await cds.run(query1); // Execute the query using cds.run()
        if (result.length > 0) {
          req.error({
            code: "STEMAILEXISTS",
            message: " already exists",
            target: "bp_no",
          });
        }
        
      });
      
      this.on('READ',States,async(req)=>{
        stat=[
            {"code":"TS","description":"Telangana"},
            {"code":"AY","description":"Ayodha"},
            {"code":"DL","description":"Delhi"},
        ]
        stat.$count=stat.length
        return stat;
    })

    this.before(["CREATE", "UPDATE"], Business_Partner, async (req) => {
        const results = await cds
        .transaction(req)
        .run(SELECT.from(Business_Partner));
        const count = results.length;
    
        req.data.bp_no = count + 1;
      });
})