import MUTATION_TYPES from "./mutation-types";
import Vue from "vue";
export const mutations = {
  [MUTATION_TYPES.SET_BACKLOG_ID](state, id) {
    state.backlogId = id;
  },
  [MUTATION_TYPES.GET_BACKLOG_SUCCESS](state, posts) {
    state.columns = posts.message.columns;
    state.tags = posts.message.tags
    state.users = posts.message.users
  },
  [MUTATION_TYPES.API_FAILURE](state, error) {
    alert(error);
  },
  [MUTATION_TYPES.SET_COLUMNS](state, val) {
    state.columns = val;
  },
  [MUTATION_TYPES.SET_ITEM_MODAL_INFO](state, itemModalInfo) {
    state.itemModalInfo = itemModalInfo;
    state.itemModalFlag = true;
    console.log(state.itemModalFlag);
  },
  [MUTATION_TYPES.CLOSE_ITEM_MODAL](state) {
    state.itemModalFlag = false;
  },
  [MUTATION_TYPES.ADD_TAG_SUCCESS](state, newTag) {
    state.tags[newTag.id] = { name: newTag.name };
    state.itemModalInfo.tagName = "";
    state.itemModalInfo.tagField = false;
  },
  [MUTATION_TYPES.SET_ITEM_MODAL_INFO_DESCRIPTION](state, description) {
    state.itemModalInfo.item.description = description;
  },
  [MUTATION_TYPES.TOGGLE_TAG](state, tagId) {
    var index = state.itemModalInfo.item.tags.indexOf(Number(tagId));
    if (index === -1) {
      state.itemModalInfo.item.tags.push(Number(tagId));
    } else {
      state.itemModalInfo.item.tags.splice(index, 1);
    }
  },
  [MUTATION_TYPES.SET_TAG_NAME](state, name) {
    state.itemModalInfo.tagName = name;
  },
  [MUTATION_TYPES.SHOW_TAG_FIELD](state) {
    state.itemModalInfo.tagField = true;
  },
  [MUTATION_TYPES.EDIT_POINT](state, point) {
    state.itemModalInfo.item.point = point;
  },
  [MUTATION_TYPES.ADD_USER](state) {
    state.itemModalInfo.item.users.push("");
  },
  [MUTATION_TYPES.CHANGE_USER](state, val) {
    console.log(val);
    state.itemModalInfo.item.users.splice(val.index, 1, Number(val.userId));
  },
  [MUTATION_TYPES.ITEM_DELETE_SUCCESS](state) {
    state.columns[state.itemModalInfo.columnIndex].items.splice(
      state.itemModalInfo.itemIndex,
      1
    );
    state.itemModalFlag = false;
  },
  [MUTATION_TYPES.ITEM_UPDATE_SUCCESS](state) {
    state.columns[state.itemModalInfo.columnIndex].items.splice(
      state.itemModalInfo.itemIndex,
      1,
      state.itemModalInfo.item
    );
    state.itemModalFlag = false;
  },
  [MUTATION_TYPES.SET_ITEM_MODAL_INFO_NAME](state, name) {
    state.itemModalInfo.item.name = name;
  },
  [MUTATION_TYPES.FORMAT_ITEM_MODAL_INFO](state) {
    state.itemModalInfo.item.users = Array.from(
      new Set(state.itemModalInfo.item.users)
    );
    state.itemModalInfo.item.tags.sort();
  },
  [MUTATION_TYPES.ITEM_CREATE_SUCCESS](state, response) {
    console.log(response)
    state.columns[state.itemModalInfo.columnIndex].items.push(
      state.itemModalInfo.item
    );
    state.itemModalFlag = false;
  },
  [MUTATION_TYPES.SET_COLUMN_COLOR](state, color) {
    state.columnModalInfo.column.color = color;
  },
  [MUTATION_TYPES.CLOSE_COLUMN_MODAL](state) {
    state.columnModalFlag = false;
  },
  [MUTATION_TYPES.EDIT_COLUMN_MODAL_INFO](state, columnModalInfo) {
    state.columnModalInfo = columnModalInfo;
    state.columnModalFlag = true;
  },
  [MUTATION_TYPES.SET_COLUMN_MODAL_INFO_NAME](state, name) {
    state.columnModalInfo.column.name = name;
  },
  [MUTATION_TYPES.COLUMN_DELETE_SUCCESS](state) {
    state.columns.splice(state.columnModalInfo.columnIndex, 1);
    state.columnModalFlag = false;
  },
  [MUTATION_TYPES.COLUMN_UPDATE_SUCCESS](state) {
    state.columns.splice(
      state.columnModalInfo.columnIndex,
      1,
      state.columnModalInfo.column
    );
    state.columnModalFlag = false;
  },
  [MUTATION_TYPES.COLUMN_CREATE_SUCCESS](state) {
    state.columns.push(state.columnModalInfo.column);
  }
}
