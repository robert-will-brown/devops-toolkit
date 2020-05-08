# Service Management

## Background

### **System V**

System V \(Sys V\) is one of the first and traditional init systems for the UNIX/Linux operating system. Init is the first process started by the kernel during system boot, and is a parent process for everything.

Most Linux distributions first started using the traditional init system, called System V \(Sys V\).

Over the years, several alternative init systems have been released to address design limitations in the stable versions such as launchd, Service Management, systemd and Upstart.

But the systemd has been adopted by many large Linux distributions over the traditional SysVinit manager.

### systemd

systemd is a new init system and system manager that has become so popular that it has been widely transformed into the new standard init system by most Linux distributions.

Systemctl is a systemd application that allows you to manage the systemd system. 

* systemd provides aggressive parallelization capabilities
* Uses socket and D-Bus activation for starting services
* Offers on-demand starting of daemons
* Keeps track of processes using Linux cgroups
* Supports snapshotting and restoring of the system state
* Maintains mount and automount points
* Implements an elaborate transactional dependency-based service control logic

## Links

| Page | URL |
| :--- | :--- |
| Ubuntu Systemd for upstart users | [https://wiki.ubuntu.com/SystemdForUpstartUsers](https://wiki.ubuntu.com/SystemdForUpstartUsers) |

## Identifing the Init System

{% hint style="info" %}
This is not a perfect check as it seems there isn't a definitive way of doing this.
{% endhint %}

```text
strings /sbin/init | awk 'match($0, /(upstart|systemd|sysvinit)/) { print toupper(substr($0, RSTART, RLENGTH));exit; }'
```

Run these seperatly to check if you are running multiple systems.

```text
strings /sbin/init | grep -q "/lib/systemd" && echo SYSTEMD
strings /sbin/init | grep -q "sysvinit" && echo SYSVINIT
strings /sbin/init | grep -q "upstart" && echo UPSTART
```

## Service Commands

List failed units

```text
systemctl list-units --state=failed
```

### Start

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start example
```
{% endtab %}

{% tab title="SysVinit" %}
```
service example start
```
{% endtab %}
{% endtabs %}

### Stop

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl stop example
```
{% endtab %}

{% tab title="Upstart" %}
```

```
{% endtab %}

{% tab title="SysVinit" %}
```
service example stop
```
{% endtab %}
{% endtabs %}

### Restart

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start exampl
```
{% endtab %}

{% tab title="" %}
```

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
Put this in

| To Start a Service | service example start | systemctl start example |
| :--- | :--- | :--- |
| To Stop a Service | service example stop | systemctl stop example |
| Stop and then Start a Service \(Restart a Service\) | service example restart | systemctl restart example |
| Reload a Service \(Reload the config file\) | service example reload | systemctl reload example |
| Restarts if the service is already running | service example condrestart | systemctl condrestart example |
| How to check if a service is currently running | service example status | systemctl status example |
| How to enable a service on boot/startup | chkconfig example on | systemctl enable example |
| How to disable a service on boot/startup | chkconfig example off | systemctl disable example |
| How to check if a service is configured to start on boot or not | chkconfig example –list | systemctl is-enabled example |
| How to display a list of enabled or disabled services on boot with runlevels information | chkconfig | systemctl list-unit-files –type=service |
| Create a new service file or modify any configuration | chkconfig example –add | systemctl daemon-reload |
{% endhint %}

### Stop Service

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start exampl
```
{% endtab %}
{% endtabs %}

### Stop Service

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start exampl
```
{% endtab %}
{% endtabs %}

### Stop Service

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start exampl
```
{% endtab %}
{% endtabs %}

### Stop Service

{% tabs %}
{% tab title="Systemd" %}
```text
systemctl start exampl
```
{% endtab %}
{% endtabs %}

## Example Service Files

{% tabs %}
{% tab title="Systemd" %}
`/lib/systemd/system/foo.service` 

```bash
[Unit]
Description=Job that runs the foo daemon
Documentation=man:foo(1)

[Service]
Type=forking
Environment=statedir=/var/cache/foo
ExecStartPre=/usr/bin/mkdir -p ${statedir}
ExecStart=/usr/bin/foo-daemon --arg1 "hello world" --statedir ${statedir}

[Install]
WantedBy=multi-user.target
```
{% endtab %}

{% tab title="Upstart" %}
`/etc/init/foo.conf`

```bash
description "Job that runs the foo daemon"

# start in normal runlevels when disks are mounted and networking is available
start on runlevel [2345]

# stop on shutdown/halt, single-user mode and reboot
stop on runlevel [016]

env statedir=/var/cache/foo

# create a directory needed by the daemon
pre-start exec mkdir -p "$statedir"

exec /usr/bin/foo-daemon --arg1 "hello world" --statedir "$statedir"
```
{% endtab %}
{% endtabs %}



