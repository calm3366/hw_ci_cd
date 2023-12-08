###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "file_ssh_public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "image_id" {
  type        = string
  default     = "fd8gvgtf1t3sbtt4opo6"
  description = "Centos-7"
}

# variable "image_id" {
#   type        = string
#   default     = "fd8e8mremu2mdi1p5kmi"
#   description = "ubuntu-2204-lts"
# }

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "ssh_login" {
  type        = string
  default     = "centos"
}

variable "count_vm" {
  type        = number
  default     = 2
}

variable "vm_name" {
  type        = list(string)
  default     = ["sonar-01","nexus-01"]
}

variable "vms_resources" {
    type = map
    default = { 
        "cores" = 2
        "memory" = 4
        "core_fraction" = 5
    }
}

variable "serial-port-enable" {
  default     = "1"
}

