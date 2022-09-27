##### Prerequisites

The setups steps expect following tools installed on the system (Tested on).

- Github
- Ruby 2.7.4p191
- Rails 6.1.7
- PostgreSQL 14.1
- Redis v=5.0.7

##### Install dependencies

```bash
bundle exec bundle install
npm install
```

##### Create and migrate the database

```bash
rails db:create db:migrate
```

##### Start Webpack Dev server (Optional)
Separate server for compiling VueJS on real time.

```bash
./bin/webpack-dev-server
```

##### Start Sidekiq
Simple, efficient background processing for Ruby.
You can start the sidekiq server using the command given below.

```bash
sidekiq
```

##### Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000/dashboard

The dashboard contains two list scrollable list. Both of them are subscribed to separate Channels.
While the other list is filled with inventory that is less than or equal to 10, the list on the left shows real-time store updates.
Both channels are created and broadcast from Rails app through Sidekiq(async worker). The frontend is handled by VueJS.

All the messages received from Web Socket by Event machine is carried out in one of the worker. This broadcasts to `StockChannel` responsible for live updates.
Every 10 messages is bundled and sent to another worker. This worker saves all the messages in DB table `shoe_stores`.
After saving, it broadcasts list of all store-model which have inventories less than 10 to `LowInventoryChannel`.

This provides a live stream for all browser-based store updates.

##### Available JSON API to fetch store, model and inventory range

```bash
http://localhost:3000/store-check
```

Accepted params
```bash
store = Name of Store
model = Name of model
less_than = ALl store with model have inventory less than provided value
more_than = Same as less than but output with list more than provided value

*All these params can be used together as well.
```
Example
```bash
http://localhost:3000/store-check?store=ALDO Auburn Mall&model=GRELIDIEN&less_than=50&more_than=30
```

