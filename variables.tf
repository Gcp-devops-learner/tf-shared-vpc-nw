variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  default     = ""
}

variable "service_project_id_1" {
  description = "The ID of the service project"
  type        = string
}

# variable "service_project_id_2" {
#   description = "The ID of the service project"
#   type        = string
# }

variable "host_service_account" {
  description = "The service account of the host project"
  type        = string
}

variable "service_project_account" {
  description = "The service account of the service project"
  type        = string
}


# variable "cluster_name" {
#   type        = string
#   description = "The name of the cluster (required)"
# }


variable "network_name" {
  type    = string
  default = ""
}

# variable "subnets" {
#   type        = list(map(string))
#   description = "The list of subnets being created"
# }

variable "subnet1" {
  type        = string
    description = "The  subnets being created"
}

# variable "subnet2" {
#   type        = string
#     description = "The  subnets being created"
# }

# variable "subnet3" {
#   type        = string
#   description = "The  subnets being created"
# }

variable "subnet_ip1" {
  type        = string
  description = "The  subnets ip being created"
}

# variable "subnet_ip2" {
#   type        = string
#   description = "The  subnets ip being created"
# }

# variable "subnet_ip3" {
#   type        = string
#   description = "The  subnets ip being created"
# }

variable "subnets_iam" {
  type        = list(string)
  description = "The list of subnets being created"
}


 variable "ip-range-pods-gke-autopilot-private" {
  type = string
  description = "Ip range pods should be mentioned"

 }

  variable "ip-range-service-gke-autopilot-private" {
  type = string
  description = "Ip range service should be mentioned"

 }

 variable "ip_cidr_range_pods" {
  type = string
  description = "Ip range pods should be mentioned"
 }

 variable "ip_cidr_range_service" {
  type = string
  description = "Ip range service should be mentioned"
 }

# variable "secondary_ranges" {
#   type        = map(list(object({ range_name = string, ip_cidr_range = string })))
#   description = "Secondary ranges that will be used in some of the subnets"
#   default     = {}
# }

variable "region" {
  type = string
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "shared_vpc_host" {
  type        = bool
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = false
}

variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "delete_default_internet_gw" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = true
}

variable "mtu" {
  type        = number
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  default     = 0
}

# variable "gke_master_ipv4" {
#     type = string
#     }

#  variable "gke_master_authorized_nw" {
#     type =string
#  }
   


variable "rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
}


