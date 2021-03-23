terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "4.1.0"
    }
  }
}

provider "heroku" {
  email = var.heroku_email
  api_key = var.heroku_api_key
} 

resource "heroku_app" "app_production" {
  name = "app-production-tp"
  region = "us"
}

resource "heroku_addon" "db_production" {
  app  = heroku_app.app_production.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "app_staging" {
  name = "app-staging-tp"
  region = "us"
}

resource "heroku_addon" "db_staging" {
  app  = heroku_app.app_staging.name
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_app" "app_QA" {
  name = "app-qa-tp"
  region = "us"
}

resource "heroku_addon" "db_QA" {
  app  = heroku_app.app_QA.name
  plan = "heroku-postgresql:hobby-dev"
}
#Pour créer la pipeline
resource "heroku_pipeline" "pipeline" {
  name = "projet-terraform-tp"
}

# Couple apps to different pipeline stages
resource "heroku_pipeline_coupling" "staging" {
  app = heroku_app.app_staging.name
  pipeline = heroku_pipeline.pipeline.id
  stage = "staging" 
}

resource "heroku_pipeline_coupling" "production" {
  app = heroku_app.app_production.name
  pipeline = heroku_pipeline.pipeline.id
  stage = "production" 
}

resource "heroku_pipeline_coupling" "QA" {
  app = heroku_app.app_QA.name
  pipeline = heroku_pipeline.pipeline.id
  stage = "review" 
}
