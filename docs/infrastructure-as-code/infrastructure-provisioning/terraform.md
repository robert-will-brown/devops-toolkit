# Terraform

## Introduction

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.

Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.

The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.

## Links

| Content | Link |
| :--- | :--- |
| Provider Reference | [https://www.terraform.io/docs/providers/](https://www.terraform.io/docs/providers/) |
| Terraform Glossary | [https://www.terraform.io/docs/glossary.html](https://www.terraform.io/docs/glossary.html) |

## Files

| File | Purpose |
| :--- | :--- |
| `terraform.tfstate` | Tracks the remote state of the infrastructure.  Allows terraform to re-align the remote infrastructure.  This file can be kept in source control. |

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

### Providers

A provider is responsible for understanding API interactions and exposing resources. Providers generally are an IaaS \(e.g. Alibaba Cloud, AWS, GCP, Microsoft Azure, OpenStack\), PaaS \(e.g. Heroku\), or SaaS services \(e.g. Terraform Cloud, DNSimple, Cloudflare\).

{% embed url="https://www.terraform.io/docs/providers/" %}

### Backends & Enchanced Backends \(State tracking\)

Terraform needs to track what the infrastructure its provisioned is.  The default store for this is a local`terraform.tfstat`but it can also be stored using the backend functionality of terraform.  When working in a team the remote state will always be available for the whole team.  Available backends are:

* s3 \(with a locking mechanism using dynamoDB\)
* consul \(with locking\)
* terraform enterprise \(commercial solution\)

Some backends will enable remote operations.  The terraform apply will then run completely remotely.  These are called the enhanced backends.

{% embed url="https://www.terraform.io/docs/backends/types/index.html" caption="Backend State Tracking" %}

To configure a remote state:

1. Add the backend code to a `.tf` file.
2. Run the initialisation process.

{% hint style="info" %}
You can't use variables to store the AWS keys to access the S3 backend store.  Setup your shell first with the correct credentials.
{% endhint %}

## Datasources

For certain providers \(like AWS\), terraform provides datasources.  For example list of AMI's or Availability Zones.  You could for example only allow access to EC2 instance by pulling in the list of IP addresses only from one region.

## Commands

### terraform init

Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc. 

This is the first command that should be run for any new or existing Terraform configuration per machine. This sets up all the local data necessary to run Terraform that is typically not committed to version   control.

```bash
terraform init
```

### terraform plan

Generates an execution plan for Terraform and optionally executes.

```bash
terraform plan
```

Gernerate an output file with the plan, which can then be fed to `terraform apply file` . 

```bash
terraform plan -out file
```

### terraform apply

 Builds or changes infrastructure according to Terraform configuration files in DIR.

By default, apply scans the current directory for the configuration and applies the changes appropriately. However, a path to another configuration or an execution plan can be provided. Execution plans can be used to only execute a pre-determined set of actions.

```bash
terraform apply
```

Apply the changes that have been recorded in a `terraform plan -out file` command.

```bash
terraform apply file
rm file
```

### terraform destroy

Destroy Terraform-managed infrastructure.

```bash
terraform destroy
```

