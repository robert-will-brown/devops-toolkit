# Ansible

## Introduction

Ansible is an IT automation tool. It can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.

Ansible’s strengths are simplicity, ease-of-use and a language that is designed around auditability by humans.

Ansible manages machines in an agent-less manner using SSH.  This means that it can also automate configuration of other devices such as switches.

## Components & Terms

### Control node

Any machine with Ansible installed.  You can have multiple control nodes.

### Managed nodes

The network devices \(and/or servers\) you manage with Ansible. Managed nodes are also sometimes called “hosts”. Ansible is not installed on managed nodes.

### Inventory

A list of managed nodes. An inventory file is also sometimes called a “hostfile”. Your inventory can specify information like IP address for each managed node. An inventory can also organize managed nodes, creating and nesting groups for easier scaling. 

{% embed url="https://docs.ansible.com/ansible/latest/user\_guide/intro\_inventory.html\#intro-inventory" %}

### Playbooks

Ordered lists of tasks, saved so you can run those tasks in that order repeatedly. Playbooks can include variables as well as tasks. Playbooks are written in YAML.

{% embed url="https://docs.ansible.com/ansible/latest/user\_guide/playbooks\_intro.html" caption="Playbooks Introduction" %}

### Modules

Modules are pre-written peices of functionality that let you perform specific tasks on remote hosts.  Examples could be using the `command` module to run a remote command or the `service` command to restart and apache service.  You could use the `ios_banner` module to configure the login banner on a Cisco switch.   The ansible module set seems pretty exhaustive - a list of the modules is here:

{% embed url="https://docs.ansible.com/ansible/latest/modules/modules\_by\_category.html" caption="Module Index List" %}

{% embed url="https://docs.ansible.com/ansible/latest/user\_guide/modules.html" caption="How to work with modules" %}

### Tags

If you have a large playbook, it may become useful to be able to run only a specific part of it rather than running _everything_ in the playbook. Ansible supports a “tags:” attribute for this reason.

{% embed url="https://docs.ansible.com/ansible/latest/user\_guide/playbooks\_tags.html" %}

### Ansible Vault

Ansible Vault is a feature of ansible that allows you to keep sensitive data such as passwords or keys in encrypted files, rather than as plaintext in playbooks or roles. These vault files can then be distributed or placed in source control.

{% embed url="https://docs.ansible.com/ansible/latest/user\_guide/vault.html" %}

### Ansible Galaxy

A way of building standardised playbooks.  This allows users to build and contribute to the "galaxy" service from which you can download pre-built playbooks for performing various tasks.  This approach should also be utilsed for playbooks that will be checked into source code.

Galaxy provides pre-packaged units of work known to Ansible as roles.

{% embed url="https://galaxy.ansible.com/home" %}

## Commands

### Version

```bash
$ ansible --version
ansible 2.9.6
```

### Listing hosts

List all of the hosts configured in the `ansible.cfg` file.

```bash
$ ansible --list-hosts all
  hosts (4):
    app1
    app2
    lb
    control
```

List a group of hosts defined in the configuration file.

```bash
$ ansible --list-hosts loadbalancers
  hosts (1):
    lb
```

List all of the app servers defined in the configuration file.

```bash
$ ansible --list-hosts app*
  hosts (2):
    app1
    app2
```

List all hosts apart from the app servers.

```bash
$ ansible --list-hosts \!app*
  hosts (2):
    lb
    control
```

### Interactive

Run uptime on all of the "webservers" and "loadbalancers".

```bash
$ ansible -m shell -a "uptime" webservers:loadbalancers
```

Stop a service on host.

```bash
$ ansible -m service -a "name=httpd state=started" --become loadbalancers
```

Print all available variables available from host "app1".

```bash
$ ansible -m setup app1
```

### Playbooks

Run a playbook.

```bash
$ ansible-playbook setup-app.yml
```

Run a playbook in Check mode \(dry-run\).

```bash
$ ansible-playbook setup-app.yml --check
```

Run a playbook with specific tags.

```bash
$ ansible-playbook setup-app.yml --tags myfirsttag
```

Prompt for password that is referenced in a playbook.

```bash
$ ansible-playbook setup-app.yml --ask-vault-pass
```

### Vault

Create a Vault.

```bash
$ ansible-vault create secret-variables.yml
```

Edit a Vault.

```bash
$ ansible-vault edit secret-variables.yml
```

