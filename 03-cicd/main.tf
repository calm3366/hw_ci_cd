resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "image_os" {
  image_id = var.image_id
}

resource "yandex_compute_instance" "vm" {
  count = var.count_vm
  name = var.vm_name[count.index]
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vms_resources.cores 
    memory        = var.vms_resources.memory
    core_fraction = var.vms_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_os.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    #ssh-keys           = "${var.ssh_login}:${sensitive(file(var.file_ssh_public_key))}"
    user-data          = data.template_file.cloudinit.rendered 
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.ssh_login
    ssh_key = sensitive(file(var.file_ssh_public_key))
  }
}

resource "local_file" "user_vm" {
    content  = "ssh_login: ${var.ssh_login}"
    filename = "ter_vars/ssh_login.yml"
}

resource "local_file" "vm_01" {
    content  = "vm_01: ${yandex_compute_instance.vm[0].network_interface[0].nat_ip_address}"
    filename = "ter_vars/vm_01.yml"
}

resource "local_file" "vm_02" {
    content  = "vm_02: ${yandex_compute_instance.vm[1].network_interface[0].nat_ip_address}"
    filename = "ter_vars/vm_02.yml"
}

