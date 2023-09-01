project_id = "km1-runcloud"

host_service_account = "serviceAccount:sricharank-km1-runcloud-iam-gs@km1-runcloud.iam.gserviceaccount.com"

service_project_account = "user:baljeet@baljeetkaursce.joonix.net"

service_project_id_1 = "service-project1-367504"

delete_default_internet_gw = "true"

network_name = "shared-vpc-kamp-project"

region = "europe-west8" 

subnets_iam = [
    "milan-subnet-01"
]

subnet1 = "milan-subnet-01"

subnet_ip1 = "10.0.0.0/24"

ip-range-pods-gke-autopilot-private = "ip-range-pods-gke-autopilot-private"

ip-range-service-gke-autopilot-private = "ip-range-service-gke-autopilot-private"

ip_cidr_range_pods = "192.168.64.0/24"

ip_cidr_range_service = "172.16.1.0/28"

rules = [{
    name                    = "firewall-allow-ssh-ingress"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
