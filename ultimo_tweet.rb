#!/usr/bin/env ruby
#require 'twitter'
require 'rack'
require 'thin'
#require './configure'

class Ultimo_tweet

  def call env
    req = Rack::Request.new(env)
    res = Rack::Response.new
    res['Content-Type'] = 'text/html'
    name = (req["firstname"] && req["firstname"] != '') ? req["firstname"] : 'timoreilly'
    res.write <<-"EOS"
      <!DOCTYPE HTML>
      <html>
        <title>Rack::Response</title>
        <body>
          <h1>
            #{prueba(name)}
            <form action="/" method="post">
              Tu nombre: <input type="text" name="firstname" autofocus><br>
              <input type="submit" value="Submit">
            </form>
          </h1>
        </body>
      </html>
    EOS
    res.finish
  end

  def prueba(name)
    "interpola #{name}"
  end
end

Rack::Server.start(
  :app => Ultimo_tweet.new,
  :Port => 9292,
  :server => 'thin'
)
