##---------------------------------------------------------------------------------------------------------
# module:- labels
##---------------------------------------------------------------------------------------------------------
module "labels" {
  source      = "git::https://github.com/opsstation/terraform-digitalocean-labels.git?ref=v1.0.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order
}

##---------------------------------------------------------------------------------------------------------
# resource:- this resource by digitalocean_uptime_check
##---------------------------------------------------------------------------------------------------------
resource "digitalocean_uptime_check" "test" {
  count   = var.enable ? length(var.target_url) : 0
  name    = format("%s-uptime-check-%s", module.labels.id, count.index)
  target  = element(var.target_url, count.index)
  type    = element(var.type, count.index)
  regions = var.regions
  enabled = var.enabled
}

##---------------------------------------------------------------------------------------------------------
# resource:- this resource by digitalocean_uptime_alert
##---------------------------------------------------------------------------------------------------------
resource "digitalocean_uptime_alert" "test" {
  count      = var.enable ? length(var.target_url) : 0
  name       = format("%s-alert", module.labels.id)
  check_id   = element(concat(digitalocean_uptime_check.test[*].id, [""]), count.index)
  type       = element(var.alert_type, count.index)
  threshold  = element(var.threshold, count.index)
  comparison = element(var.comparison, count.index)
  period     = element(var.period, count.index)

  dynamic "notifications" {
    for_each = try(jsondecode(var.notifications), var.notifications) ##var.notifications == [] ? 0 : 1
    content {
      email = lookup(notifications.value, "email", null)
      dynamic "slack" {
        for_each = lookup(notifications.value, "slack", [])
        content {
          channel = lookup(slack.value, "channel", null)
          url     = lookup(slack.value, "url", null)
        }
      }
    }
  }
}



