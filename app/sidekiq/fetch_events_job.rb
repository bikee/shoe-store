class FetchEventsJob
  include Sidekiq::Job
  require 'faye/websocket'
  require 'eventmachine'
  require 'json'
  sidekiq_options queue: 'events', concurrency: 1

  def perform(*args)
    events = []

    EM.run {
      ws = Faye::WebSocket::Client.new('ws://localhost:8080/')

      ws.on :message do |event|
        ActionCable.server.broadcast(
          "stock_channel", JSON.parse(event.data)
        )

        events << JSON.parse(event.data)

        if events.count > 10
          UpdateDbJob.perform_async(events)
          events = []
        end

        p JSON.parse(event.data)
      end

      ws.on :close do |event|
        p [:close, event.code, event.reason]
        ws = nil
        break
      end
    }
  end
end
