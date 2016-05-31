# CPU Monitor

### Introduction

The solution is composed by 2 applications:
- __CPU Monitor Server:__ web application that uses NoSQL database [Redis] for monitoring clients system;
- __CPU Monitor Client:__ an agent that sends system information to the _CPU Monitor Server_.

There is a Monitor Server DEMO running on http://ec2-52-37-77-130.us-west-2.compute.amazonaws.com/.

### Steps to prepare the source code
##### CPU Monitor Server
CPU Monitor Server requires [Redis] (http://redis.io/) running with default configuration.
You can download _CPU Monitor Server_ project from [GitHub] (https://github.com/LeonamAnjos/cpu-monitor-server) or clone it with following command:
```sh
$ git clone https://github.com/LeonamAnjos/cpu-monitor-server.git
$ cd cpu-monitor-server
```
It is necessary to install some _"gems"_ listed in the Gemfile. You can use _bundler_ to do the task.
```sh
$ bundle install
```
To run the tests, you can user _rspec_ command:
```sh
$ rspec
```

##### CPU Monitor Client
You can download _CPU Monitor Client_ project from [GitHub] (https://github.com/LeonamAnjos/cpu-monitor-client) or clone it with following command:
```sh
$ git clone https://github.com/LeonamAnjos/cpu-monitor-client.git
$ cd cpu-monitor-client
```
It is necessary to install some _"gems"_ listed in the Gemfile. You can use _bundler_ to do the task.
```sh
$ bundle install
```
To run the tests, you can use _rspec_ command:
```sh
$ rspec
```
The agent needs some environment information to perform. You can do it by editing _"config.yml"_. There you can set:
- ___url___ - the CPU Monitor Server http address, folowing by _/cpu_status_ routed for this feature.
- ___id___ - through the _id_ the server will identify the client. It should be unique.
- ___hostname___ - through the _hostname_ users can identify the client.
- ___log_file___ - path and file name for logging.

### Running
To run the the agent in background:
```sh
$ ruby cpu_monitor_control.rb start
```
To check the agent status:
```sh
$ ruby cpu_monitor_control.rb status
```
To kill the agent:
```sh
$ ruby cpu_monitor_control.rb stop
```
