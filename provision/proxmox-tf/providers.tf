terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
    vultr = {
      source  = "vultr/vultr"
      version = "2.2.0"
    }
    linode = {
      source  = "linode/linode"
      version = "1.16.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
    healthchecksio = {
      source  = "kristofferahl/healthchecksio"
      version = "~> 1.9.0"
    }
    uptimerobot = {
      source  = "louy/uptimerobot"
      version = "0.5.1"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = "0.2.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.2.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.15.1"
    }
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = "0.5.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmoxapiurl
  pm_user         = var.proxmoxuser
  pm_password     = var.pmpass
  pm_tls_insecure = true
}


provider "vultr" {
  api_key     = var.vultrpass
  rate_limit  = 700
  retry_limit = 3
}

provider "linode" {
  token = var.linodekey
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "healthchecksio" {
  api_key = var.healthchecksio_api_key
}

provider "healthchecksio" {
  api_key = var.hc_internal_api_key
  api_url = var.hc_internal_api_url
  alias   = "internal"
}

provider "uptimerobot" {
  api_key = var.uptimerobot_api_key
}

provider "acme" {
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}

provider "macaddress" {
  # Configuration options
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  # config_context = "main-context"
}

provider "kubernetes-alpha" {
  config_path = "~/.kube/config"
  # config_context = "main-context"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "rancher2" {
  api_url    = var.rancher_api_url
  access_key = var.rancher_access_key
  secret_key = var.rancher_secret_key
  insecure   = true
}