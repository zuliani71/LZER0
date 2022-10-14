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
	res.sendFile(__dirname + '/index.BRU3.html');
	console.log(__dirname);
});
//
// TCP/IP socket
io.on('connection', function(socket){
	// print message to the server
	console.log('Yay, connection was recorded');
	// test the readTCP stream
	var HOST='crsbru3.dyndns.org';
	var PORT='5754';
	var net = require('net');
	let client = new net.Socket()
	function connect() {
		console.log("new client")
		var client = net.connect(PORT, HOST, function() {
			console.log('connected to server!');
		});
		client.on('data', function(data) {
		var messageToSend = data.toString().replace(/(\n|\r)+$/, '');
			console.log(messageToSend);
			// sending data to the web client
			// io.emit('chat message', messageToSend); // emit an event to all connected sockets
			socket.emit('chat message', messageToSend); // emit an event to the socket
			//handling disconnects
			socket.on('disconnect', function() {
				io.emit('chat message', 'some user disconnected');
				client.end();
				client.destroy();
			});
		});
		client.on('end', function() {
			console.log('disconnected from server');
			reconnect()
		});

	}
	// function that reconnect the client to the server
	function reconnect () {
		setTimeout(() => {
			client.removeAllListeners() // the important line that enables you to reopen a connection
			connect()
		}, 1000)
	}
	connect()
});
http.listen(3013, function(){
  console.log('listening on *:3013');
});
