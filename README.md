# Terraform Infrastructure as Code (IaC) - digitalocean monitoring Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This Terraform module creates structured monitoring for digitalocean resources with specific attributes.

## Usage

- Use the module by referencing its source and providing the required variables.

## Example: basic
You can use this module in your Terraform configuration like this:
```hcl
module "uptime-alert" {
  source      = "git::https://github.com/opsstation/terraform-digitalocean-monitoring.git?ref=v1.0.0"
  name        = "side"
  environment = "testing"
  target_url  = ["https://google.com/"]
  type        = ["http"]
  alert_type  = ["down_global"]
  period      = ["2m"]
  comparison  = ["less_than"]
  ####
  notifications = [
    {
      email = ["example111@gmail.com"]
      slack = [
        {
          channel = "testing"
          url     = "https://hooks.slack.com/services/TEXXXXXXXXxxxxYTGH8DNkjgggyKipj"
        }
      ]
    }
  ]
}


```
## Example: complete
You can use this module in your Terraform configuration like this:
```hcl
module "uptime-alert" {
  source      = "git::https://github.com/opsstation/terraform-digitalocean-monitoring.git?ref=v1.0.0"
  name        = "side"
  environment = "testing"
  target_url  = ["http://google.com/", "https://google.com/"]
  type        = ["http", "https"]
  alert_type  = ["down_global"]
  period      = ["2m", "3m"]
  comparison  = ["less_than"]

  notifications = [
    {
      email = ["example111@gmail.com"]
      slack = [
        {
          channel = "alerts"
          url     = "https://hooks.slack.com/servicesxxxxx/TEggyxxxxxxxxxxxxxxxxKipj"
        }
      ]
    }
  ]
}

```
Please ensure you specify the correct 'source' path for the module.

## Module Inputs

- `name` : A human-friendly display name for the check.
- `environment` : Environment (e.g. `prod`, `dev`, `staging`).
- `label_order` : Label order, e.g. `name`,`application`.
- `region` : An array containing the selected regions to perform healthchecks from: 'us_east', 'us_west', 'eu_west', 'se_asia'.
- `alert_type` : The type of health check to perform. Must be one of latency, down, down_global or ssl_expiry.

## Module Outputs
- This module currently does not provide any outputs.

# Examples
For detailed examples on how to use this module, please refer to the '[example](https://github.com/opsstation/terraform-digitalocean-monitoring/tree/master/_examples)' directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opsstation/terraform-digitalocean-monitoring/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.34.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.34.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-digitalocean-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_uptime_alert.test](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/uptime_alert) | resource |
| [digitalocean_uptime_check.test](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/uptime_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_type"></a> [alert\_type](#input\_alert\_type) | The type of health check to perform. Must be one of latency, down, down\_global or ssl\_expiry. | `list(any)` | <pre>[<br>  "down_global"<br>]</pre> | no |
| <a name="input_comparison"></a> [comparison](#input\_comparison) | The comparison operator used against the alert's threshold. Must be one of greater\_than or less\_than. | `list(any)` | <pre>[<br>  "less_than"<br>]</pre> | no |
| <a name="input_enable"></a> [enable](#input\_enable) | A boolean value indicating whether the check is enabled/disabled. | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | A boolean value indicating whether the check is enabled/disabled. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | A human-friendly display name for the check. | `string` | `""` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | The notification settings for a trigger alert. | `list(any)` | `[]` | no |
| <a name="input_period"></a> [period](#input\_period) | Period of time the threshold must be exceeded to trigger the alert. Must be one of 2m, 3m, 5m, 10m, 15m, 30m or 1h. | `list(string)` | <pre>[<br>  "2m"<br>]</pre> | no |
| <a name="input_regions"></a> [regions](#input\_regions) | An array containing the selected regions to perform healthchecks from: 'us\_east', 'us\_west', 'eu\_west', 'se\_asia'' | `list(string)` | <pre>[<br>  "us_east",<br>  "us_west",<br>  "eu_west",<br>  "se_asia"<br>]</pre> | no |
| <a name="input_target_url"></a> [target\_url](#input\_target\_url) | The endpoint to perform healthchecks on. | `list(any)` | `[]` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The threshold at which the alert will enter a trigger state. The specific threshold is dependent on the alert type. | `list(any)` | <pre>[<br>  1<br>]</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | The type of health check to perform: 'ping' 'http' 'https'. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The IDs of the DigitalOcean uptime checks. |
<!-- END_TF_DOCS -->