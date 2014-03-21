'use strict';

var http     =  require('http');
var fs       =  require('fs');
var path     =  require('path');

var slaveId = process.env.SLAVE_ID;

function serveError (res, err) {
  console.error(err);
  res.writeHead(500, { 'Content-Type': 'text/plain' });
  res.end(err.toString());
}

function serveIndex (res) {
  res.writeHead(200, { 'Content-Type': 'text/html' });
  fs.readFile(path.join(__dirname, 'static', 'index.html'), 'utf8', function (err, html) {
    if (err) return serveError(res, err);
    res.end(html.replace(/\{\{slave-id\}\}/, slaveId));
  });
}

function serveCss (res) {
  res.writeHead(200, { 'Content-Type': 'text/css' });
  fs.createReadStream(path.join(__dirname, 'static', 'index.css')).pipe(res); 
}

var server = http.createServer(function (req, res) {
  console.log('[slave-%d] %s %s', slaveId, req.method, req.url);
  if (req.url === '/') return serveIndex(res);
  if (req.url === '/index.css') return serveCss(res);
  res.writeHead(404);
  res.end();
});

server.on('listening', function (address) {
  var a = server.address();
  console.log('[slave-%d] listening: http://%s:%d', slaveId, a.address, a.port);  
});
server.listen(3000);
