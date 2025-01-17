terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" # Fixed typo in source
      version = "~> 2.25.0"
    }
  }
}

provider "docker" {}

# Create a Docker network
resource "docker_network" "monitoring_network" { # Removed the extra comma
  name = "monitoring_network"
}

# Deploy Prometheus container
resource "docker_container" "prometheus" { # Removed the extra comma
  name  = "prometheus_container"
  image = "prom/prometheus:latest" # Corrected image name

  ports {
    internal = 9090
    external = 9090
  }

  networks_advanced {
    name = docker_network.monitoring_network.name
  }

  volumes {
    host_path      = "C:\\Users\\HP\\Downloads\\terraform-proj\\prometheus.yml" # Update the absolute path
    container_path = "/etc/prometheus/prometheus.yml"
  }
}

# Deploy Grafana container
resource "docker_container" "grafana" {
  name  = "grafana_container"
  image = "grafana/grafana:latest" # Corrected syntax

  ports {
    internal = 3000
    external = 3000
  }

  networks_advanced {
    name = docker_network.monitoring_network.name
  }
}
