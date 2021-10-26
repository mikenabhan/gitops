resource "cloudflare_record" "service_primary" {
  zone_id = var.personal_zone_id
  name    = proxmox_vm_qemu.instance[count.index].name
  value   = proxmox_vm_qemu.instance[count.index].default_ipv4_address
  type    = "A"
  ttl     = 60
  proxied = false
  count   = length(proxmox_vm_qemu.instance)
}