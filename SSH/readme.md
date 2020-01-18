# Goal :: root user account can't login to the system!

### Install our RSA key based SSH login system first  on the server or create a sudo privilege   user. 

> Our key-based system will create few user on the system. Before disabling root user we must need to create another admin user on the system. 


Create a hidden folder called `ditsystem` under a private directory.

    mkdir -p /usr/local/.ditsystem
	
> For security purpose, we are going to move few system tool from default path to to custom path. Such as `passwd` `usermod`  It will prevent user account modification delete and password change option. 
### Disable SHELL Login
Delete root user password.

    passwd -d root

Change root user shell from **`/bin/bash`** to **`/sbin/nologin`**. 

    usermod --shell /sbin/nologin root

Now `shell` is disable for `root` user. Now we can't use root user shell directly.  `sudo -i` will not work to go to the root shell.
 >NB: If system having a GUI that will allow some access. We need to disable root login via console device (TTY) and then user can't login to the system physically.

### Disable TTY Console 
TTY devices the root user is allowed to login on, emptying `/etc/securetty`  file prevents root login on any devices attached to the computer system.

    sudo mv /etc/securetty /usr/local/.ditsystem
    sudo touch /etc/securetty
    sudo chmod 600 /etc/securetty
    
Now, root user is disable from the TTY. If anyone try to login on the system from physically. It will show login incorrect. 

![enter image description here](https://lh3.googleusercontent.com/YIIu1SFSyt7hDjrxD8MYATuCkrI5BnhmoefQLMgYcX2fqs4_K59EcZNeOHAG0rU0cQIfkilAy6F2 "root_user_disable")

### Post configuration step [Highly confidential].

Move `usermod` `passwd`  to our custom hidden directory. 

    mv /bin/passwd /usr/local/.ditsystem
    mv /usr/sbin/usermod /usr/local/.ditsystem
    
> **NB:** To use `passwd` or `usermod` tool after doing the post configuration step, use `/usr/local/.ditsystem/passwd` instead of `passwd`.  Same for `usermod`.

### Future up-gradation:

* *Email notification when someone try to reset any user password of the system.*
