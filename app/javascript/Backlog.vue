<template>
  <div class="app">
    <div id="backlog">
      <draggable v-model="columns" class="columns" group="columns" @end="moveColumn">
        <Column
          v-for="(column, index) in columns"
          :key="index"
          class="card text-white mb-3 column"
          v-bind:style="{ 'background-color': column.color}"
          :column="column"
          :index="index"
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
import axios from "axios";
export default {
  components: {
    draggable,
    Column
  },
  data() {
    return {};
  },
  mounted() {
    this.getBacklog(this.$route.params["id"]);
  },
  computed: {
    //...mapState(["columns"]),
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
    ...mapActions(["moveColumn", "getBacklog", "setColumns"])
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