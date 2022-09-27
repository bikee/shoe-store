import Vue from 'vue';
import ActionCableVue from 'actioncable-vue';
import App from '@/components/App.vue';
import { BootstrapVue } from 'bootstrap-vue';
import 'bootstrap-vue/node_modules/bootstrap/scss/bootstrap.scss';

export default () => {
  document.addEventListener('DOMContentLoaded', () => {
    Vue.use(ActionCableVue, {
      debug: true,
      debugLevel: "error",
      connectionUrl: "ws://localhost:3000/cable", // or function which returns a string with your JWT appended to your server URL as a query parameter
      connectImmediately: true,
    });

    Vue.use(BootstrapVue);
    new Vue({
      render: (h) => h(App),
    }).$mount("#vue-app");
  })
}