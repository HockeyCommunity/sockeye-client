# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sockeye/client/version'

Gem::Specification.new do |spec|
  spec.name          = "sockeye-client"
  spec.version       = Sockeye::Client::VERSION
  spec.authors       = ["Jack Hayter"]
  spec.email         = ["jack@hockey-community.com"]

  spec.summary       = "A small library to send data to a socket server for resending to connected users"
  spec.description   = "This library is used internally at HC to send data to our socket server, for delivery to specific connected socket.io clients. The authenticity of send-requests is currently achieved through a simple shared secret."
  spec.homepage      = "https://github.com/HockeyCommunity/sockeye-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "socket.io-client-simple"
end
