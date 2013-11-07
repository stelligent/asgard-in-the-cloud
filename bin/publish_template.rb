require 'rubygems'
require 'aws-sdk'
require 'trollop'
require 'opendelivery'

opts = Trollop::options do
  opt :region, "AWS Region", :default => "us-east-1", :type => String
  opt :awsconfig, "AWS Config file location", :default => "~/.aws/aws.config", :type => String
end

load File.expand_path(opts[:awsconfig])

storage = OpenDelivery::Storage.new(opts[:region])

storage.upload("stelligent-blog", "asgard.template", "asgard/asgard.template")

