terraform {
  backend "remote" {
    organization = ""

    workspaces {
      name = "k8s-prod"
    }
  }
}
