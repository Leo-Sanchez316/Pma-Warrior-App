#!/bin/bash

echo "=== PMA Warrior Render Build ==="

# Install dependencies
echo "Installing dependencies..."
npm install

# Build client from client directory 
echo "Building client (React app)..."
cd client
npm run build 2>/dev/null || (
  echo "No client package.json, building with main vite..."
  cd ..
  npx vite build
)
cd ..

# Build server
echo "Building server (Express API)..."
npx esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist

echo "Build complete!"
echo "Client: dist/public/"
echo "Server: dist/index.js"