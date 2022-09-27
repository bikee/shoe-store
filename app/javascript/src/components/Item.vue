<template>
  <div class="item-inner">
    <span class="date">{{ dateTime }}</span>
    <span class="store">{{ source.store }}</span>
    <span class="model">{{ source.model }}</span>
    <span class="inventory" :class="status(source.inventory)">{{ source.inventory }}</span>
  </div>
</template>

<script>
export default {
  name: 'item-component',

  props: {
    source: {
      type: Object,
      default () {
        return {}
      }
    }
  },

  data() {
    return {
      date: '',
      time: '',
    }
  },

  computed: {
    dateTime() {
      let updatedDate = null;

      if (this.source.updated_at) {
        const date = new Date(this.source.updated_at);
        updatedDate = `${date.toLocaleDateString()} - ${date.toLocaleTimeString()}`
      }

      return updatedDate || `${this.date} - ${this.time}`;
    }
  },

  methods: {
    getDate: function () {
      return new Date().toLocaleDateString();
    },

    getTime: function () {
      return new Date().toLocaleTimeString();
    },

    status: function(value) {
      let classStatus = 'alerts';

      if (value >= 50) {
        classStatus = 'normal';
      } else if (value < 50 && value >= 20){
        classStatus = 'warn';
      }

      return classStatus;
    },
  },

  mounted: function () {
    this.date = this.getDate();
    this.time = this.getTime();
  }
}
</script>

<style lang="scss" scoped>
  .date {
    color: #606c76;
    font-size: 14px;
  }

  .store {
    font-size: 20px;
    padding-left: 5px;
    padding-right: 5px;
  }

  .model {
    font-size: 18px;
    color: #2196F3;
  }

  .inventory {
    margin-left: 10px;
    padding-left: 10px;
    padding-right: 10px;
    font-size: 25px;
  }

  .warn {
    color: #000;
    background-color: #ffeb3b;
  }

  .alerts {
    color: #fff;
    background-color: #f44336
  }

  .normal {
    color: #fff;
    background-color: #4CAF50;
  }
</style>