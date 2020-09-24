import Vue from "vue";
import Vuex from "vuex";
import { mutations } from "./mutations";
import actions from "./actions";
Vue.use(Vuex);
const state = {
  backlogId: "",
  columns: [],
  itemModalFlag: false,
  itemModalInfo: {},
  users: {
    1: { name: "UserA" },
    2: { name: "UserB" },
    3: { name: "UserC" },
    4: { name: "UserD" }
  },
  tags: {
    1: { name: "tagA" },
    2: { name: "tagB" },
    3: { name: "tagC" },
    4: { name: "tagD" }
  },
  columnModalFlag: false,
  columnModalInfo: {
    new: true,
    columnIndex: 1,
    column: {
      name: "sample",
      color: "#FDA1FF",
      items: []
    }
  }
};

const store = new Vuex.Store({
  state,
  mutations,
  actions
});

export default store;
