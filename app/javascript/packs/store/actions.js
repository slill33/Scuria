import MutationTypes from "./mutation-types";
import axios from "axios";
//後でモジュール化対応
//https://vuex.vuejs.org/ja/guide/structure.html
export default {
  // Backlog関係のaction
  setBacklogId({ commit }, id) {
    commit(MutationTypes.SET_BACKLOG_ID, id);
  },
  getBacklog({ commit, state }) {
    axios
      .get(
        `/api/v1/private/backlogs/${state.backlogId}/columns_and_items_get.json`,
      )
      .then(response => {
        commit(MutationTypes.GET_BACKLOG_SUCCESS, response.data);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },


  //Item関係のaction
  moveItem({ commit, state }, event) {
    axios
      .put(
        `/api/v1/private/backlogs/${state.backlogId}/item_location_update.json`,
        {
          backlog_item_id: state.columns[Number(event.to.dataset.columnIndex)].items[event.newIndex].id,
          new_column_id: state.columns[Number(event.to.dataset.columnIndex)].id,
          new_priority: event.newIndex,
        }
      )
      .then(response => {
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  updateItem({ commit, state }) {
    commit(MutationTypes.FORMAT_ITEM_MODAL_INFO);
    const item = state.itemModalInfo.item
    axios
      .put(
        `/api/v1/private/backlogs/${state.backlogId}/backlog_items/update.json`,
        {
          id: state.columns[state.itemModalInfo.columnIndex].items[state.itemModalInfo.itemIndex].id,
          name: item.name,
          point: item.point,
          description: item.description,
          user_ids: item.users,
          tag_ids: item.tags,
          parent_id: item.parent_id,
          child_backlog_id: item.child_backlog_id
        }
      )
      .then(response => {
        commit(MutationTypes.ITEM_UPDATE_SUCCESS);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  createItem({ commit, state }) {
    const item = state.itemModalInfo.item
    axios
      .post(
        `/api/v1/private/backlogs/${state.backlogId}/backlog_items/create.json`,
        {
          backlog_column_id: state.columns[state.itemModalInfo.columnIndex].id,
          name: item.name,
          point: item.point,
          description: item.description,
          user_ids: item.users,
          tag_ids: item.tags,
          parent_id: item.parent_id,
          child_backlog_id: item.child_backlog_id
        }
      )
      .then(response => {
        commit(MutationTypes.ITEM_CREATE_SUCCESS, response);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  deleteItem({ commit, state }) {
    const ans = confirm("本当に削除しますか？");
    if (ans) {
      axios
        .delete(
          `/api/v1/private/backlogs/${state.backlogId}/backlog_items/destroy.json`,
          {
            data:
            {
              id: state.columns[state.itemModalInfo.columnIndex].items[state.itemModalInfo.itemIndex].id,
            }
          }
        )
        .then(response => {
          commit(MutationTypes.ITEM_DELETE_SUCCESS);;
        })
        .catch(error => {
          commit(MutationTypes.API_FAILURE, error);
        });
    }
  },


  //Item用モーダルウィンドウ関係のaction
  editItem({ commit }, val) {
    var itemModalInfo = {
      new: false,
      columnIndex: val.columnIndex,
      itemIndex: val.itemIndex,
      tagName: "",
      tagField: false,
      item: JSON.parse(JSON.stringify(val.item))
    };
    commit(MutationTypes.SET_ITEM_MODAL_INFO, itemModalInfo);
  },
  closeItemModal({ commit }) {
    commit(MutationTypes.CLOSE_ITEM_MODAL);
  },
  editPoint({ commit }, point) {
    commit(MutationTypes.EDIT_POINT, point);
  },
  showTagField({ commit }) {
    commit(MutationTypes.SHOW_TAG_FIELD);
  },
  toggleTag({ commit }, tagId) {
    commit(MutationTypes.TOGGLE_TAG, tagId);
  },
  setTagName({ commit }, name) {
    commit(MutationTypes.SET_TAG_NAME, name);
  },

  addUser({ commit }) {
    commit(MutationTypes.ADD_USER);
  },
  changeUser({ commit }, val) {
    commit(MutationTypes.CHANGE_USER, val);
  },
  editItemName({ commit }, name) {
    commit(MutationTypes.SET_ITEM_MODAL_INFO_NAME, name);
  },
  editItemDescription({ commit }, description) {
    commit(MutationTypes.SET_ITEM_MODAL_INFO_DESCRIPTION, description);
  },
  newItem({ commit }, index) {
    var itemModalInfo = {
      new: true,
      columnIndex: index,
      itemIndex: "",
      tagName: "",
      tagField: false,
      item: {
        id: "",
        name: "",
        tags: [],
        users: [],
        point: 0,
        description: "",
        parent_id: 0,
        child_backlog_id: 0
      }
    };
    commit(MutationTypes.SET_ITEM_MODAL_INFO, itemModalInfo);
  },

  //Tag関係のaction
  addTag({ commit, state }, name) {
    axios
      .post(
        `/api/v1/private/backlogs/${state.backlogId}/backlog_tags/create.json`,
        {
          name: name,
        }
      )
      .then(response => {
        commit(MutationTypes.ADD_TAG_SUCCESS, response.data);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },

  //Column関係のaction
  moveColumn({ commit, state }, event) {
    axios
      .put(
        `/api/v1/private/backlogs/${state.backlogId}/column_location_update.json`,
        {
          backlog_column_id: state.columns[event.newIndex].id,
          new_position: event.newIndex,
        }
      )
      .then(response => {
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  setColumns({ commit }, val) {
    commit(MutationTypes.SET_COLUMNS, val);
  },
  updateColumn({ commit, state }) {
    const column = state.columnModalInfo.column
    axios
      .put(
        `/api/v1/private/backlogs/${state.backlogId}/backlog_columns/update.json`,
        {
          id: column.id,
          name: column.name,
          color: column.color,
          parent_id: column.parent_id,

        }
      )
      .then(response => {
        commit(MutationTypes.COLUMN_UPDATE_SUCCESS);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  createColumn({ commit, state }) {
    const column = state.columnModalInfo.column
    axios
      .post(
        `/api/v1/private/backlogs/${state.backlogId}/backlog_columns/create.json`,
        {
          name: column.name,
          color: column.color,
          parent_id: column.parent_id,
        }
      )
      .then(response => {
        commit(MutationTypes.COLUMN_CREATE_SUCCESS, response);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
      });
  },
  deleteColumn({ commit, state }) {
    const ans = confirm("本当に削除しますか?");
    if (ans) {
      axios
        .delete(
          `/api/v1/private/backlogs/${state.backlogId}/backlog_columns/destroy.json`,
          {
            data:
            {
              id: state.columnModalInfo.column.id,
            }
          }
        )
        .then(response => {
          commit(MutationTypes.COLUMN_DELETE_SUCCESS);;
        })
        .catch(error => {
          commit(MutationTypes.API_FAILURE, error);
        });
    }
  },


  //Column用モーダルウィンドウ関係のaction
  setColumnColor({ commit }, val) {
    commit(MutationTypes.SET_COLUMN_COLOR, val.hex);
  },
  closeColumnModal({ commit }) {
    commit(MutationTypes.CLOSE_COLUMN_MODAL);
  },
  editColumn({ commit }, val) {
    var columnModalInfo = {
      new: false,
      columnIndex: val.index,
      column: JSON.parse(JSON.stringify(val.column))
    };
    commit(MutationTypes.EDIT_COLUMN_MODAL_INFO, columnModalInfo);
  },
  newColumn({ commit }) {
    var columnModalInfo = {
      new: true,
      columnIndex: "",
      column: {
        name: "",
        color: "#4D4D4D",
        items: [],
        parent_id: 0,
      }
    };
    commit(MutationTypes.EDIT_COLUMN_MODAL_INFO, columnModalInfo);
  },
  editColumnName({ commit }, name) {
    commit(MutationTypes.SET_COLUMN_MODAL_INFO_NAME, name);
  },
  editColumnParentColumn({ commit }, parentId) {
    commit(MutationTypes.EDIT_COLUMN_PARENT_COLUMN, parentId);
  },
  editItemChildBacklog({ commit }, childId) {
    commit(MutationTypes.EDIT_ITEM_CHILD_BACKLOG, childId);
  },
  editItemParentItem({ commit }, parentId) {
    commit(MutationTypes.EDIT_ITEM_PARENT_ITEM, parentId);
  },
};
