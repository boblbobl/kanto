require 'coffee-script'
express = require 'express'
less = require 'connect-lesscss'

app = express.createServer()

app.configure ->
  app.use express.static("#{__dirname}/public")
  app.use '/application.css', less("#{__dirname}/less/application.less")
  app.set 'view engine', 'ejs'
  app.set 'view options',
    layout: false

app.get '/', (req, res) ->
  res.render 'index',
    title: "Kanto"
  
app.listen(3000)
console.log "Server is listening"