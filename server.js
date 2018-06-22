const express = require('express');
const path = require('path');
const request = require('request');
const bodyParser = require('body-parser');

const app = express();
const publicPath = path.join(__dirname, './public');
const indexHtmlPath = path.join(__dirname, './public/index.html');

app.use(express.static(publicPath));
// app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.sendFile(indexHtmlPath);
});

app.put('/word-years', (req, res) => {
  console.log(req.body)

  request(req.body.queryString, (err, response, body) => {
      console.log(body)

      body = JSON.parse(body)


    // const rawJSON = JSON.parse(body);
    const wordDict = {};
    body.phrases.forEach((phrase)=>{
        wordDict[phrase.tks[0].tt] = phrase.fy;
    })
    res.send(wordDict);
  })
});

app.listen(3000, () => console.log('Example app listening on port 3000!'))
