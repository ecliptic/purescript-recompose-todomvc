import devMiddleware from 'webpack-dev-middleware'
import findup from 'findup-sync'
import morgan from 'morgan'
import path from 'path'
import webpack from 'webpack'

export {devMiddleware, morgan}

const config = require(findup(`webpack.${process.env.NODE_ENV}.js`))
const compiler = webpack(config)

const index = path.join(config.output.path, 'index.html')

export function getPublicPath () {
  return config.output.publicPath
}

export function getCompiler () {
  return compiler
}

export function getIndexHtml () {
  return compiler.outputFileSystem.readFileSync(index)
}
