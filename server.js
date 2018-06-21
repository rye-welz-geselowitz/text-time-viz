const express = require('express');
const path = require('path');
const request = require('request');

const app = express();
const publicPath = path.join(__dirname, './public');
const indexHtmlPath = path.join(__dirname, './public/index.html');

app.use(express.static(publicPath));

app.get('/', (req, res) => {
    res.sendFile(indexHtmlPath);
});

app.get('/test', (req, res) => {
  request('http://phrasefinder.io/search?query=shall&corpus=eng-gb', (err, response, body) => {
    res.send(JSON.parse(body));
  })
});

app.listen(3000, () => console.log('Example app listening on port 3000!'))
