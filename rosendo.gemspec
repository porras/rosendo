Gem::Specification.new do |s|
  s.name              = "rosendo"
  s.version           = "0.0.1"
  s.date              = Date.today
  s.summary           = "Minimalistic and naive Sinatra reimplementation, without any dependencies other than the ruby socket library"
  s.author            = ["Sergio Gil"]
  s.email             = "sgilperez@gmail.com"
  s.homepage          = "http://github.com/porras/rosendo"
  
  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--main README.md)
  
  s.files             = %w(README.md LICENSE example.rb) + Dir.glob("{lib/**/*}") + Dir.glob("{test/**/*}")
  s.require_paths     = ["lib"]
end