output "id" {
  description = "The IDs of the DigitalOcean uptime checks."
  value       = join("", digitalocean_uptime_check.test[*].id)
}
