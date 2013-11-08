maintainer       'WellFX, Inc.'
maintainer_email 'robertf@well-fx.com'
license          'All rights reserved'
description      'Installs/Configures Licode'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "ubuntu"

depends "rightscale"
depends "apt"
depends "git"
depends "repo"

recipe "licode_cookbook::default",
  "Install the dependencies for licode."

recipe "licode_cookbook::installErizo",
  "Build and Install the erizoController for licode."

recipe "licode_cookbook::installNuve",
  "Build and Install nuve for licode."

recipe "licode_cookbook::updateCode",
  "Updates application source files from the remote repository. This recipe" +
  " will call the corresponding provider from the app server cookbook," +
  " which will download/update application source code."

attribute "licode_cookbook/uri",
  :display_name => "Licode git uri",
  :description =>
    "Enter the uri of git repository to download the licdoe code",
  :required => "required",
  :recipes => ["licode_cookbook::default"]

attribute "licode_cookbook/install_dir",
  :display_name => "Licode Installation Directory",
  :description =>
    "Enter the directory where you want to install Licode too.",
  :required => "required",
  :recipes => ["licode_cookbook::default"]
