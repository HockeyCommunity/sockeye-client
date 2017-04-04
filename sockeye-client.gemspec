# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "sockeye-client"
  spec.version       = "0.1.0"
  spec.authors       = ["Jack Hayter"]
  spec.email         = ["jack@hockey-community.com"]

  spec.summary       = "Acts as a simple websocket client, designed for use with the sockeye-server."
  spec.description   = "Uses websockets to communicate with a sockeye-server to receive messages that were pushed to it with sockeye-pusher"
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
  spec.add_runtime_dependency 'websocket-eventmachine-client', '~> 1.2', '>= 1.2.0'

end
