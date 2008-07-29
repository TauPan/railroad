(in /home/mike/projects/railroad)
Gem::Specification.new do |s|
  s.name = %q{railroad}
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Javier Smaldone"]
  s.cert_chain = ["/home/mike/.gem/gem-public_cert.pem"]
  s.date = %q{2008-07-29}
  s.default_executable = %q{railroad}
  s.description = %q{}
  s.email = %q{javier@smaldone.com.ar}
  s.executables = ["railroad"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["COPYING", "ChangeLog", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/railroad", "init.rb", "lib/railroad.rb", "lib/railroad/aasm_diagram.rb", "lib/railroad/app_diagram.rb", "lib/railroad/controllers_diagram.rb", "lib/railroad/diagram_graph.rb", "lib/railroad/models_diagram.rb", "lib/railroad/options_struct.rb", "tasks/diagrams.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://railroad.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{railroad}
  s.rubygems_version = %q{1.2.0}
  s.signing_key = %q{/home/mike/.gem/gem-private_key.pem}
  s.summary = %q{A DOT diagram generator for Ruby on Rail applications}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
