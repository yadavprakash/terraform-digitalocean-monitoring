provider "digitalocean" {

}

##---------------------------------------------------------------------------------------------------------
# module:- module by uptime-alert
##---------------------------------------------------------------------------------------------------------
module "uptime-alert" {
  source      = "./../.."
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
