import MutationTypes from "./mutation-types";
import axios from "axios";
export default {
  setBacklogId({ commit }, id) {
    commit(MutationTypes.SET_BACKLOG_ID, id);
  },
  getBacklog({ commit, state }) {
    axios
      .get(
        `/api/v1/private/backlogs/${state.backlogId}/columns_and_items_get.json`
      )
      .then(response => {
        commit(MutationTypes.GET_BACKLOG_SUCCESS, response.data);
      })
      .catch(error => {
        commit(MutationTypes.API_FAILURE, error);
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
    var toIndex = event.newIndex;
    commit(MutationTypes.MOVE_COLUMN, toIndex);
  },
  setColumns({ commit }, val) {
    commit(MutationTypes.SET_COLUMNS, val);
  },
  editItem({ commit }, val) {
    var modalInfo = {
      new: false,
      columnIndex: val.columnIndex,
      itemIndex: val.itemIndex,
      tagName: "",
      tagField: false,
      item: JSON.parse(JSON.stringify(val.item))
    };
    commit(MutationTypes.SET_MODAL_INFO, modalInfo);
  },
  closeModal({ commit }) {
    commit(MutationTypes.CLOSE_MODAL);
  },
  addTag({ commit }, name) {
    var newTag = {
      id: 10,
      name: name
    };
    commit(MutationTypes.ADD_TAG_SUCCESS, newTag);
  },
  toggleTag({ commit }, tagId) {
    commit(MutationTypes.TOGGLE_TAG, tagId);
  },
  showTagField({ commit }) {
    commit(MutationTypes.SHOW_TAG_FIELD);
  },
  setTagName({ commit }, name) {
    commit(MutationTypes.SET_TAG_NAME, name);
  },
  editPoint({ commit }, point) {
    console.log(point);
    commit(MutationTypes.EDIT_POINT, point);
  },
  addUser({ commit }) {
    console.log("addUser");
    commit(MutationTypes.ADD_USER);
  },
  changeUser({ commit }, val) {
    commit(MutationTypes.CHANGE_USER, val);
  },
  itemUpdate({ commit, state }) {
    commit(MutationTypes.FORMAT_MODAL_INFO);
    console.log(state.modalInfo.item);
    //api
    commit(MutationTypes.ITEM_UPDATE_SUCCESS);
  },
  itemCreate({ commit, state }) {
    //api
    commit(MutationTypes.ITEM_CREATE_SUCCESS);
  },
  itemDelete({ commit, state }) {
    //api
    const ans = confirm("本当に削除しますか？");
    if (ans) commit(MutationTypes.ITEM_DELETE_SUCCESS);
  },
  editItemName({ commit }, name) {
    commit(MutationTypes.EDIT_ITEM_NAME, name);
  },
  newItem({ commit }, index) {
    var modalInfo = {
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
        point: ""
      }
    };
    commit(MutationTypes.SET_MODAL_INFO, modalInfo);
  }
};
