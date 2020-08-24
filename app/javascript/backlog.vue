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
    <p>{{$data}}</p>
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
      tasks: [
        ['task1-1', 'task1-2', 'task1-3', 'task1-4'],
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