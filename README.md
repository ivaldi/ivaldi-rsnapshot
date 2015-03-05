#rsnapshot

##Overview
The rsnapshot module allows you to setup an rsnapshot backup master and rsnapshot backup nodes. Each node is automatically added to the master and backuped using a cronjob on the master.

##Setup
###Installing a rsnapshot master server
To setup a rsnapshot master server with location name `dc1`, add the following lines to its puppet configuration.

    class { 'rsnapshot::master':
      location_name => 'dc1',
	  exclusions    => ['var/spool'],
    }

This will install rsnapshot, generate a ssh key pair and setup cronjobs to run rsnapshot as root.

###Adding rsnapshot nodes
For every server that needs to be backed up to the previously configures rsnapshot master, add the following lines.

    class { 'rsnapshot::node':
      to_location => 'dc1',
    }

This will add the ssh public key of the rsnapshot master with `location_name` `dc1` to the `authorized_keys` file of root, allowing rsnapshot to login from the master server. On the rsnapshot master, this will add a line to `/etc/rsnapshot.conf` to backup this node.
