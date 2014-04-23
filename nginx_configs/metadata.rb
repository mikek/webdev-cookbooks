name              "nginx_configs"
maintainer        "Mikhail Kolesnik"
maintainer_email  "mike@openbunker.org"
description       "Adds a few Nginx configuration files"
version           "0.0.5"

recipe "nginx_configs", "Adds a few Nginx configuration files."

depends 'nginx'


attribute "nginx_configs/www_redirect_site_enabled",
  :default => "true"

attribute "nginx_configs/default_site_enabled",
  :default => "true"

attribute "nginx_configs/default_site_text",
  :default => ""
