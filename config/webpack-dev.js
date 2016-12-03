import config from './webpack-base'
import Webpack from 'webpack'
import HtmlWebpackPlugin from 'html-webpack-plugin'

const port = process.env.PORT
  ? parseInt(process.env.PORT, 10)
  : 3000

config.merge({
  debug: true,
  devtool: 'inline-source-map',
  entry: [
    `webpack-hot-middleware/client?path=http://localhost:${port}/__webpack_hmr`,
    './src/Todo/Views/Index.jsx',
  ],
  output: {
    publicPath: `http://localhost:${port}/`,
  },
})

config.loader('css', {
  test: /\.css$/,
  loaders: ['style', 'css?sourceMap'],
})

config.plugin('html', HtmlWebpackPlugin, [{
  filename: 'index.html',
  template: 'assets/index.html',
  showErrors: false,
}])
config.plugin('hot-module', Webpack.HotModuleReplacementPlugin)
config.plugin('no-errors', Webpack.NoErrorsPlugin)

export default config.resolve()
