# Copyright (C) 2021 One More Game - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

resource "github_repository" "this" {
  name                   = "omgpkgs"
  description            = "OMG Nix Package Expressions"
  delete_branch_on_merge = true
  visibility             = "public"
  has_issues             = true
  has_wiki               = false
  topics                 = ["nix", "nixos", "nixpkgs"]
  vulnerability_alerts   = true
}

resource "github_team_repository" "this_bots" {
  team_id    = data.terraform_remote_state.github.outputs.bots_team.id
  repository = github_repository.this.name
  permission = "pull"
}

resource "github_team_repository" "this_infra" {
  team_id    = data.terraform_remote_state.github.outputs.infra_team.id
  repository = github_repository.this.name
  permission = "push"
}

resource "github_branch_protection" "this" {
  repository_id          = github_repository.this.name
  pattern                = "master"
  enforce_admins         = true
  require_signed_commits = true

  required_status_checks {
    contexts = ["buildkite/${buildkite_pipeline.this.slug}"]
  }
}

resource "github_repository_webhook" "this" {
  repository = github_repository.this.name
  events     = ["deployment", "pull_request", "push"]

  configuration {
    url          = buildkite_pipeline.this.webhook_url
    content_type = "application/json"
    insecure_ssl = false
  }
}
