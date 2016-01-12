# Testing

## About
This directory contains vagrant code for testing this module.  This utilizes R10K + Puppet in order to pull all of the necessary dependancies.  It uses the main test class (tests/init.pp) for testing.

## Operating Systems
The vagrant configuration file specifies the OS used by the vagrant provider (such as virtual box).  The only listed OS's as of now are Ubuntu but additional can be added if this testing environment is to be extended.

### Selecting an OS
* Edit the Vagrantfile
* Comment out the OS you don't want
* Uncomment the OS you want to test

See below:

```
require './config.lucid.rb'
#require './config.precise.rb'
#require './config.trusty.rb'
#require './config.vivid.rb'
```

## Test
To test a single configuration do the following:

```
vagrant destroy
./run.bash
```
This will ensure that any previous test runs are destroyed before starting a new one.  See the output.  The last line should indicate if the test passed or failed.
