const path = require('path');

module.exports = {
  entry: {
	popup : './src/popup.jsx',
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js',
  },
};