## Terraform

### What we manage in Terraform

We currently manage the following in Terraform:

- GitHub resources, including teams, repositories, actions secrets, etc
- AWS resources, such as
  - [setting up new environments](https://github.com/ministryofjustice/modernisation-platform/tree/main/terraform/environments)
    - [bootstrapping environments](https://github.com/ministryofjustice/modernisation-platform/tree/main/terraform/environments/bootstrap), including the secure baselines and giving access to a role from the Modernisation Platform landing zone account
    - [environment-specific infrastructure that we manage](https://github.com/ministryofjustice/modernisation-platform/tree/main/terraform/environments), including the core accounts for the Modernisation Platform
  - [the Modernisation Platform landing zone account](https://github.com/ministryofjustice/modernisation-platform/tree/main/terraform/modernisation-platform-account), including S3 state storage for all environments

#### Terraform workspaces

We make use of Terraform workspaces to create the same resources in each environment. This allows you to interpolate `terraform.workspace` to configure different values, such as Autoscaling Group limits or tags, in different environments. For example:

```
resource "aws_instance" "example" {
  count = "${terraform.workspace == "production" ? 5 : 1}"

  tags = {
    environment = terraform.workspace
    is-production = "${terraform.workspace == "production" ? true : false}"
  }
}
```

When you are running Terraform, check your workspace is set correctly for where you want to deploy changes, e.g for `core-logging`:

```bash
$ cd terraform/environments/core-logging
$ terraform workspace list
* default
  core-logging-production
$ terraform workspace select core-logging-production
$ terraform plan
```

You will likely get an error if you haven't changed your workspace from `default`.

#### Permissions required for each directory in `terraform/`

Terraform doesn't look recursively for `.tf` files, so we utilise subdirectories to keep related infrastructure together. You need different permissions to run each directory, following the directory structure:

- `terraform/`
  - `environments/` needs to be run with an MOJ organisational root account IAM user
    - `bootstrap/` also needs to be run with an MOJ organisational root account IAM user
    - any other subdirectory (e.g. `bichard7/`, `core-logging/` can be run using an Modernisation Platform landing zone account IAM user, after `bootstrap/` has been run for that environment
  - `github/` can be run using an Modernisation Platform landing zone account IAM user, and requires a `GITHUB_TOKEN` to be set as an environment variable that has permissions to create repositories
  - `modernisation-platform-account/` can be run using an Modernisation Platform landing zone account IAM user

We are looking at automating these in their entirety, so in the future all changes have to go through a GitHub pull request and you won't be able to apply changes locally.
