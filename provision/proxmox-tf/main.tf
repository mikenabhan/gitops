variable "hostname" {
  type      = string
  default     = "gitops"
}


variable "vm_count" {
  type      = number
  default     = 3
}


/* Null resource that generates a cloud-config file per vm */

data "template_file" "user_data" {
  count    = var.vm_count
  template = file("${path.module}/files/user_data.cfg")
  vars = {
    pubkey   = file("~/.ssh/id_rsa.pub")
    hostname = "${var.hostname}-${count.index}"
    fqdn     = "${var.hostname}-${count.index}.${var.personal_domain}"
    ping_url = healthchecksio_check.instance[count.index].ping_url
  }
}
resource "local_file" "cloud_init_user_data_file" {
  count    = var.vm_count
  content  = data.template_file.user_data[count.index].rendered
  filename = "${path.module}/files/user_data_${count.index}.cfg"
}

resource "null_resource" "cloud_init_config_files" {
  count = var.vm_count
  connection {
    type     = "ssh"
    user     = "${var.pve_user}"
    password = "${var.pve_password}"
    host = "pvef${count.index}.${var.personal_domain}"
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_file[count.index].filename
    destination = "/var/lib/vz/snippets/user_data_${var.hostname}-${count.index}.yml"
  }
}

/* Configure cloud-init User-Data with custom config file */
resource "proxmox_vm_qemu" "instance" {
  count = var.vm_count
  depends_on = [ null_resource.cloud_init_config_files
  ]

  name = "${var.hostname}-${count.index}"
  desc = "GitOps K3s Node"
  # target_node = "pve"
  target_node = (count.index == 0 ? "pve" : "pve${count.index + 1}")

  clone = "ubuntu-template"
  agent = "1"

  cores = 2
  memory = 8192
  balloon = 4096

  os_type = "cloud-init"
  network {
    bridge   = "vmbr0"
    firewall = "false"
    model    = "virtio"
  }

  disk {
    type    = "scsi"
    storage = "nvme"
    size    = "100G"
  }

  ipconfig0 = "ip=dhcp"
  cicustom = "user=local:snippets/user_data_${var.hostname}-${count.index}.yml"
  cloudinit_cdrom_storage = "local-lvm"

}

resource "healthchecksio_check" "instance" {
  count = var.vm_count
  provider = healthchecksio.internal
  name = "${var.hostname}-${count.index}"
  desc = "GitOps K3s Host Health"

  tags = [
    "home",
    "infrastructure",
    "private",
    "host"
  ]

  grace    = 120 # seconds
  schedule = "* * * * *"
  timezone = "America/Denver"

  channels = [
    data.healthchecksio_channel.telegram.id
  ]
}

data "healthchecksio_channel" "telegram" {
  provider = healthchecksio.internal
  kind = "telegram"
  name = "Custom"
}