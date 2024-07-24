terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "> 0.8"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket = "demo-tf-state"
    region = "ru-central1"
    key    = "terraform/terraform.tfstate"

    # access_key = (переменная в GITLAB-CI)
    # secret_key = (переменная в GITLAB-CI)

    skip_region_validation      = true
    skip_credentials_validation = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/<cloud_id>/<id_dynamodb>"
    dynamodb_table = "demo-tf-state"
  }
  required_version = ">= 1.0.0"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}