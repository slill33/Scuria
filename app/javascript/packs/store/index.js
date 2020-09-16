import Vue from "vue";
import Vuex from "vuex";
import { mutations } from "./mutations";
import actions from "./actions";
Vue.use(Vuex);
// export const store = new Vuex.Store({
//   state: {
//     items: [
//       { is_do: false, title: "タスク1" },
//       { is_do: true, title: "タスク2" },
//       { is_do: false, title: "タスク3" }
//     ]
//     // backlogId: this.$route.params["id"]
//   },
//   mutations,
//   actions
// });
const state = {
  name: "name",
  columns:[]
};

const store = new Vuex.Store({
  state,
  mutations,
  actions
});

export default store;
