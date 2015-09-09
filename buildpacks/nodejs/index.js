var http = require('http');
var port = process.env.VCAP_APP_PORT || 3003

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end("<html><head><title>nodejs_buildpack</title></head><body>OK!</body></html>");
}).listen(port);