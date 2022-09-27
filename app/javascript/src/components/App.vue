<template>
  <div class="container-fluid ">
    <div class="row d-flex justify-content-center mb-5 title-div">
      <h1 class="title">Shoe Store</h1>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="row d-flex justify-content-center mb-2">
          <h2>Live store Update</h2>
        </div>
        <virtual-list
          class="list scroll-touch"
          :data-key="'store'"
          :data-sources="list"
          :data-component="itemComponent"
          :item-class="'list-item-fixed'"
        />
      </div>
      <div class="col-md-6">
        <div class="row d-flex justify-content-center mb-2">
          <h2>Store with low Inventory</h2>
        </div>
        <virtual-list
          class="list scroll-touch"
          :data-key="'id'"
          :data-sources="low_inventory_list"
          :data-component="itemComponent"
          :item-class="'list-item-fixed'"
        />
      </div>
    </div>
  </div>
</template>

<script>
import VirtualList from 'vue-virtual-scroll-list';
import Item from './Item';

export default {
  name: 'App',
  data() {
    return {
      itemComponent: Item,
      list: [],
      low_inventory_list: [],
    };
  },

  channels: {
    StockChannel: {
      connected() {
        console.log('StockChannel Connected!');
      },
      rejected() {},
      received(data) {
        this.list.unshift(data);
      },
      disconnected() {},
    },
    LowInventoryChannel: {
      connected() {
        console.log('LowInventoryChannel Connected!');
      },
      rejected() {},
      received(data) {
        this.$set(this, 'low_inventory_list', JSON.parse(data));
      },
      disconnected() {},
    },
  },

  mounted() {
    this.$cable.subscribe({
      channel: "StockChannel",
    });

    this.$cable.subscribe({
      channel: "LowInventoryChannel",
    });
  },
}
</script>

<style lang="scss" scoped>
  .title {
    padding: 20px;
    text-align: center;
    color: white;
    font-size: 30px;
  }

  .title-div {
    background: #1abc9c;
  }
</style>

<style lang="scss">
  .list {
    height: 600px;
    width: 100%;
    border: 2px solid;
    border-radius: 3px;
    overflow-y: auto;
    border-color: dimgray;
    display:inline;
    float:left;
  }

  .list-item-fixed {
    display: flex;
    align-items: center;
    padding: 0 1em;
    height: 60px;
    border-bottom: 1px solid;
    border-color: lightgray;
  }
</style>