const ExtractTextPlugin = require('extract-text-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const path = require('path')
const webpack = require('webpack')

module.exports = {
  devtool: 'cheap-module-source-map',
  entry: './src/SelectFrom/Client.purs',
  module: {
    loaders: [{
      test: /\.purs$/,
      loader: 'purs-loader',
      exclude: /node_modules/,
      query: {
        bundle: true,
        src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs']
      }
    }, {
      test: /\.json$/,
      loaders: ['json']
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract(
        'style', [
          'css?modules&importLoaders=1&localIdentName=[name]__[local]___[hash:base64:5]',
          'resolve-url?sourceMap'
        ]
      )
    }, {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract(
        'style', [
          'css?sourceMap&modules&importLoaders=2&localIdentName=[name]__[local]___[hash:base64:5]',
          'resolve-url?sourceMap',
          'sass?sourceMap'
        ]
      )
    }, {
      test: /\.sass$/,
      loader: ExtractTextPlugin.extract(
        'style', [
          'css?sourceMap&modules&importLoaders=2&localIdentName=[name]__[local]___[hash:base64:5]',
          'resolve-url?sourceMap',
          'sass?sourceMap&indentedSyntax=true'
        ]
      )
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
    new webpack.DefinePlugin({'process.env.NODE_ENV': '"production"'}),
    new HtmlWebpackPlugin({title: 'SELECT FROM'}),
    new ExtractTextPlugin('css/SelectFrom.css', {allChunks: true}),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurrenceOrderPlugin()
  ],
  resolve: {
    root: ['./node_modules'].concat(process.env.NODE_PATH.split(':')),
    extensions: ['', '.js', '.json', '.purs']
  },
  resolveLoader: {
    root: ['./node_modules'].concat(process.env.NODE_PATH.split(':'))
  }
}
