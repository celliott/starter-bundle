#!/usr/bin/env node

const express = require('express');
const	basicAuth = require('basic-auth');
const	logger = require('morgan');
const data = require('./data');

const	api_port = process.env['API_PORT'] || 3000;
const api_host = process.env['API_HOST'] || '0.0.0.0';
const	api_user = process.env['API_USER'] || 'admin';
const	api_pass = process.env['API_PASS'];

const app = express();
app.use(logger('dev'));

var auth = function (req, res, next) {
	function unauthorized(res) {
		res.set('WWW-Authenticate', 'Basic realm=Authorization Required');
		return res.status(401).send({ msg: 'Not Authorized' })
	}
	var user = basicAuth(req)
	if (!user || !user.name || !user.pass) {
		return unauthorized(res);
	}
	if (user.pass === api_pass) {
		return next();
	} else {
		return unauthorized(res);
	}
}

app.get('/healthz', function(req, res, next) {
	res.status(200).send({status: "ok"});
})

app.get('/', auth, function(req, res, next) {
	res.status(200).send(data);
})

app.listen(api_port, api_host, function(){
  console.log(`Running on http://${api_host}:${api_port}`);
})
