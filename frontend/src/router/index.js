import { createRouter, createWebHistory } from "vue-router"
import LoginView from "../views/LoginView.vue"
import RegisterView from "../views/RegisterView.vue"
import HomeView from "../views/HomeView.vue"
import EventsView from "@/views/EventsView.vue"
import SuccessView from "@/views/Order/SuccessView.vue"
import DeclinedView from "@/views/Order/DeclinedView.vue"
import CartView from "@/views/Order/CartView.vue"
import FinishView from "@/views/Order/FinishView.vue"

const AdminPanelView = () => import("../views/AdminPanelView.vue")
const SpecificEventView = () => import("../views/SpecificEventView.vue")

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
      component: EventsView,
    },
    {
      path: "/evenimente/:hashed_id",
      name: "view_event",
      component: SpecificEventView,
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
      children: [
        {
          path: "/adminpanel/:section/edit_user/:id",
          name: "edituser",
          component: AdminPanelView,
        },
      ],
    },
    {
      path: "/cart",
      name: "cart",
      component: CartView,
    },
    {
      path: "/order/success",
      name: "order_success",
      component: SuccessView,
    },
    {
      path: "/order/declined",
      name: "order_declined",
      component: DeclinedView,
    },
    {
      path: "/finish",
      name: "finish",
      component: FinishView,
    },
    {
      path: "/(.*)*",
      redirect: "/",
    },
  ],
})

export default router
