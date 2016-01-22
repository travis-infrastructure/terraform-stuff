# Credentials provided with HEROKU_EMAIL and HEROKU_API_KEY
provider "heroku" {}

resource "heroku_addon" "rate_limit_redis" {
    app = "travis-staging"
    plan = "heroku-redis:premium-0"
}

output "rate_limit_redis_url_env_var" {
    value = "${heroku_addon.rate_limit_redis.config_vars.0}"
}
