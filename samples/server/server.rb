require 'webrick'
require 'json'
require 'net/http'
require 'net/https' if RUBY_VERSION < '1.9'
require 'uri'

GITHUB_USERNAME = "thangvo38"
GITHUB_REPO = "travis-sample"
TRAVIS_API_TOKEN = "SSbldqcvI1tYvr7GLxVX0w"
PORT = 3000

class Server < WEBrick::HTTPServlet::AbstractServlet
  def do_POST (request, response)
      web_hook_data = JSON.parse(request.body)

      if !web_hook_data.nil? && web_hook_data['type'] == 'app_version'
        travisci_exec(web_hook_data['public_identifier'], web_hook_data['app_version'], web_hook_data['build_url'])
      else
        response.body = 'Unsupported Type'
      end
  end
end

def travisci_exec (app_id, app_version, resigned_url)

  headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'Travis-API-Version'=> '3',
      'Authorization' => 'token ' + TRAVIS_API_TOKEN,
  }

  body = {
      'request' => {
          'branch' => 'master',
          'message' => 'Test with Kobiton',
          'config' => {
              'merge_mode' => 'deep_merge',
              'env' => {
                  'HOCKEYAPP_ID' => app_id,
                  'APP_VERSION' => app_version,
                  'RESIGNED_URL' => resigned_url
              }
          }
      }}

  url = URI.parse("https://api.travis-ci.org/repo/#{GITHUB_USERNAME}%2F#{GITHUB_REPO}/requests")
  req = Net::HTTP.new(url.host, url.port)
  req.use_ssl = true
  res = req.post(url, body.to_json, headers)
  puts res.code
end

server = WEBrick::HTTPServer.new(:Port => PORT)
server.mount "/", Server

trap 'INT' do
  server.shutdown
end

abc()
# server.start
# travisci_exec(0,0,0)

