const express = require('express');
const path = require('path');

const app = express();
const publicPath = path.join(__dirname, './public');
const indexHtmlPath = path.join(__dirname, './public/index.html');

app.use(express.static(publicPath));

app.get('/', (req, res) => {
    res.sendFile(indexHtmlPath);
});

app.listen(3000, () => console.log('Example app listening on port 3000!'))
