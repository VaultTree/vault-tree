# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "builder"
  s.version = "3.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Weirich"]
  s.date = "2013-02-23"
  s.description = "Builder provides a number of builder objects that make creating structured data\nsimple to do.  Currently the following builder objects are supported:\n\n* XML Markup\n* XML Events\n"
  s.email = "jim.weirich@gmail.com"
  s.homepage = "http://onestepback.org"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "Builder -- Easy XML Building", "--main", "README.rdoc", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Builders for MarkUp."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
