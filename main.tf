terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_compute_instance_v2" "test" {

  name = "steveb-test"
  image_name = "RockyLinux-8.7-OFED-5.8-dev"
  flavor_name = "balanced1.8cpu16ram"
  key_pair = "rocky_bastion_v2"
  
  network {
    name = "bastion"
    access_network = true
  }

  user_data = <<-EOF
    #cloud-config
    users:
      - name: default
        # this is taken from /etc/cloud/cloud.cfg:system_info:default_user
        lock_passwd: true
        gecos: "Cloud User"
        groups: [adm, systemd-journal]
        homedir: /var/lib/cloud-user
        sudo: ["ALL=(ALL) NOPASSWD:ALL"]
        shell: /bin/bash
        
        
  EOF

}