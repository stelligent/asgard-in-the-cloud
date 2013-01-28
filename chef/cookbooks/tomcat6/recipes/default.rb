package "tomcat6" do
  action :install
end

execute "chown" do
  command "chown tomcat:tomcat -R /usr/share/tomcat6/"
end

service "tomcat6" do
  action [:enable, :start]
end


