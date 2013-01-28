directory "/usr/share/tomcat6/webapps" do
  recursive true
  action :delete
end

directory "/usr/share/tomcat6/webapps" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "/usr/share/tomcat6/webapps/asgard.war" do
  source "https://s3.amazonaws.com/stelligent-asgard/asgard.war"
  mode "0644"
end

bash "extract war" do
  user "root"
  cwd "/usr/share/tomcat6/webapps"
  code <<-EOH
    unzip asgard.war -d /usr/share/tomcat6/webapps/asgard
  EOH
end

template "/usr/share/tomcat6/conf/tomcat-users.xml" do
  mode 0440
  owner "root"
  group "root"
  source "tomcat-users-xml.erb"
end

template "/tmp/security.xml" do
  mode 0440
  owner "root"
  group "root"
  source "security-xml.erb"
end

bash "enable security" do
  user "root"
  cwd "/usr/share/tomcat6/webapps/asgard/WEB-INF"
  code <<-EOH
    linecount=`wc -l web.xml | awk '{ print $1}'`
    i=`expr $linecount - 1`
    head -$i web.xml > /tmp/head
    tail -1 web.xml > /tmp/tail
    cat /tmp/head /tmp/security.xml /tmp/tail > web.xml
  EOH

end

execute "chown" do
  command "chown tomcat:tomcat -R /etc/tomcat6/"
end

execute "chown" do
  command "chown tomcat:tomcat -R /usr/share/tomcat6/"
end

service "tomcat6" do
  action [:restart]
end


