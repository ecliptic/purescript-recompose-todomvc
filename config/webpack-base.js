import Config from 'webpack-configurator'
import dotenv from 'dotenv'
import path from 'path'
import Webpack from 'webpack'

// Load environment variables from a .env file if it exists
dotenv.config({silent: true})

const config = new Config()
const srcPath = path.join(__dirname, '..', 'src')

config.merge({
  output: {
    path: path.join(__dirname, '..', 'public'),
    filename: 'bundle.js',
    libraryTarget: 'umd',
  },
  resolve: {
    root: [srcPath],
    packageMains: ['webpack', 'browser', 'web', 'browserify', ['jam', 'main'], 'main'],
    extensions: ['', '.js', '.jsx', '.json', '.css', '.purs'],
  },
  noParse: /\.min\.js/,
  target: 'web',
})

// JavaScript
config.loader('js', {
  test: /\.jsx?$/,
  loaders: ['babel'],
  exclude: /node_modules/,
})
config.loader('json', {
  test: /\.json$/,
  loader: 'json',
})

// PureScript
config.loader('purescript', {
  test: /\.purs$/,
  loader: 'purs',
  exclude: /node_modules/,
  query: {
    psc: 'psa',
    src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs'],
    warnings: false,
  },
})

// Images
config.loader('images', {
  test: /\.(jpe?g|png|gif|svg)(\?.*)?$/i,
  loaders: [
    'url-loader?limit=10000',
    'image-webpack-loader?{progressive:true, optimizationLevel: 7, interlaced: false, pngquant:{quality: "65-90", speed: 4}}', // eslint-disable-line
  ],
})

// Fonts
config.loader('woff', {
  test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
  loader: 'url-loader?limit=10000&minetype=application/font-woff',
})
config.loader('ttf', {
  test: /\.(ttf)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
  loader: 'file-loader',
})
config.loader('eot', {
  test: /\.(eot)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
  loader: 'file-loader',
})

// Plugins
config.plugin('define-env', Webpack.DefinePlugin, [{
  'process.env': {
    NODE_ENV: JSON.stringify(process.env.NODE_ENV) || 'production',
    HOT: JSON.stringify(process.env.HOT) || undefined,
  },
}])

export default config
