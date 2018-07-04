const path = require('path')
const webpack = require('webpack')

module.exports = {
  entry: {
    app: [
      './index.js'
    ]
  },

  devServer: {
    hot: true
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.(css|sass)$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
      },
    ],

    noParse: /\.elm$/,
  },
  devServer: {
    inline: true,
    stats: { colors: true },
  },
}
