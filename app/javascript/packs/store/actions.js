import MutationTypes from "./mutation-types";
import axios from "axios";
export default {
  getBacklog({ commit }, id) {
    commit(MutationTypes.GET_BACKLOG_REQUEST);
    axios
      .get(`/api/v1/private/backlogs/${id}/columns_and_items_get.json`)
      .then(response => {
        commit(MutationTypes.GET_BACKLOG_SUCCESS, response.data);
      })
      .catch(error => {
        commit(MutationTypes.GET_BACKLOG_FAILURE, error);
      });
  },
  moveItem({ commit }, event) {
    var to = {
      columnIndex: Number(event.to.dataset.columnIndex),
      itemIndex: event.newIndex
    };
    commit(MutationTypes.MOVE_ITEM, to);
  },
  moveColumn({ commit }, event) {
    var toIndex = event.newIndex
    commit(MutationTypes.MOVE_COLUMN, toIndex);
  },
  setColumns({ commit }, val) {
    commit(MutationTypes.SET_COLUMNS, val);
  }
};
