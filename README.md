# Rosendo [![Build Status](https://travis-ci.org/porras/rosendo.png)](https://travis-ci.org/porras/rosendo)

Rosendo is a minimalistic and naive [Sinatra](http://sinatrarb.com) reimplementation, without any
dependencies other than the ruby socket library. It's a learning exercise on the HTTP specs, web
servers, and how not to write software. It contains a (stupidly simple) HTTP server, a (rather
incomplete) HTTP parser and a (really oversimplified) DSL.

**Rosendo is not intended for any production use. Specifically, *it's not intended as a Sinatra
replacement*. It has much less features, for sure much more bugs, and probably much worse
performance. It's just a learning exercise.**

This ongoing exercise is a game, whose rules (invented by myself) consist in reimplementing a web
framework (Sinatra is far better for this purpose than my other favorite framework Rails, for
obvious reasons) from scratch, using just Ruby. I wanted to prevent myself from using anything from
the standard library, but probably making this without the socket library would be too much, so
that's the only allowed exception. Still, no webrick, no erb, no nothing, and obviously no gems.

The rule doesn't apply to the tests though (I'm using minitest and Net::HTTP).

The purpose of the game/exercise comes from a reflection about how much software we usually depend
on when writing our applications (just run `bundle show` in your last Rails app if you don't believe
me) and is double:

1) Remember that the software we take for granted and like to whine about some times, it's actually
great software we should thank for every minute we're using it. Trying to live without it for some
time is a great way to achieve this.

2) At the same time, demystifying it. Not everybody can write such good web servers like the ones we
use everyday, but everybody can write the simplest one. And understanding a bit how they work is a
great thing, even if you're not obviously going to write a web server every time you want to write a
web app. The same is true for every other piece of the stack.

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
* Params in query string

### Sinatra features that Rosendo plans to support

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

See [`example.rb`](https://github.com/porras/rosendo/blob/master/example.rb) for some supported things.

[Rosendo](http://en.wikipedia.org/wiki/Rosendo_Mercado) is also the name of the most charismatic
Spanish rock singer and songwriter ever.

[![Rosendo Mercado](http://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Rosendo_-_11.jpg/320px-Rosendo_-_11.jpg)](http://en.wikipedia.org/wiki/Rosendo_Mercado)

## License

Released under the [MIT license](https://github.com/porras/rosendo/blob/master/LICENSE).