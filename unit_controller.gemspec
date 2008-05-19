Gem::Specification.new do |s|
	s.name   = "unit_controller"
  s.summary = "UnitController assists with unit testing controllers by stubbing view rendering."
	s.version = "0.0.1"
	s.author = "Dan Manges"
	s.description = s.summary
	s.email = "daniel.manges@gmail.com"
  s.homepage = "http://unit-controller.rubyforge.org"
  s.rubyforge_project = "unit-controller"

  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << "UnitController" << '--main' << 'README' << '--line-numbers'

  s.files = FileList['{lib,test}/**/*.rb', 'README', 'Rakefile'].to_a
end
