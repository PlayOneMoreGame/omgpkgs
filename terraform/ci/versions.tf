# Copyright (C) 2021 One More Game - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

terraform {
  required_version = ">= 0.13"
  required_providers {
    buildkite = {
      source  = "jradtilbrook/buildkite"
      version = "0.0.15"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.16"
    }
  }
}
