jbrowse-contrib
===============

Configuration and miscellaneous support files for the `AIP` project `JBrowse` installation

## Installing JBrowse

For the `AIP` project, please follow the steps outlined below for the setup and installation of the app:

    ### server: columbia
	$ cd /opt/www/araport/htdocs

    ### clone the jbrowse-contrib repo
    ### remember to clone `--recursive` to get the submodule as well
    ### submodule `jbrowse-latest-release` points to latest release (https://github.com/GMOD/jbrowse/releases)
	$ git clone --recursive https://github.com/Arabidopsis-Information-Portal/jbrowse-contrib.git .

	### make a symlink and change into the release directory
	### set up jbrowse by running the `setup.sh` script
	$ ln -sf jbrowse-latest-release jbrowse
	$ cd jbrowse
	$ ./setup.sh

Point the web browser to <http://araport-dev.jcvi.org/jbrowse> to check that the app is functioning properly.

## Loading data into JBrowse

Before data can be loaded into `JBrowse`, please following the instructions for setting up the data area from here: [araport-contrib](http://github.com/arabidopsis-information-portal/araport-contrib/blob/master/README.md)

Once the `JBrowse` setup has completed successfully and data has been downloaded to the right location, refer to the following steps to load data:

	### server: columbia
	$ cd /opt/www/araport/htdocs/jbrowse

	### create symlink to shared data area
	$ ln -sf ../../data/jbrowse data

	### copy config file(s), modified css/html and loading script to JBrowse installation directory
	$ cp ../jbrowse-contrib/jbrowse-load.sh .

	### run the loading script
	$ ./jbrowse-load.sh > jbrowse-load.log 2> jbrowse-load.err

	### after loading, replace the trackList.json config with the customized copy from the repo
	$ cp ../jbrowse-contrib/data/json/arabiodopsis/trackList.json data/json/arabidopsis/trackList.json

## JCVI specific code/data migration workflow to production

##### Migrating to test

This involves making use of a command line mechanism to push the app from dev --> test.

	### prepare to push from dev --> test

	### edit `tarinclude` file which lists relative paths to code that needs to be migrated
	### Example line(s) in `tarinclude`:

	    ./htdocs/jbrowse-latest-release
	    ./htdocs/jbrowse

	$ cd /opt/www/araport
	$ vim tarinclude

	### invoke push from dev --> test, this step only copies the app code
	### data area is already shared between the dev and test servers
	$ make

Point the web browser to <http://araport-test.jcvi.org/jbrowse> to check that the app is functioning properly.

##### Synching with production

This mechanism is regulated by `rdist`, a remote file distribution client, which is controlled by a configuration file, called a `distfile`.

	### prepare to synch test with prod
	### to check the areas that are set up to be synched, invoke the following command:
	$ cd /opt/www/araport
	$ make getdistfile

	### this will retrieve a file called `distfile.araport`
	### contains a list of directories to be mirrored (and a list of excluded directories as well)

	### synch the application
	$ make test2pro

	### synch the data (if this is the first time, process will take a while: ~0.5 hrs)
	$ make test2pro_data

Once the synch is complete, point the web browser to <http://apps.araport.org/jbrowse> to check that the app is functioning properly.
