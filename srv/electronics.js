const cds = require('@sap/cds');

module.exports = cds.service.impl(async (srv) => {
  const { BusinessPartner, Store, Product, StockData, PurchaseApp, PurchaseItem, SalesApp, SalesItem } = srv.entities;

  // Implementation of service functions

  // Business Partner Validation
  srv.before('CREATE', 'BusinessPartner', async (req) => {
    const { GSTINNumber, Is_gstn_registered } = req.data;
    if (Is_gstn_registered && !GSTINNumber) {
      req.error(400, 'GSTIN Number is mandatory when GSTN is registered');
    }
  });

  // Purchase Price Validation
  srv.before('CREATE', 'PurchaseItem', async (req) => {
    const { product_id, price } = req.data;
    const product = await cds.tx(req).run(SELECT.from(Product).where({ ProductID: product_id }));
    if (product && product.ProductCostPrice && price > product.ProductCostPrice) {
      req.error(400, 'Price should not be more than the cost price');
    }
  });

  // Sales Price Validation
  srv.before('CREATE', 'SalesItem', async (req) => {
    const { product_id, price } = req.data;
    const product = await cds.tx(req).run(SELECT.from(Product).where({ ProductID: product_id }));
    if (product && product.ProductSellPrice && price < product.ProductSellPrice) {
      req.error(400, 'Price should not be less than the sell price');
    }
  });

  // Stock Update on Purchase
  srv.after('CREATE', 'PurchaseApp', async (req) => {
    const { Items } = req.data;
    for (const item of Items) {
      const stockData = await cds.tx(req).run(SELECT.one(StockData).where({ store_id: item.store_id, product_id: item.product_id }));
      if (stockData) {
        stockData.stock_qty += item.qty;
        await cds.tx(req).run(UPDATE(StockData).set(stockData).where({ store_id: item.store_id, product_id: item.product_id }));
      } else {
        await cds.tx(req).run(INSERT.into(StockData).entries({ store_id: item.store_id, product_id: item.product_id, stock_qty: item.qty }));
      }
    }
  });

  // Stock Update on Sales
  srv.after('CREATE', 'SalesApp', async (req) => {
    const { Items } = req.data;
    for (const item of Items) {
      const stockData = await cds.tx(req).run(SELECT.one(StockData).where({ store_id: item.store_id, product_id: item.product_id }));
      if (stockData && stockData.stock_qty >= item.qty) {
        stockData.stock_qty -= item.qty;
        await cds.tx(req).run(UPDATE(StockData).set(stockData).where({ store_id: item.store_id, product_id: item.product_id }));
      } else {
        req.error(400, 'Insufficient stock for the sales');
      }
    }
  });
  this.on('READ',States,async(req)=>{
    genders=[
        {"code":"TS","description":"Telangana"},
        {"code":"AP","description":"Andra Pradesh"},
        {"code":"TN","description":"Tamil Nadu"},
    ]
    genders.$count=genders.length
    return genders;
  })
});