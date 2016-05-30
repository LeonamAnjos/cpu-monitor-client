# CPU Monitor Server

### Introduction

Web application monitor that uses a NoSQL database (redis) for monitoring others computers by checking some system data, as follow:
- CPU usage
- Disk usage
- Process running

### Steps to prepare the source code
##### Web Application Server
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

##### Agents
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

### Steps to deploy the server and agents

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
