import config from './webpack-base'
import ExtractTextPlugin from 'extract-text-webpack-plugin'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import Webpack from 'webpack'

config.merge({
  bail: true,
  debug: false,
  profile: false,
  devtool: 'cheap-module-source-map',
  entry: ['./src/Todo/Views/Index.jsx'],
})

config.loader('css', {
  test: /\.css$/,
  loader: ExtractTextPlugin.extract(['css?minimize']),
})

config.plugin('html', HtmlWebpackPlugin, [{
  filename: 'index.html',
  template: 'assets/index.html',
  showErrors: false,
}])
config.plugin('occurrence-order', Webpack.optimize.OccurrenceOrderPlugin)
config.plugin('minify', Webpack.optimize.UglifyJsPlugin, [{
  compress: {
    screw_ie8: true,
    warnings: false,
  },
  comments: false,
}])
config.plugin('extract-styles', ExtractTextPlugin, [
  'style.css',
  {allChunks: true},
])

export default config.resolve()
