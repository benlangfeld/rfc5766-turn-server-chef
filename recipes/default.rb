include_recipe 'apt'

package 'gdebi-core'

version = node['rfc5766-stun-turn']['version']
archive_filename = "turnserver-#{version}-debian-wheezy-ubuntu-mint-x86-64bits.tar.gz"

remote_file "/tmp/#{archive_filename}" do
  source "http://turnserver.open-sys.org/downloads/v#{version}/#{archive_filename}"
  action :create_if_missing
  notifies :run, 'bash[install rfc5766]', :immediately
end

bash "install rfc5766" do
  cwd "/tmp"
  code <<-EOH
    tar xvfz #{archive_filename}
	  gdebi -n rfc5766-turn-server_#{version}-1_amd64.deb
  EOH
  action :nothing
end

file "/etc/default/rfc5766-turn-server" do
  content "TURNSERVER_ENABLED=1\n"
end

template '/etc/turnserver.conf' do
  source 'turnserver.conf.erb'
  variables(
    external_ip: node['rfc5766-stun-turn']['external_ip'],
    relay_ip: node['rfc5766-stun-turn']['local_ip'],
    realm: node['rfc5766-stun-turn']['realm'],
    turn_shared_secret: node['rfc5766-stun-turn']['turn']['shared_secret'],
  )
end

service 'rfc5766-turn-server' do
  action :start
end
