variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name2" {
  type = string
}

variable "location2" {
  type = string
}

variable "vnet1" {
  type = string
}

variable "subnet1" {
  type = string
}

variable "vnet2" {
  type = string
}

variable "subnet2" {
  type = string
}

variable "vmss1" {
  type = string
}

variable "vmss2" {
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

variable "nat2" {
  type = string
}

variable "ipconfig2" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}