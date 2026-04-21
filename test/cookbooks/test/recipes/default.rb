dpkg_autostart 'mysql-server' do
  allow false
end

dpkg_autostart 'apache2' do
  allow false
end

file '/etc/init.d/mysql-server' do
  content "#!/bin/sh\nexit 0\n"
  mode '0755'
end

file '/etc/init.d/apache2' do
  content "#!/bin/sh\nexit 0\n"
  mode '0755'
end

file '/etc/init.d/redis-server' do
  content "#!/bin/sh\nexit 0\n"
  mode '0755'
end
