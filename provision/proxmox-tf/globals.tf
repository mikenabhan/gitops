variable "pmpass" {
  type      = string
  sensitive = true
}

variable "vultrpass" {
  type      = string
  sensitive = true
}

variable "linodekey" {
  type      = string
  sensitive = true
}

variable "razersshpub" {
  type      = string
  sensitive = true
}

variable "proxmoxapiurl" {
  type      = string
  sensitive = true
}

variable "proxmoxuser" {
  type      = string
  sensitive = true
}

variable "cloudflare_token" {
  type      = string
  sensitive = true
}

variable "healthchecksio_api_key" {
  type      = string
  sensitive = true
}

variable "network_zone_id" {
  type      = string
  sensitive = true
}

variable "random_pass" {
  type      = string
  sensitive = true
}

variable "setvar" {
  type      = string
  default   = "value"
  sensitive = true
}

variable "bgp_hostname" {
  type      = string
  sensitive = true
}

variable "network_domain" {
  type      = string
  sensitive = true
}

variable "uptimerobot_api_key" {
  type      = string
  sensitive = true
}

variable "contact_email" {
  type      = string
  sensitive = true
}

variable "gateway_ip" {
  type      = string
  sensitive = true
}

variable "personal_zone_id" {
  type      = string
  sensitive = true
}

variable "hc_internal_api_key" {
  type      = string
  sensitive = true
}

variable "hc_internal_api_url" {
  type      = string
  sensitive = true
}

variable "personal_domain" {
  type      = string
  sensitive = false
}

variable "statping_api_key" {
  type      = string
  sensitive = true
}

variable "rancher_api_url" {
  type      = string
  sensitive = true
}

variable "rancher_access_key" {
  type      = string
  sensitive = true
}

variable "rancher_secret_key" {
  type      = string
  sensitive = true
}

variable "cname_destination" {
  type      = string
  sensitive = true
}

variable "nfs_ip" {
  type      = string
  sensitive = true
}