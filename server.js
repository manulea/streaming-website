const express = require('express');
const app = express();
const path = require('path');

// Serve static assets from node_modules
app.use('/node_modules', express.static(path.join(__dirname, 'node_modules')));

// Serve your HTML file
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});