<template>
  <div>
    <div class="card-header column-header">
      <div class="column-name">{{column.name}}</div>
      <i
        class="material-icons md-24 column-header-icon"
        @click="editColumn({index:columnIndex,column:column})"
      >settings</i>
    </div>
    <draggable
      v-model="column.items"
      tag="div"
      class="card-body items"
      group="items"
      @end="moveItem"
      :data-column-index="columnIndex"
    >
      <Item
        v-for="(item, index) in column.items"
        :key="item.id"
        :item="item"
        :columnIndex="columnIndex"
        :itemIndex="index"
      ></Item>
    </draggable>
    <div class="card-footer">
      <div class="item-name" style="text-align:right">
        <i class="material-icons md-24" @click="newItem(columnIndex)">add</i>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import draggable from "vuedraggable";
import Item from "./Item.vue";
export default {
  props: ["column", "columnIndex"],
  components: {
    draggable,
    Item
  },
  data() {
    return {};
  },
  mounted() {},
  computed: {},
  methods: {
    ...mapActions(["moveItem", "newItem", "editColumn"])
  }
};
</script>

<style>
/* ---------------------------column用---------------------------*/
.column {
  margin: 0rem 0.3rem;
  width: 20rem;
}
.column-header {
  display: flex;
}
.column-name {
  float: left;
}
.column-header-icon {
  margin-left: auto;
}
</style>