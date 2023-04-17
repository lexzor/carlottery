import { createRouter, createWebHistory } from "vue-router"
import LoginView from "../views/LoginView.vue"
import RegisterView from "../views/RegisterView.vue"
import HomeView from "../views/HomeView.vue"
import EventsView from "@/views/EventsView.vue"
import SuccessView from "@/views/Order/SuccessView.vue"
import DeclinedView from "@/views/Order/DeclinedView.vue"
import CartView from "@/views/Order/CartView.vue"
import FinishView from "@/views/Order/FinishView.vue"
import TicketsView from "@/views/TicketsView.vue"
import WinnersView from "@/views/WinnersView.vue"
import { useAccountStore } from "@/stores/account"

const AdminPanelView = () => import("../views/AdminPanelView.vue")
const SpecificEventView = () => import("../views/SpecificEventView.vue")
const AccountView = () => import("../views/Account/AccountView.vue")
const WebTermsView = () => import("../views/WebTermsView.vue")
const SpecificEventTicketsView = () => import("../views/SpecificEventTicketsView.vue")
const SpecificEventWinnerView = () => import("../views/SpecificEventWinnerView.vue")

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
			meta: {
				restrictedIfLoggedIn: true,
			},
		},
		{
			path: "/register",
			name: "register",
			component: RegisterView,
			meta: {
				restrictedIfLoggedIn: true,
			},
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
				{
					path: "/adminpanel/:section:/edit_event/:id",
					name: "editevent",
					component: AdminPanelView,
				},
			],
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/cart",
			name: "cart",
			component: CartView,
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/order/success",
			name: "order_success",
			component: SuccessView,
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/order/declined",
			name: "order_declined",
			component: DeclinedView,
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/finish",
			name: "finish",
			component: FinishView,
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/bilete",
			name: "bilete",
			component: TicketsView,
		},
		{
			path: "/bilete/:hashed_id",
			name: "bilete_eveniment",
			component: SpecificEventTicketsView,
		},
		{
			path: "/cont",
			name: "cont",
			component: AccountView,
			children: [
				{
					path: "/cont/:page",
					// name: "cont_comenzi",
					component: AccountView,
				},
			],
			meta: {
				needsAuth: true,
			},
		},
		{
			path: "/castigatori",
			name: "castigatori",
			component: WinnersView,
		},
		{
			path: "/castigatori/:hashed_id",
			name: "bilete_eveniment",
			component: SpecificEventWinnerView,
		},
		{
			path: "/termeni-si-conditii",
			name: "termeni",
			component: WebTermsView,
		},
		{
			path: "/(.*)*",
			redirect: "/",
		},
	],
})

let firstLogin = true

router.beforeEach(async (to, from, next) => {
	const account = useAccountStore()

	if (firstLogin) {
		await account.autoLogin()
		firstLogin = false
	}

	if (to.meta.needsAuth) {
		if (!account.isLogged()) {
			router.push({ path: "/login" })
		}
	}

	if (to.meta.restrictedIfLoggedIn) {
		if (account.isLogged()) {
			router.push({ path: "/" })
		}
	}

	next()
})

export default router
