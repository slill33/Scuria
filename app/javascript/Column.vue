<template>
  <div>
    <div class="card-header column-header">
      <div class="column-name">{{column.name}}</div>
      <i class="material-icons md-24 column-header-icon">settings</i>
    </div>
    <draggable
      v-model="column.items"
      tag="div"
      class="card-body items"
      group="items"
      @end="moveItem"
      :data-column-index="index"
    >
      <Item v-for="item in column.items" :key="item.id" :item="item"></Item>
    </draggable>
    <div class="card-footer">
      <div class="item-name" style="text-align:right">
        <i class="material-icons md-24">add</i>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import draggable from "vuedraggable";
import Item from "./Item.vue";
export default {
  props: ["column", "index"],
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
    ...mapActions(["moveItem"])
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