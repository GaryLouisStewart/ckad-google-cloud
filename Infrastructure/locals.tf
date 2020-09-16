resource "random_string" "resource_names" {
    length = 8
    upper = false
    number = false
    lower = true
    special = false
}

locals {
    resource_name = "${var.name_prefix}-${random_string.resource_names.result}"
}