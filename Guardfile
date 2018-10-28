ignore %r{^ignored/path/}, /db/

fork { `mongod --dbpath db/` }

guard 'process', :name => 'API Runner', :command => 'ruby src/app.rb' do
  watch(/src\/.*/)
end