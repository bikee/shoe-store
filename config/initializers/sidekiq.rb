require 'sidekiq/api'

Sidekiq::Extensions.enable_delay!

# Clear and Start fetching event on start
Sidekiq::Queue.new('events').clear
Sidekiq::RetrySet.new.clear
FetchEventsJob.perform_async
