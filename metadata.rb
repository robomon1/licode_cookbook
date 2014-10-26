maintainer       'WellFX, Inc.'
maintainer_email 'robertf@well-fx.com'
license          'All rights reserved'
description      'Installs/Configures Licode'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

supports "ubuntu"

depends "sys_firewall"
depends "rightscale"
depends "apt"
depends "git"
depends "repo"

recipe "licode_cookbook::default",
  "Install the dependencies for licode."

recipe "licode_cookbook::configLicode",
  "Set the attributes of the licode_config.js."

recipe "licode_cookbook::installErizo",
  "Build and Install the erizoController for licode."

recipe "licode_cookbook::installNuve",
  "Build and Install nuve for licode."

recipe "licode_cookbook::updateCode",
  "Updates application source files from the remote repository. This recipe" +
  " will call the corresponding provider from the app server cookbook," +
  " which will download/update application source code."

recipe "licode_cookbook::installStunnel",
  "Install stunnel for SSL support."

attribute "licode_cookbook/install_dir",
  :display_name => "Licode Installation Directory",
  :description =>
    "Enter the directory where you want to install Licode too.",
  :required => "required",
  :recipes => [
    "licode_cookbook::default",
    "licode_cookbook::configLicode"
  ]

attribute "licode_cookbook/rabbitmq_host",
  :display_name => "RabbitMQ Host.",
  :description =>
    "Enter the rabbitmq host.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/rabbitmq_port",
  :display_name => "RabbitMQ Port.",
  :description =>
    "Enter the rabbitmq port.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/mongodb_url",
  :display_name => "MongoDB url.",
  :description =>
    "Enter the mongodb url (ex: 'server1,server2,server3/nuvedb?slaveOk=true')",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/erizo_controller",
  :display_name => "Erizo Controller Host.",
  :description =>
    "Enter the erizo controler host and optional port (ex: 'server1.example.com:443')",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/erizo_controller_port",
  :display_name => "Erizo Controller Port.",
  :description =>
    "Enter the erizo controler port (ex: 'server1.example.com:443')",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]
    
attribute "licode_cookbook/erizo_controller_ssl",
  :display_name => "Erizo Controller SSL.",
  :description =>
    "Turn on SSL support for Erizo Controller (ex: 'true')",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]
    
attribute "licode_cookbook/turnserver_url",
  :display_name => "TURN Server URL.",
  :description =>
    "Enter the TURN server url (ex: 'turn:1.1.1.1:443?transport=tcp')",
  :required => "optional",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/turnserver_username",
  :display_name => "TURN Server User.",
  :description =>
    "Enter the TURN server user.",
  :required => "optional",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/turnserver_password",
  :display_name => "TURN Server Password.",
  :description =>
    "Enter the TURN server password.",
  :required => "optional",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/stunserver_host",
  :display_name => "STUN Server Host.",
  :description =>
    "Enter the STUN server host.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/stunserver_port",
  :display_name => "STUN server Port.",
  :description =>
    "Enter the STUN server port.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/aws_access_key",
  :display_name => "AWS Access Key.",
  :description =>
    "AWS Access Key.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/aws_secret_key",
  :display_name => "AWS Secret Key.",
  :description =>
    "AWS Secret Key.",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]

attribute "licode_cookbook/ssl_crt",
  :display_name => "SSL Certificate",
  :description =>
    "SSL certificate.",
  :required => "required",
  :recipes => [
    "licode_cookbook::configLicode",
    "licode_cookbook::installStunnel"
  ]

attribute "licode_cookbook/ssl_key",
  :display_name => "SSL Key",
  :description =>
    "SSL key.",
  :required => "required",
  :recipes => [
    "licode_cookbook::configLicode",
    "licode_cookbook::installStunnel"
  ]

attribute "licode_cookbook/ssl_ca",
  :display_name => "SSL Intermediate Certificate",
  :description =>
    "SSL intermediate certificate",
  :required => "required",
  :recipes => [
    "licode_cookbook::configLicode",
    "licode_cookbook::installStunnel"
  ]

attribute "licode_cookbook/public_ip",
  :display_name => "Public IP address of this server.",
  :description =>
    "Enter the Public IP of this server (ex: '127.0.0.1')",
  :required => "required",
  :recipes => ["licode_cookbook::configLicode"]
