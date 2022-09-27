import consumer from "./consumer"

consumer.subscriptions.create("LowInventoryChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to Low Inventory Channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
