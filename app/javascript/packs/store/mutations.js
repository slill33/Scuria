import MUTATION_TYPES from "./mutation-types";
import Vue from "vue";
export const mutations = {
  [MUTATION_TYPES.SET_BACKLOG_ID](state, id) {
    state.backlogId = id;
  },
  [MUTATION_TYPES.GET_BACKLOG_SUCCESS](state, posts) {
    state.columns = [
      {
        name: "Todo",
        id: 1,
        color: "#28a745",
        items: [
          {
            id: 1,
            name: "task1-1",
            tags: [1, 2],
            users: [1, 2],
            point: 1
          },
          { id: 2, name: "task1-3", tags: [], users: [], point: 1 },
          { id: 3, name: "task1-2", tags: [], users: [], point: 100 }
        ]
      },
      {
        name: "Doing",
        id: 2,
        color: "#6f42c1",
        items: [
          {
            id: 4,
            name: "task1-1",
            tags: [3, 4],
            users: [3, 4],
            point: 0
          },
          { id: 5, name: "task1-3", tags: [], users: [], point: 10 },
          { id: 6, name: "task1-2", tags: [], users: [], point: 100 }
        ]
      },
      {
        name: "Done",
        id: 3,
        color: "#007bff",
        items: [
          {
            id: 7,
            name: "task1-1",
            tags: [3, 4],
            users: [3, 4],
            point: 0
          },
          { id: 8, name: "task1-3", tags: [], users: [], point: 10 },
          { id: 9, name: "task1-2", tags: [], users: [], point: 100 }
        ]
      }
      /*         {
        name: "doing",
        id: 200,
        items: [{ name: "task2-1" }, { name: "task2-3" }, { name: "task2-2" }]
      },
      {
        name: "done",
        id: 300,
        items: [{ name: "task3-1" }, { name: "task3-3" }, { name: "task3-2" }]
      } */
    ];
    state.columns = posts.message.columns;
  },
  [MUTATION_TYPES.API_FAILURE](state, error) {
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
  },
  [MUTATION_TYPES.SET_MODAL_INFO](state, modalInfo) {
    state.modalInfo = modalInfo;
    // state.modalFlag = true;
    state.modalFlag = true;
    console.log(state.modalFlag);
  },
  [MUTATION_TYPES.CLOSE_MODAL](state) {
    state.modalFlag = false;
  },
  [MUTATION_TYPES.ADD_TAG_SUCCESS](state, newTag) {
    state.tags[newTag.id] = { name: newTag.name };
    state.modalInfo.tagName = "";
    state.modalInfo.tagField = false;
  },
  [MUTATION_TYPES.TOGGLE_TAG](state, tagId) {
    var index = state.modalInfo.item.tags.indexOf(Number(tagId));
    if (index === -1) {
      state.modalInfo.item.tags.push(Number(tagId));
    } else {
      state.modalInfo.item.tags.splice(index, 1);
    }
  },
  [MUTATION_TYPES.SET_TAG_NAME](state, name) {
    state.modalInfo.tagName = name;
  },
  [MUTATION_TYPES.SHOW_TAG_FIELD](state) {
    state.modalInfo.tagField = true;
  },
  [MUTATION_TYPES.EDIT_POINT](state, point) {
    state.modalInfo.item.point = point;
  },
  [MUTATION_TYPES.ADD_USER](state) {
    state.modalInfo.item.users.push("");
  },
  [MUTATION_TYPES.CHANGE_USER](state, val) {
    console.log(val);
    state.modalInfo.item.users.splice(val.index, 1, Number(val.userId));
  },
  [MUTATION_TYPES.ITEM_DELETE_SUCCESS](state) {
    state.columns[state.modalInfo.columnIndex].items.splice(
      state.modalInfo.itemIndex,
      1
    );
    state.modalFlag = false;
  },
  [MUTATION_TYPES.ITEM_UPDATE_SUCCESS](state) {
    state.columns[state.modalInfo.columnIndex].items.splice(
      state.modalInfo.itemIndex,
      1,
      state.modalInfo.item
    );
    state.modalFlag = false;
  },
  [MUTATION_TYPES.EDIT_ITEM_NAME](state, name) {
    state.modalInfo.item.name = name;
  },
  [MUTATION_TYPES.FORMAT_MODAL_INFO](state) {
    state.modalInfo.item.users = Array.from(
      new Set(state.modalInfo.item.users)
    );
    state.modalInfo.item.tags.sort();
  },
  [MUTATION_TYPES.ITEM_CREATE_SUCCESS](state) {
    state.columns[state.modalInfo.columnIndex].items.push(state.modalInfo.item);
  }
};
