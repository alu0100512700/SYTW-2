#!/usr/bin/env ruby
# encoding: UTF-8
require 'twitter'
require 'rack'
require 'thin'
require './configure'

class Ultimo_tweet

  def call env
    req = Rack::Request.new(env)
    res = Rack::Response.new
    res['Content-Type'] = 'text/html'
    name = (req["firstname"] && req["firstname"] != '') ? req["firstname"] : 'timoreilly'
    res.write <<-"EOS"
      <!DOCTYPE HTML>
      <html>
        <meta charset="UTF-8">
        <title>Rack::Response</title>
        <body>
          <h1>
	    <div align="center">
            #{name} este es tu último tweet: <br>
            #{prueba(name)}
	    <br></br>
            <form action="/" method="post">
              Tu nombre: <input type="text" name="firstname" autofocus><br>
              <input type="submit" value="Submit">
            </form>
	    </div>
          </h1>
        </body>
      </html>
    EOS
    res.finish
  end

  def prueba(name)
    Twitter.user_timeline(name).first.text
    rescue
    "Error: no es usuario"
  end
end

Rack::Server.start(
  :app => Ultimo_tweet.new,
  :Port => 9292,
  :server => 'thin'
)
