const findup = require('findup-sync')
const path = require('path')
const webpack = require('webpack')

exports.devMiddleware = require('webpack-dev-middleware')
exports.morgan = require('morgan')

const config = require(findup('webpack.' + process.env.NODE_ENV + '.js'))
const compiler = webpack(config)

const index = path.join(config.output.path, 'index.html')

exports.getPublicPath = function getPublicPath () {
  return config.output.publicPath
}

exports.getCompiler = function getCompiler () {
  return compiler
}

exports.getIndexHtml = function getIndexHtml () {
  return compiler.outputFileSystem.readFileSync(index)
}
