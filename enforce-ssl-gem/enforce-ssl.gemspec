Gem::Specification.new do |s|
  s.name = 'enforce-ssl'
  s.version = '0.2.2'

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
  s.files += Dir['lib/**/*rb']
  s.add_development_dependency 'rake', '0.8.7'
end
