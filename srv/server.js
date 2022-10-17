const cds = require('@sap/cds');
const proxy = require('@sap/cds-odata-v2-adapter-proxy'); //middle ware

cds.on('bootstrap', app => {
    app.use(proxy());
});

//bootstrap event is default event which will trigger when capm starts

module.exports = cds.server;


