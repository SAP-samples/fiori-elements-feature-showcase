const cds = require('@sap/cds');
const express = require('express');

module.exports = (o) => {
    cds.on('bootstrap', app => {
        const ui5 = 'https://ui5.sap.com';
        ['resources', 'test-resources'].forEach(x => {
            console.log('overlaying', x)
            const proxy = require('http-proxy').createProxyServer({
                host: ui5,
                changeOrigin: true,
            });
            app.use(`/${x}`, express.static(`ui5overlay/${x}`));
            app.use(`/${x}`, function (req, res, next) {
                proxy.web(req, res, {
                    target: `${ui5}/${x}`
                }, next);
            });
        });
    });

    // delegate to default server
    return cds.server(o);
}
