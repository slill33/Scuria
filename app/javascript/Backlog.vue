<template>
  <div class="app">
    <div id="backlog">
      <ItemModal v-if="modalFlag"></ItemModal>
      <draggable v-model="columns" class="columns" group="columns" @end="moveColumn">
        <Column
          v-for="(column, index) in columns"
          :key="index"
          class="card text-white mb-3 column"
          v-bind:style="{ 'background-color': column.color}"
          :column="column"
          :columnIndex="index"
        ></Column>
      </draggable>
      <span>{{$store.state}}</span>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import draggable from "vuedraggable";
import Column from "./Column.vue";
import ItemModal from "./ItemModal.vue";
import axios from "axios";
export default {
  components: {
    draggable,
    Column,
    ItemModal
  },
  data() {
    return {};
  },
  mounted() {
    this.setBacklogId(this.$route.params["id"]);
    this.getBacklog();
  },
  computed: {
    ...mapState(["modalFlag", "modalInfo"]),
    columns: {
      get() {
        return this.$store.state.columns;
      },
      set(val) {
        this.setColumns(val);
      }
    }
  },
  methods: {
    ...mapActions(["moveColumn", "getBacklog", "setColumns", "setBacklogId"])
  }
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
</style>