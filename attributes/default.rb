default['rfc5766-stun-turn']['version'] = '3.2.4.4'
default['rfc5766-stun-turn']['local_ip'] = node['ipaddress']
default['rfc5766-stun-turn']['external_ip'] = node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']
default['rfc5766-stun-turn']['realm'] = 'example.com'
default['rfc5766-stun-turn']['turn']['shared_secret'] = 'abc123'
