<template>
  <div id="backlog">
    <div class="example-modal-window">
      <p>ボタンを押すとモーダルウィンドウが開きます</p>
      <button @click="openModal">開く</button>
      <ItemModal @close="closeModal" v-if="modal" :item="modalItem" :users="users" :tags="tags"></ItemModal>
    </div>
    <draggable v-model="columns" class="columns" group="columns">
      <div
        v-for="(column, index) in columns"
        :key="index"
        class="card text-white column"
        v-bind:style="{ 'background-color': column.color}"
      >
        <div class="card-header column-header">
          <div class="column-name">{{column.name}}</div>
          <i class="material-icons md-24 column-header-icon">settings</i>
        </div>
        <draggable
          v-model="columns[index].items"
          class="card-body items"
          group="items"
          @end="itemDraggableEnd"
          :data-column-id="column.id"
        >
          <Item
            v-for="item in column.items"
            :key="item.id"
            :item="item"
            @edit="editItem"
            :users="users"
            :tags="tags"
          ></Item>
        </draggable>
        <div class="card-footer">
          <div class="item-name" style="text-align:right">
            <i class="material-icons md-24">add</i>
          </div>
        </div>
      </div>
    </draggable>
    <span>{{$data}}</span>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import Item from "./Item.vue";
import ItemModal from "./ItemModal.vue";
import axios from "axios";
export default {
  components: {
    ItemModal,
    draggable,
    Item
  },
  data() {
    return {
      modal: false,
      message: "",
      columns: [],
      modalItem: {},
      users: {
        1: { name: "UserA" },
        2: { name: "UserB" },
        3: { name: "UserC" },
        4: { name: "UserD" }
      },
      tags: {
        1: { name: "tagA" },
        2: { name: "tagB" },
        3: { name: "tagC" },
        4: { name: "tagD" }
      }
    };
  },
  mounted() {
    // axios
    //   .get(
    //     `/api/v1/private/backlogs/${this.$route.params["id"]}/columns_and_items_get.json`
    //   )
    //   .then(response => (this.columns = response.data.message.columns))
    //   .catch(error => {
    //     alert("更新できませんでした");
    //   });
    this.columnSample();
  },
  methods: {
    itemDraggableEnd: function(event) {
      var test = event;
      console.log(event);
      console.log(event.from.dataset.id);
      console.log(event.to.dataset.id);
    },
    openModal() {
      this.modal = true;
    },
    closeModal() {
      this.modal = false;
    },
    editItem(item) {
      this.openModal();
      this.modalItem = item;
    },
    columnSample() {
      this.columns = [
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
    }
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

.items .item:first-child {
  margin: 0rem 0rem 0.4rem 0rem;
}
</style>