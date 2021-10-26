resource "local_file" "AnsibleInventory" {
  content = templatefile("./ansible/inventory.tmpl",
    {
      master-dns      = proxmox_vm_qemu.instance[*].name,
      master-ip       = proxmox_vm_qemu.instance[*].default_ipv4_address,
      master-id       = proxmox_vm_qemu.instance[*].name,
      network-domain  = var.personal_domain
    }
  )
  filename = "./ansible/hosts.yml"
}

output "playbook_command" {
  value = "ansible-playbook -i ./ansible/hosts.yml ./ansible/ha_cluster.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
}

output "get_kubeconfig" {
  value     = "k3sup install --skip-install --host ${proxmox_vm_qemu.instance[0].name}.${var.personal_domain}  --user ansible --local-path ~/.kube/config"
  sensitive = false
}

