asgard-in-the-cloud
===================

Asgard is an open source application from Netflix that makes it easier to work with Amazon Web Services. It offers lots of functionality that isn't accessible via AWS’s normal web interface. It’s provided free of charge by Netflix, and the source is available on GitHub.

Setting up Asgard can be a bit of a pain, so Stelligent has developed a CloudFormation template and Chef cookbooks to set up an EC2 instance and deploy Asgard to it.

Running the CloudFormation template is as simple as clicking here and following the prompts.

While the template will set up some basic Tomcat security, Asgard does give full administrative access to your AWS account. When not in use, it's a good idea to shutdown Asgard's EC2 instance. (This also keeps you from accumulating EC2 fees.)