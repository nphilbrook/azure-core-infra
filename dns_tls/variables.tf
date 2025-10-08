variable "resource_group_name" {
  type = string
}

variable "default_tags" {
  description = "A map of default tags to apply to all Azure resources"
  type        = map(string)
}