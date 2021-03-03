# Copyright (C) 2021 One More Game - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

resource "buildkite_pipeline" "this" {
  name                                     = github_repository.this.name
  repository                               = github_repository.this.ssh_clone_url
  cancel_intermediate_builds               = true
  cancel_intermediate_builds_branch_filter = "!master"
  default_branch                           = "master"
  skip_intermediate_builds                 = true
  skip_intermediate_builds_branch_filter   = "!master"
  steps                                    = <<EOH
steps:
  - command: "buildkite-agent pipeline upload .buildkite/pipeline.yml"
    label: ":pipeline:"
    agents:
      os: linux
EOH

  team {
    slug         = data.terraform_remote_state.buildkite.outputs.omg_team_slug
    access_level = "BUILD_AND_READ"
  }
}
