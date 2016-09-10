const path = require('path')

exports.modifyWebpackConfig = function (config) {
  const srcPath = path.join(__dirname, 'src')

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

  return config
    .merge({
      resolve: {
        root: [srcPath],
        extensions: [
          '',
          '.js',
          '.jsx',
          '.cjsx',
          '.coffee',
          '.json',
          '.less',
          '.css',
          '.scss',
          '.sass',
          '.toml',
          '.yaml',
          '.purs',
        ],
      },
      resolveLoader: {
        root: [srcPath],
      },
    })
}
