# Copyright (C) 2021 One More Game - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

data "vault_generic_secret" "buildkite" {
  path = "secret/buildkite"
}

data "vault_generic_secret" "ci" {
  path = "secret/tap/ci"
}

provider "buildkite" {
  api_token    = data.vault_generic_secret.buildkite.data["api_token"]
  organization = "one-more-game"
}

provider "github" {
  token = data.vault_generic_secret.ci.data["github_token"]
  owner = "PlayOneMoreGame"
}
