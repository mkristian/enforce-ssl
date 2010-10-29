Gem::Specification.new do |s|
  s.name = 'enforce-ssl'
  s.version = '0.1.0'

  s.summary = 'enforce the use of SSL for all controller actions'
  s.description = 'enforce the use of SSL for all controller actions, skip the enforcement with skip_before_filter :enforce_ssl for selected actions. moto: secure everything, open where needed'
  s.homepage = 'http://github.com/mkristian/enforce-ssl'

  s.authors = ['mkristian']
  s.email = ['m.kristian@web.de']

  s.files = Dir['MIT-LICENSE']
  s.licenses << 'MIT-LICENSE'
#  s.files += Dir['History.txt']
#  s.files += Dir['README.textile']
#  s.extra_rdoc_files = ['History.txt','README.textile']
#  s.rdoc_options = ['--main','README.textile']
  s.files += Dir['lib/**/*']
  s.add_development_dependency 'rake', '0.8.7'

  s.post_install_message = <<-TEXT
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
configure the enforced ssl port with 
(default => { development => 3000, production => 443 }):

   config.ssl_port = 8443

for development you can do that in 'config/environments/development.rb'. 
you can use 'jetty-run' from 'ruby-maven' gem (jruby only) to have both 
an http and an https port listing for requests.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
TEXT
end
