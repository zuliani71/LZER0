"use strict"; // needed for the (let, const, function, class) not yet supported outside strict mode
var express = require('express');
var app = express();
app.use('/', express.static(__dirname + '/')); // tells where to find the js scripts inside the html file
var http = require('http').Server(app);
var io = require('socket.io')(http);
require('events').EventEmitter.prototype._maxListeners = 0; // needed to remove the (node) warning: possible EventEmitter memory leak detected.
//
// load the html file
app.get('/', function(req, res){
	res.sendFile(__dirname + '/index.BRU.html');
	console.log(__dirname);
});
//
// waiting for connections
http.listen(3099, "0.0.0.0", function(){
  console.log('listening on *:3099');
});
