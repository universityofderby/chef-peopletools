name 'peopletools'
maintainer 'University of Derby'
maintainer_email 'serverteam@derby.ac.uk'
license 'Apache 2.0'
description 'Provides Oracle PeopleTools resources'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
source_url 'https://github.com/universityofderby/chef-peopletools' if respond_to?(:source_url)
issues_url 'https://github.com/universityofderby/chef-peopletools/issues' if respond_to?(:issues_url)

supports 'centos'
supports 'redhat'

depends 'ark', '~> 1.0'
depends 'sysctl', '~> 0.6'
