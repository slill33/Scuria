import MUTATION_TYPES from "./mutation-types";
import Vue from "vue";
//後でモジュール化対応
//https://vuex.vuejs.org/ja/guide/structure.html
export const mutations = {
  // Backlog関係のmutation
  [MUTATION_TYPES.SET_BACKLOG_ID](state, id) {
    state.backlogId = id;
  },
  [MUTATION_TYPES.GET_BACKLOG_SUCCESS](state, posts) {
    state.columns = posts.message.columns;
    state.tags = posts.message.tags
    state.users = posts.message.users
    state.parentColumns = posts.message.parent_backlog_columns
    state.childBacklogs = posts.message.child_backlogs
    state.parentItems = posts.message.allocated_items_from_parent_backlog
  },


  // API失敗時のmutation(共有)
  [MUTATION_TYPES.API_FAILURE](state, error) {
    if (error.response.data.message != null) {
      alert(error.response.data.message);
    }
    else {
      alert(error)
    }
  },


  //Item関係のmutation
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
  [MUTATION_TYPES.ITEM_CREATE_SUCCESS](state, response) {
    state.itemModalInfo.item.id = response.data.created_item_id
    state.columns[state.itemModalInfo.columnIndex].items.push(
      state.itemModalInfo.item
    );
    state.itemModalFlag = false;
  },


  //Item用モーダルウィンドウ関係のmutation
  [MUTATION_TYPES.SET_ITEM_MODAL_INFO](state, itemModalInfo) {
    state.itemModalInfo = itemModalInfo;
    state.itemModalFlag = true;
  },
  [MUTATION_TYPES.CLOSE_ITEM_MODAL](state) {
    state.itemModalFlag = false;
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
    state.itemModalInfo.item.users.splice(val.index, 1, Number(val.userId));
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
  [MUTATION_TYPES.EDIT_ITEM_CHILD_BACKLOG](state, childId) {
    state.itemModalInfo.item.child_backlog_id = childId;
  },
  [MUTATION_TYPES.EDIT_ITEM_PARENT_ITEM](state, parentId) {
    state.itemModalInfo.item.parent_id = parentId;
  },


  //Tag関係のmutation
  [MUTATION_TYPES.ADD_TAG_SUCCESS](state, response) {
    state.tags[response.created_tag_id] = { name: state.itemModalInfo.tagName };
    state.itemModalInfo.tagName = "";
    state.itemModalInfo.tagField = false;
  },


  //Column関係のmutation
  [MUTATION_TYPES.SET_COLUMNS](state, val) {
    state.columns = val;
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
  [MUTATION_TYPES.COLUMN_CREATE_SUCCESS](state, response) {
    state.columnModalInfo.column.id = response.data.created_column_id
    state.columns.push(state.columnModalInfo.column);
    state.columnModalFlag = false;
  },


  //Column用モーダルウィンドウ関係のmutation
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
  [MUTATION_TYPES.EDIT_COLUMN_PARENT_COLUMN](state, parentId) {
    state.columnModalInfo.column.parent_id = parentId;
  },
}
