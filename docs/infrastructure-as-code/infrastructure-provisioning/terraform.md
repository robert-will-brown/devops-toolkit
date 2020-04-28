# Terraform

## Introduction

cads

## Components & Terms

### Variables

{% tabs %}
{% tab title="String" %}
```javascript
variable "myvar" {
  type = string
  default = "hello terraform"
}
```
{% endtab %}

{% tab title="Map" %}
```javascript
variable "mymap" {
  type = map(string)
  default = {
	  mykey = "my value"
	}
}
```
{% endtab %}

{% tab title="List" %}
```javascript
variable "mylist" {
  type = list
  default = [1, 2, 3]
}
```
{% endtab %}
{% endtabs %}



## Commands

### terraform init

Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc. 

This is the first command that should be run for any new or existing Terraform configuration per machine. This sets up all the local data necessary to run Terraform that is typically not committed to version   control.

```bash
$ terraform init
```

### terraform plan

Generates an execution plan for Terraform and optionally executes.

```bash
$ terraform plan
```

Gernerate an output file with the plan, which can then be fed to `terraform apply file` . 

```bash
$ terraform plan -out file
```

### terraform apply

 Builds or changes infrastructure according to Terraform configuration files in DIR.

By default, apply scans the current directory for the configuration and applies the changes appropriately. However, a path to another configuration or an execution plan can be provided. Execution plans can be used to only execute a pre-determined set of actions.

```bash
$ terraform apply
```

Apply the changes that have been recorded in a `terraform plan -out file` command.

```bash
$ terraform apply file
$ rm file
```

### terraform destroy

Destroy Terraform-managed infrastructure.

```bash
$ terraform destroy
```

