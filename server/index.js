const express = require('express');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

// Enable CORS
app.use(cors());

// Proxy requests to the target API
app.use(
  '/api',
  createProxyMiddleware({
    target: 'https://api.oros.dahobul.com',
    changeOrigin: true,
    pathRewrite: { '^/api': '' },
  })
);

// Export the app for Vercel
module.exports = app;