help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST)  | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
frontend:  ## install frontend
	@sh components/frontend.sh
mongodb: ## install mongodb
	@sh components/mongodb.sh
catalogue: ## install catalogue
	@sh components/catalogue.sh
redis: ## install redis
	@sh components/redis.sh
user: ## install user
	@sh components/user.sh
cart: ## install cart
	@sh components/cart.sh
mysql: ## install mysql
	@sh components/mysql.sh
shipping: ## install shipping
	@sh components/shipping.sh
rabbitmq: ## install rabbitmq
	@sh components/rabbitmq.sh
payment: ## install payment
	@sh components/payment.sh