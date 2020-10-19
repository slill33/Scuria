<template>
  <div class="app">
    <div id="backlog">
      <ItemModal v-if="itemModalFlag"></ItemModal>
      <ColumnModal v-if="columnModalFlag"></ColumnModal>
      <draggable
        v-model="columns"
        class="columns"
        group="columns"
        @end="moveColumn"
        draggable=".column"
      >
        <Column
          v-for="(column, index) in columns"
          :key="index"
          class="card text-white mb-3 column"
          v-bind:style="{ 'background-color': column.color }"
          :column="column"
          :columnIndex="index"
        ></Column>
        <button
          type="button"
          class="btn btn-dark rounded-circle p-0 column-add"
          @click="newColumn()"
        >
          ＋
        </button>
      </draggable>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import draggable from "vuedraggable";
import Column from "./Column.vue";
import ItemModal from "./ItemModal.vue";
import ColumnModal from "./ColumnModal.vue";
import axios from "axios";
export default {
  components: {
    draggable,
    Column,
    ItemModal,
    ColumnModal,
  },
  data() {
    return {};
  },
  mounted() {
    this.setBacklogId(this.$route.params["id"]);
    this.getBacklog();
  },
  computed: {
    ...mapState(["itemModalFlag", "columnModalFlag"]),
    columns: {
      get() {
        return this.$store.state.columns;
      },
      set(val) {
        this.setColumns(val);
      },
    },
  },
  methods: {
    ...mapActions([
      "moveColumn",
      "getBacklog",
      "setColumns",
      "setBacklogId",
      "newColumn",
    ]),
  },
};
</script>

<style>
/* ---------------------------column用---------------------------*/
#backlog {
  margin: 1rem;
}

.columns {
  display: flex;
  align-items: flex-start;
}
.column-add {
  width: 2rem;
  height: 2rem;
}
</style>
