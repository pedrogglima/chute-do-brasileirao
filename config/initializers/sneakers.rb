# frozen_string_literal: true

# host: <rabbitmq> stands for docker-compose dns.
Sneakers.configure connection: Bunny.new({ host: 'rabbitmq' })
Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy
