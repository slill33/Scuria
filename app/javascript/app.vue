<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import UserIndexPage from 'UserIndexPage.vue'

const router = new VueRouter({
  routes: [
    { path: '/',
      component: UserIndexPage  }
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>