# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://81a30dca66c3b723b884d5d9b9ce12d5@o4506438536003584.ingest.sentry.io/4506653603725312'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.enabled_environments = %w[production staging]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
