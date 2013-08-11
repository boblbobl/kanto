require 'coffee-script'

http    = require 'http'
express = require 'express'
less    = require 'connect-lesscss'
fb      = require 'facebook-js'
globals = require ('./config')

app = express()
port = 3000

app.configure ->
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session( { secret: 'secret' } )
  app.use express.static("#{__dirname}/public")
  app.use '/application.css', less("#{__dirname}/less/application.less")
  app.set 'view engine', 'ejs'
  app.set 'view options',
    layout: false

app.get '/', (req, res) ->
  
  console.log 'session_token: ' + req.session.accessToken
  
  res.render 'index',
    title: "Kanto",
    is_auth: if req.session.accessToken then true else false,
    user: req.session.user,
    fb: req.session.fb
    
app.get '/login', (req, res) ->
  res.redirect(fb.getAuthorizeUrl({
      client_id: globals.fb.id,
      redirect_uri: "#{globals.url}/auth",
      scope: "email, user_location"
    }))
    
app.get '/auth', (req, res) ->
  fb.getAccessToken globals.fb.id, globals.fb.secret, req.param('code'), "#{globals.url}/auth", (error, access_token, refresh_token) ->
    console.log 'error:' + error
    console.log 'access_token:' + access_token
    req.session.accessToken = access_token
    req.session.refreshToken = refresh_token
    
    fb.apiCall 'GET', '/me', {access_token: access_token}, (err, resp, body) ->
      for own key, value of body
        console.log key + ':' + value
      
      req.session.user = {
        'name': body.name,
        'email': body.email
      }
      res.redirect '/'
  
app.listen(port)
console.log "Server is listening on port " + port