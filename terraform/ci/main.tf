# Copyright (C) 2021 One More Game - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

terraform {
  backend "consul" {
    path = "terraform/ci/omgpkgs"
    lock = true
  }
}

###############################################################################
#                                     Data                                    #
###############################################################################

data "terraform_remote_state" "buildkite" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tf-root"
    storage_account_name = "omgtfroot"
    container_name       = "tfstate"
    key                  = "core-infrastructure.services.buildkite.tfstate"
  }
}

data "terraform_remote_state" "github" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tf-root"
    storage_account_name = "omgtfroot"
    container_name       = "tfstate"
    key                  = "core-infrastructure.services.github.tfstate"
  }
}
