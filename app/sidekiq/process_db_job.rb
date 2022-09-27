class ProcessDbJob
  include Sidekiq::Job

  def perform(*args)
    begin
      low_inventories = ShoeStore.where(inventory: 0..10).order(inventory: :asc)

      ActionCable.server.broadcast(
        'low_inventory_channel', low_inventories.to_json
      )
    rescue Exception => e
      puts "Issue Updating DB! #{e}"
    end
  end
end

