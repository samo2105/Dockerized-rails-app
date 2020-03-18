process.env.NODE_ENV = process.env.NODE_ENV || 'development'

config.webpacker.check_yarn_integrity = false

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
