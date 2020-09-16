import MUTATION_TYPES from "./mutation-types";
import Vue from "vue";
export const mutations = {
  [MUTATION_TYPES.GET_BACKLOG_REQUEST](state) {},
  [MUTATION_TYPES.GET_BACKLOG_SUCCESS](state, posts) {
    state.columns = posts.message.columns;
  },
  [MUTATION_TYPES.GET_BACKLOG_FAILURE](state, error) {
    alert(error);
  },

  [MUTATION_TYPES.MOVE_ITEM](state, to) {
    //apiに変更
    console.log(
      "移動したアイテムのID = " +
        state.columns[to.columnIndex].items[to.itemIndex].id
    );
    console.log("移動先のcolumnId = " + state.columns[to.columnIndex].id);
    console.log("移動先のindex = " + to.itemIndex);
  },
  [MUTATION_TYPES.SET_COLUMNS](state, val) {
    state.columns = val;
  },
  [MUTATION_TYPES.MOVE_COLUMN](state, toIndex) {
    //apiに変更
    console.log("移動したカラムのID = " + state.columns[toIndex].id);
    console.log("移動先のindex = " + toIndex);
  }
};
