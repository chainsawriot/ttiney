require 'mastodon'
require 'twitter'
require 'oauth2'

TW_CONKEY = ""
TW_CONSEC = ""
TW_ACCTOK = ""
TW_ACCTOKSEC = ""
MAS_BASEURL = ''
MAS_LOGIN = ''
MAS_PASSWORD = ''

twitterclient = Twitter::REST::Client.new do |config|
  config.consumer_key        = TW_CONKEY
  config.consumer_secret     = TW_CONSEC
  config.access_token        = TW_ACCTOK
  config.access_token_secret = TW_ACCTOKSEC
end

mastodonclient = Mastodon::REST::Client.new(base_url: MAS_BASEURL)

#app = mastodonclient.create_app('ttiney', 'https://github.com/chainsawriot')
app = mastodonclient.create_app('ttiney', "urn:ietf:wg:oauth:2.0:oob", 'read write follow')


oauthclient = OAuth2::Client.new(app.client_id, app.client_secret, site: MAS_BASEURL)

token = oauthclient.password.get_token(MAS_LOGIN, MAS_PASSWORD, scope: 'read write follow')

mastodonclient = Mastodon::REST::Client.new(base_url: MAS_BASEURL, bearer_token: token.token)

testmsg = 'Testing ttiney https://github.com/chainsawriot/ttiney'

mastodonclient.create_status(testmsg)
twitterclient.update(testmsg)
