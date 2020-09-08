<template>
  <div id="backlog">
    <div class="example-modal-window">
      <p>ボタンを押すとモーダルウィンドウが開きます</p>
      <button @click="openModal">開く</button>


      <!-- コンポーネント ItemModal -->
      <ItemModal @close="closeModal" v-if="modal">
        <!-- default スロットコンテンツ -->
        <p>Vue.js Modal Window!</p>
        <div>
          <input v-model="message" />
        </div>
        <!-- /default -->
        <!-- footer スロットコンテンツ -->
        <template slot="footer">
          <button @click="doSend">送信</button>
        </template>
        <!-- /footer -->
      </ItemModal>
    </div>
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
          :data-column-id="column.id"
        >
          <Item v-for="item in column.items" :key="item.id" :item="item"></Item>
        </draggable>
        <div class="card-footer">
          <div class="item-name" style="text-align:right">
            <i class="material-icons md-24">add</i>
          </div>
        </div>
      </div>
    </div>
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
      modal: true,
      message:'',
      columns: []
    };
  },
  mounted() {
    axios
      .get(
        `/api/v1/private/backlogs/${this.$route.params["id"]}/columns_and_items_get.json`
      )
      .then(response => (this.columns = response.data.message.columns))
      .catch(error => {
        alert("更新できませんでした");
      });
  },
  methods: {
    itemDraggableEnd: function(event) {
      var test = event;
      console.log(event);
      console.log(event.from.dataset.columnId);
      console.log(event.to.dataset.columnId);
    },
    openModal() {
      this.modal = true
    },
    closeModal() {
      this.modal = false
    },
    doSend() {
      if (this.message.length > 0) {
        alert(this.message)
        this.message = ''
        this.closeModal()
      } else {
        alert('メッセージを入力してください')
      }
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