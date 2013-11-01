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

recipe "licode_cookbook::default",
  "Install the dependencies for licode."

recipe "licode_cookbook::installErizo",
  "Build and Install the erizoController for licode."

recipe "licode_cookbook::installNuve",
  "Build and Install nuve for licode."
