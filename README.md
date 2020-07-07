remote-unlock
=============

`remote-unlock` allows one to unlock a CRYPTO discipline remotely via OpenSSH.

It does this by starting up an `sshd` process which listens on a non-standard
port (2332 by default). This `sshd` instance is also configured to ignore
default authorized_keys files.

`/etc/remote-unlock.conf` contains information on the CRYPTO volume,
destination mount point, fsck options and finally the public key(s) to grant
access to to unlock the volume.

This tool will not work with FDE. The CRYPO discipline must be on a non-booting
partition or drive.


## Example `/etc/remote-unlock.conf`

```
CRYPT_DEV=4a58c59032e7fdb1.a
CRYPT_MOUNT=/mnt

FSCK_OPTS=-y

MOUNT_DEV=9720bbfacf0d1363.a
MOUNT_OPTS=nodev,nosuid,softdep

SSH_AUTHORIZED_KEY="sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIA7khawMK6P0fXjhXXPEUTA2rF2tYB2VhzseZA/EQ/OtAAAAC3NzaDpncmVhdGVy"
```

# Setup

## Installation

```
git clone ....
cd remote-unlock && doas make install
```

Now create your configuration. Device UUIDs can be found by running `disklabel
sdX` (where X is your device number).


No create the `remote-unlock` specific `sshd` config:

```
/sbin/remote-unlock init
```

## Running on boot

Calling `remote-unlock` with the `listen` option will fire up `sshd`. After a
successful unlock, the `sshd` process will be killed.

```
echo "/sbin/remote-unlock listen" >> /etc/rc.local
```

After the next reboot, a new `sshd` should be listening on port 2332. A
successful connection with your configured public keys should drop you to the
`bioctl` password prompt!
