# Credentials provided with HEROKU_EMAIL and HEROKU_API_KEY
provider "heroku" {}

resource "heroku_addon" "rate_limit_redis" {
    app = "travis-production"
    plan = "heroku-redis:premium-0"
}

output "rate_limit_redis_addon_name" {
    value = "${heroku_addon.rate_limit_redis.name}"
}
