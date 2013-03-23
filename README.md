# Rosendo

Rosendo is a minimalistic and naive [Sinatra](http://sinatrarb.com) reimplementation, without any
dependencies other than the ruby socket library. It's a learning exercise on the HTTP specs, web
servers, and how not to write software.

*Rosendo is not intended for any production use. Specifically, **it's not intended as a Sinatra
replacement**. It has much less features, for sure much more bugs, and probably much worse
performance. It's just a learning exercise.*

## Usage

Install it via Rubygems or Bundler, require it, and pretend it's Sinatra:

    require 'rosendo'
    
    class MyApp < Rosendo::App
      get "/" do
        "Hello, World!"
      end
    end
    
    MyApp.run!(port: 2000)

## Features

### Sinatra features that Rosendo supports

* Route mapping methods (`get`, `post`, ...)
* Headers reading and setting
* Basic params in URL (`/hello/:name`)
* HTTP status code
* Redirects

### Sinatra features that Rosendo plans to support

* Params in query string
* Form params in request body
* Templates

### Sinatra features that Rosendo doesn't plan to support (for the moment)

* Advanced route patterns (*, regular expressions, conditions, ...)
* Filters
* Helpers
* Variables (`set` method)
* Cookies
* Sessions
* Config blocks
* Rack compliance
* Streaming
* Logging
* *Classic* mode
* Static files

See `example.rb` for some supported things.
