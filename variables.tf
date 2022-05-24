variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet1" {
  type = string
}

variable "subnet1" {
  type = string
}

variable "vmss1" {
  type = string
}

variable "vmssusername" {
  type = string
}

variable "vmsspassword" {
  type = string
  sensitive = true
}

variable "vmsku" {
  type = string
}

variable "nat1" {
  type = string
}

variable "ipconfig" {
  type = string
}