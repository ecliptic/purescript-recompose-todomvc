const HtmlWebpackPlugin = require('html-webpack-plugin')
const path = require('path')
const webpack = require('webpack')

const nodeModules = path.join(__dirname, '/node_modules')

module.exports = {
  devtool: 'eval',
  entry: './src/SelectFrom/Init.js',
  module: {
    loaders: [{
      test: /\.purs$/,
      loader: 'purs',
      exclude: /node_modules/,
      query: {
        psc: 'psa',
        src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs'],
        warnings: false
      }
    }, {
      test: /\.json$/,
      loaders: ['json']
    }, {
      test: /\.css$/,
      loaders: [
        'style?singleton',
        'css?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]',
        'resolve-url?sourceMap'
      ]
    }, {
      test: /\.scss$/,
      loaders: [
        'style?singleton',
        'css?sourceMap&modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]',
        'resolve-url?sourceMap',
        'sass?sourceMap'
      ]
    }, {
      test: /\.sass$/,
      loaders: [
        'style?singleton',
        'css?sourceMap&modules&importLoaders=2&localIdentName=[name]__[local]___[hash:base64:5]',
        'resolve-url?sourceMap',
        'sass?sourceMap&indentedSyntax=true'
      ]
    }, {
      test: /\.(png|gif|jpe?g)$/i,
      loaders: [
        'file?hash=sha512&digest=hex&name=[hash].[ext]',
        'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
      ]
    }, {
      test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: 'url?limit=10000&mimetype=application/font-woff&hash=sha512&digest=hex&name=[hash].[ext]'
    },
    {
      test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: 'url?limit=10000&hash=sha512&digest=hex&name=[hash].[ext]'
    }
  ]},
  output: {
    path: path.join(__dirname, 'build'),
    publicPath: '/',
    filename: 'js/SelectFrom.js'
  },
  plugins: [
    new webpack.DefinePlugin({'process.env.NODE_ENV': '"development"'}),
    new HtmlWebpackPlugin({title: 'SELECT FROM'}),
    new webpack.NoErrorsPlugin()
  ],
  resolve: {
    root: [nodeModules].concat(process.env.NODE_PATH.split(':')),
    extensions: ['', '.js', '.json', '.purs']
  },
  resolveLoader: {
    root: [nodeModules].concat(process.env.NODE_PATH.split(':'))
  }
}
