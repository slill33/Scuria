import Vue from "vue";
import VueRouter from "vue-router";
import Backlog from "../Backlog.vue";
import store from "./store"

const router = new VueRouter({
  mode: "history",
  routes: [{ path: "/backlogs/:id(\\d+)", component: Backlog }]
});

export default router;