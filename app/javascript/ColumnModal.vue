<template>
  <transition name="modal" appear>
    <div class="modal modal-overlay" @click.self="closeColumnModal()">
      <div class="modal-window">
        <div class="modal-content">
          <label for="columnName">カラム名</label>
          <input
            type="name"
            class="form-control mb-4"
            placeholder="ColumnName"
            style="max-width:30rem"
            v-bind:value="columnModalInfo.column.name"
            @input="editColumnName($event.target.value)"
          />
          <div v-if="Object.keys(parentColumns).length > 0">
            <label for="parent-column">親カラム</label>
            <select
              class="form-control"
              placeholder="parent-column"
              v-bind:value="columnModalInfo.column.parent_id"
              @change="editColumnParentColumn($event.target.value)"
            >
              >
              <option :value="0">選択してください</option>
              <option
                v-for="(value, key) in parentColumns"
                :key="value.name"
                :value="Number(key)"
                >{{ value.name }}</option
              >
            </select>
          </div>
          <label for="Color">Color</label>
          <picker v-model="color" class="mx-auto"></picker>
        </div>
        <footer class="modal-footer">
          <button
            type="button"
            class="btn btn-danger mr-auto"
            @click="deleteColumn()"
            v-show="columnModalInfo.new === false"
          >
            削除
          </button>
          <button
            type="button"
            class="btn btn-primary"
            @click="updateColumn()"
            v-show="columnModalInfo.new === false"
          >
            変更
          </button>
          <button
            type="button"
            class="btn btn-primary"
            @click="createColumn()"
            v-show="columnModalInfo.new"
          >
            作成
          </button>
        </footer>
      </div>
    </div>
  </transition>
</template>
<script>
import { mapState, mapActions } from "vuex";
import { Compact } from "vue-color";
export default {
  components: {
    picker: Compact,
  },
  methods: {
    ...mapActions([
      "setColumnColor",
      "closeColumnModal",
      "editColumnName",
      "updateColumn",
      "deleteColumn",
      "createColumn",
      "editColumnParentColumn",
    ]),
  },
  watch: {},
  computed: {
    ...mapState(["columnModalInfo", "parentColumns"]),
    color: {
      get() {
        return this.$store.state.columnModalInfo.column.color;
      },
      set(val) {
        this.setColumnColor(val);
      },
    },
  },
};
</script>
<style lang="scss" scoped>
.modal {
  &.modal-overlay {
    display: flex;
    align-items: center;
    justify-content: center;
    position: fixed;
    z-index: 30;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
  }
  &-window {
    background: #fff;
    border-radius: 4px;
    overflow: hidden;
    width: 30rem;
  }
  &-content {
    padding: 1.5rem;
  }
  &-footer {
    background: #ccc;
    padding: 10px;
    text-align: right;
  }
}
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.4s;
  .modal-window {
    transition: opacity 0.4s, transform 0.4s;
  }
}
.modal-leave-active {
  transition: opacity 0.6s ease 0.4s;
}
.modal-enter,
.modal-leave-to {
  opacity: 0;
  .modal-window {
    opacity: 0;
    transform: translateY(-20px);
  }
}
/* ---------------------------modal---------------------------*/
.modal-right-content {
  margin: 0.5rem 0;
}
.modal-right-content-label-box {
  display: flex;
  margin: 0.2rem;
}
.modal-right-content-label-box > p {
  margin: 0;
}
.modal-right-content-form-box {
  display: flex;
}
.modal-right-content-form-box > i {
  margin-top: auto;
  margin-bottom: auto;
}
.modal-assignee {
  float: left;
}
.modal-tag {
  display: inline-block;
  height: 1.7rem;
  padding: 0 0.3rem;
  margin: 0 0.1rem;
  background-color: #fff;
  border: 0.01rem solid #aaa;
  border-radius: 0.1rem;
  white-space: nowrap;
  text-overflow: ellipsisu;
  overflow: hidden;
  color: #333;
  font-size: 1em;
  text-decoration: none;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}
.modal-tag:hover {
  background-color: #3498db;
  border: 1px solid #3498db;
  color: #fff;
}
.setting-modal-tag {
  background-color: #3498db;
  border: 1px solid #3498db;
  color: #fff;
}
.modal-content-2rows {
  margin-bottom: 0;
}
</style>
