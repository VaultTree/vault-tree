maintainer        ""
maintainer_email  ""
license           "MIT"
description       "Installs Ruby"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end
