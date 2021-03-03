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
  backend = "consul"

  config = {
    path = "terraform/services/buildkite"
    lock = true
  }
}

data "terraform_remote_state" "github" {
  backend = "consul"

  config = {
    path = "terraform/services/github"
    lock = true
  }
}
