import { createRouter, createWebHistory } from "vue-router"
import LoginView from "../views/LoginView.vue"
import RegisterView from "../views/RegisterView.vue"
import HomeView from "../views/HomeView.vue"

const AdminPanelView = () => import("../views/AdminPanelView.vue")

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/evenimente",
      name: "evenimente",
      component: HomeView,
    },
    {
      path: "/login",
      name: "login",
      component: LoginView,
    },
    {
      path: "/register",
      name: "register",
      component: RegisterView,
    },
    {
      path: "/adminpanel/:section",
      name: "adminpanel",
      component: AdminPanelView,
    },
  ],
})

export default router
