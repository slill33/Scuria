<template>
  <div id="backlog">
    <draggable tag="ul">
      <li v-for="(task, index) in tasks" :key='index'>{{ task }}</li>
    </draggable>
    <div class="columns">
    <draggable v-model=tasks[index] tag="ul" v-for="(list, index) in tasks" :key='index' class="column" group="tasks" @end="draggableEnd" :data-column-id="index">
      <li v-for="item in list" :key='item'>{{ item }}</li>
    </draggable>
    </div>
    <p>--------------------------------------</p>
    <p>{{$data}}</p>
    <draggable v-model=columns[index].items tag="ul" v-for="(column, index) in columns" :key='index' class="column" group="tasks" @end="draggableEnd" :data-column-id="index">
      <li v-for="item in column.items" :key='item.name'>{{ item.name }}</li>
    </draggable>
  </div>
</template>

<script>
import draggable from 'vuedraggable';

export default {
  name: 'backlog',
  components: {
    draggable,
  },
  data() {
    return {
      backlog_id:1,
      columns: [
          {name: "todo", columnId:100, items: [{name:'task1-1'}, {name:'task1-3'}, {name:'task1-2'}]},
          {name: "doing", columnId:200, items: [{name:'task2-1'}, {name:'task2-3'}, {name:'task2-2'}]},
          {name: "done", columnId:300, items: [{name:'task3-1'}, {name:'task3-3'}, {name:'task3-2'}]}
      ],
      tasks: [
        ['task1-1', 'task1-2', 'task1-3', 'taskx'],
        ['task2-1', 'task2-2', 'task2-3', 'task2-4'],
        ['task3-1', 'task3-2', 'task3-3']
      ]
    }
  },
  methods: {
      draggableEnd: function(event) {
          var test = event
          console.log(event)
          console.log(event.from.dataset.columnId)
          console.log(event.to.dataset.columnId)
      }
  }
  //computed(){
  //
  //}
}
</script>

<style>
.columns{
  display:flex;
  flex-diretion: row;
}
.column{
  font-size: 50px;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>