locals {
  service_project_1 = {
    service_project_id_1   = var.service_project_id_1 
  }
#   service_project_2 = {
#     service_project_id_2 = var.service_project_id_2 
#   }
  host_service_account_1 = var.host_service_account

  service_project_account_1 =var.service_project_account

}

module "vpc-host" {
  source     = "./modules"
  depends_on = [module.vpc, module.firewall_rules]
  project_id = var.project_id 
  shared_vpc_host = true
  shared_vpc_service_projects = [
    local.service_project_1.service_project_id_1 ,
    # local.service_project_2.service_project_id_2
  ]
  
}

module "vpc"  {
    source  = "terraform-google-modules/network/google"
    version = "~> 7.2"
    project_id   = var.project_id 
    network_name = var.network_name
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = var.subnet1
            subnet_ip             = var.subnet_ip1
            subnet_region         = var.region
        }
    ]
 

    secondary_ranges = {
        milan-subnet-01 = [
            {
                range_name    = var.ip-range-pods-gke-autopilot-private
                ip_cidr_range =  var.ip_cidr_range_pods 
            },
            {
                range_name    = var.ip-range-service-gke-autopilot-private
                ip_cidr_range = var.ip_cidr_range_service      
            },
        ]

        subnet-02 = []
    }

}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  depends_on = [module.vpc]
  project_id   = var.project_id
  network_name = var.network_name
  rules = [

    for r in var.rules : {
      name                    = r.name
      description             = r.description
      direction               = r.direction
      priority                = r.priority
      ranges                  = r.ranges
      source_tags             = r.source_tags
      source_service_accounts = r.source_service_accounts
      target_tags             = r.target_tags
      target_service_accounts = r.target_service_accounts
      allow                   = r.allow
      deny                    = r.deny
      log_config              = r.log_config
  }]
}

module "subnet-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/subnets_iam"
  depends_on = [module.vpc-host]
  subnets        = var.subnets_iam 
  subnets_region = var.region
  project        = var.project_id   
  mode           = "authoritative"
  bindings = {
    "roles/compute.networkUser" = [
        local.host_service_account_1,
        local.service_project_account_1
        
    #   "group:my-group@my-org.com",
    #   "user:my-user@my-org.com",
    ]
    # "roles/compute.networkViewer" = [
    #   "serviceAccount:my-sa@my-project.iam.gserviceaccount.com",
    #   "group:my-group@my-org.com",
    #   "user:my-user@my-org.com",
    # ]
  }
#   conditional_bindings = [
#     {
#       role = "roles/compute.networkAdmin"
#       title = "expires_after_2019_12_31"
#       description = "Expiring at midnight of 2019-12-31"
#       expression = "request.time < timestamp(\"2020-01-01T00:00:00Z\")"
#       members = ["user:my-user@my-org.com"]
#     }
#   ]
}



