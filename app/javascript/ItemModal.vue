<template>
  <transition name="modal" appear>
    <div class="modal modal-overlay" @click.self="closeItemModal()">
      <div class="modal-window">
        <div class="modal-content">
          <input
            type="name"
            class="form-control mb-4"
            placeholder="ItemName"
            style="max-width:30rem"
            v-bind:value="itemModalInfo.item.name"
            @input="editItemName($event.target.value)"
          />
          <div class="modal-content-2rows">
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="mail2">説明</label>
                <textarea class="form-control" placeholder="Description" style="height:6.5rem"></textarea>
              </div>
              <div class="col-md-6">
                <div class="modal-right-content">
                  <label for="Point">Point</label>
                  <select
                    class="form-control"
                    placeholder="Point"
                    v-bind:value="itemModalInfo.item.point"
                    @change="editPoint($event.target.value)"
                  >
                    <option :value="0">選択してください</option>
                    <option :value="Number(n)" v-for="n of 89" :key="n">{{n}}</option>
                  </select>
                </div>
                <div class="modal-right-content">
                  <div class="modal-right-content-label-box">
                    <p>作業者</p>
                    <i class="material-icons md-24" @click="addUser()">add</i>
                  </div>
                  <div v-show="itemModalInfo.item.users.length>0">
                    <!-- <span v-for="tagId in item.tags" :key="tagId" class="tag">{{tags[tagId].name}}</span> -->
                    <div
                      v-for="(userId, index) in itemModalInfo.item.users"
                      class="modal-right-content-form-box"
                      :key="userId + '_' +index"
                    >
                      <select
                        class="form-control"
                        placeholder="作業者"
                        v-bind:value="itemModalInfo.item.users[index]"
                        @change="changeUser({userId:$event.target.value,index:index})"
                      >
                        <option
                          v-for="(value, key) in users"
                          :key="value.name"
                          :value="Number(key)"
                        >{{value.name}}</option>
                      </select>
                      <i class="material-icons md-24 column-header-icon">clear</i>
                    </div>
                  </div>
                </div>

                <div class="modal-right-content">
                  <div class="modal-right-content-label-box">
                    <p>タグ</p>
                  </div>
                  <div class="item-tags">
                    <span
                      v-for="(value, key) in tags"
                      :key="key"
                      class="modal-tag"
                      v-bind:class="{'setting-modal-tag':itemModalInfo.item.tags.indexOf(Number(key))!= -1}"
                      @click="toggleTag(key)"
                    >{{value.name}}</span>
                    <i class="material-icons md-24" @click="showTagField">add</i>
                  </div>
                  <div class="modal-right-content-form-box" v-show="itemModalInfo.tagField">
                    <input
                      type="text"
                      id="text1"
                      class="form-control"
                      v-bind:value="itemModalInfo.tagName"
                      @input="setTagName($event.target.value)"
                    />
                    <i
                      class="material-icons md-24 column-header-icon"
                      @click="addTag(itemModalInfo.tagName)"
                    >check</i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <footer class="modal-footer">
          <button
            type="button"
            class="btn btn-danger mr-auto"
            v-show="itemModalInfo.new===false"
            @click="deleteItem()"
          >削除</button>
          <button
            type="button"
            class="btn btn-primary"
            v-show="itemModalInfo.new===false"
            @click="updateItem()"
          >変更</button>
          <button
            type="button"
            class="btn btn-primary"
            v-show="itemModalInfo.new"
            @click="createItem()"
          >作成</button>
        </footer>
      </div>
    </div>
  </transition>
</template>
<script>
import { mapState, mapActions } from "vuex";
export default {
  methods: {
    ...mapActions([
      "closeItemModal",
      "addTag",
      "toggleTag",
      "setTagName",
      "showTagField",
      "editPoint",
      "addUser",
      "changeUser",
      "updateItem",
      "createItem",
      "deleteItem",
      "editItemName"
    ])
  },
  watch: {},
  computed: {
    ...mapState(["tags", "users", "itemModalInfo", "tagField"])
  }
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