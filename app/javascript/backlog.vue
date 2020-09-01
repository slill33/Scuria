<template>
  <div id="backlog">
    <div class="columns">
      <div
        v-for="(column, index) in columns"
        :key="index"
        class="card text-white mb-3 column"
        v-bind:style="{ 'background-color': column.color}"
      >
        <div class="card-header column-header">
          <div class="column-name">{{column.name}}</div>
          <i class="material-icons md-24 column-header-icon">settings</i>
        </div>
        <draggable
          v-model="columns[index].items"
          tag="div"
          class="card-body items"
          group="items"
          @end="itemDraggableEnd"
          :data-column-id="column.columnId"
        >
          <Item v-for="item in column.items" :key="item.itemId" :item="item"></Item>
        </draggable>
        <div class="card-footer">
          <div class="item-name" style="text-align:right">
            <i class="material-icons md-24">add</i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import Item from "./Item.vue";

export default {
  components: {
    draggable,
    Item
  },
  data() {
    return {
      backlog_id: 1,
      columns: [
        {
          name: "Todo",
          columnId: 1,
          color: "#28a745",
          items: [
            {
              itemId: 1,
              name: "task1-1",
              tags: [
                { name: "aaaa", tagId: 1 },
                { name: "iii", tagId: 2 }
              ],
              users: [
                { name: "yamda", userId: 1 },
                { name: "satou", userId: 2 }
              ],
              point: 0
            },
            { itemId: 2, name: "task1-3", tags: [], users: [], point: 10 },
            { itemId: 3, name: "task1-2", tags: [], users: [], point: 100 }
          ]
        },
        {
          name: "Doing",
          columnId: 2,
          color: "#6f42c1",
          items: [
            {
              itemId: 4,
              name: "task1-1",
              tags: [
                { name: "aaaa", tagId: 1 },
                { name: "iii", tagId: 2 }
              ],
              users: [
                { name: "yamda", userId: 1 },
                { name: "satou", userId: 2 }
              ],
              point: 0
            },
            { itemId: 5, name: "task1-3", tags: [], users: [], point: 10 },
            { itemId: 6, name: "task1-2", tags: [], users: [], point: 100 }
          ]
        },
        {
          name: "Done",
          columnId: 3,
          color: "#007bff",
          items: [
            {
              itemId: 7,
              name: "task1-1",
              tags: [
                { name: "aaaa", tagId: 1 },
                { name: "iii", tagId: 2 }
              ],
              users: [
                { name: "yamda", userId: 1 },
                { name: "satou", userId: 2 }
              ],
              point: 0
            },
            { itemId: 8, name: "task1-3", tags: [], users: [], point: 10 },
            { itemId: 9, name: "task1-2", tags: [], users: [], point: 100 }
          ]
        }
        /*         {
          name: "doing",
          columnId: 200,
          items: [{ name: "task2-1" }, { name: "task2-3" }, { name: "task2-2" }]
        },
        {
          name: "done",
          columnId: 300,
          items: [{ name: "task3-1" }, { name: "task3-3" }, { name: "task3-2" }]
        } */
      ],
      tasks: [
        ["task1-1", "task1-2", "task1-3", "taskx"],
        ["task2-1", "task2-2", "task2-3", "task2-4"],
        ["task3-1", "task3-2", "task3-3"]
      ]
    };
  },
  methods: {
    itemDraggableEnd: function(event) {
      var test = event;
      console.log(event);
      console.log(event.from.dataset.columnId);
      console.log(event.to.dataset.columnId);
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