<template>
  <div
    class="card text-dark item"
    @click="editItem({item: item,columnIndex: columnIndex,itemIndex:itemIndex})"
  >
    <div class="card-header item-header">
      <div v-if="item.tags.length>0" class="item-tags">
        <span v-for="tagId in item.tags" :key="tagId" class="tag">{{tags[tagId].name}}</span>
      </div>
      <div class="item-user">
        <div v-if="item.users.length>0" class="item-users">
          <span v-for="(userId, index) in item.users" :key="index+'_'+userId">{{users[userId].name}}</span>
        </div>
      </div>
    </div>
    <div class="card-body item-body">
      <div class="item-name">
        <span>{{item.name}}</span>
      </div>
      <div>
        <span>[{{item.point}}]</span>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  props: ["item", "columnIndex", "itemIndex"],
  methods: {
    ...mapActions(["editItem"])
  },
  computed: {
    ...mapState(["tags", "users"])
  }
};
</script>

<style scoped>
/* ---------------------------tag用---------------------------*/
.tag {
  margin: 0.2rem 0.1rem 0rem 0rem;
  display: inline-block;
  max-width: 3rem;
  height: 1.3rem;
  padding: 0 0.3rem;
  background-color: #fff;
  border: 0.01rem solid #aaa;
  border-radius: 0.1rem;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
  color: #333;
  font-size: 0.7em;
  text-decoration: none;
  -webkit-transition: 0.2s;
  transition: 0.2s;
}
.tag:hover {
  background-color: #3498db;
  border: 1px solid #3498db;
  color: #fff;
}

/* ---------------------------item用---------------------------*/
.item {
  max-width: 20rem;
  margin: 0.4rem 0rem;
}

.item-header {
  display: flex;
  justify-content: flex-end;
  padding: 0.5rem;
}
.item-tags {
  margin-right: auto;
}
.item-user {
  font-size: 0.75em;
  display: flex;
}
.item-header-icon {
  margin-bottom: auto;
  margin-top: auto;
  margin-left: 0.5rem;
}
.item-header div {
  margin-bottom: auto;
  margin-top: auto;
}

.item-users {
  margin-bottom: auto;
  margin-top: auto;
  margin-right: 0.5rem;
  text-align: right;
}

.item-body {
  padding: 0.8rem;
}

.item-name {
  float: left;
  max-width: 14rem;
}
</style>