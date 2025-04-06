provider "google" {
  project = var.project_id
  region  = var.region_a
}

# Cloud Run in Region A
module "cloud_run_a" {
  source       = "./modules/cloud_run"
  region       = var.region_a
  service_name = var.service_name_a
}

# Cloud Run in Region B
module "cloud_run_b" {
  source       = "./modules/cloud_run"
  region       = var.region_b
  service_name = var.service_name_b
}

# Load Balancer setup
module "load_balancer" {
  source         = "./modules/load_balancer"
  project_id     = var.project_id
  backends = [
    {
      region       = var.region_a
      service_name = var.service_name_a
    },
    {
      region       = var.region_b
      service_name = var.service_name_b
    }
  ]
}
