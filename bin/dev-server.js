import config from '../config/webpack-dev'
import express from 'express'
import open from 'open'
import webpack from 'webpack'
import webpackDevMiddleware from 'webpack-dev-middleware'
import webpackHotMiddleware from 'webpack-hot-middleware'

const app = express()
const compiler = webpack(config)
const PORT = parseInt(process.env.PORT, 10) || 3000

const devMiddleware = webpackDevMiddleware(compiler, {
  publicPath: config.output.publicPath,
  stats: {colors: true},
})

app.use(devMiddleware)

app.use(webpackHotMiddleware(compiler))

const server = app.listen(PORT, 'localhost', serverError => {
  if (serverError) return console.error(serverError)

  console.log(`Listening at http://localhost:${PORT}`)
  open(`http://localhost:${PORT}`)
})

process.on('SIGTERM', () => {
  console.log('Stopping dev server')
  devMiddleware.close()
  server.close(() => {
    process.exit(0)
  })
})
