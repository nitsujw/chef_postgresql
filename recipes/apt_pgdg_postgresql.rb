if not %w(etch lenny lucid precise sid squeeze wheezy raring).include? node['postgresql']['pgdg']['release_apt_codename']
  raise "Not supported release by PGDG apt repository"
end

include_recipe 'apt'

file "remove deprecated Pitti PPA apt repository" do
  action :delete
  path "/etc/apt/sources.list.d/pitti-postgresql-ppa"
end

dist = node['postgresql']['pgdg']['release_apt_codename']
dist = 'wheezy' if dist == 'raring'

apt_repository 'apt.postgresql.org' do
  uri 'http://apt.postgresql.org/pub/repos/apt'
  distribution "#{dist}-pgdg"
  components %w(main)
  key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
  action :add
end
