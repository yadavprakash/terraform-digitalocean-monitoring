provider "digitalocean" {

}

##---------------------------------------------------------------------------------------------------------
# module:- module by uptime-alert
##---------------------------------------------------------------------------------------------------------
module "uptime-alert" {
  source      = "./../.."
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
