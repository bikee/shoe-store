class UpdateDbJob
  include Sidekiq::Job

  def perform(events)
    begin
      events.each do |event|
        shoe_store = ShoeStore.find_or_create_by(store: event['store'], model: event['model'])
        shoe_store.update(inventory: event['inventory'])
      end

      ProcessDbJob.perform_async

    rescue Exception => e
      puts "Issue Updating DB! #{e}"
    end
  end
end
